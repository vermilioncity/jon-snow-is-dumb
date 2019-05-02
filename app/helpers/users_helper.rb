module UsersHelper
  def avatar_for(user, options = { size: 80 })

    size = options[:size]
    default_image = image_url('viserys-150.png')

    if user
      avatar_url = user.avatar.url || default_image
      username = user.username
    else
      avatar_url = default_image
      username = 'anonymous'
    end

    image_tag(avatar_url, alt: username, size: size)

  end
end
