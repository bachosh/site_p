class FiltercopartsController < ApplicationController
  before_action :set_filtercopart, only: [:show, :edit, :update, :destroy]

  # GET /filtercoparts
  # GET /filtercoparts.json
  def index
    @filtercoparts = Filtercopart.all
  end

  # GET /filtercoparts/1
  # GET /filtercoparts/1.json
  def show
  end

  # GET /filtercoparts/new
  def new
    @filtercopart = Filtercopart.new
  end

  # GET /filtercoparts/1/edit
  def edit
  end

  # POST /filtercoparts
  # POST /filtercoparts.json
  def create
    @filtercopart = Filtercopart.new(filtercopart_params)

    respond_to do |format|
      if @filtercopart.save
        format.html { redirect_to @filtercopart, notice: 'Filtercopart was successfully created.' }
        format.json { render :show, status: :created, location: @filtercopart }
      else
        format.html { render :new }
        format.json { render json: @filtercopart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filtercoparts/1
  # PATCH/PUT /filtercoparts/1.json
  def update
    respond_to do |format|
      if @filtercopart.update(filtercopart_params)
        format.html { redirect_to @filtercopart, notice: 'Filtercopart was successfully updated.' }
        format.json { render :show, status: :ok, location: @filtercopart }
      else
        format.html { render :edit }
        format.json { render json: @filtercopart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filtercoparts/1
  # DELETE /filtercoparts/1.json
  def destroy
    @filtercopart.destroy
    respond_to do |format|
      format.html { redirect_to filtercoparts_url, notice: 'Filtercopart was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filtercopart
      @filtercopart = Filtercopart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def filtercopart_params
      params.require(:filtercopart).permit(:record_status, :vechile_type, :year, 
        :make, :model_group, :model_detail, :damage_description, :lot_cond, 
        :odometer, :engine, :drive, :transmission, :fuel_type, :runs_drives, :location_city, 
        :buy_it_now_price, :color, :sale_date)
    end
end
