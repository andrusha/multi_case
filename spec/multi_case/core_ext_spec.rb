require 'spec_helper'
require 'multi_case/core_ext'

def f
  multi_case :a, :b do
    multi(:a => :b) { 1 }
  end
end

describe "core extensions" do
  it "makes multi_case global function" do
    value = multi_case :a, :b do
      multi(:a => :b) { 1 }
    end

    value.should == 1
  end

  it "allow you to call it from inside arbitrary function" do
    f.should == 1
  end

  it "is accessible from inside another class" do
    Class.new do
      def f
        multi_case :a, :b do
          multi(:a => :b) { 1 }
        end
      end
    end.new.f.should == 1
  end
end
