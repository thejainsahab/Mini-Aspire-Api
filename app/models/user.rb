class User < ApplicationRecord
    has_secure_password
    
    validates :email, presence: true, uniqueness: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :username, presence: true, uniqueness: true
    validates :password,length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
    
    def can_approve_loans
        self.is_admin
    end
    
    def loans
        Loan.where(user_id: self.id)
    end
end