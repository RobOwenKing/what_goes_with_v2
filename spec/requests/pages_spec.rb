require 'rails_helper'

RSpec.describe 'Pages', type: :request do
  describe 'GET /' do
    it 'should display the home page' do
      get root_path

      expect(response).to have_http_status(200)
      expect(response.body).to include('What goes with')
    end
  end
end
