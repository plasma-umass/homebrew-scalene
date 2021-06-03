class Scalene < Formula
  desc "A high-performance CPU, GPU and memory profiler for Python"
  homepage "https://github.com/plasma-umass/scalene"
  license "Apache-2.0"
  
  head do
    url "https://github.com/plasma-umass/scalene.git", :branch => "master"
  end

  test do
    system "scalene --help"
  end

  def install
    system "make"

    lib.install "scalene/libscalene.dylib"

    (buildpath/"runner_script").write(runner_script)
    bin.install "runner_script" => "scalene"
  end

  def runner_script; <<~EOS
#!/usr/bin/env sh

OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES DYLD_INSERT_LIBRARIES=#{lib}/libscalene.dylib PYTHONMALLOC=malloc python3 -m scalene "$@"
  EOS
  end

end
