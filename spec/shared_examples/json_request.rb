RSpec.shared_context 'json request' do
  # a helper method used to convert JSON responses into
  # a ruby Hash with symbolized keys
  def json_body
    JSON.parse(response.body, symbolize_names: true)
  end
end
