require 'spec_helper'

describe Donor do
  it { should allow_value('melanieplaza@gmail.com', 'melanie.plaza@aya.yale.edu').for(:email) }
  it { should_not allow_value('melp', '@', 'apple@stout').for(:email)}
end
