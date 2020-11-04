{-|
# Region

A package to define a region:

## Region name:

    CloudRegion.RegionName "my_region"

## CloudRegion with network configuration:

    CloudRegion.RegionWithParams
      { name = "my_region"
      , values.networks = Some
        [ CloudRegionNetwork::{
            , name = "public"
            , routes_externally = Some True
            , default_interface = Some True
            , nat_source = Some True
          }
          , CloudRegionNetwork::{
            , name = "private"
            , routes_externally = Some False
            , nat_destination = Some True
          }
        ]
      }
-}
{ RegionName = ./RegionName.dhall
, RegionWithParams = ./RegionWithParams.dhall
, Type = ./Type.dhall
, default = ./default.dhall
}
