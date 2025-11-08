fd '\.html\.in$' | while read src
do
	target="${src#./}"
	target="public/${target%.in}"
	echo "$target"
done | xargs redo-ifchange
