# Omnic-ArchivedHandlers
No longer functional or otherwise de-supported handlers for Omnic.

### Minecraft Status
Displayed basic status information for a custom Minecraft server.

Handler: `handlers/minecraft_status_handler.rb`

Config:
```ruby
config.handlers.minecraft_status do |minecraft|
  minecraft.service_base_url = '' # Status API base URL
  minecraft.status_endpoint = 'server/status'
  minecraft.server_url = '' # Minecraft server URL
end
```

### Radio
Showed status of a custom streaming radio station and allowed queuing tracks to play next. 

Handler: `handlers/radio_api_handler.rb`

Config: 
```ruby
config.handlers.radio_api do |api|
  api.public_key = '' # API public key
  api.private_key = '' # API private key
  api.radio_name = '' # Name of the radio station
  api.base_url = '' # Base URL of the radio API
  api.splash_image = '' # URI of the splash image to use

  api.endpoints do |endpoint|
    endpoint.icecast = '/api/stats/icecast'
    endpoint.share = '/api/stats/share'
    endpoint.history_current = '/api/history/current'
    endpoint.history_by_date = '/api/history/date'
    endpoint.skip = '/api/skip'
    endpoint.file_request = '/api/request/file'
    endpoint.folder_request = '/api/request/folder'
    endpoint.id_request = '/api/request/id'
  end
end
```

### Reddit Search
Allowed searching a set of subreddits and posted a random image from the results.

Handler: `handlers/reddit_search_handler.rb`

Config:
```ruby
config.handlers.reddit do |reddit|
  reddit.client_id = '' # Reddit API client ID
  reddit.client_secret = '' # Reddit API client secret
  reddit.subreddit_list_file = '' # Path to file that lists subreddits to search
  reddit.subs_per_request = 10
  reddit.results_per_request = 50
  reddit.media_only = false
  reddit.concurrent_requests = 5
end
```

### OWL
Showed information about the Overwatch League from their API.

Handler: `handlers/owl_handler.rb`

Config:
```ruby
config.handlers.owl_api do |api|
  api.base_url = 'https://api.overwatchleague.com'
  api.website_url = 'https://overwatchleague.com'
  api.icon_url = 'https://blznav.akamaized.net/img/esports/esports-mobile-overwatch-ce8dd5ae960a11f8.png'
  api.locale = 'en-us'

  api.endpoints do |endpoint|
    endpoint.teams = '/teams'
    endpoint.team_detail = '/v2/team'
    endpoint.ranking = '/ranking'
    endpoint.schedule = '/schedule'
    endpoint.live_match = '/live-match'
    endpoint.maps = '/maps'
    endpoint.standings = '/v2/standings'
    endpoint.players = '/players'
  end
end
```

### OWC
Showed information about Overwatch Contenders from their API.

Handler: `handlers/owc_handler.rb`

Config:
```ruby
config.handlers.owc_api do |api|
  api.base_url = 'https://api.overwatchcontenders.com'
  api.website_url = 'https://overwatchcontenders.com'
  api.icon_url = 'https://d29lsjvrzx3tjj.cloudfront.net/5.20.1/assets/themes/ow-contenders/images/favicon.png'
  api.home_color = '0x8cba11'
  api.locale = 'en-us'

  api.endpoints do |endpoint|
    endpoint.regions = '/regions'
    endpoint.teams = '/teams'
    endpoint.team_detail = '/team'
    endpoint.ranking = '/ranking'
    endpoint.schedule = '/schedule'
    endpoint.live_match = '/live-match'
    endpoint.maps = '/maps'
    endpoint.standings = '/standings'
    endpoint.brackets = '/brackets'
  end
end
```

### OW Status
Set currently-live OWL/OWC games as the bot's status.

Handler: `handlers/ow_status_handler.rb`

Config:
```ruby
config.handlers.ow_status do |status|
  status.owc_base_url = 'https://api.overwatchcontenders.com'
  status.owc_stream = 'https://www.twitch.tv/overwatchcontenders'
  status.owc_channel_id = 'UCWPW0pjx6gncOEnTW8kYzrg' # Youtube channel ID
  status.owl_base_url = 'https://api.overwatchleague.com'
  status.owl_stream = 'https://www.twitch.tv/overwatchleague'
  status.owl_channel_id = 'UCiAInBL9kUzz1XRxk66v-gw' # Youtube channel ID
  status.min_sleep_time = 60 * 10 # 10 minutes (in seconds)
  status.max_sleep_time = 60 * 90 # 90 minutes (in seconds)
  status.max_game_time = 3 # hours
  status.locale = 'en-us'
  status.app_name = 'Omnic'
  status.credentials_file = '' # Path to the credentials file

  status.owc_endpoints do |endpoint|
    endpoint.live_match = '/live-match'
  end

  status.owl_endpoints do |endpoint|
    endpoint.live_match = '/live-match'
  end
end
```

### OW Patch
Showed Overwatch patch information.

Handler: `handlers/ow_patch_handler.rb`

Config:
```ruby
config.handlers.ow_patch do |patch|
  patch.base_url = 'https://blizztrack.com'
  patch.versions_url_pattern = '/api/%s/info/json'
  patch.notes_url_pattern = '/feeds/%s/notes/json'

  patch.realms = {
    Live: 'overwatch',
    PTR: 'overwatch_ptr',
    'Pro 1': 'overwatch_professional',
    'Pro 2': 'overwatch_professional_2'
  }
end
```
