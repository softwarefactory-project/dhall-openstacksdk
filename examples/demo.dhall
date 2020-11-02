let OpenStack = ../package.dhall

let cache =
      Some
        { expiration = Some OpenStack.Config.Cache.Expiration::{
          , server = Some 5
          }
        }

let clouds =
      { rh = OpenStack.Cloud::{
        , auth = Some
            ( OpenStack.Cloud.Auth.Union.user
                OpenStack.Cloud.Auth.User::{
                , username = Some "nodepool"
                , auth_url = "https://mycloud:5000/v2.0"
                }
            )
        , regions = Some [ OpenStack.Cloud.Region.Union.regionName "Public" ]
        }
      }

in  OpenStack.Config::{ cache, clouds = toMap clouds }
