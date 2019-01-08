# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  belongs_to :team

  has_many :created_games, :class_name => "Game", :foreign_key => "author_id"

  validates_presence_of :email, :message => "Neįvedėte el. pašto adreso"

  validates_uniqueness_of :email,
    :message => "Vartotojas su šiuo adresu, jau yra užregistruotas"

  validates_presence_of :nickname,
    :message => "Neįvedėte vardo"

  validates_uniqueness_of :nickname,
    :message => "Toks vartotojas jau yra"

  validates_length_of :password, :minimum => 4,
    :message => "Slaptažodis per trumpas (mažiausiai 4 simboliai)",
    :if => :password_required?

  validates_confirmation_of :password,
    :message => "Slaptažodis ir patvirtinimas nesutampa",
    :if => :password_required?


  def member_of_any_team?
    !! team
  end

  def captain?
    member_of_any_team? && team.captain.id == id
  end

  def author_of?(game)
    game.author.id == self.id
  end
end
