require 'rails_helper'

RSpec.describe Person, type: :model do
  it 'factory is valid' do
  	expect(build(:person)).to be_valid
  end
  it 'wont initialize without a name' do
    expect(Person.new).to_not be_valid
  end 

  it 'must have a name' do
  	expect(build(:person, lastname: nil)).to_not be_valid
  end

  it 'must return correct name' do
    person = Person.create(firstname: 'joe', lastname: 'bloggs')
    expect(person.fullname).to eq('joe bloggs')
  end

  it 'must return correct name' do
    person = Person.create(firstname: 'joe', lastname: 'bloggs', middlenames: 'alexander')
    expect(person.fullname).to eq('joe alexander bloggs')
  end

  it 'must return correct age' do 
    person = Person.create(firstname: 'joe', lastname: 'bloggs', dob: '2000/01/01', died: '2015/01/01')
    expect(person.age).to eq(15)
  end
#   it 'must return correct name' do
#     create(:person, firstname: "joe", lastname: 'bloggs')
#     expect()
#   #   expect(build(:person, firstname: "joe", lastname: 'bloggs')).to eq("joe bloggs")
#   # end
#   it 'returns the average if there are enough submissions' do
# { create(:mpg_submission, mpg: 25, vehicle: subject) }
#     expect(subject.average_mpg).to eq(27.5)
#   end

  # it 'cant die before born' do
  # 	expect(build(:person, died: 500.years.ago)).to_not be_valid
  # end
end
