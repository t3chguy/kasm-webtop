#!/usr/bin/env bash
set -ex

if [ "${ARCH}" == "arm64" ] ; then
  wget -q https://github.com/prusa3d/PrusaSlicer/releases/download/version_2.7.1/PrusaSlicer-2.7.1+linux-arm64-GTK3-202312130749.tar.bz2 -O /tmp/prusaslicer.tgz
else
  wget -q https://github.com/prusa3d/PrusaSlicer/releases/download/version_2.7.1/PrusaSlicer-2.7.1+linux-x64-GTK3-202312121425.tar.bz2 -O /tmp/prusaslicer.tgz
fi

tar -xvf /tmp/prusaslicer.tgz -C /opt/
mv /opt/PrusaSlicer-* /opt/PrusaSlicer
rm -rf /tmp/prusaslicer.tgz

wget -q https://raw.githubusercontent.com/prusa3d/PrusaSlicer/master/resources/icons/PrusaSlicer.png -O /opt/PrusaSlicer/prusaslicer_icon.png

cat >/usr/share/applications/prusaslicer.desktop <<EOL
[Desktop Entry]
Version=2.6.0
Name=PrusaSlicer
TryExec=/opt/PrusaSlicer/prusa-slicer
Exec=/opt/PrusaSlicer/prusa-slicer -- %u
Icon=/opt/PrusaSlicer/prusaslicer_icon.png
Terminal=false
StartupWMClass=PrusaSlicerDesktop
Type=Application
EOL
chmod +x /usr/share/applications/prusaslicer.desktop
mkdir /home/kasm-user/Desktop
cp /usr/share/applications/prusaslicer.desktop /home/kasm-user/Desktop/prusaslicer.desktop

chown 1000:0 /home/kasm-user/Desktop/prusaslicer.desktop
