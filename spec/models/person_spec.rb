require 'rails_helper'

RSpec.describe Person, type: :model do
  it 'factory is valid' do
  	expect(build(:person)).to be_valid
  end

  it 'must have a name' do
  	expect(build(:person, lastname: nil)).to_not be_valid
  end

  # it 'cant die before born' do
  # 	expect(build(:person, died: 500.years.ago)).to_not be_valid
  # end
end
