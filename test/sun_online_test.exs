defmodule SunOnlineTest do
  use ExUnit.Case
  doctest SunOnline

  test "application starts successfully" do
    # Verify the application is running
    assert Process.whereis(SunOnline.Supervisor) != nil
  end
end
