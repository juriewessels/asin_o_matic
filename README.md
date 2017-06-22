# Asin-O-Matic

The Asin-O-Matic is an API that uses the custom [Asin-O-Mator](https://github.com/juriewessels/asin_o_mator) gem to scrapes and store Amazon data for a given ASIN (Amazon product number).

For a JS client that consumes the Asin-O-Matic data see the [Asin-O-Matic JS Client](https://github.com/juriewessels/asin_o_matic_js_client).

To get started simply clone the repo and run: `bin/setup`

The Asin-O-Matic runs on:

* Ruby 2.4.1
* Rails 5.1 (API Only)

#### Notes
* The Asin-O-Matic :
  * Uses the custom [Asin-O-Mator](https://github.com/juriewessels/asin_o_mator) gem to scrape and parse Amazon product data.
  * Generates JSON output using [`jbuilder`](https://github.com/rails/jbuilder).
  * Is well tested with [`RSpec`](https://github.com/rspec/rspec-rails) request specs and uses [`VCR`](https://github.com/vcr/vcr) to test against recorded Amazon page responses. The first time the specs are executed the response will be recorded. If no recordring are present the first spec execution will be slower due to response recording.
