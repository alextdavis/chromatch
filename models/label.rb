class Label < Sequel::Model
  plugin :validation_helpers
  # --- Associations ---

  # --- Hooks ---

  # --- Validation ---
  def validate
    super

    validates_presence [:name]
    validates_unique [:name]
  end

  # --- Class Methods ---

  # --- Instance Methods ---
end