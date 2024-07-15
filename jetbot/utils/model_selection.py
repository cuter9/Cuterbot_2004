import pandas as pd
import os
from traitlets import HasTraits, Unicode, List
import numpy

HEAD_LIST = ['model_function', 'model_type', 'model_path']
MODEL_REPO_DIR = os.path.join(os.environ["HOME"], "model_repo")
MODEL_REPO_DIR_DOCKER = os.path.join("/workspace", "model_repo")

class trt_model_selection(HasTraits):
    model_function = Unicode(default_value='object detection').tag(config=True)
    model_function_list = List(default_value=[]).tag(config=True)
    model_type = Unicode(default_value='SSD').tag(config=True)
    model_type_list = List(default_value=[]).tag(config=True)
    model_path = Unicode(default_value='').tag(config=True)
    model_path_list = List(default_value=[]).tag(config=True)

    def __init__(self):
        super().__init__()
        self.df = pd.read_csv(os.path.join(MODEL_REPO_DIR_DOCKER, "trt_model_tbl.csv"),
                              header=None, names=HEAD_LIST)
        self.model_function_list = list(self.df["model_function"].astype("category").cat.categories)
        self.model_type_list = list(self.df["model_type"].astype("category").cat.categories)
        mf = self.df[self.df.model_function == self.model_function]
        self.model_path_list = mf[mf.model_type == self.model_type].loc[:, ['model_path']].values.tolist()

    def update_model_list(self):
        mf = self.df[self.df.model_function == self.model_function]     # select the models based on given model function
        mt = mf[mf.model_type == self.model_type]               # select the models from the given model type
        self.model_path_list = mt.loc[:, ['model_path']].values.tolist()
        return self.model_path_list

    def update_model_type_list(self):
        mf = self.df[self.df.model_function == self.model_function]     # select the models based on given model function
        # mt = mf[mf.model_type == self.model_type]
        self.model_type_list = list(mf["model_type"].astype("category").cat.categories) # the model types of the given model function
        return self.model_type_list

ms = trt_model_selection()
ms.model_function = 'classifier'
ms.model_type = 'ResNet'
model_type_list = ms.update_model_type_list()
model_path_list = ms.update_model_list()
print(ms.model_function_list, ms.model_type_list)
model_path_list = os.path.join(MODEL_REPO_DIR_DOCKER, model_path_list[0][0].split("/", 1)[1])
print(model_path_list)