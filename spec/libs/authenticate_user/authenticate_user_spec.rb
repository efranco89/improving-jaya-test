# This method will test the method that authenticates the posts from the webhook
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthenticateUser, type: :lib do

  describe 'grant_access' do

    let(:request_headers) {
      {
        'Content-Type':	'application/json',
        'User-Email': 'example@example.com',
        'User-Password': '123456789'
      }
    }

    let(:body) {}

    context 'When the user tokens match' do
      before do
        ENV['OCTO_EVENTS_USER_EMAIL'] = 'example@example.com'
        ENV['OCTO_EVENTS_USER_PASSWORD'] = '123456789'
      end

      let(:authenticated_user) {
        AuthenticateUser.grant_access(
          request_headers: request_headers,
          body: body
        )
      }

      it 'Returns ok and a confirmation message' do
        expect(authenticated_user).to_not be_nil
        expect(authenticated_user).to be_an_instance_of(Array)
        expect(authenticated_user[0]).to eq(:ok)
        expect(authenticated_user[1]).to eq('User tokens are valid')
      end
    end

    context 'When the user tokens do not match' do
      before do
        ENV['OCTO_EVENTS_USER_EMAIL'] = 'example@example.com'
        ENV['OCTO_EVENTS_USER_PASSWORD'] = '123456987'
      end

      let(:authenticated_user) {
        AuthenticateUser.grant_access(
          request_headers: request_headers,
          body: body
        )
      }

      it 'Returns error and an error message ' do
        expect(authenticated_user).to_not be_nil
        expect(authenticated_user).to be_an_instance_of(Array)
        expect(authenticated_user[0]).to eq(:error)
        expect(authenticated_user[1]).to eq('User tokens are invalid')
      end
    end

    context 'When the headers are incomplete' do

      let(:request_headers) {
        {
          'Content-Type':	'application/json',
          'User-Password': '123456789'
        }
      }

      before do
        ENV['OCTO_EVENTS_USER_EMAIL'] = 'example@example.com'
        ENV['OCTO_EVENTS_USER_PASSWORD'] = '123456789'
      end

      let(:authenticated_user) {
        AuthenticateUser.grant_access(
          request_headers: request_headers,
          body: body
        )
      }

      it 'Returns error and an error message ' do
        expect(authenticated_user).to_not be_nil
        expect(authenticated_user).to be_an_instance_of(Array)
        expect(authenticated_user[0]).to eq(:error)
        expect(authenticated_user[1]).to eq('The User-Email header is mandatory')
      end
    end

    context 'When the content_type is not valid' do

      let(:request_headers) {
        {
          'Content-Type':	'application/json_url_encoded_xxx',
          'User-Email': 'example@example.com',
          'User-Password': '123456789'
        }
      }

      before do
        ENV['OCTO_EVENTS_USER_EMAIL'] = 'example@example.com'
        ENV['OCTO_EVENTS_USER_PASSWORD'] = '123456789'
      end

      let(:authenticated_user) {
        AuthenticateUser.grant_access(
          request_headers: request_headers,
          body: body
        )
      }

      it 'Returns error and an error message ' do
        expect(authenticated_user).to_not be_nil
        expect(authenticated_user).to be_an_instance_of(Array)
        expect(authenticated_user[0]).to eq(:error)
        expect(authenticated_user[1]).to eq('The application/json_url_encoded_xxx is not a valid format')
      end
    end

  end
end
