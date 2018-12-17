import axios from 'axios'

class Api {
  constructor() {
    this.$http = axios.create({
      baseURL: process.env.NODE_ENV === 'production' ? 'https://igai.info' : 'http://localhost:3000',
      timeout: 60000,
      headers: {
        'Cache-Control': 'no-cache',
        'X-Requested-With': 'XMLHttpRequest',
        'X-CSRF-Token': gon.general.rails.csrf.token
      }
    })
  }
  getMessages (chat_room_id) {
    return this.$http.get(`chat_rooms/${chat_room_id}/messages.json`)
  }
  markAllMessagesAsRead (chat_room_id, user_id) {
    return this.$http.post(`chat_rooms/${chat_room_id}/messages/read?&user_id=${user_id}`)
  }
}

export default new Api()
