class ProjectsController < ApplicationController
  def index
    @project = Project.all.paginate(:page =>params[:page], :per_page => 3)
    #    @pinout = Pinout.all
      render layout: "application_lite"
  end

  def show


    #@project = Project.all
    @project = Project.find(params[:id])
    @pinout = Pinout.all.paginate(:page => params[:page], :per_page =>10)


  end
end

#Notatki
#@paints = @category.paints.page(params[:page]).per(6)
