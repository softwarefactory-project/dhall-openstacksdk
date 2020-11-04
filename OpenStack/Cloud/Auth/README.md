# Auth

A package to define an authentification method.

## User

    Auth.SetUser
      Auth.User::{
        , username = Some "my_username"
        , password = Some "my_password"
        , auth_url = "https://mycloud:5000/v2.0"
      }

## Application Credential

    Auth.SetAppCredential
      Auth.AppCredential::{
        , auth_url = "https://mycloud:5000/v3"
        , application_credential_id = "app_cred_id"
        , application_credential_secret = "app_cred_secret"
    }
