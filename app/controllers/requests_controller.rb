class RequestsController < ApplicationController
  
  respond_to :html, :json, :xml

  def index
    # @requests = Request.includes(:department, :responses).page(params[:page]).per(10)


    if params[:status].nil?
      @requests = Request.paginate(:page => params[:page], :per_page => 30)
    else
      @requests = Request.where(:status => params[:status].capitalize!).paginate(:page => params[:page], :per_page => 30)
    end

    @total_requests = Request.includes(:department, :responses).size

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
      redirect_to root_path unless @requester.save
    end
    
    @request = @requester.requests.build(params[:request])
  
    if @requester.save && @request.save
      RequestMailer.request_sent_email(@request).deliver
      redirect_to request_path(@request)
    end
  end

end
