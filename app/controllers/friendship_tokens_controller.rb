class FriendshipTokensController < APIController
  def show
    # Obtiene la hora actual en formato Unix timestamp
    friendship_token = "#{Time.now.to_i}"

    # URL base de tu frontend (ajusta esto según tu configuración)
    frontend_base_url = "http://127.0.0.1:3000"

    # Agrega el token de amistad a la cadena de consulta de la URL
    frontend_url = "#{frontend_base_url}/&friendship_token=#{friendship_token}&user_id=#{current_bearer.id}"

    # Crea el código QR utilizando la gema rqrcode
    qr = RQRCode::QRCode.new(frontend_url)
    png = qr.as_png(size: 300)

    # Envía el código QR como una imagen PNG
    send_data png.to_s, type: 'image/png', disposition: 'inline'
  end
end