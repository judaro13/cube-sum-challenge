require "syro"
require "mote"

class Web < Syro::Deck
  include Mote::Helpers

  def view(template)
    sprintf("views/%s.mote", template)
  end

  def partial(template, params = {})
    mote(view(template), params)
  end

  def render(template, params = {})
    res.html partial("layout",
      title: params[:title],
      content: partial(template, params))
  end
end
