# dhall-openstacksdk

`dhall-openstacksdk` contains [Dhall][dhall-lang] bindings to [OpenStack][openstacksdk],
so you can generate openstack configuration from Dhall expressions.

## Example

```dhall
-- ./examples/demo.dhall
let OpenStack = ../package.dhall

let clouds =
      { rh = OpenStack.Cloud::{
        , auth = Some OpenStack.Cloud.Auth::{ username = Some "nodepool" }
        , regions = Some [ { name = "Public" } ]
        }
      }

in  OpenStack.Config::{ clouds = toMap clouds }

```
[dhall-lang]: https://dhall-lang.org
[openstacksdk]: https://docs.openstack.org/openstacksdk/latest/
