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
                , auth_url = Some "https://mycloud:5000/v2.0"
                }
            )
        , regions = Some [ OpenStack.CloudRegion.RegionName "Public" ]
        }
      }

in  OpenStack::{ cache, clouds = toMap clouds }
