class HomeController < ApplicationController
  respond_to :html, :json


  def index
    @requests = Request.includes(:department, :responses)

    self.calc_overview_stats

    @departments = []
    Department.limit(8).order('id asc').each do |dept|
      dept.name = dept.name.gsub(/Department/, "Dept.")

      total_department_requests = Request.count(:conditions => "department_id = #{dept.id}").to_f
      fulfilled_percent = ((Request.count(:conditions => "department_id = #{dept.id} AND status = 'fulfilled'").to_f / total_department_requests ) * 100).round(3)
      denied_percent = ((Request.count(:conditions => "department_id = #{dept.id} AND status = 'denied'").to_f / total_department_requests ) * 100).round(3)
      pending_percent = ((Request.count(:conditions => "department_id = #{dept.id} AND status = 'pending'").to_f / total_department_requests ) * 100).round(3)


      @departments << { :department => dept, 
                        :total_department_requests => total_department_requests ,
                        :fulfilled_percent => fulfilled_percent ,
                        :denied_percent => denied_percent ,
                        :pending_percent => pending_percent 
                      }

    
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => { :requests => @requests, 
                                      :total_requests => @total_requests, 
                                      :total_fulfilled => @total_fullfilled, 
                                      :total_denied => @total_denied, 
                                      :total_pending => @total_pending 
                                    } 
                                  }
    end
  end

  def stats
    self.calc_overview_stats

    respond_to do |format|
      format.json { render :json => { :total_requests => @total_requests, 
                                      :total_fulfilled => @total_fullfilled, 
                                      :total_denied => @total_denied, 
                                      :total_pending => @total_pending 
                                    }
                                  }
    end

  end




  def calc_overview_stats
    @total_requests = Request.count.to_f
    @total_fullfilled = (( Request.count(:conditions => "status = 'fulfilled'") / @total_requests ) * 100).round(3)
    @total_pending = (( Request.count(:conditions => "status = 'pending'") / @total_requests ) * 100).round(3)
    @total_denied = (( Request.count(:conditions => "status = 'denied'") / @total_requests ) * 100).round(3)
  end

end
