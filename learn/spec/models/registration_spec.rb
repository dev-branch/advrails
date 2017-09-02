# == Schema Information
#
# Table name: registrations
#
#  id         :integer          not null, primary key
#  semester   :string           not null
#  year       :integer          not null
#  capacity   :integer          not null
#  is_open    :boolean          default(FALSE)
#  klass_id   :integer          not null
#  teacher_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Registration, type: :model do

  describe '.new' do
    it 'instantiates a Registration object' do
      r = Registration.new
      expect(r.is_a?(Registration)).to be true
      expect(r.attributes.keys.count).to eql(9)
    end
  end

end
