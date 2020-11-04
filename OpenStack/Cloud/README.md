# Cloud

A package to define a cloud configuration:

    Cloud::{
      , auth = Some
      ( Cloud.Auth.SetUser
        Cloud.Auth.User::{
          , username = Some "nodepool"
          , auth_url = "https://mycloud:5000/v2.0"
        }
      )
      , regions = Some [ Cloud.Region.RegionName "Public" ]
    }

** NOTE **
 `auth_type` should be set to `Some "v3applicationcredential` if `Cloud.Auth.SetAppCredential` is used
