class AbsencesController < ApplicationController
  respond_to :html, :js

  def create
    absence = Absence.create(absence_params.merge(user_id: current_user.id))
    redirect_to timetracks_path(date: absence.date)
  end

  def update
    absence = Absence.find(params[:id])
    absence.update_attributes(absence_params.merge(user_id: current_user.id))
    redirect_to timetracks_path(date: absence.date)
  end

  def absence_params
    params.require(:absence).permit(:date, :reason)
  end

end
