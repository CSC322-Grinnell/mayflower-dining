json.extract! ingredient, :id, :name, :portion_size, :mech_soft, :pureed, :diet, :hc_prep, :hc_prep_leftover, :bb_prep, :bb_prep_leftover, :buckley_prep, :buckley_prep_leftover, :created_at, :updated_at
json.url ingredient_url(ingredient, format: :json)
