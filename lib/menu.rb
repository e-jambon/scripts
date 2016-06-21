# encoding: utf-8

=begin
Author:       e-jambon
Date:         2016/06/12
Version:      0.2.
Description:  Quick and dirty little tool.
              Creates a menu to use in terminal.
                * Untested.
                * No support provided
                * Not commented.

              USE AT YOUR OWN RISKS.
=end

class Menu
  attr :menu_map, :current_level, :user_choice, :title, :header

  def initialize menu_map, title
    @title = title
    @current_directory = %x`pwd`
    @current_level = '0'
    @menu_map =  menu_map
    make_title
  end



  def make_title
    ctl = '┏'
    ctr = '┓'
    ch= '━'
    cbl = '┗'
    cbr= '┛'
    cv = '┃'

    length = @title.length
    spaces = length%2 == 0 ?  76 - length : 75 - length

    top_L = bottom_L = horizontal_L = title_L = empty_L = ""
    (length+spaces).times {horizontal_L += ch}
    top_L = ctl + horizontal_L + ctr
    bottom_L = cbl + horizontal_L + cbr

    (length+spaces).times {empty_L += " "}
    empty_L = cv + empty_L + cv
    title_L = cv + " "*(spaces/2) + @title + " "*(spaces/2) + cv

    @header = top_L + "\n" +
              empty_L + "\n" +
              title_L + "\n" +
              empty_L + "\n" +
              bottom_L + "\n\n"
  end


  def print_menu_header menu_level, title = "MENU -- MAKE A CHOICE"
    system('clear')
    puts @header
  end

  def footer
    puts "\n X or x to quit / j or <- to previous menu"
    puts "  Your choice"
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



##############################
#
#     USAGE EXAMPLE
#
#
##############################
=begin (menu_example.rb)
#!/usr/bin/env ruby
#encoding = utf-8
require_relative './lib/menu'   # therefore, must be in /lib'parent folder.




#MENU example
#            In case you wonder, it's in french
#            '0.1' is the menu level
#            followed by an array containing 2 items :
#            [0] the menu Description
#            [1] the command the system must execute
#side note : this one was done on Mac-OSx.
MENU={
              #NIVEAU PRINCIPAL
              '0.1' => ["Utilitaires"],
              '0.2' => ["Mon Web"],
              '0.3' => ["Organisation"],
              '0.4' => ["Communication"],
              '0.5' => ["Programmation"],
              '0.6' => ["Loisirs"],
              '0.7' => ["Autre"],

              # Utilitaires
              '0.1.1' => ["Atom.io localement", "atom ."],
              '0.1.2' => ["Cyberduck", "open -g /Applications/Cyberduck.app"],
              '0.1.3' => ["No Machine","open -g /Applications/NoMachine.app"],
              '0.1.4' => ["Autre","echo 'Pas encore implémenté'"],

              # Mon Web
              '0.2.1' => ["Editeur sur e-jambon.com", "atom ~/Documents/localweb/e-jambon.com"],
              '0.2.2' => ["Blog Jambon","open -g http://ici.e-jambon.com"],
              '0.2.3' => ["Liens","open -g http://links.e-jambon.com"],
              '0.2.4' => ["RSS", 'open -g http://kriss.e-jambon.com'],
              '0.2.5' => ["WIKI", 'open -g http://wiki.e-jambon.com'],



              # Organisation
              '0.3.1' => ["Trello", "open -g https://trello.com"],
              '0.3.3' => ["Freemind", "open -g /Applications/FreeMind.app/"],

              # Communication
              '0.4.4' => ["XChat","open '/Applications/XChat Azure.app/'"],

              # Programmation
              '0.5.1' => ["Docker kinematic", "open -g '/Applications/Docker/Kitematic (Beta).app/'"],
              '0.5.2' => ["Dash", "open -g '/Applications/Docker/Dash.app/'"],
              '0.5.3' => ["Github Desktop", "open -g '/Applications/GitHub Desktop.app/'"],
              '0.5.4' => ["Terminal iterm", "open -g '/Applications/iTerm.app'" ],


              # Loisirs
              '0.6.1' => ["Calibre/lecture", "open -g '/Applications/calibre.app'"],
              '0.6.2' => ["Krita/dessin", "open -g '/Applications/Krita.app'"],
              '0.6.3' => ["Mypaint", 'open -g /Applications/MyPaint.app'],

              # Autre
              '0.7.1' => ["OBS capture video", "open '/Applications/OBS.app'"],
            }

mymenu = Menu.new(MENU, "This is my another  title")
mymenu.main

=end
