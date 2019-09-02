defmodule Httpclient.Router do

  require IEx
  use Plug.Router
  alias Httpclient.Users

  plug(:match)
  plug(Plug.Parsers,
    parsers: [:urlencoded,:json],
    pass: ["application/json"],
    json_decoder: Poison
  )
  plug(:dispatch)

  get "/" do
    users = 
        Users.User
        |>Users.Repo.all
    IO.inspect(users)

    render(conn,"sample4post.html",users: Enum.map(users, fn(s) -> %{username: s.username,id: s.id} end))
  end

  post "/" do

    body =  Map.put(conn.params,:message,"Post Request is successful!")
    Map.put(conn.params,:message,"Post Request is successful!")
    |>IO.inspect( label: "Submitted contact")
    
    name = Map.get(conn.params,"name")

    %Users.User{username: name}
    |>Users.Repo.insert()
    render_json(conn,body)
  end

  match _ do
    send_resp(conn, 404, "Requested page not found!")
  end

  @template_dir "lib/httpclient/templates" #テンプレートファイルのディレクトリ

  #<htmlファイルとrenderする関数>render
  defp render(%{status: status} = conn, template, assigns \\ []) do
    body =
      @template_dir       
      |> Path.join(template)                            #Path.join関数は二つのパスをつなげる関数
      |> String.replace_suffix(".html", ".html.eex")    #replace_suffixは文字列の末尾をreplaceする関数(意味:suffix=接尾辞)
      |> EEx.eval_file(assigns)                         #ファイルネームとしてパスを受け取る(assignはhtmlに渡す変数)

    send_resp(conn, (status || 200), body)              #ファイルネームであるbodyとともにconnを送ることによってrenderされる
  end

  defp render_json(%{status: status} = conn, data) do
    body = Poison.encode!(data)
    send_resp(conn, (status || 200), body)
  end
  
end
