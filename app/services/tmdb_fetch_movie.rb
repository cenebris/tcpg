class TmdbFetchMovie
  def self.call(title)
    uri = URI('https://api.themoviedb.org/3/search/movie')
    tmdb_api_key = Rails.application.secrets.tmdb_api_key
    params = { api_key: tmdb_api_key, query: title }
    uri.query = URI.encode_www_form(params)
    response = HTTParty.get(uri)
    response['results'].first
  rescue
    nil
  end
end