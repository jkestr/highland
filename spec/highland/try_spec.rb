require File.join(File.dirname(__FILE__), "/../spec_helper" )

module Highland
  describe Try do
    describe '.do_smth' do

      it 'should do smth' do
        Try.do_smth.should == "smth"
      end

      it 'should not do other' do
        Try.do_smth.should_not == "other"
      end

    end
  end
end
