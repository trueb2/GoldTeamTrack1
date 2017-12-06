class ChemicalsController < ApplicationController
  before_action :set_chemical, only: [:show, :edit, :update, :destroy]

  # GET /chemicals
  # GET /chemicals.json
  def index
    @count = Chemical.count
    @chemicals = Chemical.all.paginate(page: params[:page], per_page: 1000)
  end

  # GET /chemicals/1
  # GET /chemicals/1.json
  def show
  end

  # GET /chemicals/new
  def new
    @chemical = Chemical.new
  end

  # GET /chemicals/1/edit
  def edit
  end

  # POST /chemicals
  # POST /chemicals.json
  def create
    @chemical = Chemical.new(chemical_params)

    respond_to do |format|
      if @chemical.save
        format.html { redirect_to @chemical, notice: 'Chemical was successfully created.' }
        format.json { render :show, status: :created, location: @chemical }
      else
        format.html { render :new }
        format.json { render json: @chemical.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chemicals/1
  # PATCH/PUT /chemicals/1.json
  def update
    respond_to do |format|
      if @chemical.update(chemical_params)
        format.html { redirect_to @chemical, notice: 'Chemical was successfully updated.' }
        format.json { render :show, status: :ok, location: @chemical }
      else
        format.html { render :edit }
        format.json { render json: @chemical.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chemicals/1
  # DELETE /chemicals/1.json
  def destroy
    @chemical.destroy
    respond_to do |format|
      format.html { redirect_to chemicals_url, notice: 'Chemical was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chemical
      @chemical = Chemical.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chemical_params
      params.require(:chemical).permit(:name, :compound_id, :clear_air_act_chemical, :is_metal, :metal_category)
    end
end
