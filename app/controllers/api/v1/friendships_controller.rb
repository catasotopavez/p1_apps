class API::V1::FriendshipsController < APIController
  # Método para crear una nueva amistad
  def create
    json_data = JSON.parse(request.body.read)
    id = json_data["friendId"]
    pos = json_data["gps_coord"]
    friend = User.find(id) # Encuentra al amigo por su ID
    # Utiliza la relación para crear una amistad directamente
    friendship = current_bearer.friendships.new(friend: friend, gps_coordinates: pos)

    #ver si ya existe
    existing_friendship = current_bearer.friendships.find_by(friend: friend)

    if friendship.save
      render json: { message: '¡Amistad creada con éxito!' }, status: :created
    else
      if current_bearer.id == friend.id
        render json: { error: 'No puedes ser amigo de ti mismo.' }, status: :unprocessable_entity
        return
      elsif existing_friendship
        render json: { error: 'La amistad ya existe.' }, status: :unprocessable_entity
        return
      else
        render json: { error: friendship.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
end
