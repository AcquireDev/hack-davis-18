class ApplicationsController < BaseController
  before_action :set_application, only: [:show, :update, :destroy]

  # Limited only to the current users applications
  # GET /applications
  # GET /applications.json
  def index
    if(application_params.has_key?(:job_board_id))
      applications = authorized_user.applications.joins(:listing).where("listings.job_board_id = ?", application_params[:job_board_id])
    else
      applications = authorized_user.applications
    end
    @not_applied = applications.where(stage: "not_applied").ordered
    @applied = applications.where(stage: "applied").ordered
    @interviewing = applications.where(stage: "interviewing").ordered
    @hidden = applications.where(stage: "hidden").ordered
    @rejected = applications.where(stage: "rejected").ordered
    @offer = applications.where(stage: "offer").ordered
    @accepted = applications.where(stage: "accepted").ordered
  end

  # GET /applications/1
  # GET /applications/1.json
  def show
  end

  # POST /applications
  # POST /applications.json
  def create
    @application = Application.new(application_params)

    if @application.save
      render :show, status: :created, location: @application
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /applications/1
  # PATCH/PUT /applications/1.json
  def update
    if @application.update(application_params)
      if application_params.has_key?("applied") && application_params["applied"]
        @application.update_attributes(stage: "applied")
      end

      render :show, status: :ok, location: @application
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  # DELETE /applications/1
  # DELETE /applications/1.json
  def destroy
    @application.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = Application.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def application_params
      params.permit(:listing_id, :applied, :status, :notes, :user_id, :new, :stage, :job_board_id)
    end
end
