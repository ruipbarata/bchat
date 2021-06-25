import consumer from "./consumer"

$(document).on('turbolinks:load', function () {
  var messages = $('#messages');
  if ($('#messages').length > 0) {

    function messages_to_bottom() { messages.scrollTop(messages.prop("scrollHeight")) }

    messages_to_bottom()

    var chatRoomsChannel = consumer.subscriptions.create({
      channel: "ChatRoomsChannel",
      chat_room_id: $('#messages').attr('data-chat-room-id')
    }, {
      connected() {
        // Called when the subscription is ready for use on the server
        console.log("Connected to the chat room #" + messages.attr('data-chat-room-id'));
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        // Called when there's incoming data on the websocket for this channel
        messages.append(data['message']);
        messages_to_bottom()
      },

      send_message(message, chat_room_id) {
        this.perform('send_message', { message: message, chat_room_id: chat_room_id })
      }
    });

    $('#new_message').on('submit', function (e) {
      var $this = $(this)
      var textarea = $this.find('#message_body')
      if ($.trim(textarea.val()).length > 1) {
        chatRoomsChannel.send_message(textarea.val(), messages.data('chat-room-id'));
        textarea.val('')
      }
      e.preventDefault()
      return false
    });
  }
});