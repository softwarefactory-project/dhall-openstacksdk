# The Dhall OpenStack SDK configuration schemas

`dhall-openstacksdk` contains [Dhall][dhall-lang] bindings to [OpenStack][openstacksdk] clouds.yaml.

This package can be used to create clouds.yaml, addressing common issues:

- Undocumented options, for example to define the default public network for region with multiple networks.
- Sharing cloud configuration between provider.

## Schemas

This package uses strongly typed schemas to define all the attributes, including:

### Application credential

An Application credential needs a specific configuration where
some keystone v3 parameters, such as domain_name, are invalid.
The binding ensure only valid parameters are used:

```dhall

OpenStack.CloudAuth.AppCredential::{
  , application_credential_id = "app_id"
  , application_credential_secret = "app_secret"
}
```

### Region networks

A region may have specific network configuration to define the default network:

```dhall
OpenStack.CloudRegion.RegionWithParams
  { name = "myRegion"
  , values.networks = Some
    [ OpenStack.CloudRegionNetwork::{
      , name = "public"
      , routes_externally = Some True
      , default_interface = Some True
      , nat_source = Some True
      }
    , OpenStack.CloudRegionNetwork::{
      , name = "private"
      , routes_externally = Some False
      , nat_destination = Some True
      }
    ]
  }
```

## Usage

Here is a full example with 1 application credential for a cloud and two accounts for another cloud (one user and one application credential).
This example use a function to manage the required parameters for the two accounts:

```dhall
-- ./examples/demo.dhall
let OpenStack = ../package.dhall

let mycloud_1_url = "https://mycloud_01:5000/v3"

let mkMyCloud =
      \(auth : OpenStack.CloudAuth.Type) ->
        OpenStack.Cloud::{
        , image_format = Some "raw"
        , auth = Some auth
        , regions = Some
          [ OpenStack.CloudRegion.RegionWithParams
              { name = "myRegion"
              , values.networks = Some
                [ OpenStack.CloudRegionNetwork::{
                  , name = "public"
                  , routes_externally = Some True
                  , default_interface = Some True
                  , nat_source = Some True
                  }
                , OpenStack.CloudRegionNetwork::{
                  , name = "private"
                  , routes_externally = Some False
                  , nat_destination = Some True
                  }
                ]
              }
          ]
        }

let clouds =
      { mycloud_1_user =
          mkMyCloud
            ( OpenStack.CloudAuth.SetUser
                OpenStack.CloudAuth.User::{
                , auth_url = Some mycloud_1_url
                , password = Some "userpass"
                , username = Some "username"
                }
            )
      , mycloud_1_app1_id =
              mkMyCloud
                ( OpenStack.CloudAuth.SetAppCredential
                    OpenStack.CloudAuth.AppCredential::{
                    , auth_url = Some mycloud_1_url
                    , application_credential_id = "app1_id"
                    , application_credential_secret = "app1_secret"
                    }
                )
          //  { auth_type = Some "v3applicationcredential" }
      , mycloud_2 = OpenStack.Cloud::{
        , auth_type = Some "v3applicationcredential"
        , profile = Some "mycloud_2"
        , auth = Some
            ( OpenStack.CloudAuth.SetAppCredential
                OpenStack.CloudAuth.AppCredential::{
                , application_credential_id = "app2_id"
                , application_credential_secret = "app2_secret"
                }
            )
        , image_format = Some "qcow2"
        }
      }

let cache =
      Some { expiration = Some OpenStack.CacheExpiration::{ server = Some 5 } }

in  OpenStack::{ cache, clouds = toMap clouds }

```

The generated yaml file is:

```
# dhall-to-yaml --file ./examples/demo.dhall
cache:
  expiration:
    server: 5
clouds:
  mycloud_1_app1_id:
    auth:
      application_credential_id: app1_id
      application_credential_secret: app1_secret
      auth_url: https://mycloud_01:5000/v3
    auth_type: v3applicationcredential
    image_format: raw
    regions:
      - name: myRegion
        values:
          networks:
            - default_interface: true
              name: public
              nat_source: true
              routes_externally: true
            - name: private
              nat_destination: true
              routes_externally: false
  mycloud_1_user:
    auth:
      auth_url: https://mycloud_01:5000/v3
      password: userpass
      username: username
    image_format: raw
    regions:
      - name: myRegion
        values:
          networks:
            - default_interface: true
              name: public
              nat_source: true
              routes_externally: true
            - name: private
              nat_destination: true
              routes_externally: false
  mycloud_2:
    auth:
      application_credential_id: app2_id
      application_credential_secret: app2_secret
    auth_type: v3applicationcredential
    image_format: qcow2
    profile: mycloud_2

```

## Validation

The dhall-openstacksdk package can also be used to validate a clouds.yaml file using the `yaml-to-dhall` command:

```
$ cat bad_clouds.yaml
clouds:
  mycloud:
    profile: mycloud
    bad_param: true
    auth:
      project_name: myproject

$ yaml-to-dhall --file bad_clouds.yaml https://softwarefactory-project.io/cgit/software-factory/dhall-openstacksdk/plain/OpenStack/Type.dhall


Error: $.clouds.mycloud: Key(s) bad_param present in the YAML object but not in the expected Dhall record type
```

With dhall 1.34, it's possible to rewrite a clouds.dhall with the schemas completions:

```
$ dhall rewrite-with-schemas --schemas ./OpenStack/Type.dhall < clouds.dhall
```

## Changes

Frozen packages are available in the tag commit.

### 0.1.0

- Initial release

[dhall-lang]: https://dhall-lang.org
[openstacksdk]: https://docs.openstack.org/openstacksdk/latest/
