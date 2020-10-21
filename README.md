# dhall-openstacksdk

`dhall-openstacksdk` contains [Dhall][dhall-lang] bindings to [OpenStack][openstacksdk],
so you can generate openstack configuration from Dhall expressions.

## Example

```dhall
-- ./examples/demo.dhall
let OpenStack = ../package.dhall

let cache =
      Some
        { expiration = Some OpenStack.Config.Cache.Expiration::{
          , server = Some 5
          }
        }

let clouds =
      { rh = OpenStack.Cloud::{
        , auth = Some OpenStack.Cloud.Auth::{
          , username = Some "nodepool"
          , auth_url = "https://mycloud:5000/v2.0"
          }
        , regions = Some [ OpenStack.Cloud.Region.Union.regionName "Public" ]
        }
      }

in  OpenStack.Config::{ cache, clouds = toMap clouds }

```
[dhall-lang]: https://dhall-lang.org
[openstacksdk]: https://docs.openstack.org/openstacksdk/latest/
