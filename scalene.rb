# typed: false
# frozen_string_literal: true

##
# Scalene formula for Homebrew.
class Scalene < Formula
  ##
  # Installs Scalene script and libraries.
  desc "High-performance CPU, GPU and memory profiler for Python"
  homepage "https://github.com/plasma-umass/scalene"
  version "1.5.32.1"
  license "Apache-2.0"
  depends_on "python" => :build
  
  stable do
    url "https://github.com/plasma-umass/scalene.git", revision: "5666c0547abf8d3da52e2aac04278992db7940cb"
  end

  head do
    url "https://github.com/plasma-umass/scalene.git", branch: "master"
  end

  def install
    system "make"

    lib.install "scalene/libscalene.dylib"

    # Install the Scalene Python package
    system "python3", "-m", "pip", "install", "-e", "."

    (buildpath/"runner_script").write(runner_script)
    bin.install "runner_script" => "scalene"
  end

  test do
    puts "Testing..."
    system "scalene"
  end

  def runner_script
    <<~EOS
      #!/usr/bin/env sh
      OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES DYLD_INSERT_LIBRARIES=#{lib}/libscalene.dylib PYTHONMALLOC=malloc python3 -m scalene "$@"
    EOS
  end
end
