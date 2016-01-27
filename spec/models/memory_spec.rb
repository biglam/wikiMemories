require 'rails_helper'

RSpec.describe Memory, type: :model do
  
 it 'factory is valid' do
  expect(build(:memory)).to be_valid
 end
 it 'wont initialize without a name' do
   expect(Memory.new).to_not be_valid
 end 

 it 'must have a title' do
  expect(build(:memory, title: nil)).to_not be_valid
 end

 it 'must have a story' do
  expect(build(:memory, story: nil)).to_not be_valid
 end

 it 'must report correct vote count' do
  mem = Memory.create!(title: 'woo', story: 'hoo', user_id: 1)
  6.times do 
    mem.votes.create(user_id: 1, value: 1)
  end
  5.times do
    mem.votes.create(user_id: 1, value: -1)
  end
  mem.update_ranking_from_votes
  expect(mem.ranking).to eq(1)
 end


end
