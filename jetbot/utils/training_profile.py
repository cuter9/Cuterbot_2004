# %matplotlib inline
# from IPython.display import clear_output

import numpy as np
import os
import matplotlib
import matplotlib.pyplot as plt

matplotlib.use("TkAgg")

# dir_training_records = os.path.join(dir_depo, 'training records', TRAIN_MODEL)
# os.makedirs(dir_training_records, exist_ok=True)

fig_1, ax_1 = plt.subplots(figsize=(8, 4))
font = {'weight': 'normal', 'size': 10}


def plot_loss(loss_data, best_loss, no_epoch, dir_training_records, train_model, train_method):
    plt.cla()
    epochs = range(len(loss_data))
    ld_train = [ld[0] for ld in loss_data]
    ld_test = [ld[1] for ld in loss_data]
    ax_1.semilogy(epochs, ld_train, "r-", linewidth=1.0, label="Training Loss: {:.4E}".format(ld_train[-1]))
    ax_1.semilogy(epochs, ld_test, 'bs--', linewidth=1.0, label="Test Loss: {:.4E}".format(ld_test[-1]))

    ax_1.set_xlim(0, int(epochs[-1] * 1.1) + 1)
    xlim = epochs[-1] + 2
    ax_1.set_xlim(0, xlim)
    plt.legend()
    plt.title("Training convergence plot -- {:s} \n current best test loss : {:.4f}".format(train_model, best_loss))
    plt.xlabel('epoch', fontdict=font)
    plt.ylabel('loss', fontdict=font)

    fig_1.canvas.draw()
    fig_1.canvas.flush_events()
    plt.show(block=False)
    if len(loss_data) >= no_epoch:
        profile_plot = os.path.join(dir_training_records,
                                    "Training_convergence_plot_Model_{:s}_Training_Method_{:s})".
                                    format(train_model, train_method))
        fig_1.savefig(profile_plot)
    # display(fig_1)


def lt_plot(lt_epoch, lt_sample, dir_training_records, train_model, train_method):
    # ----- training time statistics in terms of epoch
    learning_time_epoch = np.array(lt_epoch)
    mean_lt_epoch = np.mean(learning_time_epoch)
    max_lt_epoch = np.amax(learning_time_epoch)
    min_lt_epoch = np.amax(learning_time_epoch)
    print(
        "mean learning time per epoch: {:.3f} s, maximum epoch learning time: {:.3f} s, minimum epoch learning time: {:.3f} s".
        format(mean_lt_epoch, max_lt_epoch, min_lt_epoch))

    # ----- training time statistics in terms of sample
    learning_time_sample = np.array(lt_sample)
    mean_lt_sample = np.mean(learning_time_sample)
    max_lt_sample = np.amax(learning_time_sample)
    min_lt_sample = np.amax(learning_time_sample)
    print(
        "mean learning time per sample: {:.3f} s, maximum sample learning time: {:.3f} s, minimum sample learning time: {:.3f} s".
        format(mean_lt_sample, max_lt_sample, min_lt_sample))

    fig_2, axh = plt.subplots(1, 2, figsize=(10, 4))
    fig_2.suptitle("Training Time Statistics -- {:s}".format(train_model))
    axh[0].set_ylabel('no. of epoch')
    axh[0].set_xlabel('time of training in an epoch , sec.')
    axh[0].hist(learning_time_epoch)
    axh[1].set_ylabel('no. of sample')
    axh[1].set_xlabel('time for training a sample , sec.')
    axh[1].hist(learning_time_sample, bins=(0.01 * np.array(list(range(101)))).tolist())
    plt.show(block=False)
    training_time_file = os.path.join(dir_training_records,
                                      "Training_time_Model_{:s}_Training_Method_{:s})".
                                      format(train_model, train_method))
    fig_2.savefig(training_time_file)
