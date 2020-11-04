# Config

A package to define a cloud and cache for clouds.yaml configuration file:

    Config::{
    , cache = Some
      { expiration = Some Config.Cache.Expiration::{ server = Some 5 }
      }
    , clouds = toMap
        { cloud = Cloud::{
          , auth = Some
              ( Cloud.Auth.SetUser
                  Cloud.Auth.User::{
                  , username = Some "nodepool"
                  , auth_url = "https://mycloud:5000/v2.0"
                  }
              )
          , regions = Some [ Cloud.Region.RegionName "Public" ]
          }
        }
    }
