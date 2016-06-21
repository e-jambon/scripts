# encoding: utf-8

=begin

Author        : Yann GUERON
Date          : 2016/06/12
Version       : 0.1.
Description   : Little tool to require a copy of a template locally


=end

class Menu
  attr :menu_map, :current_level, :user_choice

  def initialize menu_map
    STDERR.puts "DEPRECATED. Use menu_v2.rb"
    @current_directory = %x`pwd`
    @current_level = '0'
    @menu_map =  menu_map
  end


  def print_menu_header menu_level, title = "MENU -- MAKE A CHOICE"
    system('clear')
    puts "-------------------------------------------------\n"+
         "|                                               |\n"+
         "|  "+ title + "                        |\n"+
         "|                                               |\n"+
         "-------------------------------------------------\n"+
         " LEVEL : #{menu_level}\n\n"
  end

  # print the menu content on screen
  def print_menu menu_level= '0'
    print_menu_header menu_level

    20.times do |counter|
      lvl =  "#{menu_level}.#{counter}"
      puts  " #{counter}  : " + @menu_map[lvl][0] if @menu_map.has_key?(lvl)
    end
    puts "Make a choice between those items. (X to exit)"
    puts "Use left arrow to go back"
  end

  # get the user choice
  def get_user_choice
    @user_choice = gets.chomp
  end

  # returns true only if the user choice is valid.
  def is_user_choice_valid?
    return false if @user_choice.empty?
    return true if  @user_choice == 'X' || @user_choice == 'x' || (@menu_map.has_key? @current_level + '.' + @user_choice)
    return true if @user_choice == "\e[D"
  end

  # Otherwise, sets the current_level
  # launches the action found in the menu_map if any.
  def action
    (@current_level = 'X' ; return) if ( @user_choice == 'X' || @user_choice == 'x')

    (menu_level_left ;  return) if @user_choice == "\e[D"

    tmp_lvl = @current_level + '.' + @user_choice
    cmd = @menu_map[tmp_lvl][1]
    cmd ? execute_action(cmd) : @current_level = tmp_lvl
  end

  def execute_action cmd
    output = %x[#{cmd}]
    puts output
    sleep 2
  end

  def invalid_user_choice
    puts "INVALID CHOICE"
    sleep 2
  end

  # Changes the current level value to go on the next left branch.
  # from 'a.b.c.0.1' to 'a.b.c.0.'
  def menu_level_left
    return if @current_level.length == 1
    arry = @current_level.split('.')
    arry.pop
    @current_level = arry.join('.')
  end

  def main
    while @current_level != 'X'
      print_menu @current_level
      get_user_choice
      is_user_choice_valid? ? action : invalid_user_choice
    end

  end

  end
