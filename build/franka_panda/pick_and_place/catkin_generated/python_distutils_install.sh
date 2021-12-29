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
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/shivam/gods_plan/src/franka_panda/pick_and_place"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/shivam/gods_plan/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/shivam/gods_plan/install/lib/python3/dist-packages:/home/shivam/gods_plan/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/shivam/gods_plan/build" \
    "/usr/bin/python3" \
    "/home/shivam/gods_plan/src/franka_panda/pick_and_place/setup.py" \
    egg_info --egg-base /home/shivam/gods_plan/build/franka_panda/pick_and_place \
    build --build-base "/home/shivam/gods_plan/build/franka_panda/pick_and_place" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/shivam/gods_plan/install" --install-scripts="/home/shivam/gods_plan/install/bin"
