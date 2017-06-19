RSpec.shared_context 'json request' do
  def json_body
    JSON.parse(response.body, symbolize_names: true)
  end
end
