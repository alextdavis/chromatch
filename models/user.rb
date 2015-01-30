class User < Sequel::Model
  plugin :validation_helpers
  # --- Associations ---

  one_to_many :expertises
  one_to_mnay :taggings
  many_to_many :bookmarkings

  # --- Hooks ---

  # --- Validation ---



  # --- Class Methods ---

  # --- Instance Methods ---
end