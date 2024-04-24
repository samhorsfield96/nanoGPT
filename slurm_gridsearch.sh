#!/bin/bash

#Submit this script with: sbatch thefilename
#For more details about each parameter, please check SLURM sbatch documentation https://slurm.schedmd.com/sbatch.html

#SBATCH --time=18:00:00   # walltime
#SBATCH --ntasks=1   # number of tasks
#SBATCH --cpus-per-task=1   # number of CPUs Per Task i.e if your code is multi-threaded
#SBATCH --nodes=1   # number of nodes
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=8G   # memory per node
#SBATCH -J "synteny_LLM_grid"   # job name
#SBATCH -o "synteny_LLM_grid.out"   # job output file
#SBATCH -e "synteny_LLM_grid.err"   # job error file
#SBATCH --mail-user=shorsfield@ebi.ac.uk   # email address
#SBATCH --mail-type=END


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
source /homes/shorsfield/.bashrc
conda activate LLM
cd /hps/software/users/jlees/shorsfield/software/nanoGPT
sh run_gridsearch.sh