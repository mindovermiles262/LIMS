module UsersHelper
  def admin_only
    unless current_user && current_user.admin?
      flash[:danger] = "Unauthorized Access"
      redirect_to root_path
    end
  end

  def admin_or_analyst
    unless current_user && (current_user.admin? || current_user.analyst?)
      flash[:danger] = "Unauthorized"
      redirect_to root_path
    end
  end
end
