class MovieDecorator < Draper::Decorator
  delegate_all

  def cover
    'http://lorempixel.com/100/150/' + %W(abstract nightlife transport).sample + '?a=' + SecureRandom.uuid
  end

  def tmdb_poster
    tmdb = get_tmdb_data(title)
    'https://image.tmdb.org/t/p/w500' + tmdb['poster_path']
  rescue
    nil
  end

  def tmdb_vote_average
    tmdb = get_tmdb_data(title)
    tmdb['vote_average']
  rescue
    nil
  end

  def tmdb_overview
    tmdb = get_tmdb_data(title)
    tmdb['overview']
  rescue
    nil
  end

  def get_tmdb_data(title)
    Rails.cache.fetch(title, expires_in: 5.minutes) { TmdbFetchMovie.call(title) }
  end
end
 
