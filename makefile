name=mongo-sg1
image=library://ibug/default/mongo
host_dir=$(shell pwd)
singularity_image_dir=${HOME}/singularity/images
vol1=${host_dir}/volume
mnt1=/data/db
vol2=${host_dir}/shared
mnt2=/shared
pl1=27017
pd1=27017


pull:
	cd ${singularity_image_dir} && \
	singularity pull --name mongo.sif ${image} 

start:
	singularity instance start --bind ${vol1}:${mnt1} --bind ${vol2}:${mnt2} ${singularity_image_dir}/mongo.sif ${name}

stop:
	singularity instance stop ${name}

mongo:
	 singularity exec --bind ${vol1}:${mnt1} ${singularity_image_dir}/mongo.sif mongo --host localhost

commit:
	git add .
	git commit -am "auto commit by "$(shell whoami)
	git pull
	git merge -m 'auto merge'
	git push

clean-cache:
	singularity cache clean

# run:
# 	singularity run --bind ${vol1}:${mnt1} --bind ${vol2}:${mnt2} ${singularity_image_dir}/mongo.sif 


# create:
# 	docker run -d -it --name ${name} \
# 	-v ${vol1}:${mnt1} \
# 	-v ${vol2}:${mnt2} \
# 	-p ${pl1}:${pd1} \
# 	${image}

# create_auth:
# 	docker run -d -it --name ${name} \
# 	-v ${vol1}:${mnt1} \
# 	-v ${vol2}:${mnt2} \
# 	-p ${pl1}:${pd1} \
# 	${image} \
# 	--auth

# bash:
# 	docker exec -it ${name} /bin/bash

# connect:
# 	docker exec -it ${name} mongo

# stop:
# 	docker stop ${name}

# start:
# 	docker start ${name}

# restart: stop start

# delete:
# 	docker rm ${name}






