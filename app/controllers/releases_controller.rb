class ReleasesController < ApplicationController
  before_action :set_release, only: [:show, :edit, :update, :destroy]

  # GET /releases
  # GET /releases.json
  def index
    @count = Release.count
    @releases = Release.all
  end

  # GET /releases/1
  # GET /releases/1.json
  def show
  end

  # GET /releases/new
  def new
    @release = Release.new
  end

  # GET /releases/1/edit
  def edit
  end

  def tree
    west = params[:w] || -130
    east = params[:e] || -65
    south = params[:s] || 22
    north = params[:n] || 50
    facility_fields = Hash(params.fetch("facilities", {}).permit!).map do | key, val |
      { "facilities.#{key}" => val }
    end.reduce(:merge) || {}
    release_fields = (Hash(params.fetch("releases", {}).permit!)).map do | key, val |
      { "releases.#{key}" => val }
    end.reduce(:merge) || {}
    chemical_fields = (Hash(params.fetch("chemicals", {}).permit!)).map do | key, val |
      { "chemicals.#{key}" => (val == "true" ? true : (val == "false" ? false : val) ) }
    end.reduce(:merge) || {}
    @releases = ActiveRecord::Base.connection.exec_query("SELECT companies.name AS company_name, facilities.name AS facility_name, releases.year AS release_year FROM companies INNER JOIN facilities ON facilities.company_id = companies.id INNER JOIN releases ON releases.facility_id = facilities.id LIMIT 500")
  end

  def events
    puts params
    west = params[:w] || -130
    east = params[:e] || -65
    south = params[:s] || 22
    north = params[:n] || 50
    facility_fields = Hash(params.fetch("facilities", {}).permit!).map do | key, val |
      { "facilities.#{key}" => val }
    end.reduce(:merge) || {}
    release_fields = (Hash(params.fetch("releases", {}).permit!)).map do | key, val |
      { "releases.#{key}" => val }
    end.reduce(:merge) || {}
    chemical_fields = (Hash(params.fetch("chemicals", {}).permit!)).map do | key, val |
      { "chemicals.#{key}" => (val == "true" ? true : (val == "false" ? false : val) ) }
    end.reduce(:merge) || {}
    @releases = Release.includes(:facility, :chemical).joins(:facility, :chemical).where("facilities.latitude > #{south} and facilities.latitude < #{north} and facilities.longitude > #{west} and facilities.longitude < #{east}").where(facility_fields.merge(release_fields).merge(chemical_fields)).limit(100)
  end

	def new_event

	end

	def create_event
		puts params
		release_fields = params.fetch("release").permit(:year, :quantity)
		chemical_fields = params.fetch("chemical").permit(:name, :clear_air_act_chemical)
		chemical_fields[:clear_air_act_chemical] ||= 0
		facility_fields = params.fetch("facility").permit(:name, :address, :city, :state, :latitude, :longitude)
		company_fields = params.fetch("company").permit(:name)
		company = Company.create(company_fields)
		facility = Facility.create(facility_fields.merge({ company: company }))
		chemical = Chemical.create(chemical_fields)
		release = Release.create(release_fields.merge({ units: "pounds", chemical: chemical, facility: facility }))
		puts release.id
		redirect_to "/?new_event=1"
	end	

  # POST /releases
  # POST /releases.json
  def create
    @release = Release.new(release_params)

    respond_to do |format|
      if @release.save
        format.html { redirect_to @release, notice: 'Release was successfully created.' }
        format.json { render :show, status: :created, location: @release }
      else
        format.html { render :new }
        format.json { render json: @release.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /releases/1
  # PATCH/PUT /releases/1.json
  def update
    respond_to do |format|
      if @release.update(release_params)
        format.html { redirect_to @release, notice: 'Release was successfully updated.' }
        format.json { render :show, status: :ok, location: @release }
      else
        format.html { render :edit }
        format.json { render json: @release.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /releases/1
  # DELETE /releases/1.json
  def destroy
    @release.destroy
    respond_to do |format|
      format.html { redirect_to releases_url, notice: 'Release was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_release
      @release = Release.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def release_params
      params.require(:release).permit(:date, :method, :quantity, :units)
    end
end
