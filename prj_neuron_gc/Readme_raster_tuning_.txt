ZDZ 的程序的简化版的说明, v2.0.13
最后更新 2012-05-22, xyy

使用 raster_tuning --help, 查看用的是普通 LIF 模型还是指数LIF模型(开头会有一句 "! Use Exponential I&F model")

程序改成只有边显示图形边计算及纯计算两个模式. 其他如计算 Lyapunov 指数,
 功率谱等功能皆已去除(但愿去除干净了), 即是说关于分析的代码去除了.

程序默认会把完整的电平数据输出到 data 目录下的 staffsave.txt. 每次运行会覆盖上次数据
 如果需要输出放电时刻的数据, 需在执行时加上参数 --save-spike FILE
 如需要把电平数据输出到别处, 需用参数 -o FILE 指定路径
 参见下面 "程序命令行选项" 一节

默认配置用 --help 参数查看.

程序命令行选项:
  语法:
  raster_tuning [选项]
    -ng           不显示图形界面
    -t TIME       总计算时间, TIME 以毫秒为单位. (默认值为原来的宏COMP_TIME)
    -n N [N2]     神经元数, N 是兴奋型, N2 是抑制型. 省略 N2 相当于 N2=0
    -inf FILE     设置配置文件的路径. 默认是 test2.txt
                  特别地, -inf - 表示不读取任何文件, 使用程序内部的默认值.
    -mat FILE     设置连接矩阵的路径. 默认是 cortical_matrix.txt
                  特别地, -mat - 表示路径是完全图
    -o FILE       设置输出电平文件的路径, 若路径中的目录不存在, 程序会自动建立.
                  默认是 data/staffsave.txt
    --save-conductance FILE
                  输出电导(兴奋电导)数据到文件 FILE
    --save-spike FILE
                  设置输出放电时刻的文件路径. 默认不输出. FILE 为 "-" (短横杠) 时,
                  表示输出到 "./data/ras.txt"
    --save-spike-interval FILE
                  保存平均放电间隔到文件 FILE
    --read-pr FILE
                  从文件 FILE 读取每个神经元的 poisson 输入率(相对值).
    --read-ps FILE
                  从文件 FILE 读取每个神经元的 poisson 输入强度(相对值).
    -s, --save-while-cal
                  设置边计算边输出电平数据(默认)
    --save-last   设置在最后输出电平数据, 输出数据不完整. 仅用作测试.
    --bin-save    电压数据保存成二进制格式(raw double)
    -scee VALUE   设置兴奋型到兴奋型的连接强度
    -scei VALUE   设置兴奋型到抑制型的连接强度
    -scie VALUE   设置抑制型到兴奋型的连接强度
    -scii VALUE   设置抑制型到抑制型的连接强度
    -pr VALUE     设置 poisson 型输入的频率
    -ps VALUE     设置 poisson 型输入对兴奋型神经的单次强度
    -psi VALUE    设置 poisson 型输入对抑制型神经的单次强度
    --pr-mul [VALUE ...] [VALUE@POSITION ...]
                  在命令行设置各个神经元的 poisson 输入率倍率. 可以只设定前几个.
                  可以用 VALUE@POSITION 的语法指定第几个的值, 编号从 1 开始
                  未指定值的神经默认是 1. 必须提前指定神经元个数(即通过 -n 选项).
                  例如: --pr-mul 1.1 1.2 1.3@4 1.4@2 1.5 1.6 的结果相当于
                       --pr-mul 1.1 1.4 1.5 1.6 (即是说 "1.2 1.3@4" 被后面的值覆盖了)
    --ps-mul [VALUE ...] [VALUE@POSITION ...]
                  在命令行设置各个神经元的 poisson 输入强度(兴奋型)倍率. 语法同 --pr-mul
    --psi-mul [VALUE ...] [VALUE@POSITION ...]
                  在命令行设置各个神经元的 poisson 输入强度(抑制型)倍率. 语法同 --pr-mul
    -dt VALUE     设置时间步长为 VALUE
    --save-interval VALUE 或 -stv VALUE
                  输出数据的记录间隔. 若使用 --RC-filter, dt 会被更改为最近整数分之一.
    --seed-auto-on, --seed-auto-off
                  打开或关闭自动设置随机种子(用微秒级(windows上是毫秒级)的系统时间). 默认是打开
    -seed VALUE   设置随机数种子, 隐含--seed-auto-off. 功能同配置文件中的 initial_seed
                  当 seed 设为 0 时, 相当于使用 test2.txt 中的 initial_seed.
    --RC-filter   使用 RC 低通滤波后再采样. 截止频率为"输出数据的记录间隔"对应的最高频率
                  使用此选项时, dt 会强制设成 stv 的整数分之一.
    --RC-filter VALUEco VALUEci
                  使用 RC 低通滤波, 手动设置滤波系数. y[t] = co * y[t-dt] + ci * x[t]
                  输出的数据是 y[stv], y[2*stv], ..., y[k*stv]
                  其中 stv 是输出数据的记录间隔. 见 --save-interval
    -v, --verbose 计算时输出更多信息
    -q, --quiet   安静模式, 只显示错误和警告
    -h, --help    显示帮助(以及一些默认值), 然后程序终止.
    --version     显示版本信息, 然后程序终止.

程序读取输入参数的顺序是
  1. 命令行
  2. 配置文件(默认是 test2.txt)
  3. 程序内置的默认值
以先读到的值为准. 命令行中若出现重复或互斥的项, 以最后(右侧)的为准.

--pr-mul 与 --read-pr 的作用是累积的.

命令行参数以及输入输出的文件中, 神经元编号从 1 开始. (虽然程序内部是从 0 开始的)

注意:
    2011-10-22 以前的版本, 放电时刻文件神经元编号从 0 开始. 之后的从 1 开始.
    输出的数据开头会有一段未平稳的状态, 未去除.
    从 2.0.13 开始, 当使用参数 --RC-filter 时, 输出的电压数据会根据精确的放电时刻进行平均, 从而更为平滑.
    参数文件读取对于不符合格式(malformat)的文件可能会出问题. -inf, -mat, --read-pr, --read-ps
    图形模式时显示的 Poisson 输入频率及输入强度是指第一个神经元的. 但用键盘更改时所有值同比例变化.
    抑制型的神经尚未完整测试

示例:
raster_tuning -ng -n 20 -t 10000 -inf test2_0.txt -o data/staffsave2.txt -v
 含义是不显示图形界面, 20个神经元(都是兴奋型), 计算到 10000ms,
     配置(参数)文件是 test2_0.txt, 输出到 data/staffsave2.txt, 显示更多信息.

raster_tuning -n 2 -pr 1 -ps 0.012 --ps-mul 0.1@2
 显示图形界面, 第二个神经的Poisson输入强度设为 0.1 * 0.012 (第一个仍是 0.012)

raster_tuning -h
 显示帮助然后退出


默认配置文件:
test.txt            周期电流输入, 宏POISSON_INPUT_USE 为 0 时启用
test2.txt           Poisson 脉冲输入, 宏POISSON_INPUT_USE 为 1 时启用
cortical_matrix.txt 神经元间连接关系矩阵, 宏CORTICAL_STRENGTH_NONHOMO 为 1 时启用


神经连接临接矩阵文件 note:
  1. 第 i 行 j 列的元素表示 j 神经元对 i 神经元的影响. 元素的值不必是整数.
  2. 对角线的值不会影响计算
  3. 抑制型神经的编号排在兴奋型后
  4. 连接强度的值是配置文件(默认是test2.txt)的 Strength_CorEE 或 Strength_CorIE 或
     Strength_CorEI 或 Strength_CorII (相应于连接的两个神经元的类型) 与矩阵元素的乘积
  5. 多余的行不会被读入, 故可在末尾加任意注释.
  6. 神经元个数必须与连接矩阵的阶数相同, 否则...


代码内部的宏可调节的功能有:

默认神经元数目
#define Number_Exneuron 2
#define Number_Inneuron 0

神经网连接方式
#define CORTICAL_STRENGTH_NONHOMO 1

外部输入模式
#define POISSON_INPUT_USE 1

是否使用平滑上升电导
#define SMOOTH_CONDUCTANCE_USE 0

总计算时间(到时会停)
#define COMP_TIME  100000.0

解 ODE 的方法
#define RK4_RUN 1
#define RK3_RUN 0
#define RK2_RUN 0


为更改输出的信息, 以及一些重要的程序行为, 需要留意的代码如下(重要性高到低)

stdafx.h 全部, 特别是前半部. 用以设置如上各项宏

poisson_input.cpp
函数 void compute_perstep() 的后半部 及 函数 void LastRun().
用以更改 staffsave.txt, ras.txt, z.txt 等的输出内容

myopengl.cpp
void DrawSpikeInfo(). 更改屏幕额外显示的信息

datainput.cpp
int read_cortical_matrix(..). 更改读入临接矩阵的方式

