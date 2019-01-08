# -*- encoding : utf-8 -*-
class Application < Merb::Controller

protected

  def ensure_team_member
    unless current_user.member_of_any_team?
      raise Unauthorized, "Jums neleidžiama apsilankyti šiame puslapyje."
    end
  end

  def ensure_team_captain
    unless current_user.captain?
      raise Unauthorized, "Šiam veiksmui atlikti turite būti kapitonas."
    end
  end

  def ensure_author
    unless logged_in? and @current_user.author_of?(@game)
      raise Unauthorized, "Kad pamatytumėte šį puslapį, turite būti žaidimo autorius."
    end
  end

  def ensure_game_was_not_started
    raise Unauthorized, "Žaidimas jau prasidėjęs, jo redaguoti negalima" if @game.started?
  end
end
