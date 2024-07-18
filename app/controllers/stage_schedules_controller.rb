class StageSchedulesController < ApplicationController
  before_action :set_stage_schedule, only: %i[show edit update destroy]

  # GET /stage_schedules or /stage_schedules.json
  def index
    @data = StageSchedules.generate
  end

  # GET /stage_schedules/1 or /stage_schedules/1.json
  def show
  end

  # GET /stage_schedules/new
  def new
    @stage_schedule = StageSchedule.new
  end

  # GET /stage_schedules/1/edit
  def edit
  end

  # POST /stage_schedules or /stage_schedules.json
  def create
    @stage_schedule = StageSchedule.new(stage_schedule_params)

    respond_to do |format|
      if @stage_schedule.save
        format.html do
          redirect_to stage_schedule_url(@stage_schedule), notice: 'Stage schedule was successfully created.'
        end
        format.json { render :show, status: :created, location: @stage_schedule }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @stage_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stage_schedules/1 or /stage_schedules/1.json
  def update
    respond_to do |format|
      if @stage_schedule.update(stage_schedule_params)
        format.html do
          redirect_to stage_schedule_url(@stage_schedule), notice: 'Stage schedule was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @stage_schedule }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @stage_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stage_schedules/1 or /stage_schedules/1.json
  def destroy
    @stage_schedule.destroy!

    respond_to do |format|
      format.html { redirect_to stage_schedules_url, notice: 'Stage schedule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_stage_schedule
    @stage_schedule = StageSchedule.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def stage_schedule_params
    params.require(:stage_schedule).permit(:id, :name, :date, :stage_id)
  end
end
