class JobsController < ApplicationController
  http_basic_authenticate_with name: AUTHENTICATION["HTTP_USER"], password: AUTHENTICATION["HTTP_PASSWORD"], except: [:show, :new, :create]

  before_action :set_job, only: [:show, :edit, :update, :destroy]

  # GET /jobs/1
  # GET /jobs/1.json
  def show
    @preview = true if params[:preview]
    @meta_keywords = @job.skill_list.to_s

    @jobs = Job.tagged_with(@job.skill_list, :any => true)

  end

  # GET /jobs/new
  def new
    @job = Job.new
    @meta_title = 'Post a new Job'
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)

    respond_to do |format|
      if @job.save
        format.html { redirect_to job_path(@job, preview: true)}
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    if params[:publish]
      @job.update(published_at: Time.now)
      redirect_to root_path
    else

      respond_to do |format|
        if @job.update(job_params)
          format.html { redirect_to @job, notice: 'Job was successfully updated.' }
          format.json { render :show, status: :ok, location: @job }
        else
          format.html { render :edit }
          format.json { render json: @job.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def ruby_on_rails
    
  end

  def publish

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:company_name, :publish, :company_url, :job_url, :job_application_url, :logo, :employer_twitter_account, :employer_careers_url, :company_email, :title, :is_full_time, :description, :how_to_apply, :skill_list)
    end
end