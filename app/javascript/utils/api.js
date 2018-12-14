import axios from 'axios'

class Api {
  constructor() {
    this.$http = axios.create({
      baseURL: 'http://localhost:3000'
    })
  }
  getMessages (product_id, chat_room_id) {
    return this.$http.get(`products/${product_id}/chat_rooms/${chat_room_id}/messages.json`)
  }
}

export default new Api()
