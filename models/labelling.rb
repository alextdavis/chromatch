class Labelling < Sequel::Model
  # --- Associations ---

  many_to_one :user
  many_to_one :label

  # --- Hooks ---

  # --- Validation ---

  # --- Class Methods ---

  # --- Instance Methods ---
end