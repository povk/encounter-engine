When %r{высылаю пользователю (.*) приглашение вступить в команду}i do |recepient_email|
  Если %{я захожу в комнату команды}
  И %{иду по ссылке "Пригласить участников"}
  И %{ввожу "#{recepient_email}" в поле "Пригласить нового участника"}
  И %{нажимаю "Пригласить"}
  То %{должен увидеть "Пользователю #{recepient_email} выслано приглашение"}  
end

Then %r{пользователь (.*) должен получить приглашение от команды (.*)}i do |user_email, team_name|
  Допустим %{я логинюсь как #{user_email}}
  Если %{я захожу в личный кабинет}
  То %{должен увидеть "Вас пригласили в команду #{team_name}"}
  И %{одно письмо с текстом "Вас пригласили вступить в команду #{team_name}" должно быть выслано на #{user_email}}
end

Then %r{пользователь (.*) не должен получить приглашение}i do |user_email|
  Допустим %{я логинюсь как #{user_email}}
  Если %{я захожу в личный кабинет}
  То %{я не должен видеть "Вас пригласили в команду"}
  И %{никакие письма не должны быть высланы на #{user_email} }
end

When %r{как пользователь (.*) принимаю приглашение команды (.*)$}i do |user_email, team_name|
  Если %{я захожу в личный кабинет}
  То %{должен увидеть "Вас пригласили в команду #{team_name}"}

  user = User.find_by_email user_email
  team = Team.find_by_name team_name
  invitation = Invitation.find :first, :conditions => { :for_user_id => user.id, :to_team_id => team.id }

  Если %{я иду по ссылке "accept-invitation-#{invitation.id}"}
  То %{должен быть перенаправлен в личный кабинет}
end

When %r{как пользователь (.*) отказываюсь от приглашения команды (.*)$}i do |user_email, team_name|
  Если %{я захожу в личный кабинет}
  То %{должен увидеть "Вас пригласили в команду #{team_name}"}

  user = User.find_by_email user_email
  team = Team.find_by_name team_name
  invitation = Invitation.find :first, :conditions => { :for_user_id => user.id, :to_team_id => team.id }

  Если %{я иду по ссылке "reject-invitation-#{invitation.id}"}
  То %{должен быть перенаправлен в личный кабинет}
end