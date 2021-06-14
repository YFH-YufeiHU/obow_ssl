#!/bin/sh

#SBATCH --job-name=TestJob	        # name of the job TRAININGJOB
#SBATCH --partition=gpu_p13       	# request for allocation on the CPU partition
#SBATCH --nodes=1			# node=1
#SBATCH --ntasks-per-node=4		# every node has 8 gpus		
#SBATCH	--gres=gpu:4			# reserve 8 gpus for each node
#SBATCH --cpus-per-task=3       	# number of OpenMP threads
# /!\ Caution, "multithread" in Slurm vocabulary refers to hyperthreading.
#SBATCH --time=66:59:59             	##95:59:59            # maximum execution time requested (HH:MM:SS)a
#SBATCH --output=omp%j.out          	# name of output file
#SBATCH --error=omp%j.out           	# name of error file (here, in common with outp


#SBATCH --qos=qos_gpu-t4 # Pour specifier une QoS différente du défaut, vous pouvez au choix : - qos_gpu-t3 (défaut)  20h  96 noeuds- qos_gpu-t4  100h 1 noeud- qos_gpu-dev 2h  4 noeuds
#SBATCH --hint=nomultithread

#SBATCH --account=uvt@gpu #ldr@gpu # uvt@gpu


hostname
echo --------------------------------------
pwd
#cd projets/morphodas/
echo --------------------------------------
pwd
echo --------------------------------------
echo --------------------------------------
module load anaconda-py3
conda activate vissl
pip list
python3 main_obow.py --config=cityscapes/ResNet50_OBoW_cityscapes\
                     --workers=32 -p=250 \
                     --dst-dir=./experiments/ --data-dir=../MoCo_SSL_segmentation/data/cityscapes/\
                     --multiprocessing-distributed \
                     #--convert-to-torchvision
