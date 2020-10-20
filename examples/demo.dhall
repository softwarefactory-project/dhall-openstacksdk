let OpenStack = ../package.dhall

let clouds =
      { rh = OpenStack.Cloud::{
        , auth = Some OpenStack.Cloud.Auth::{ username = Some "nodepool" }
        , regions = Some [ { name = "Public" } ]
        }
      }

in  OpenStack.Config::{ clouds = toMap clouds }
