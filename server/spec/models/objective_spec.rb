require 'rails_helper'

RSpec.describe Objective, type: :model do
  it { should have_db_column(:weight).of_type(:integer).with_options(null: false) }
  it { should have_db_column(:title).of_type(:string) }

  it { should validate_presence_of(:weight) }
  it { should validate_numericality_of(:weight).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(100) }

  describe "factory" do
    subject { build(:objective) }

    it { should be_valid }
  end
end
