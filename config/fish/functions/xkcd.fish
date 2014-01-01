function xkcd --description="View a random xkcd comic strip"
  set_color green
  echo "Downloading random xkcd..."
  set_color normal

  set -l url (curl -sL http://dynamic.xkcd.com/random/comic/ | command grep -om1 'http://imgs.xkcd.com/comics/[^.]*\.[a-z]*')

  set -l ext (echo $url | awk -F . '{if (NF>1) {print $NF}}')
  set -l img "/tmp/xkcd-wallpaper.$ext"

  curl -so "$img" --fail "$url"

  if test (count $argv) -eq 0
    ql "$img"
  else
    if test $argv[1] = "-o"
      open "$img"
    else
      ql "$img"
    end
  end
end
