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
