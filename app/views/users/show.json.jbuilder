json.(@user, :id, :email)
json.job_board_id @user.settings(:job_search).job_board_id
json.total_applications @user.applications.count
json.completed_applications @user.applications.where(applied: true).count
