grep 'create view' *.sql \
| sed -e "s/q[0-9]*.sql:create[ \t]*view[ \t]*//" \
| sed -e "s/[ \t]*as//" \
| sed -e "s/.*/drop view if exists & cascade;/" \
| tee others/drop_views.sql