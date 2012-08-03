module TournamentsHelper
  def poker_registration_path
    current_user.email.nil? ? edit_user_path(current_user) : toggle_poker_player_user_path(current_user)
  end

  def result(player, field, options = {})
    best_in_place_if (current_user.admin? || player.user_id == current_user.id), player, field.to_sym, options
  end

  def show_results?(player)
    !player.new_record? && !player.no_show? && (player.tournament.today? || player.tournament.over?)
  end

  def show_rsvp?(player)
    (!player.tournament.over? && player.user_id == current_user.id) || current_user.admin?
  end
end
