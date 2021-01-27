class MapGeocodingApi
  require 'net/http'
  require 'uri'
  require 'json'
  require 'logger'


  def self.fetch(address)
    logger = Logger.new('./geocoding_api.log')
    # set query parameter and convert to encoded url
    params = URI.encode_www_form({address: address.to_s, key: "AIzaSyAKFofeAnA3Tyxnjk650ndR9sobCRvkkvc"})

    # create a uri object
    # uri method:
    # uri.scheme  'http'
    # uri.host    'maps.googleapis.com'
    # uri.port    '80'
    # uri.path    '/maps/api/geocode/json'
    # uri.query   'address=address&key=xxxxxx'
    uri = URI.parse("https://maps.googleapis.com/maps/api/geocode/json?#{params}")

    begin
      # response = Net::HTTP.start(uri.host, uri.port) do |http|
      #   # set maximum second
      #   http.open_timeout = 5
      #   http.read_timeout = 10
      #   http.use_ssl = true
      #   http.get(uri.request_uri)
      # end
      logger.debug("uri in fetch: #{uri}")
      response = Net::HTTP.get_response(uri)
      logger.debug("response in fetch: #{response}")

      case response
      when Net::HTTPSuccss
        JSON.parse(response.body)

      when Net::HTTPRedirection
        logger.warn("Redirection: code=#{response.code} message=#{response.message}")
      else
        logger.error("HTTP ERROR: code=#{response.code} message=#{response.message}")
      end
    rescue IOError => e
      logger.error(e.message)
    rescue TimeoutError => e
      logger.error(e.message)
    rescue JSON::ParserError => e
      logger.error(e.message)
    rescue => e
      logger.error(e.message)
    end
  end
end