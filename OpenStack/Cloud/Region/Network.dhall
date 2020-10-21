{ Type =
    { name : Text
    , routes_externally : Optional Bool
    , default_interface : Optional Bool
    , nat_source : Optional Bool
    , nat_destination : Optional Bool
    }
, default =
  { routes_externally = None Bool
  , default_interface = None Bool
  , nat_source = None Bool
  , nat_destination = None Bool
  }
}
