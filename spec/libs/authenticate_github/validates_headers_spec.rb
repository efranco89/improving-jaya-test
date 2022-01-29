# This method will check for the request headers
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthenticateGithub, type: :lib do
  describe 'verify_mandatory_headers' do
    context 'When all the headers are present and had a value' do
      let(:request_headers) {
        {
          'Content-Type':	'application/json',
          'X-Github-Event':	'issue_comment',
          'X-Hub-Signature': 'sha1=12c6b5721e813a955265c48a6fe9dbf01368bbbb',
          'X-Hub-Signature-256':	'sha256=2417365a3f1d442b24a8cc7b75fa67992c95ec0ccfe3c97110b96f55971e0953'
        }
      }

      it 'Does not raises error' do
        expect {
          AuthenticateGithub.send(
            :verify_mandatory_headers, request_headers: request_headers
          )
        }.to_not raise_error
      end
    end

    context 'When there is a missing header' do
      let(:request_headers) {
        {
          'X-Github-Event':	'issue_comment',
          'X-Hub-Signature': 'sha1=7183d7de5eaa11dc8872654858628f29729106c2',
          'X-Hub-Signature-256':	'sha256=05e12c2569ebccc48ea91176f5febd0148d35983cd279fe44c822996a10f3948'
        }

      }

      it 'Raises error indicating missing key' do
        expect {
          AuthenticateGithub.send(
            :verify_mandatory_headers, request_headers: request_headers
          )
        }.to raise_error(ArgumentError, 'The Content-Type header is mandatory')
      end
    end

    context 'When there is a missing value' do
      let(:request_headers) {
        {
          'Content-Type':	'',
          'X-Github-Event':	'issue_comment',
          'X-Hub-Signature': 'sha1=7183d7de5eaa11dc8872654858628f29729106c2',
          'X-Hub-Signature-256':	'sha256=05e12c2569ebccc48ea91176f5febd0148d35983cd279fe44c822996a10f3948'
        }

      }

      it 'Raises error indicating missing value' do
        expect {
          AuthenticateGithub.send(
            :verify_mandatory_headers, request_headers: request_headers
          )
        }.to raise_error(ArgumentError, 'The Content-Type header must have a value')
      end
    end

  end
end
