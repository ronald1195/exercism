defmodule FileSniffer do

  @extension_media_types %{
    "exe" => "application/octet-stream",
    "bmp" => "image/bmp",
    "png" => "image/png",
    "jpg" => "image/jpg",
    "gif" => "image/gif"
  }

  @signature_media_types %{
    "\x7F\x45" => "application/octet-stream",
    "\x42\x4D" => "image/bmp",
    "\x89\x50" => "image/png",
    "\xFF\xD8" => "image/jpg",
    "\x47\x49" => "image/gif"
  }

  def type_from_extension(extension) do
    @extension_media_types[extension]
  end

  def type_from_binary(<<signature::binary-size(8), _::binary>>) do
    # @signature_media_types[signature]
    IO.inspect(signature, label: "signature value:::")
    IO.inspect(@signature_media_types[signature], label: "signature:::")
  end

  def verify(file_binary, extension) do
    # Please implement the verify/2 function
  end
end
