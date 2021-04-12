require 'rails_helper'

RSpec.describe 'Configuration' do
  describe '.configure' do
    it 'yields a block with the config argument' do
      block = nil
     Userstamper.configure do |config|
        block = config
      end
      expect(block).to be(Userstamper::Configuration)
    end
  end

  describe '.config' do
    it 'matches default_stamper and default_stamper_class' do
      config = Userstamper.config
      expect(config.default_stamper_class.name).to eq(config.default_stamper)
    end
  end
end
