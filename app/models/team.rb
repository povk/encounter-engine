# -*- encoding : utf-8 -*-
class Team < ActiveRecord::Base
  has_many :game_entries, :class_name => "GameEntry"
  has_many :members, :class_name => "User"
  belongs_to :captain, :class_name => "User"

  validates_uniqueness_of :name,
    :message => "Komanda tokiu pavadinimu jau yra"

  validates_presence_of :name,
    :message => "Komandos pavadinimas negali būti tuščias"

  after_save :adopt_captain

  def current_level_in(game)
    game_passing = GamePassing.of(self, game)
    game_passing.try :current_level
  end

  def finished?(game)
    game_passing = GamePassing.of(self, game)
    !! game_passing.try(:finished?)
  end

  protected

  def adopt_captain
    unless captain.nil?
      self.members << captain unless members.include?(captain)
    end
  end
end
