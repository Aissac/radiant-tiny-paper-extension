require File.dirname(__FILE__) + '/../spec_helper'

describe Asset do
  
  before do
    @asset = create_asset
  end

  it "is valid" do
    @asset.should be_valid
  end
  
  it "responds to named scope by_title" do
    Asset.respond_to?(:by_title).should be_true
  end
  
  ['title', 'asset_content_type'].each do |i|
    it "sorts by known column #{i}" do
      Asset.should_receive(:paginate).with(:page => 1, :per_page => 25, :order => "#{i} asc", :conditions => nil)
      Asset.assets_paginate(:sort_by => i, :sort_order => 'asc', :page => 1, :conditions => nil)
    end
  end
  
  it "does not sort by unknown column" do
    Asset.should_receive(:paginate).with(:page => 1, :per_page => 25, :conditions => nil)
    Asset.assets_paginate(:sort_by => 'test', :sort_order => 'asc', :page => 1, :conditions => nil)
  end
  
  it "does not sort by unknown sort order attribute" do
    Asset.should_receive(:paginate).with(:page => 1, :per_page => 25, :conditions => nil)
    Asset.assets_paginate(:sort_by => 'title', :sort_order => 'test', :page => 1, :condtions => nil)
  end
  
  it "filters by title" do
    foo = mock("proxy")
    foo.should_receive(:paginate)
    Asset.should_receive(:by_title).with('test').and_return(foo)
    Asset.assets_paginate(:title => 'test')
  end

private
  def create_asset(options = {})
    @asset = Asset.new({:caption => 'test_caption', :title => 'test_title', :asset_file_name => 'test_asset_file_name', :asset_content_type => 'test_asset_content_type'}.merge(options))
    @asset.save
    @asset
  end
end