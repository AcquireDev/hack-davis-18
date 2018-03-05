json.extract! application, :id, :listing_id, :applied, :status, :notes, :user_id, :created_at, :updated_at, :stage
json.company application.listing.company.name
json.title application.listing.job_title
json.description application.listing.description
json.url application.listing.url
