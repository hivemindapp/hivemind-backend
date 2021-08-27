require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
    it { should have_many(:comments).dependent(:destroy) }
  end
end
