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
end