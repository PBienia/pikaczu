class PinoutsController < ApplicationController

    #scope :project, -> { where(project.id: 'project') }
#  before_action :set_pinout, only: [:show, :edit, :update, :destroy]
  def index
      #@pinouts = Pinout.all
      @pinouts = Pinout.all.paginate(:page => params[:page], :per_page =>14)
    #  @project = Project.find(params[:id])
    #  @projects = Project.all

  #  scope :only_project, ->(project) { where("project_id == ?", project) }

      render layout: "application_pinout"
  end

  def pinout_project


    @pinouts = Pinout.all
     @project = Project.all
    #  @projects = Project.all
      render layout: "application_pinout"


  end

  def show
        @pinout = Pinout.find(params[:id])
        render layout: "application_lite"
  end

  def new

@pinout = Pinout.new
@project = Project.all

  end

  def edit
  end

  def update
    respond_to do |format|
      if @pinout.update(pinout_params)
        format.html { redirect_to @pinout, notice: 'Pinout was successfully updated.' }
        format.json { render :show, status: :ok, location: @pinout }
      else
        format.html { render :edit }
        format.json { render json: @pinout.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  @pinout.destroy
  respond_to do |format|
    format.html { redirect_to pinouts_url, notice: 'Pinout was successfully destroyed.' }
    format.json { head :no_content }
  end
end

def create
@pinout = Pinout.new(pinout_params)

respond_to do |format|
  if @pinout.save
    format.html { redirect_to pinouts_index_path, notice: 'Pinout was successfully created.' }
    format.json { render :show, status: :created, location: @pinout }
  else
    format.html { render :new }
    format.json { render json: @pinout.errors, status: :unprocessable_entity }
  end
end
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pinout
      @pinout = Pinout.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pinout_params
      params.require(:pinout).permit(:project_id, :pin_dut, :pin_dut_name, :pin_dut_desc, :pin_setup, :pin_setup_name, :pin_setup_desc)
    end


end
