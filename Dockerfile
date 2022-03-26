FROM debian:bullseye

RUN cd /tmp && \
	apt update && \
	apt upgrade -y && \
	apt install -y libhwloc15 libuv1 libssl1.1 tmux tor && \
	apt install -y cmake ninja-build build-essential libhwloc-dev libuv1-dev libssl-dev wget && \
	wget -q https://github.com/xmrig/xmrig/archive/refs/tags/v6.16.4.tar.gz -O xmrig-6.16.4.tar.gz && \
	tar -zxf xmrig-6.16.4.tar.gz && \
	mkdir -p xmrig-6.16.4/build && \
	cd xmrig-6.16.4/build && \
	cmake .. -G Ninja && \
	ninja all && \
	install xmrig /usr/local/bin && \
	cd - && \
	rm -rf xmrig-6.16.4* && \
	apt remove --purge -y cmake ninja-build build-essential libhwloc-dev libuv-dev libssl-dev wget && \
	apt autoremove --purge -y && \
	apt clean && \
	rm -rf /var/lib/apt/lists/*
