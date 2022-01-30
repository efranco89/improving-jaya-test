# This method will check for the user env variables
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthenticateUser, type: :lib do
  describe 'validates_user_tokens_present' do
    context 'When ENV[OCTO_EVENTS_USER_EMAIL] && ENV[OCTO_EVENTS_USER_PASSWORD] are set' do
      before do
        ENV['OCTO_EVENTS_USER_EMAIL'] = 'ejemplo@gmail.com'
        ENV['OCTO_EVENTS_USER_PASSWORD'] = '123456987'
      end
      it 'Does not raise error' do
        expect { AuthenticateUser.send(:validates_user_tokens_present) }.to_not raise_error
      end
    end
    context 'When ENV[OCTO_EVENTS_USER_EMAIL] && ENV[OCTO_EVENTS_USER_PASSWORD] are nil' do
      before do
        ENV.delete('OCTO_EVENTS_USER_EMAIL')
        ENV.delete('OCTO_EVENTS_USER_PASSWORD')
      end
      it 'Raises error' do
        expect { AuthenticateUser.send(:validates_user_tokens_present) }.to raise_error(
          ArgumentError, 'You have not set a ENV[OCTO_EVENTS_USER_EMAIL] or ENV[OCTO_EVENTS_USER_PASSWORD]'
        )
      end
    end

    context 'When ENV[OCTO_EVENTS_USER_EMAIL] && ENV[OCTO_EVENTS_USER_PASSWORD] are empty' do
      before do
        ENV['OCTO_EVENTS_USER_EMAIL'] = ''
        ENV['OCTO_EVENTS_USER_PASSWORD'] = ''
      end
      it 'Raises error' do
        expect { AuthenticateUser.send(:validates_user_tokens_present) }.to raise_error(
          ArgumentError, 'You have not set a ENV[OCTO_EVENTS_USER_EMAIL] or ENV[OCTO_EVENTS_USER_PASSWORD]'
        )
      end
    end
  end
end
