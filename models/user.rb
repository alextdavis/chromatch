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

    validates_presence [:uid, :email, :name]
    validates_unique [:uid, :email]
  end

  # --- Class Methods ---

  # --- Instance Methods ---

  def generate_token
    self.update({:token => SecureRandom.hex})
  end

end