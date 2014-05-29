require 'spec_helper'

describe Resident do
	it { should have_many(:donations) }
	it { should have_many(:donors).through(:donations) }
	it { should have_many(:statuses) }
	it { should belong_to(:partner) }
	it { should allow_value('marcy jean', 'shirley que').for(:name) }
  	it { should_not allow_value('winna').for(:name) }
  	it { should_not allow_value('$winna here').for(:name) }
  	it { should validate_presence_of(:name) }
  	it { should validate_presence_of(:bio) }
  	it { should validate_presence_of(:goals) }
end
