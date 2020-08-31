# frozen_string_literal: true

class CompaniesController < ApplicationController
  before_action :set_company, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  before_action :redirect_to_company, only: %i[edit update]

  after_action :verify_authorized, except: %i[index show new create]
  after_action :verify_policy_scoped, only: %i[index]

  def index
    @companies = policy_scope(Company).reverse
  end

  def show; end

  def new
    @company = Company.new
  end

  def edit;
    authorize @company
  end

  def create
    @company = Company.create(company_params)
    @company.user_id = current_user.id

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @company
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @company.destroy
    authorize @company
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_company
    @company = Company.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def company_params
    params.require(:company).permit(:name, :user_id)
  end

  def redirect_to_company
    @current_user = current_user
    unless @current_user.stripe_subscription_id?
      redirect_to @company, notice: 'You do not have a subscription.' and return
    end
  end
end
