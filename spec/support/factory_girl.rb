RSpec.configure do |config|
  # Include FactoryGirl Syntax Methods
  config.include FactoryGirl::Syntax::Methods

  # Spring and FactoryGirl don't always play nice together. This makes sure the Factory
  # definitions are available.
  config.before(:all) do
    FactoryGirl.reload
  end
end
