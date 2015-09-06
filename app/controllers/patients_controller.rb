class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]
   helper_method :sort_column, :sort_direction
  # GET /patients
  # GET /patients.json
  def index
    @patients = Patient.order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 10)
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
  end

  # GET /patients/new
  def new
    @patient = Patient.new
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients
  # POST /patients.json
  def create
    @patient = Patient.new(patient_params)

    respond_to do |format|
      if @patient.save
        format.html { redirect_to @patient, notice: 'Patient was successfully created.' }
        format.json { render :show, status: :created, location: @patient }
      else
        format.html { render :new }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to @patient, notice: 'Patient was successfully updated.' }
        format.json { render :show, status: :ok, location: @patient }
      else
        format.html { render :edit }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    @patient.destroy
    respond_to do |format|
      format.html { redirect_to patients_url, notice: 'Patient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def reading
    @clucose_reading = Patient.find_by(:id=>params[:id].to_i)
  end

  def create_glucose_reading

     @clucose_reading = GlucoseReading.new(:patient_id => params[:patient][:id].to_i,:reading=>params[:glucose][:reading].to_i)

    respond_to do |format|
      if @clucose_reading.save
        format.html { redirect_to root_path, notice: 'Reading was successfully created.' }
        format.json { render :show, status: :created, location: @patient }
      else
        format.html { redirect_to glucose_reading_path(params[:patient][:id].to_i), notice: 'Unable to create Reading' }
        format.json { render json: @clucose_reading.errors, status: :unprocessable_entity }
      end
    end
  end

def daliy_report 
  @daliy_report = GlucoseReading.get_daily_report
end

def monthly_report 
  @reports = GlucoseReading.where("date(created_at) >= ? and date(created_at) <=?",Date.today,Date.today)
end

def show_month_wise
  
  @month_report = GlucoseReading.where("date(created_at) >= ? and date(created_at) <=?",params[:start][:date].to_date.strftime("%Y-%m-%d"),params[:end][:date].to_date.strftime("%Y-%m-%d"))
  
  end

  def month_wise_report
    @reports = GlucoseReading.where("MONTH(created_at) = ? and YEAR(created_at) = ? ",Date.today.month,Date.today.year)
  end

  def find_month_wise_report
   
    @reports = GlucoseReading.where("MONTH(created_at) = ? and YEAR(created_at) = ? ",params[:timer][:month],params[:timer][:year])
    
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      params.require(:patient).permit(:name, :address, :age, :phone_no)
    end

     def sort_column
    Patient.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
