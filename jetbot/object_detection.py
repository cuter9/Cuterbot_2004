from xml.sax.xmlreader import InputSource
import tensorrt as trt
from jetbot.ssd_tensorrt import parse_boxes, parse_boxes_fpn, TRT_INPUT_NAME, TRT_OUTPUT_NAME
from .tensorrt_model import TRTModel, parse_boxes_yolo
import numpy as np
import cv2
import ctypes
import os

mean = 255.0 * np.array([0.5, 0.5, 0.5])
stdev = 255.0 * np.array([0.5, 0.5, 0.5])


def bgr8_to_ssd_input(camera_value, input_shape):
    """Preprocess an image size to meet the size of model input before TRT SSD inferencing.
    """
    x = camera_value
    x = cv2.cvtColor(x, cv2.COLOR_BGR2RGB)
    # x = cv2.resize(x, (300, 300))
    x = cv2.resize(x, input_shape)
    x = x.transpose((2, 0, 1)).astype(np.float32)
    x -= mean[:, None, None]
    x /= stdev[:, None, None]
    return x[None, ...]


def bgr8_to_ssd_fpn_input(camera_value, input_shape):
    """Preprocess an image size to meet the size of model input before TRT SSD FPN model inferencing.
       the input for SSD FPN mode which converted from Tensorflow V2 does nor need normalization to +/- 1
       because the normalization function has been already included in the model
    """
    x = camera_value
    x = cv2.resize(x, input_shape)
    x = cv2.cvtColor(x, cv2.COLOR_BGR2RGB)
    # x = cv2.resize(x, (300, 300))
    x = x.transpose((2, 0, 1)).astype(np.float32)
    x -= mean[:, None, None]
    x /= stdev[:, None, None]
    # return x[None, ...]
    return x[None, ...]


def preprocess_yolo(img, input_shape, letter_box=False):
    """Preprocess an image size to meet the size of model input before TRT YOLO inferencing.

    # Args
        img: int8 numpy array of shape (img_h, img_w, 3)
        input_shape: a tuple of (H, W)
        letter_box: boolean, specifies whether to keep aspect ratio and
                    create a "letterboxed" image for inference

    # Returns
        preprocessed img: float32 numpy array of shape (3, H, W)
    """
    if letter_box:
        img_h, img_w, _ = img.shape
        new_h, new_w = input_shape[0], input_shape[1]
        offset_h, offset_w = 0, 0
        if (new_w / img_w) <= (new_h / img_h):
            new_h = int(img_h * new_w / img_w)
            offset_h = (input_shape[0] - new_h) // 2
        else:
            new_w = int(img_w * new_h / img_h)
            offset_w = (input_shape[1] - new_w) // 2
        resized = cv2.resize(img, (new_w, new_h))
        img = np.full((input_shape[0], input_shape[1], 3), 127, dtype=np.uint8)
        img[offset_h:(offset_h + new_h), offset_w:(offset_w + new_w), :] = resized
    else:
        img = cv2.resize(img, input_shape)

    img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    img = img.transpose((2, 0, 1)).astype(np.float32)
    img /= 255.0
    return img


def load_plugins():
    library_path = os.path.join(os.path.dirname(__file__), 'yolo_tensorrt/libyolo_layer.so')
    ctypes.CDLL(library_path)


class ObjectDetector(object):

    def __init__(self, engine_path, type_model=None, preprocess_fn=bgr8_to_ssd_input):
        logger = trt.Logger()
        trt.init_libnvinfer_plugins(logger, '')
        load_plugins()

        assert type_model is not None
        self.type_model = type_model

        # self.trt_model = TRTModel(engine_path, input_names=[TRT_INPUT_NAME],
        #                          output_names=[TRT_OUTPUT_NAME, TRT_OUTPUT_NAME + '_1'])
        self.trt_model = TRTModel(engine_path)

        if self.type_model == 'SSD':
            self.preprocess = bgr8_to_ssd_input
            self.postprocess = parse_boxes
        elif self.type_model == 'SSD_FPN':
            self.preprocess = bgr8_to_ssd_fpn_input
            self.postprocess = parse_boxes_fpn
        elif self.type_model == 'YOLO':
            self.preprocess = preprocess_yolo
            self.postprocess = parse_boxes_yolo
        self.input_shape = self.trt_model.input_shape

    def execute(self, *inputs, conf_th=0.5):

        # trt_outputs = self.trt_model(inputs)
        # trt_outputs = self.trt_model(self.preprocess_fn(*inputs))
        # print("model input shape", self.input_shape)
        # print('Image size:', np.shape(inputs))
        # detections = None

        trt_outputs = self.trt_model(self.preprocess(*inputs, self.input_shape))
        detections = self.postprocess(trt_outputs, conf_th=conf_th)

        '''
        if self.type_model == 'SSD':
            detections = parse_boxes(trt_outputs)
        elif self.type_model == 'SSD_FPN':
            detections = parse_boxes_fpn(trt_outputs)
        elif self.type_model == 'YOLO':
            detections = parse_boxes_yolo(trt_outputs)
        '''
        # return trt_outputs
        # print(detections)
        return detections

    def __call__(self, *inputs, conf_th=0.5):
        return self.execute(*inputs, conf_th=conf_th)
