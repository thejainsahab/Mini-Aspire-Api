class Repayment < ApplicationRecord
    belongs_to :loan

    enum state: { pending: 'pending', paid: 'paid' }
  end