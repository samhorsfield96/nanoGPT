# Uses code from PanGPT (https://github.com/mol-evol/panGPT) developed by James McInerney
import torch
from torch.utils.data import Dataset
import random

class GenomeDataset(Dataset):
    """
    GenomeDataset: A custom PyTorch Dataset for preprocessing genomic sequences.

    This class facilitates loading and preprocessing genomic sequences for training
    and evaluating deep learning models. It utilizes a provided tokenizer to
    convert text sequences into numerical representations suitable for model input.

    Args:
        texts (list): A list of text strings representing the genomic sequences.
        tokenizer (transformers.PreTrainedTokenizer): A tokenizer object for
            tokenizing the text sequences.
        max_length (int): The maximum allowed length for the processed sequences
            (after tokenization and padding).

    Attributes:
        tokenizer (transformers.PreTrainedTokenizer): The tokenizer used for
            tokenization.
        texts (list): The list of original text sequences.
        max_length (int): The maximum allowed length for the processed sequences.

    Methods:
        __len__() -> int: Returns the number of samples in the dataset.
        __getitem__(idx) -> torch.tensor: Returns a preprocessed genomic sequence
            (tensor) at the specified index.
    """

    def __init__(self, texts, tokenizer, max_length):
        self.tokenizer = tokenizer
        self.texts = [self.tokenizer.encode(text).ids for text in texts]
        self.max_length = max_length

    def __len__(self):
        return len(self.texts)

    def __getitem__(self, idx):
        encoded = self.texts[idx]

        if len(encoded) > self.max_length:
            encoded = encoded[: self.max_length]

        padded = encoded + [self.tokenizer.token_to_id("[PAD]")] * (
            self.max_length - len(encoded)
        )
        return torch.tensor(padded)

    def batch_sample(self, genome_idx):
        #text = self.texts[genome_idx]
        encoded = self.texts[genome_idx]
        pos_idx = torch.randint(len(encoded), (1,))[0]

        data = encoded[pos_idx : pos_idx + self.max_length]
        obs = encoded[pos_idx + 1 : pos_idx + self.max_length + 1]

        padded_data = data + [self.tokenizer.token_to_id("[PAD]")] * (
            self.max_length - len(data)
        )

        padded_obs = obs + [self.tokenizer.token_to_id("[PAD]")] * (
            self.max_length - len(obs)
        )

        return torch.tensor(padded_data), torch.tensor(padded_obs)