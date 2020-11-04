# dhall-openstacksdk

`dhall-openstacksdk` contains [Dhall][dhall-lang] bindings to [OpenStack][openstacksdk],
so you can generate openstack configuration from Dhall expressions.

## Example

```dhall
-- ./examples/demo.dhall
let OpenStack = ../package.dhall

let cache =
      Some
        OpenStack.Cache::{
        , expiration = Some OpenStack.CacheExpiration::{ server = Some 5 }
        }

let clouds =
      { rh = OpenStack.Cloud::{
        , auth = Some
            ( OpenStack.CloudAuth.SetUser
                OpenStack.CloudAuth.User::{
                , username = Some "nodepool"
                , auth_url = "https://mycloud:5000/v2.0"
                }
            )
        , regions = Some [ OpenStack.CloudRegion.RegionName "Public" ]
        }
      }

in  OpenStack::{ cache, clouds = toMap clouds }

```

```
# dhall-to-yaml --file ./examples/demo.dhall
cache:
  expiration:
    server: 5
clouds:
  rh:
    auth:
      auth_url: https://mycloud:5000/v2.0
      username: nodepool
    regions:
      - Public

```

[dhall-lang]: https://dhall-lang.org
[openstacksdk]: https://docs.openstack.org/openstacksdk/latest/
