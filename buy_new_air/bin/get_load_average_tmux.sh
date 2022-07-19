!/bin/sh

echo "#[fg=colour255]($(uptime | awk '{print $(NF-2)}')) #[default]"
