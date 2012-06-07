module TournamentsHelper
  def poker_registration_path
    current_user.email.nil? ? edit_user_path(current_user) : toggle_poker_player_user_path(current_user)
  end

  def rsvp_link(tournament, no_show)
    link_to (no_show ? "I'll be there" : "Can't make it"), rsvp_tournament_path(tournament, :no_show => !no_show)
  end

  def result(player, field)
    best_in_place_if (current_user.admin? || player.user_id == current_user.id), player, field.to_sym
  end

  def show_results?(player)
    !player.new_record? && !player.no_show? && (player.tournament.today? || player.tournament.over?)
  end

  def show_rsvp?(player)
    !player.tournament.over? && player.user_id == current_user.id
  end
end
