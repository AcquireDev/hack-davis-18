class ApplicationsController < BaseController
  before_action :set_application, only: [:show, :update, :destroy]

  # Limited only to the current users applications
  # GET /applications
  # GET /applications.json
  def index
    if(application_params.has_key?(:new))
      @applications = authorized_user.applications.where(status: "new").order(:applied)
    elsif(application_params.has_key?(:stage))
      @applications = authorized_user.applications.where(stage: application_params["stage"])
    else
      @applications = authorized_user.applications.where.not(status: "new").order(:applied)
    end
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
      if @application.not_applied? && @application.applied
        @application.update_attributes(stage: applied)
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
      params.permit(:listing_id, :applied, :status, :notes, :user_id, :new, :stage)
    end
end
