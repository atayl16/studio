class ArtifactsController < ApplicationController
  before_action :set_artifact, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :authenticate_user!, except: [:index, :show]
  # GET /artifacts
  # GET /artifacts.json
  def index
    @artifacts = Artifact.all
  end

  # GET /artifacts/1
  # GET /artifacts/1.json
  def show
  end

  # GET /artifacts/new
  def new
    @artifact = Artifact.new
  end

  # GET /artifacts/1/edit
  def edit
    #authorize @artifact
  end

  # POST /artifacts
  # POST /artifacts.json
  def create
    @artifact = Artifact.new(artifact_params)

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

  # PATCH/PUT /artifacts/1
  # PATCH/PUT /artifacts/1.json
  def update
    #authorize @artifact
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

  # DELETE /artifacts/1
  # DELETE /artifacts/1.json
  def destroy
    @artifact.destroy
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
      params.require(:artifact).permit(:name, :key, :user_id, :image, :description)
    end
end
