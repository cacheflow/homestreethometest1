require 'spec_helper'

describe Partner do
  it { should have_many(:residents) }
end
