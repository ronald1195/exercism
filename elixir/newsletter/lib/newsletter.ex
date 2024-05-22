defmodule Newsletter do
  def read_emails(path) do
    with {:ok, contents} <- File.read(path) do
      contents
      |> String.split("\n", trim: true)
    else
      {:error, reason} -> {:error, reason}
    end
  end

  def open_log(path) do
    File.open!(path, [:write])
  end

  def log_sent_email(pid, email) do
    with :ok <- IO.puts(pid, email) do
      :ok
    else
      {:error, reason} -> {:error, reason}
    end
  end

  def close_log(pid) do
    with :ok <- File.close(pid) do
      :ok
    else
      {:error, reason} -> {:error, reason}
    end
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    case read_emails(emails_path) do
      {:error, reason} ->
        {:error, reason}

      emails ->
        case open_log(log_path) do
          {:error, reason} ->
            {:error, reason}

          pid ->
            emails
            |> Enum.each(fn email ->
              # Only log the email if it was sent successfully
              if send_fun.(email) == :ok do
                log_sent_email(pid, email)
              end
            end)

            close_log(pid)
        end
    end
  end
end
