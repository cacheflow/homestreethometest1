require 'spec_helper'

describe Donation do
  it { should validate_numericality_of(:amount).only_integer }
end
