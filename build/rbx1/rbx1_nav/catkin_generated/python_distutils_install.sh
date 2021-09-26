#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
    DESTDIR_ARG="--root=$DESTDIR"
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/zhou/ros1/src/rbx1/rbx1_nav"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/zhou/ros1/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/zhou/ros1/install/lib/python2.7/dist-packages:/home/zhou/ros1/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/zhou/ros1/build" \
    "/usr/bin/python2" \
    "/home/zhou/ros1/src/rbx1/rbx1_nav/setup.py" \
    build --build-base "/home/zhou/ros1/build/rbx1/rbx1_nav" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/home/zhou/ros1/install" --install-scripts="/home/zhou/ros1/install/bin"
