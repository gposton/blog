Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "1rEUkYXaMnLqWJerTwyfQ", "RhXhZq9HWvEOgfHNkZP8wWwNp0Gu9i0Wtb4bleCdSw"
  provider :openid, :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
  provider :facebook, "f8d262f7f4301159aba4d96e814e1d26", "bd5ea82907de4124a488a252ab910e78"
end
