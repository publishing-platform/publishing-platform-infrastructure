# search-secrets

The purpose of this module is to decouple the [`search`](./modules/search/) module from AWS secrets. It is a temporary cost saving measure that allows secrets to be deleted when not in use without requiring full tear-down of search infrastructure.

This module contains the secrets required by the `search-api` app to access Google Vertex AI Search.