class Activity < ActiveRecord::Base

  belongs_to :task

  FIELDS_RENDERED = [:description, :date, :hours_spent, :id]
  METHODS_RENDERED = []

end
