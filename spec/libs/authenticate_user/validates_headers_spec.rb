# This method will check for the request headers
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthenticateUser, type: :lib do
  describe 'verify_mandatory_headers' do
    context 'When all the headers are present and had a value' do
      let(:request_headers) {
        {
          'Content-Type':	'application/json',
          'User-Email': 'example@example.com',
          'User-Password': '123456789'
        }
      }

      it 'Does not raises error' do
        expect {
          AuthenticateUser.send(
            :verify_mandatory_headers, request_headers: request_headers
          )
        }.to_not raise_error
      end
    end

    context 'When there is a missing header' do
      let(:request_headers) {
        {
          'Content-Type':	'application/json',
          'User-Password': '123456789'
        }

      }

      it 'Raises error indicating missing key' do
        expect {
          AuthenticateUser.send(
            :verify_mandatory_headers, request_headers: request_headers
          )
        }.to raise_error(ArgumentError, 'The User-Email header is mandatory')
      end
    end

    context 'When there is a missing value' do
      let(:request_headers) {
        {
          'Content-Type':	'application/json',
          'User-Email': 'example@example.com',
          'User-Password': ''
        }

      }

      it 'Raises error indicating missing value' do
        expect {
          AuthenticateUser.send(
            :verify_mandatory_headers, request_headers: request_headers
          )
        }.to raise_error(ArgumentError, 'The User-Password header must have a value')
      end
    end

  end
end
