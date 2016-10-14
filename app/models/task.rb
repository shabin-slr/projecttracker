class Task < ActiveRecord::Base

  #Relations
  belongs_to :user
  has_many :activities, dependent: :destroy
  #Relations end

  #Validations
  validates :name, presence: true
  validates :description, presence: true

  FIELDS_RENDERED = [:id, :name, :description, :created_at, :updated_at]
  METHODS_RENDERED = []

  def as_json(options={})
    puts options
    super(
      :methods => Task::METHODS_RENDERED,
      :only => Task::FIELDS_RENDERED,
      :include => [
        {
          :user =>
          {
            :only => User::FIELDS_RENDERED,
            :methods => User::METHODS_RENDERED
          }
        }
      ]
    )
  end



end
