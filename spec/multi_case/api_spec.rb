require 'spec_helper'

describe MultiCase::API do
  include MultiCase::API

  describe "simple matching" do
    it "matches two argument against pre-defined cases returning specified value" do
      result = multi_case :a, :c do
        multi(:a => :b) { 1 }
        multi(:a => :c) { 2 }
      end

      result.should == 2
    end

    it "return nil if no matches found" do
      result = multi_case :x, :y do
        multi(:a => :b) { 1 }
        multi(:a => :c) { 2 }
      end

      result.should be_nil
    end

    it "returns first match if we have multiple matches" do
      result = multi_case :x, :y do
        multi(:a => :b) { 1 }
        multi(:x => :y) { 2 }
        multi(:x => [:y, :z]) { 3 }
      end

      result.should == 2
    end

    it "doesn't execute unmatched functions" do
      expect do
        result = multi_case :a, :c do
          multi(:a => :b) { raise "oh shit" }
          multi(:a => :c) { 2 }
          multi(:a => :c) { raise "oh shittiest" }
        end
      end.not_to raise_error
    end
  end

  describe "case matching" do
    it "classes" do
      result = multi_case 'aaa', :y do
        multi(:a => :b) { 1 }
        multi(String => :y) { 2 }
      end

      result.should == 2
    end

    it "regexps" do
      result = multi_case 'aaa', :y do
        multi(:a => :b) { 1 }
        multi(/A+/i => :y) { 2 }
      end

      result.should == 2
    end

    it "ranges" do
      result = multi_case 'aaa', 100 do
        multi(:a => :b) { 1 }
        multi('aaa' => :c) { 2 }
        multi('aaa' => [:c, 99..120]) { 3 }
      end

      result.should == 3
    end
  end

  describe "array matching" do
    it "allow arbitrary input" do
      result = multi_case :a, :c do
        multi([:c, :a] => [:b, :d]) { 1 }
        multi([:c, :d] => [:c, :e]) { 2 }
        multi([:c, :a] => [:c, :e]) { 3 }
      end

      result.should == 3
    end

    it "treat empty arrays as catch-all" do
      result = multi_case :a, :c do
        multi([] => [:c]) { 1 }
      end

      result.should == 1
    end

    it "can match nested arrays" do
      result = multi_case [:a, :b], :c do
        multi([[:a, :b]] => [:c]) { 1 }
      end

      result.should == 1
    end
  end

end
