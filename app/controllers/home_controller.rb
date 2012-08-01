class HomeController < ApplicationController
  respond_to :html, :json, :xml

  def index
    @requests = Request.includes(:department, :responses)

    @departments = []
    Department.limit(5).order('id asc').each do |dept|
      dept.name = dept.name.gsub(/Department/, "Dept.")
      @departments << dept
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @requests.to_json }
    end
  end
end
