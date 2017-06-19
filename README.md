# Asin-O-Matic

For an amazing JS client see the [Asin-O-Matic JS Client](https://github.com/juriewessels/asin_o_matic_js_client).

To get started simply clone the repo and run: `bin/setup`

The Asin-O-Matic runs on:

* Ruby 2.4.1
* Rails 5.1 (API Only)

#### Notes
* The Asin-O-Matic :
  * Uses the [`Mechanize`](https://github.com/sparklemotion/mechanize) gem to scrape Amazon pages for a given ASIN.
  * Generates JSON output using [`jbuilder`](https://github.com/rails/jbuilder).
  * Leverages the power of a data object using [`Virtus`](https://github.com/solnic/virtus) to extract product data from scraped page objects.
  * Is well tested with [`RSpec`](https://github.com/rspec/rspec-rails) request specs and uses [`VCR`](https://github.com/vcr/vcr) to test against recorded Amazon page responses. The first time the specs are executed the response will be recorded. If no recordring are present the first spec execution will be slower due to response recording.
