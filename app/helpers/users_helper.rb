module UsersHelper
  def avatar_for(user, options = { size: 80 })

    size = options[:size]

    avatar_url = user.avatar.url || image_url('viserys-150')

    image_tag(avatar_url, alt: user.username, size: size)

  end
end
