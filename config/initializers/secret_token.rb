# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
Timestamps::Application.config.secret_token = = ENV['SECRET_KEY_BASE'] || '49f8e2e1ce765cc4a310f1ce8108a260a42987da7dd2b3406897bb37906e73e113fa452eef8f1489f8de8eccb9954ca9b359c8124c255ac3aac367af3418cb04'
