class RequestsController < ApplicationController
  
  respond_to :html, :json, :xml
  # before_filter :default_params

  def index
    @total_requests = Request.includes(:department, :responses).count


    if params[:status].nil?
      params[:status] = 'pending'
    end

    if params[:department_id].nil?
      @requests = Request.includes(:department, :responses).where(:status => params[:status]).page(params[:page]).per(10)
    else
      @requests = Request.includes(:department, :responses).where(:status => params[:status], :department_id => params[:department_id]).page(params[:page]).per(10)
    end

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


  # def default_params
  #   @a_entity = params['a_entity']
  # end


  def show
    @request = Request.find(params[:id])
    @responses = @request.responses.all
  end

  def new
    @request = Request.new
    @departments = Department.all
  end
  
  def create
    @requester = Requester.find_by_email(params[:requester]["email"])
    
    if !@requester
      @requester = Requester.create(params[:requester])
      # redirect_to root_path unless @requester.save
    end
    
    @request = @requester.requests.build(params[:request])
  
    if @requester.save && @request.save
      RequestMailer.request_sent_email(@request).deliver
      redirect_to request_path(@request)
    end
  end

end
