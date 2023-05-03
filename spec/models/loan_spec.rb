require 'rails_helper'

RSpec.describe Loan, type: :model do
  let(:user) { FactoryBot.build(:user, :with_basic_details) }
  let(:loan) { FactoryBot.build(:loan, amount: 10000, term: 10, state: :pending, user: user) }

  describe 'validations' do
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).is_greater_than(0) }
    it { should validate_presence_of(:term) }
    it { should validate_numericality_of(:term).is_greater_than(0) }
    it { should validate_presence_of(:state) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe '#generate_repayments' do
    it 'generates the correct number of repayments' do
      loan.save
      loan.generate_repayments
      expect(loan.repayments.count).to eq(loan.term)
    end

    it 'generates repayments with the correct amount and due date' do
      loan.save
      loan.generate_repayments
      expect(loan.repayments.first.amount).to eq((loan.amount / loan.term).round(2))
      expect(loan.repayments.first.due_date).to eq(Date.today + 7.days)
    end
  end

  describe '#repay' do
    it 'updates state of multiple repayments' do
        loan.save
        loan.generate_repayments
        loan.repay(5000)
        expect(loan.repayments.where(state: :paid).count).to eq(5)
    end

    it 'updates state of loan if all all repayments are made' do
        loan.save
        loan.generate_repayments
        loan.repay(10000)
        expect(loan.state).to eq("paid")
    end
  end
end
