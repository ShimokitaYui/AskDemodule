# Ask调制解调技术
## Ask简介 ([维基百科](https://zh.wikipedia.org/wiki/%E5%B9%85%E7%A7%BB%E9%94%AE%E6%8E%A7))
幅度偏移调制，又称幅移键控、幅度键移（英语：Amplitude-shift keying，ASK）是通过载波的幅度变化来表示数字信号的一种幅度调制方式。在一个ASK系统中，二进制符号1会通过一个固定幅度、固定频率的载波信号来表示。这一载波信号会持续T秒。如果信号的值为1，就会传输载波信号，反之则不会传输载波信号。  
## 2ASK调制
利用表示数字信息的0和1的基带矩阵脉冲与连续的载波相乘,2ASK信号可以表示为:
$$s\left( t \right) =m\left( t \right) \cos \left( \omega _ct+\varphi _c \right) $$
时域的乘机是频域的卷积,可以得到s(t)的频谱为:
$$s\left( \omega \right) =\frac{1}{2}\left[ M\left( \omega +\omega _c \right) +M\left( \omega -\omega _c \right) \right] $$
可以发现$s(\omega)$就是$m(t)$的频域的平移后相加的结果,由于$m(t)$是矩阵脉冲信号,其频谱宽度是无穷的，因此调制后的信号的频谱宽度也是无限的，需要对限制调制信号的频谱防止对其他信号产生干扰。通常采用***升余弦滚降滤波***对信号进行成型滤波。
## ASK解调
### 相干解调法
<div align="center">
    <img src="image.png" alt="Ask相干解调法" />
</div>  

假设输入信号为：     
$$s\left( t \right) =m\left( t \right) \cos \left( \omega _ct+\varphi _c \right) $$
载波信号为：
$$c\left( t \right) =\cos \left( \omega t+\varphi \right) $$
此时乘法器的输出为：
$$c\left( t \right) *s\left( t \right) =\frac{1}{2}m\left( t \right) \cos \left[ \left( \omega _c-\omega \right) t+\left( \varphi _c-\varphi \right) \right] +\frac{1}{2}m\left( t \right) \cos \left[ \left( \omega _c+\omega \right) t+\left( \varphi _c+\varphi \right) \right] $$
可以将频率为$\omega_c+\omega$的高频信号滤除之后得到输出信号为：
$$m_0\left( t \right) =\frac{1}{2}K_cm\left( t \right) \cos \left[ \left( \omega _c-\omega \right) t+\left( \varphi _c-\varphi \right) \right] $$
可以看出如果$\omega_c==\omega$则$m_0==\frac{1}{2}K_cm$
### 非相干解调法
非相干解调通过对信号整流之后，进行低通滤波得到包络，在通过判决门限得到输出信号
