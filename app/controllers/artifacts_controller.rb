# frozen_string_literal: true

class ArtifactsController < ApplicationController
  before_action :set_artifact, only: %i[show edit update destroy upvote]
  before_action :authenticate_user!, except: %i[index show]

  after_action :verify_authorized, only: %i[edit update destroy]
  after_action :verify_policy_scoped, only: :index

  def index
    @artifacts = policy_scope(Artifact).order(cached_votes_total: :asc).reverse
  end

  def show; end

  def new
    @artifact = current_user.artifacts.new
  end

  def edit;
    authorize @artifact
  end

  def create
    @artifact = current_user.artifacts.create(artifact_params)
    @artifact.user_id = current_user.id
    @artifact.company_id = current_user.company_id

    respond_to do |format|
      if @artifact.save
        format.html { redirect_to @artifact, notice: 'Your masterpiece was successfully created.' }
        format.json { render :show, status: :created, location: @artifact }
      else
        format.html { render :new }
        format.json { render json: @artifact.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @artifact
    respond_to do |format|
      if @artifact.update(artifact_params)
        format.html { redirect_to @artifact, notice: 'Your masterpiece was successfully updated.' }
        format.json { render :show, status: :ok, location: @artifact }
      else
        format.html { render :edit }
        format.json { render json: @artifact.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @artifact.destroy
    authorize @artifact
    respond_to do |format|
      format.html { redirect_to artifacts_url, notice: 'Artifact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    @artifact.upvote_by current_user
    redirect_back fallback_location: root_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_artifact
    @artifact = Artifact.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def artifact_params
    params.require(:artifact).permit(:name, :key, :user_id, :image, :description, :company_id)
  end
end
