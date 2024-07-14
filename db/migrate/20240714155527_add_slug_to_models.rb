class AddSlugToModels < ActiveRecord::Migration[7.1]
  def change
    models = %w[activations artists merchants schedules stages vendors]

    models.each do |model|
      add_column model, :slug, :string
      add_index model, :slug, unique: true
    end
  end
end
