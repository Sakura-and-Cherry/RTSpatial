#!/usr/bin/env bash

# gaussian & gaussian, box & point_query
echo "gaussian & uniform, box & point_query" > output.txt
for box_count in 100000; do
    for query_count in 50000 100000 200000 300000 400000 500000 600000 700000 800000 900000 1000000; do
        for box_dist in gaussian; do
            for query_dist in uniform; do
                /mnt/home/xyzhu/codes/RTSpatial/build/bin/rtspatial_exec \
                    -gpu_id=1 \
                    -box /mnt/home/xyzhu/codes/RTSpatial/dataset/box/$box_dist\_$box_count.wkt \
                    -point_query /mnt/home/xyzhu/codes/RTSpatial/dataset/point/$query_dist\_$query_count.wkt \
                    -predicate predicate >> output.txt
            done
        done
    done
done

# gaussian & gaussian, box & box contains
echo "gaussian & uniform, box & box contains" >> output.txt
for box_count in 100000; do
    for query_count in 50000 100000 200000 300000 400000 500000 600000 700000 800000 900000 1000000; do
        for box_dist in gaussian; do
            for query_dist in uniform; do
                /mnt/home/xyzhu/codes/RTSpatial/build/bin/rtspatial_exec \
                    -gpu_id=1 \
                    -box /mnt/home/xyzhu/codes/RTSpatial/dataset/box/$box_dist\_$box_count.wkt \
                    -box_query /mnt/home/xyzhu/codes/RTSpatial/dataset/box/$query_dist\_$query_count.wkt \
                    -predicate contains >> output.txt
            done
        done
    done
done

# gaussian & gaussian, box & box intersects
echo "gaussian & uniform, box & box intersects" >> output.txt
for box_count in 100000; do
    for query_count in 50000 100000 200000 300000 400000 500000 600000 700000 800000 900000 1000000; do
        for box_dist in gaussian; do
            for query_dist in uniform; do
                /mnt/home/xyzhu/codes/RTSpatial/build/bin/rtspatial_exec \
                    -gpu_id=1 \
                    -box /mnt/home/xyzhu/codes/RTSpatial/dataset/box/$box_dist\_$box_count.wkt \
                    -box_query /mnt/home/xyzhu/codes/RTSpatial/dataset/box/$query_dist\_$query_count.wkt \
                    -predicate intersects >> output.txt
            done
        done
    done
done