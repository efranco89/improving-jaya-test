# This method will test the method that checks the content_type
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthenticateGithub, type: :lib do
  describe 'validates_content_type' do
    context 'When content_type is application/json' do
      let(:content_type) { 'application/json' }
      it 'Does not raises error' do
        expect {
          AuthenticateGithub.send(
            :validates_content_type, content_type: content_type
          )
        }.to_not raise_error
      end
    end

    context 'When content_type is different application/json' do
      let(:content_type) { 'application/json_url_encoded_xxx' }
      it 'Raises error indicating invalid content_type' do
        expect {
          AuthenticateGithub.send(
            :validates_content_type, content_type: content_type
          )
        }.to raise_error(ArgumentError, "The #{content_type} is not a valid format")
      end
    end
  end
end
