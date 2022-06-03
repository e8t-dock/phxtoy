// Bring in Phoenix channels client library:
import { Socket, Presence } from "phoenix";

// And connect to the path in "lib/app_web/endpoint.ex". We pass the
// token for authentication. Read below how it should be used.
let socket = new Socket("/socket/chat01", {
  params: { token: window.userToken },
});

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "lib/app_web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "lib/app_web/templates/layout/app.html.heex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/3" function
// in "lib/app_web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket, _connect_info) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1_209_600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, connect to the socket:
socket.connect();

// Now that you are connected, you can join channels with a topic.
// Let's assume you have a channel with a topic named `room` and the
// subtopic is its id - in this case 42:

let getName = (url) => {
  let urlObj = new URL(url);
  return urlObj.searchParams.get("name") || "anonymous";
};

// 从链接参数中读取 name
let channel = socket.channel("chat01:lobby", {
  // name: window.location.search.split("=")[1],
  name: getName(window.location),
});

// let channel = socket.channel("chat01:lobby", {});

let chatInput = document.querySelector("#chat01-input");
let messageContainer = document.querySelector("#chat01-messages");

// 当按下回车时，读取 input 内容，并向后端发送 new_msg 事件和数据

chatInput.addEventListener("keypress", (evt) => {
  message = chatInput.value.trim();
  if (evt.key === "Enter") {
    if (evt.shiftKey) {
      console.log("oh shift+enter");
    } else if (message != "") {
      evt.preventDefault();
      channel.push("new_msg", { body: message });
      chatInput.value = "";
    }
  }
});

// 后端处理数据后推送到前端
// 不需要判断是否是发送方 自行 diff

const render = (text) => {
  let linkPattern =
    /https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)/gi;
  let content = text.replaceAll(
    new RegExp(linkPattern),
    '<a class="inner-link" href="$&" target="_blank">$&</a>'
  );
  return content;
};

channel.on("new_msg", (payload) => {
  let messageItem = document.createElement("div");
  console.log("on new_msg: ", payload);
  messageItem.innerHTML = `<p>[${Date()}]</p><div>${render(
    payload.body
  )}</div>`;
  // messageContainer.appendChild(messageItem);
  messageContainer.insertBefore(messageItem, messageContainer.firstChild);
});

// presence

let presence = new Presence(channel);

// 回调 onSync(() => trackOnlineUsers(presence))
const trackOnlineUsers = (presence) => {
  let response = "";
  presence.list((id, { metas: [first, ...rest] }) => {
    console.log(first, rest);
    let count = rest.length + 1;
    response += `<br>${id} (count: ${count})`;
  });
  document.querySelector("#users").innerHTML = response;
};

presence.onSync(() => trackOnlineUsers(presence));

channel
  .join()
  .receive("ok", (resp) => {
    console.log("Joined chat01:lobby successfully", resp);
  })
  .receive("error", (resp) => {
    console.log("Unable to join chat01:lobby", resp);
  });

export default socket;
