{ api_timeout : Optional Natural
, auth : Optional ../CloudAuth/Type.dhall
, auth_type : Optional Text
, identity_api_version : Optional Natural
, image_format : Optional Text
, interface : Optional Text
, networks : Optional (List ../CloudNetwork/Type.dhall)
, profile : Optional Text
, regions : Optional (List ../CloudRegion/Type.dhall)
, region_name : Optional Text
}
