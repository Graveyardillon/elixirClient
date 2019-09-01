defmodule Httpclient.Router do
  use Plug.Router

  plug(:match)
  plug(Plug.Parsers,
    parsers: [:urlencoded,:json],
    pass: ["application/json"],
    json_decoder: Poison
  )
  plug(:dispatch)

  @content_type "application/json"

  get "/" do
    render(conn,"sample4post.html")
  end

  post "/" do
    IO.inspect(conn.params, label: "Submitted contact")
    render_json(conn,conn.params)
  end

  match _ do
    send_resp(conn, 404, "Requested page not found!")
  end

  defp message() do
    Poison.encode!(%{
      response_type: "in_channel",
      text: "Hello World!"
    })
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
