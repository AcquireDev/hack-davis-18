json.(@user, :id, :email)
json.total_applications @user.applications.count
json.completed_applications @user.applications.where(applied: true).count
