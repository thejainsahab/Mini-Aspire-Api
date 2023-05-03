class Loan < ApplicationRecord
  belongs_to :user
  has_many :repayments
  
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :term, presence: true, numericality: { greater_than: 0 }
  validates :state, presence: true

  enum state: { pending: 'pending', approved: 'approved', paid: 'paid' }

  scope :pending, -> { where(state: :pending) }
  scope :approved, -> { where(state: :approved) }

  def self.create(amount, term, user_id)
    loan = Loan.new(amount: amount, term: term, user_id: user_id, state: :pending)
    loan.save!
    loan.generate_repayments
    loan
  end

  def generate_repayments
    start_date = Date.today
    repayments = []
    (1..term).each do |i|
      due_date = start_date + (i * 7).days
      amount = (self.amount / term).round(2)
      repayments << { loan_id: self.id, due_date: due_date, amount: amount, state: :pending }
    end
    Repayment.create(repayments)
  end

  def approve
    self.update_attribute(:state, :approved)
  end
  
  def repay(amount)
    self.repayments.where(state: :pending).order(:due_date).each do |repayment|
      if amount >= repayment.amount
        repayment.update(state: :paid)
        amount -= repayment.amount
      else
        break
      end
    end
    
    if repayments.all? { |repayment| repayment.paid? }
      update(state: :paid)
    end
    self.repayments
  end
end
