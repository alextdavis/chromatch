class User < Sequel::Model
  plugin :validation_helpers
  # --- Associations ---

  one_to_many :expertises
  one_to_many :taggings
  many_to_many :bookmarkings

  # --- Hooks ---

  # --- Validation ---
  def validate
    super

    validates_presence [:email, :name]
    validates_unique(:email)
  end

  # --- Class Methods ---

  # --- Instance Methods ---
end