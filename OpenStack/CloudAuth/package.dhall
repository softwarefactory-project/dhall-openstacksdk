{-|
# Auth

A package to define an authentification method.

## User

    CloudAuth.SetUser
      CloudAuth.User::{
        , username = Some "my_username"
        , password = Some "my_password"
        , auth_url = "https://mycloud:5000/v2.0"
      }

## Application Credential

    CloudAuth.SetAppCredential
      CloudAuth.AppCredential::{
        , auth_url = "https://mycloud:5000/v3"
        , application_credential_id = "app_cred_id"
        , application_credential_secret = "app_cred_secret"
    }
-}
{ AppCredential = ./AppCredential.dhall
, SetAppCredential = ./SetAppCredential.dhall
, SetUser = ./SetUser.dhall
, Type = ./Type.dhall
, User = ./User.dhall
}
