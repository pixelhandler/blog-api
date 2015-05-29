require 'rails_helper'
require 'digest'

RSpec.describe Commenter, type: :model do

  email = 'solo@rebels.com'

  before(:all) do
    @commenter = Commenter.create({ :name => 'hanssolo', :email => email });
  end

  after(:all) do
    @commenter.delete
  end

  it 'creates a hash of the email address' do
    expect( @commenter ).to be_truthy
    expect( @commenter.email_hash ).to be_truthy

    md5 = Digest::MD5.new
    md5 << email

    expect( @commenter.email_hash ).to eq md5.hexdigest
  end
end
