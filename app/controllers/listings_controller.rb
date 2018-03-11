class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :update, :destroy]

  # GET /listings
  # GET /listings.json
  def index
    @listings = Listing.all
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
  end

  # POST /listings
  # POST /listings.json
  def create
    # First find the company name (:company_name)
    if listing_params.has_key?(:company_name)
      c_name = listing_params[:company_name]
      company = Company.find_or_create_by(name: c_name)
      listing_params[:company_id] = company.id
      listing_params.delete(:company_name)
      @listing = Listing.new({
        company_id: company.id,
        description: listing_params[:description],
        deadline: listing_params[:deadline],
        job_title: listing_params[:job_title],
        url: listing_params[:url]
      })
    else
      @listing = Listing.new({
        description: listing_params[:description],
        deadline: listing_params[:deadline],
        job_title: listing_params[:job_title],
        url: listing_params[:url]
      })
    end

    if @listing.save
      ReconcileListingJob.perform_async(@listing)
      render :show, status: :created, location: @listing
    else
      render json: @listing.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    if @listing.update(listing_params)
      render :show, status: :ok, location: @listing
    else
      render json: @listing.errors, status: :unprocessable_entity
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.permit(:job_title, :description, :deadline, :company_id, :company_name, :url)
    end
end
