class JobBoardsController < BaseController
  # before_action :set_job_board, only: [:show, :update, :destroy]

  # GET /job_boards
  # GET /job_boards.json
  def index
    @job_boards = JobBoard.all
  end

  # # GET /companies/1
  # # GET /companies/1.json
  # def show
  # end
  #
  # # POST /companies
  # # POST /companies.json
  # def create
  #   @company = Company.new(company_params)
  #
  #   if @company.save
  #     render :show, status: :created, location: @company
  #   else
  #     render json: @company.errors, status: :unprocessable_entity
  #   end
  # end
  #
  # # PATCH/PUT /companies/1
  # # PATCH/PUT /companies/1.json
  # def update
  #   if @company.update(company_params)
  #     render :show, status: :ok, location: @company
  #   else
  #     render json: @company.errors, status: :unprocessable_entity
  #   end
  # end
  #
  # # DELETE /companies/1
  # # DELETE /companies/1.json
  # def destroy
  #   @company.destroy
  # end

  # private
  #   # # Use callbacks to share common setup or constraints between actions.
  #   # def set_job_board
  #   #   @job_board = JobBoard.find(params[:id])
  #   # end
  #
  #   # Never trust parameters from the scary internet, only allow the white list through.
  #   def job_board_params
  #     params.permit(:location, :type, :position_type)
  #   end
end
