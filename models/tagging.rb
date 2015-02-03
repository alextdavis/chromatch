class Tagging < Sequel::Model
  # --- Associations ---

  many_to_one :user
  many_to_one :tags

  # --- Hooks ---

  # --- Validation ---

  # --- Class Methods ---

  # --- Instance Methods ---
end