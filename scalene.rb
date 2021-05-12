class Libscalene < Formula
  desc "Memory profiling library for the Scalene profiler for Python"
  homepage "https://github.com/plasma-umass/scalene"

  head do
    url "https://github.com/plasma-umass/scalene.git", :branch => "master"
  end

  def install
    system "make"

    lib.install "libscalene.dylib"
    
    (buildpath/"runner_script").write(runner_script)
    bin.install "runner_script" => "scalene"
  end
  
  def runner_script; <<-EOS
#!/usr/bin/env sh

DYLD_INSERT_LIBRARIES=#{lib}/libscalene.dylib PYTHONMALLOC=malloc python3 -m scalene "$@"
  EOS
  end

end
