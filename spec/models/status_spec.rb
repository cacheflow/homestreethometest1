require 'spec_helper'

describe Status do
  it { should belong_to(:resident) }
  it { should validate_presence_of(:content) }
  it '#edit_content' do
  	@badstatus = Status.create(content: 'things are fuckin terrible')
  	@meanstatus = Status.create(content: 'i hate these pieces of shit')
  	expect(@badstatus.edit_content).to eq('things are puppyin terrible')
  	expect(@meanstatus.edit_content).to eq('i hate these pieces of puppy')
  end
end
