defmodule AppWeb.SurveyLive.Index do
  use AppWeb, :live_view

  # def mount(_params, %{"user_token"=>user_token}, socket) do
  def mount(_params, _session, socket) do
    # current_user = Accounts.get_user_by_session_token(user_token)
    current_user = %{id: 1, username: 'john'}
    {:ok, socket |> assign(:current_user, current_user)}
  end
end
