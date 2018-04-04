class CopartsController < ApplicationController
  before_action :set_copart, only: [:show, :edit, :update, :destroy]

  # GET /coparts
  # GET /coparts.json
  def index
    @coparts = Copart.all
  end

  # GET /coparts/1
  # GET /coparts/1.json
  def show
  end

  # GET /coparts/new
  def new
    @copart = Copart.new
  end

  # GET /coparts/1/edit
  def edit
  end

  # POST /coparts
  # POST /coparts.json
  def create
    @copart = Copart.new(copart_params)

    respond_to do |format|
      if @copart.save
        format.html { redirect_to @copart, notice: 'Copart was successfully created.' }
        format.json { render :show, status: :created, location: @copart }
      else
        format.html { render :new }
        format.json { render json: @copart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coparts/1
  # PATCH/PUT /coparts/1.json
  def update
    respond_to do |format|
      if @copart.update(copart_params)
        format.html { redirect_to @copart, notice: 'Copart was successfully updated.' }
        format.json { render :show, status: :ok, location: @copart }
      else
        format.html { render :edit }
        format.json { render json: @copart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coparts/1
  # DELETE /coparts/1.json
  def destroy
    @copart.destroy
    respond_to do |format|
      format.html { redirect_to coparts_url, notice: 'Copart was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_copart
      @copart = Copart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def copart_params
      params.require(:copart).permit(:record_status, :lot_n, :row_hash, :lot_img_fld)
    end
end
