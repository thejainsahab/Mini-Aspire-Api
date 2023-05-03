class LoansController < ApplicationController
  before_action :authorize_request

  def create
    loan = Loan.create(loan_params[:amount], loan_params[:term], @current_user.id)
    render json: loan, status: :created
  rescue => e
    render json: { errors: e.message }, status: :unprocessable_entity
  end

  def approve
    raise UnauthorizedError.new("Only admins can approve loans") unless @current_user.can_approve_loans
    loan = Loan.find(params[:id])
    loan.approve
    render json: loan, status: :ok
  rescue UnauthorizedError => e
    render json: { errors: e.message }, status: :unauthorized
  rescue => e
    render json: { errors: e.message }, status: :unprocessable_entity
  end

  def index
    loans = @current_user.loans
    render json: loans, status: :ok
  end

  def view
    loan = Loan.find(params[:id])
    raise UnauthorizedError.new("This loan does not belong to you") unless @current_user.id == loan.user_id
    render json: loan, status: :ok
  rescue UnauthorizedError => e
    render json: { errors: e.message }, status: :unauthorized
  end

  def add_payment
  end

  private

  def loan_params
    params.require(:loan).permit(:amount, :term)
  end
end
