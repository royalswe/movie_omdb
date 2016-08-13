class Imdb
  include HTTParty

  api_key = Rails.application.secrets.api_key
  base_uri "omdbapi.com/?#{api_key}"
  CACHE_POLICY = lambda { 1.days.ago }

  def self.search(title, year)
    encoded_url = URI.encode(title)
    get("s=#{encoded_url}&y=#{year}")
  end

  def self.get_info(id)
    get("i=#{id}&plot=short")
  end

end
