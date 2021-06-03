# typed: false
# frozen_string_literal: true

##
# Scalene formula for Homebrew.
class Scalene < Formula
  ##
  # Installs Scalene script and libraries.
  desc "High-performance CPU, GPU and memory profiler for Python"
  homepage "https://github.com/plasma-umass/scalene"
  version "1.3.5"
  license "Apache-2.0"

  stable do
    url "https://github.com/plasma-umass/scalene.git", revision: "d9671cb6f378822c95cf73c5f9d4ec0a4fd85b0c"
  end

  head do
    url "https://github.com/plasma-umass/scalene.git", branch: "master"
  end

  def install
    system "make"

    lib.install "scalene/libscalene.dylib"

    (buildpath/"runner_script").write(runner_script)
    bin.install "runner_script" => "scalene"
  end

  test do
    system "false"
  end

  def runner_script
    <<~EOS
      #!/usr/bin/env sh
      OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES DYLD_INSERT_LIBRARIES=#{lib}/libscalene.dylib PYTHONMALLOC=malloc python3 -m scalene "$@"
    EOS
  end
end
