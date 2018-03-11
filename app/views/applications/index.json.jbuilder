json.not_applied @not_applied, partial: 'applications/application', as: :application
json.applied @applied, partial: 'applications/application', as: :application
json.hidden @hidden, partial: 'applications/application', as: :application
json.interviewing @interviewing, partial: 'applications/application', as: :application
json.rejected @rejected, partial: 'applications/application', as: :application
json.offer @offer, partial: 'applications/application', as: :application
json.accepted @accepted, partial: 'applications/application', as: :application
