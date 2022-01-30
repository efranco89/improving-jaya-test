# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/events', type: :request do
  describe 'GET /index' do
    before do
      ENV['GITHUB_TOKEN'] = '123456789'
    end
    let(:body) {}
    before do
      ENV['OCTO_EVENTS_USER_EMAIL'] = 'example@example.com'
      ENV['OCTO_EVENTS_USER_PASSWORD'] = '123456789'
    end
    let(:request_headers) {
      {
        'Content-Type':	'application/json',
        'User-Email': 'example@example.com',
        'User-Password': '123456789'
      }
    }
    let!(:issues) { create_list(:issue, 2) }
    context 'When the headers are corrects' do
      it "Returns only events from the selected issue" do
        get "/issues/#{issues.first.id}/events", params: body, headers: request_headers
        expect(response.code).to eq('200')
        # should include only the first issue events
        events = JSON.parse(response.body)
        events.each do | event |
          expect(event["id"]).to eq(issues.first.github_issue_id)
        end
        events.each do | event |
          expect(event["id"]).to_not eq(issues.last.github_issue_id)
        end
      end
    end
    context 'When the headers are bad' do
      let(:request_headers) {
        {
          'Content-Type':	'application/json',
          'User-Password': '123456789'
        }
      }
      it 'Returns Internal Server Error' do
        post '/events', params: body, headers: request_headers
        expect(response.code).to eq('500')
      end
    end
  end
end
