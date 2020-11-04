# Region

A package to define a region:

## Region name:

    Region.RegionName "my_region"

## Region with network configuration:

    Region.RegionWithParams
      { name = "my_region"
      , values.networks = Some
        [ Region.Network::{
            , name = "public"
            , routes_externally = Some True
            , default_interface = Some True
            , nat_source = Some True
          }
          , Region.Network::{
            , name = "private"
            , routes_externally = Some False
            , nat_destination = Some True
          }
        ]
      }
