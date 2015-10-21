class AbsencesController < ApplicationController
  respond_to :html, :js

  def create
    absence = Absence.create(absence_params.merge(user_id: current_user.id))
    redirect_to timetracks_path(date: absence.date)
  end

  def update
    # FIXME: Add a current_user scope
    absence = Absence.find(params[:id])
    absence.update_attributes(absence_params.merge(user_id: current_user.id))
    redirect_to timetracks_path(date: absence.date)
  end

  def destroy
    absence = Absence.find(params[:id])
    absence.destroy
    redirect_to timetracks_path(date: absence.date)
  end

  def absence_params
    params.require(:absence).permit(:date, :reason)
  end

end
