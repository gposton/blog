require 'gchart'

module TournamentsHelper

  def poker_registration_path
    current_user.email.nil? ? edit_user_path(current_user) : toggle_poker_player_user_path(current_user)
  end

  def add_me_link(tournament_id, form)
    link_to_function "I'll be there", {:id => 'add_link'} do |page|
      page.insert_html :bottom,
        'player_results',
        :partial => 'player_result',
        :object => PlayerResult.new(:user_id => current_user.id, :tournament_id => tournament_id, :buy_in => BUY_IN),
        :locals => {:form => form}
      page.hide('add_link')
      page[:tournament_submit].visual_effect :shake, {:distance => 5, :duration => 1}
      update_total_pot page
    end
  end

  def add_user_link(tournament_id, form)
    link_to_function "Add user" do |page|
      page.insert_html :bottom,
        'player_results',
        :partial => 'player_result',
        :object => PlayerResult.new(:tournament_id => tournament_id, :buy_in => BUY_IN),
        :locals => {:form => form}
      page[:tournament_submit].visual_effect :shake, {:distance => 5, :duration => 1}
      update_total_pot page
    end
  end

  def remove_me_link(user_id)
    link_to_function 'No show' do |page|
      #set the hidden _destroy field to true
      page["remove_#{user_id}"].value = 1
      #hide the row
      page["user_#{user_id}_results"].toggleClassName('hide')
      update_total_pot page
    end
  end

  def buy_in_link(user_id)
    link_to_function 'Buy in' do |page|
      page << "var new_buy_in = parseInt($(user_#{user_id}_buy_in_field).value) + #{BUY_IN};"
      page << "$(user_#{user_id}_buy_in_field).value = new_buy_in;"
      page << "$(user_#{user_id}_buy_in_text).update(new_buy_in);"
      update_total_pot page
    end
  end

  def out_link(user_id)
    link_to_function 'Out' do |page|
      #get the num of players by counting the number of fields that end in 'finish_field'
      page << "var num_players = $$('#player_results > tbody > tr > input[id$=finish_field]').length"
      #get the number of players that are already out by counting the number of fields from above that are not 0
      page << "var num_players_out = $$('#player_results > tbody > tr > input[id$=finish_field]').findAll(function(n){ return n.value != 0}).length"
      page << "var place = num_players - num_players_out"
      page << "$(user_#{user_id}_finish_field).value = place;"
      page << "$(user_#{user_id}_finish_text).update(place);"
      #update second place with winnings of 2x buyin
      page << "if (place == 2){$(user_#{user_id}_winnings_field).value = #{BUY_IN * 2}}"
      page << "if (place == 2){$(user_#{user_id}_winnings_text).update(#{BUY_IN * 2})}"
      #update first place with winnings of 'the rest of the pot'
      page << "if (place == 1){$(user_#{user_id}_winnings_field).value = parseInt($('total_pot').innerHTML) - #{BUY_IN * 2}}"
      page << "if (place == 1){$(user_#{user_id}_winnings_text).update(parseInt($('total_pot').innerHTML) - #{BUY_IN * 2})}"
    end
  end

  def tournament_actions(user_id)
    [buy_in_link(user_id), out_link(user_id), remove_me_link(user_id)].join(' | ')
  end

  def update_total_pot(page)
    page << "var total_pot = 0"
    #add up the buy_in field
    page << "$$('#player_results > tbody > tr > input[id$=buy_in_field]').each(function(n){total_pot = total_pot + parseInt(n.value)})"
    page << "$('total_pot').update(total_pot)"
  end

  def tournament_pot_size_graph(tournaments)
    pot_sizes = tournaments.collect{|tourny|tourny.total_pot}
    max_pot_size = pot_sizes.sort{|a,b|b <=> a}.shift
    tourny_names = tournaments.collect{|tourny|tourny.date_string}
    graph = Gchart.bar( :data => pot_sizes,
                        :labels => tourny_names,
                        :bar_width_and_spacing => '25,50',
                        :size => '600x100',
                        :title => 'Pot sizes',
                        :axis_with_labels => 'y',
                        :max_value => max_pot_size,
                        :min_value => 40,
                        :bg => {:color => 'eeddcc', :type => 'gradient'},
                        :bar_colors => 'ff0000,00ff00')
    graph
  end
end
