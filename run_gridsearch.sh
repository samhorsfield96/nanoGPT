batch_size=(4 8 16 32 64)
block_size=(32 64 128 256 512 1024 2048)
n_layer=(4 8 12 16 20 24)
n_head=(4 8 12 16 20 24)
n_embd=(128 256 384)
dropout=(0.0 0.1)
learning_rate=(0.000001 0.00001 0.0001 0.001)
max_epochs=(50 100 200 400)
#max_epochs=(5 10 20 40)
weight_decay=(0.001 0.01 0.1)
beta1=(0.9)
beta2=(0.99)
grad_clip=(1.0) 
#decay_lr=("True" "False")
warmup_epochs=(25)
lr_decay_epochs=(400)
min_lr=(0.0000001)
param_set=1
outdir=/media/mirrored-hdd/shorsfield/jobs/pangenome_LLM/grid_search
data_dir=/media/mirrored-hdd/shorsfield/jobs/pangenome_LLM/training_data/synteny_char_stratified
summary_file=/media/mirrored-hdd/shorsfield/jobs/pangenome_LLM/grid_search/grid_summary.txt

for batch in "${batch_size[@]}"; do 
    for block in "${block_size[@]}"; do 
        for layer in "${n_layer[@]}"; do 
            for head in "${n_head[@]}"; do 
                for embd in "${n_embd[@]}"; do 
                    for drop in "${dropout[@]}"; do 
                        for rate in "${learning_rate[@]}"; do 
                            for epoch in "${max_epochs[@]}"; do
                                for decay in "${weight_decay[@]}"; do
                                    for b1 in "${beta1[@]}"; do
                                        for b2 in "${beta2[@]}"; do
                                            for grad in "${grad_clip[@]}"; do
                                                for w_epoch in "${warmup_epochs[@]}"; do
                                                    for d_epoch in "${lr_decay_epochs[@]}"; do
                                                        for min_rate in "${min_lr[@]}"; do
    python train.py --batch_size=${batch} --block_size=${block} --n_layer=${layer} --n_head=${head} --dropout=${drop} \
        --learning_rate=${rate} --max_epochs=${epoch} --weight_decay=${decay} --beta1=${b1} --beta2=${b2} --grad_clip=${grad} \
        --warmup_epochs=${w_epoch} --lr_decay_epochs=${d_epoch} --min_lr=${min_rate} --param_set_ID=${param_set} --always_save_checkpoint=True \
        --out_dir=${outdir}/param_set_${param_set} --data_dir=${data_dir} --summary_file=${summary_file}
    ((param_set += 1))
done ; done ; done ; done ; done ; done ; done ; done ; done ; done ; done ; done ; done ; done ; done