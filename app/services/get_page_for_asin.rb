# A service class to handle the scraping of data
class GetPageForAsin

  extend Callable

  PRODUCT_PATH = 'https://www.amazon.ca/gp/product/'.freeze

  # Amazon seems to dislike the Mechanizer user-agent and returns a 503.
  # To emulate a browser the `user_agent_alias` is set to a browser.
  # The choice of browser user_agent is arbitrary
  USER_AGENT = 'Mac Safari'.freeze

  def initialize(asin:)
    raise AsinRequiredError if asin.blank?
    @asin = asin
  end

  def call
    fetch_page_data
  rescue StandardError => exception
    raise ProductNotFoundError if exception.response_code == '404'
    raise MechanizerError, exception
  end

  private

  def fetch_page_data
    mechanizer = Mechanize.new
    mechanizer.user_agent_alias = USER_AGENT
    mechanizer.get(PRODUCT_PATH + @asin)
  end

  # Error raised when no ASIN is supplied
  class AsinRequiredError < StandardError

    def message
      "The 'asin' parameter is required."
    end

  end

  # Error raised when no product is returned for the given ASIN
  class ProductNotFoundError < StandardError

    def message
      'No product found for the supplied ASIN.'
    end

  end

  # A catch all error for Mechanizer failures
  class MechanizerError < StandardError

    def initialize(error)
      @error = error
    end

    def message
      "Mechanizer has raised an exception: #{@error.message}."
    end

  end

end
