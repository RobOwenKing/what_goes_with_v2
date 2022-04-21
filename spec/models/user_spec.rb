require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'name' do
    it { should validate_presence_of(:name) }
  end
  describe 'role' do
    it 'should default to member' do
      user = User.create(
        email: 'test@example.com',
        password: 'password123',
        password_confirmation: 'password123',
        name: 'Dentarthurdent'
      )
      expect(user.role).to eq(1)
    end
    it 'should ignore values as a param' do
      user = User.create(
        email: 'test@example.com',
        password: 'password123',
        password_confirmation: 'password123',
        name: 'Dentarthurdent',
        role: 2
      )
      expect(user.role).to eq(1)
    end
  end
end
