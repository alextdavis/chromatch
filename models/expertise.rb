class Expertise < Sequel::Model
  # --- Associations ---

  many_to_one :user

  # --- Hooks ---

  # --- Validation ---

  # --- Class Methods ---

  # --- Instance Methods ---
end