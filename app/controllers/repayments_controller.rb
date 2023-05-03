class RepaymentsController < ApplicationController
    before_action :authorize_request
    before_action :set_loan
    before_action :authorize_loan

    def index
        repayments = @loan.repayments
        render json: repayments, status: :ok
    end

    def add_payment
        amount = params[:amount].to_f
        repayments = @loan.repay(amount)
        render json: repayments, status: :ok
    end

    private

    def set_loan
        @loan = Loan.find(params[:id])
    end

    def authorize_loan
        raise UnauthorizedError.new("This loan does not belong to you") unless @current_user.id == @loan.user_id
    end
end
