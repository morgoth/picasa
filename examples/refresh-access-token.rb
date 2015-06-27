require "signet/oauth_2/client"

# Setup your private credentials
client_id = "client-id"
client_secret = "client-secret"
code = "authorization-code"

signet = Signet::OAuth2::Client.new(
  code: code,
  token_credential_uri: "https://www.googleapis.com/oauth2/v3/token",
  client_id: client_id,
  client_secret: client_secret,
  redirect_uri: "urn:ietf:wg:oauth:2.0:oob"
)
signet.fetch_access_token!
refresh_token = signet.refresh_token
# Note and store refresh_token

# In your app fetch access_token by:
signet = Signet::OAuth2::Client.new(
  client_id: client_id,
  client_secret: client_secret,
  token_credential_uri: "https://www.googleapis.com/oauth2/v3/token",
  refresh_token: refresh_token
)
signet.refresh!

# Use access token with picasa gem
signet.access_token
