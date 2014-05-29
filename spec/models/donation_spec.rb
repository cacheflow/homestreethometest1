require 'spec_helper'

describe Donation do
  it { should validate_numericality_of(:amount).only_integer }
  it { should belong_to(:donor) }
  it { should belong_to(:resident) }
end
