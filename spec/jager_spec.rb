require 'jager'

describe Jager::CloudNet do
  describe '.setup' do
    context 'initialize the CloudNet necessary arragements' do
      it 'return new CloudNet object' do
        obj = Jager::CloudNet.new
        expect(obj)
      end 
    end 
  end
end