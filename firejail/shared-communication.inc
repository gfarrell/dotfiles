# Shared configuration for applications that need to communicate via xdg-open
# This allows proper browser/application launching across sandbox boundaries

# Essential binaries for xdg-open functionality
private-bin awk,bash,dbus-launch,dbus-send,env,sh,which,grep,sed,firefox,slack,zoom,xdg-open,xdg-mime

# Required for GNOME/desktop environment integration
private-bin basename,cut,egrep,head,readlink,tr

# Allow access to firejail binary for --join operations
private-bin firejail

# Allow access to common browser profiles for authentication sharing
noblacklist ${HOME}/.mozilla
whitelist ${HOME}/.mozilla

# Allow access to common application config for state sharing  
noblacklist ${HOME}/.config/Slack
whitelist ${HOME}/.config/Slack
noblacklist ${HOME}/.zoom
whitelist ${HOME}/.zoom

# DBus permissions for inter-application communication
dbus-user.talk org.freedesktop.Application.*
dbus-user.talk org.freedesktop.portal.*
dbus-user.talk org.mozilla.Firefox.*
dbus-user.talk com.slack.Slack
dbus-user.talk us.zoom.Zoom
dbus-user.talk org.freedesktop.FileManager1
dbus-user.talk org.kde.krun
dbus-user.talk org.gnome.Shell
