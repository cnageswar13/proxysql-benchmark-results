MYSQL1=172.16.0.2
MYSQL2=172.16.0.2,172.16.0.3
PROXY124=/tmp/proxysql124.sock
PROXY130=/tmp/proxysql130.sock

for t in 8 16 32 64 128 256 512 ; do LD_PRELOAD=/usr/local/mysql/lib/libmysqlclient.so.18 ./sysbench --num-threads=$t --max-requests=0 --max-time=60 --test=./tests/db/oltp.lua --mysql-user=sbtest --mysql-password=sbtest --mysql-port=3306 --mysql-host=$MYSQL1 --oltp-skip-trx=on --oltp-read-only=on --oltp-tables-count=8 --oltp-range-size=5 --oltp-point-selects=50 --oltp_table_size=500000 run > /root/mysql1_thr"$t".log ; done

for t in 8 16 32 64 128 256 512 ; do LD_PRELOAD=/usr/local/mysql/lib/libmysqlclient.so.18 ./sysbench --num-threads=$t --max-requests=0 --max-time=60 --test=./tests/db/oltp.lua --mysql-user=sbtest --mysql-password=sbtest --mysql-port=3306 --mysql-host=$MYSQL2 --oltp-skip-trx=on --oltp-read-only=on --oltp-tables-count=8 --oltp-range-size=5 --oltp-point-selects=50 --oltp_table_size=500000 run > /root/mysql2_thr"$t".log ; done

for t in 8 16 32 64 128 256 512 ; do LD_PRELOAD=/usr/local/mysql/lib/libmysqlclient.so.18 ./sysbench --num-threads=$t --max-requests=0 --max-time=60 --test=./tests/db/oltp.lua --mysql-user=sbtest --mysql-password=sbtest --mysql-socket=$PROXY124 --oltp-skip-trx=on --oltp-read-only=on --oltp-tables-count=8 --oltp-range-size=5 --oltp-point-selects=50 --oltp_table_size=500000 run > /root/proxy124_thr"$t".log ; done

for t in 8 16 32 64 128 256 512 ; do LD_PRELOAD=/usr/local/mysql/lib/libmysqlclient.so.18 ./sysbench --num-threads=$t --max-requests=0 --max-time=60 --test=./tests/db/oltp.lua --mysql-user=sbtest --mysql-password=sbtest --mysql-socket=$PROXY130 --oltp-skip-trx=on --oltp-read-only=on --oltp-tables-count=8 --oltp-range-size=5 --oltp-point-selects=50 --oltp_table_size=500000 run > /root/proxy130_thr"$t".log ; done
