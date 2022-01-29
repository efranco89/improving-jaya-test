# This method will check for the request headers
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthenticateGithub, type: :lib do
  describe 'validates_github_token_present' do
    context 'When there is ENV[\'GITHUB_TOKEN\']' do
      before do
        ENV['GITHUB_TOKEN'] = '123456789'
      end
      it 'Does not raises error' do
        expect { AuthenticateGithub.send(:validates_github_token_present) }.to_not raise_error
      end
    end
    context 'When ENV[\'GITHUB_TOKEN\'] is nil' do
      before do
        ENV.delete('GITHUB_TOKEN')
      end
      it 'Raises error' do
        expect { AuthenticateGithub.send(:validates_github_token_present) }.to raise_error(
          ArgumentError, 'You have not set a ENV[\'GITHUB_TOKEN\']'
        )
      end
    end
    context 'When ENV[\'GITHUB_TOKEN\'] is empty' do
      before do
        ENV['GITHUB_TOKEN'] = ''
      end
      it 'Raises error' do
        expect { AuthenticateGithub.send(:validates_github_token_present) }.to raise_error(
          ArgumentError, ('You have not set a ENV[\'GITHUB_TOKEN\']')
        )
      end
    end
  end
end
