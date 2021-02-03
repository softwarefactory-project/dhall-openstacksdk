{-|
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
-}
{ Type =
    ./Type.dhall sha256:08963e1f93536091307361ba7a8b431f2a3a16ffdfa19d14ba152c361da86b17
, default =
    ./default.dhall sha256:7cd056a4029504affab137d71aae2a9c63e08b71136e879ab28f3f0751604b69
, Cache =
    ./Cache/package.dhall sha256:870628e1e8537986368f54da95d53830ae319ddca3528a8781ce661944274771
, CacheExpiration =
    ./CacheExpiration/package.dhall sha256:92334db1d0768a6e3594736cb2b19331297a49e09a4352cd65548768fd891145
, Cloud =
    ./Cloud/package.dhall sha256:7d0f738693572bc4cb49c4ffa412a90a384136f310011c3fd45d4fa10ee65d4c
, CloudAuth =
    ./CloudAuth/package.dhall sha256:ade92ac45bc4633a394eed909afc9f6cf4b14be41ba28ae84d66d398ce05a411
, CloudNetwork =
    ./CloudNetwork/package.dhall sha256:e8f1e57415687ba3d7d606eee34d5b2325577f56b40156e1ee721b6ccbbfde2d
, CloudRegion =
    ./CloudRegion/package.dhall sha256:6f0de2fb5a3ecfa86170c7e024e82b9e483c749bfef58221aa194437e429b4e3
, CloudRegionNetwork =
    ./CloudRegionNetwork/package.dhall sha256:e8f1e57415687ba3d7d606eee34d5b2325577f56b40156e1ee721b6ccbbfde2d
}
