module MainHelper
  def days_to_go
    date = Date.parse('December 2nd, 2023')
    to_go = (date - Date.today).to_i
    if date.future?
      "#{to_go} day#{to_go > 1 ? 's' : ''} to go!"
    else
      ''
    end
  end

  def guests_data
    Guest.parents.as_json(
      only: %i[first_name last_name status group],
      methods: :guests_attributes
    ).to_json
  end
end