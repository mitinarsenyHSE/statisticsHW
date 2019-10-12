---
title: Домашняя работа
author: Митин Арсений
---
<!-- mathFunc{name, leftDelim, argument, rightDelim} -->
\providecommand{\mathFunc}[4]{#1\left#2\, #3 \,\right#4}
\providecommand{\mathbbFunc}[4]{\mathFunc{\mathbb{#1}}{#2}{#3}{#4}}
\providecommand{\mathrmFunc}[4]{\mathFunc{\mathrm{#1}}{#2}{#3}{#4}}
\providecommand{\Prob}[1]{\mathbbFunc{P}{(}{#1}{)}}
\providecommand{\Expect}[1]{\mathbbFunc{E}{[}{#1}{]}}
\providecommand{\Var}[1]{\mathrmFunc{Var}{[}{#1}{]}}

# Домашнее задание 1

## Выбор распределений

Выбранные распределения:

* Дискретное: _гипергеометрическое_
* Непрерывное: _нормальное_

## Описание основных характеристик распределений

### Гипергеометрическое распределение

Гипергеометрическое распределение - дискретное распределение, описывающее вероятность события, при котором ровно $k$
из $n$ случайно выбранных элементов окажутся *помеченными*, при этом выборка осуществляется из множества мощности $N$,
в котором присутствует $m$ помеченных элементов. Считается, что каждый из элементов может быть выбран с одинаковой
вероятностью $\frac{1}{N}$. Запишем это формально:
$$\begin{gathered}
    N \in \mathbb{N},\ m \in \overline{0, N},\ n \in \overline{0, N},\\
    k \in \overline{0, n}
\end{gathered}$$
Тогда $HG(D, N, n)$ описывает вероятность события,
при котором ровно $k$ из $n$ элементов выборки окажутся *помеченными*:
$$\begin{gathered}
    \left\{\xi \sim HG(N, m, n) \right\}\\
    \large\Updownarrow\\
    \left\{\Prob{\xi=k} = \frac{\binom{m}{k}\binom{N-m}{n-k}}{\binom{N}{n}}\right\}
\end{gathered}$$

#### Математическое ожидание гипергеометрического распределения

По определению, математическое ожидание случайной величины $\xi$ – это ее $1^\text{й}$ начальный момент.
Для начала, найдем $k^\text{й}$ начальный момент для $\xi$:
$$\Expect{\xi^r}
= \sum_{k=0}^{n} k^r \cdot \Prob{\xi=k}
= \sum_{k=0}^{n} k^r\frac{\binom{m}{k}\binom{N-m}{n-k}}{\binom{N}{n}}$$
Можем считать, что сумма берется при $k$ от $1$ до $n$,так как слагаемое при
$k=0$ будет равно $0$. Заметим, что
$$\begin{aligned}
    k\binom{m}{k} &= k \frac{m!}{k!(m-k)!} =\\
                &= k \frac{m \cdot (m-1)!}{k \cdot (k-1)! \cdot (m-k)!} =\\
                &= m \frac{(m-1)!}{(k-1)! \cdot (m-1 - (k-1))!} =\\
                &= m \binom{m-1}{k-1}
\end{aligned}$$
и, как следствие,
$$\binom{N}{n}
= \frac{1}{n} \cdot n \cdot \binom{N}{n}
= \frac{1}{n} N \binom{N-1}{n-1}$$
Подставим TODO и TODO в TODO:
$$\Expect{\xi^r} = \frac{n \cdot m}{N}
\sum_{k=1}^{r-1} \frac{\binom{m-1}{k-1}\binom{N-m}{n-k}}{\binom{N-1}{n-1}}$$
Положим $j := k-1$ и изменим индекс суммирования с на $j = \overline{0, n-1}$.
Заметим, что $n - k = n - (j+1) = (n-1) - j$ и $N - m = (N-1) - (m-1)$:
$$\Expect{\xi^r} = \frac{n \cdot m}{N} \textcolor{red}{\sum_{j=0}^{n-1} (j+1)^{r-1}
\frac{\binom{m-1}{j}\binom{(N-1) - (m-1)}{(n-1) - j}}{\binom{N-1}{n-1}}}$$
Заметим, что выделенная красным цветом часть выражения может быть записана, как
$\Expect{(\theta+1)^{r-1}}$, где $\theta \sim HG(N-1, m-1, n-1)$.
Следовательно,
$$\Expect{\xi^r} = \frac{n \cdot m}{N} \Expect{(\theta+1)^{r-1}}$$
Таким образом,
$$\boxed{
    \Expect{\xi} = \frac{n \cdot m}{N}
}$$

#### Дисперсия гипергеометрического распределения

По определению дисперсии,
$$\begin{aligned}
    \Var{\xi} &= \Expect{\left(\xi - \Expect{\xi}\right)^2} =\\
              &= \Expect{\xi^2} - \left(\Expect{xi}\right)^2
\end{aligned}$$

Выведем $2^\text{й}$ начальный момент из TODO:
$$\Expect{\xi^2}
= \frac{n \cdot m}{N}\Expect{\theta+1}
= \frac{n \cdot m}{N}\left(\frac{(n-1)(m-1)}{N-1}+1\right)$$
Подставим TODO и TODO в TODO:
$$\begin{aligned}
    \Var{\xi} &= \Expect{\xi^2} - \left(\Expect{\xi}\right)^2 =\\
              &= \frac{n \cdot m}{N}\left(\frac{(n-1)(m-1)}{N-1}+1\right)
                    - \left(\frac{n \cdot m}{N}\right)^2=\\
              &= \frac{n \cdot m}{N}\left(\frac{(n-1)(m-1)}{N-1} + 1
                   - \frac{n \cdot m}{N}\right)
\end{aligned}$$
Таким образом,
$$\boxed{
    \Expect{\xi} = \frac{n \cdot m}{N}\left(\frac{(n-1)(m-1)}{N-1} + 1 - \frac{n \cdot m}{N}\right)
}$$

#### Производящая функция гипергеометрического распределения

По определению производящей функции,
$$M_\xi(t) = \Expect{e^{t\xi}}$$
То есть,
$$\begin{aligned}
    M_\xi(t) &= \sum_{k=0}^{n} e^{tk}\Prob{\xi=k} =\\
             &= \sum_{k=0}^{n} e^{tk}\frac{\binom{m}{k}\binom{N-m}{n-k}}{\binom{N}{n}}
\end{aligned}$$

TODO

#### Характеристическая функция гипергеометрического распределения

TODO

#### Гистограмма вероятностей гипергеометрического распределения

Построим гистограмму вероятностей для $k \in \overline{0, n}$:

TODO

#### Функция распределения гипергеометрического распределения

По определению, функция распределения $F_\xi(k) = \Prob{\xi < k}$.
Событие $\{\xi < k\} = \bigcup\limits_{i=0}^{k-1}\{\xi=i\}$.
События $\{\xi=i\}\; \forall i \in \overline{0, k-1}$ являются попарно
несовместными. То есть $\forall i,j \in \overline{0, k-1}: i \neq j$
выполняется $\{\xi=i\}\large\cap\{\xi=j\}=\emptyset$. Из этого следует, что
$$\Prob{\xi < k} = \sum_{i=0}^{k-1}\Prob{\xi = i}$$
Подставим TODO в это выражение и получим:
$$F_\xi(k)
= \sum_{i=0}^{k-1}\Prob{\xi = i}
= \sum_{i=0}^{k-1}\frac{\binom{m}{i}\binom{N-m}{n-i}}{\binom{N}{n}}$$

Построим график этой функции, учитывая, что аргументом $k$ должно быть натуральное число,
не превосходящее $n$:

TODO

### Нормальное распределение

Нормальное распределение - непрерывное распределение, описывающее поведение
величины отклонения измеряемого значения $x$ от истинного значения $\mu$
(которое является математическим ожиданием) и в рамках некоторого разброса
$\sigma$ (среднеквадратичного отклонения). Запишем это формально:
$$\begin{gathered}
    \left\{ \eta \sim N(\mu, \sigma^2) \right\}\\
    \Updownarrow\\
    \left\{\begin{gathered}
        F_\eta(x) = \Prob{\eta < x} = \int_{-\infty}^{x} f_\eta(x)dx,\\
        \text{где} f_\eta(x) = \frac{1}{\sigma\sqrt{2\pi}}e^{-\frac{(x-\mu)^2}{2\sigma^2}}
    \end{gathered}\right\}
\end{gathered}$$
$f_\eta(x)$ называется плотностью вероятности.

#### Математическое ожидание нормального распределения

Найдем математическое ожидание $\eta \sim N(\mu, \sigma^2)$:
$$\begin{aligned}
    \Expect{\eta} &= \int_{-\infty}^{+\infty} x \cdot f_\eta(x)dx =\\
                  &= \int_{-\infty}^{+\infty} xe^{-\frac{(x-\mu)^2}{2\sigma^2}}dx =\\
                  &= \frac{1}{\sigma\sqrt{2\pi}} \int_{-\infty}^{+\infty} xe^{-\frac{(x-\mu)^2}{2\sigma^2}}dx
\end{aligned}$$
Сделаем замену $t = \frac{x-\mu}{\sqrt{2}\sigma}$:
$$\begin{aligned}
    \Expect{\eta} &= \frac{1}{\sigma\sqrt{2\pi}} \int_{-\infty}^{+\infty}(\sigma\sqrt{2}t + \mu)
                    e^{-t^2} d\left(\frac{x-\mu}{\sqrt{2}\sigma}\right) =\\
                  &= \frac{\sigma\sqrt{2}}{\sqrt{\pi}}\int_{-\infty}^{+\infty}te^{-t^2}dt
                    + \frac{\mu}{\sqrt{\pi}}\int_{-\infty}^{+\infty}e^{-t^2}dt =\\
                  &= \frac{\sigma\sqrt{2}}{\sqrt{\pi}}\left(\int_{-\infty}^{0}te^{-t^2}dt
                    - \int_{-\infty}^{0}te^{-t^2}dt\right) + \frac{\mu}{\sqrt{\pi}}\int_{-\infty}^{+\infty}e^{-t^2}dt =\\
                  &= \frac{\mu}{\sqrt{\pi}}\int_{-\infty}^{+\infty}e^{-t^2}dt
\end{aligned}$$
Заметим, что получившееся выражение содержит интеграл,
который может быть сведен к интегралу [Эйлера-Пуассона](https://ru.wikipedia.org/wiki/Гауссов_интеграл):
$$\int_{-\infty}^{+\infty}e^{-t^2}dt = 2\int_{0}^{+\infty}e^{-t^2}dt = \sqrt{\pi}$$
Таким образом,
$$\boxed{
    \Expect{\eta} = \mu
}$$

#### Дисперсия нормального распределения

Подставим TODO в определение дисперсии TODO:
$$\begin{aligned}
    \Var{\eta} &= \Expect{(\eta - \mu)^2} =\\
               &= \int_{-\infty}^{+\infty} (x-\mu)^2 \cdot f_{\eta}(x)dx =\\
               &= \int_{-\infty}^{+\infty}(x-\mu)^2 \frac{1}{\sigma\sqrt{2\pi}}e^{-\frac{(x-\mu)^2}{2\sigma^2}}dx =\\
               &= \frac{1}{\sigma\sqrt{2\pi}}\int_{-\infty}^{+\infty}(x-\mu)^2 e^{-\frac{(x-\mu)^2}{2\sigma^2}}dx
\end{aligned}$$
Сделаем ту же замену переменной $t = \frac{x-\mu}{\sqrt{2}\sigma}$, тогда $x = t\sqrt{2}\sigma+\mu$ и:
$$\begin{aligned}
    \Var{\eta} &= \frac{1}{\sigma\sqrt{2\pi}}
                \int_{-\infty}^{+\infty}(\sqrt{2}\sigma)^2 t^2 e^{-t^2}d(t\sqrt{2}\sigma+\mu) =\\
               &= \frac{2\sigma^2}{\sqrt{\pi}}\int_{-\infty}^{+\infty}t^2 e^{-t^2}dt
\end{aligned}$$
Проинтегрируем по частям:
<!-- TODO: | replace with \mid??? -->
$$\begin{aligned}
    \Var{\eta} &= \frac{\sigma^2}{\sqrt{\pi}}\int_{-\infty}^{+\infty}t 2t e^{-t^2} dt =\\
               &= \frac{\sigma^2}{\sqrt{\pi}}\left(\left. -t e^{-t^2} \right|_{-\infty}^{+\infty}
                 + \int_{-\infty}^{+\infty}e^{-t^2}dt\right)
\end{aligned}$$
Здесь снова появляется интеграл [Эйлера-Пуассона](https://ru.wikipedia.org/wiki/Гауссов_интеграл) и, в итоге, получаем:
$$\boxed{
    \Var{\eta} = \sigma^2
}$$
То есть, $\sigma$ является среднеквадратичным отклонением.