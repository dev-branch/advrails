# == Schema Information
#
# Table name: klasses
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  subject    :string           not null
#  level      :integer          not null
#  credits    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Klass, type: :model do

  describe '.new' do
    it 'instantiates a Klass object' do
      c = Klass.new
      expect(c.is_a?(Klass)).to be true
      expect(c.attributes.keys.count).to eql(7)
    end
  end

end
