require 'net/http'
require 'uri'
require 'curb'

class RedirectFollow
  TIMEOUT = 3 # Number of attempts before quiting

  def self.get_url(uri)
    cur_attempt = 0

    while(cur_attempt < TIMEOUT && !(uri.include?("/clk/")))
      u = URI.parse(uri)

      h = Net::HTTP.new u.host, u.port
      h.use_ssl = u.scheme == 'https'

      head = h.start do |ua|
        ua.head u.path
      end

      uri = head['location'] if head['location']
      cur_attempt += 1
    end

    # We now have the correct form we just need to fix the clk -> job & append a source
    uri.gsub!('/clk/', '/job/')
    uri += ("?src=pj")

    # Redirect again to find true url

    result = Curl::Easy.perform(uri) do |curl|
      curl.headers["User-Agent"] = "..."
      curl.verbose = false
      curl.follow_location = true
    end

    uri = result.last_effective_url # Returns the final destination URL after x redirects...
  end

end
