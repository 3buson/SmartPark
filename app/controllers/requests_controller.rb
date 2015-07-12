class RequestsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_request, only: [:show, :edit, :update, :destroy]

  # GET /requests
  # GET /requests.json
  def index
    @requests = Request.all
  end

  # POST /find
  # POST /find.json
  def getInRange
    @requests     = Request.all # all requests
    @myLongtitude = params[:longtitude]
    @myLatitude   = params[:latitude]
    @myTime       = params[:time]

    @validRequests = Array.new

    for request in @requests
      if request.expires < @myTime
        @distance = calcDist(request.latitude, request.longtitude, @myLatitude, @myLongtitude)
        #puts @distance
        if @distance < 450 # distance less than 400 m 
          @validRequests.push(request)
        end
      end
    end

    @export_data = @validRequests
    respond_to do |format|
      format.html
      format.json { render :json => @export_data.to_json(:include => :user) }
    end
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
  end

  # GET /requests/new
  def new
    @request = Request.new
  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests
  # POST /requests.json
  def create
    @request = Request.new(request_params)
    @request.user_id = params[:request][:user_id]

    respond_to do |format|
      if @request.save
        format.html { redirect_to @request, notice: 'Request was successfully created.' }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to @request, notice: 'Request was successfully updated.' }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'Request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # CONFIRM PARK SWAP /confirm
  def handleCredits
    @requestId   = params[:request_id]
    @userMinusId = params[:user_id]
    @userPlusId  = Request.find(@requestId).user_id

    @userMinus = User.find(@userMinusId)
    @userPlus  = User.find(@userPlusId)

    @userMinus.credits = @userMinus.credits - 1
    @userPlus.credits  = @userPlus.credits + 1

    @userMinus.save
    @userPlus.save

    # remove confirmed request
    Request.find(@requestId).destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    def calcDist(lat1, lon1, lat2, lon2)
      dLat = (lat2 - lat1) * (Math::PI / 180)
      dLon = (lon2 - lon1) * (Math::PI / 180)
      a = Math.sin(dLat / 2) * Math.sin(dLat / 2) + (Math.cos(lat1) * Math::PI / 180) * (Math.cos(lat2) * Math::PI / 180) * Math.sin(dLon / 2) * Math.sin(dLon / 2)
      c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
      return 6371 * c * 1000
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_params
      params.require(:request).permit(:requestType, :created, :expires, :longtitude, :latitude, :user_id)
    end
end
