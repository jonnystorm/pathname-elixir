# Copyright © 2015 Jonathan Storm <the.jonathan.storm@gmail.com>
# This work is free. You can redistribute it and/or modify it under the
# terms of the Do What The Fuck You Want To Public License, Version 2,
# as published by Sam Hocevar. See the COPYING.WTFPL file for more details.

defmodule Pathname do
  defstruct address: nil, protocol: nil, protocol_params: nil 

  @type ip_protocol :: :udp | :tcp
  @type port_number :: 0..65535

  @type t :: %Pathname{
    address: String.t,
    protocol: ip_protocol,
    protocol_params: []
  }

  def address(pathname) do
    pathname.address
  end 
  def address(pathname, value) do
    %Pathname{pathname|address: value}
  end 

  def protocol(pathname) do
    pathname.protocol
  end 
  def protocol(pathname, value) do
    %Pathname{pathname|protocol: value}
  end 
  def protocol(pathname, protocol, params) when is_list(params) do
    %Pathname{pathname|protocol: protocol, protocol_params: params}
  end

  def protocol_params(pathname) do
    pathname.protocol_params
  end 
  def protocol_params(pathname, value) do
    %Pathname{pathname|protocol_params: value}
  end 

  def new(address) do
    new(address, nil, nil)
  end 
  def new(address, protocol, protocol_params) do
    %Pathname{}
    |> Pathname.address(address)
    |> Pathname.protocol(protocol)
    |> Pathname.protocol_params(protocol_params)
  end 

  def pathname_to_uri(pathname) do
    [   
      "#{Pathname.protocol pathname}",
      "#{Pathname.address pathname}",
      "#{Pathname.protocol_params(pathname)[:port]}"
    ]   
    |> Enum.join(":")
    |> String.strip(?:)
  end
end 
