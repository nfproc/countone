Hardware-oriented implementation of the "count the ones" test
=============================================================

For English description, please refer to <a href="README.en.md">README.en.md</a>.

概要
----

このリポジトリには，以下の論文で提案されたTRNG向け乱数検定回路のHLS実装と，
PYNQ-Z1 で動作するデモシステムを収録しています．

> Ryusei Oya, Naoki Fujieda, and Shuichi Ichikawa: An HLS implementation
> of on-the-fly randomness test for TRNGs, 10th International Symposium
> on Computing and Networking (CANDAR 2022), pp. 151–157 (11/2022).

デモシステムは PYNQ 2.7 向けに作成されており，Xilinx Vivado 2020.2 および
Vitis HLS 2020.2 を使って合成されます．

------------------------------------------------------------------------

リポジトリの構成
----------------

リポジトリのフォルダ構成は以下のとおりです．

- `C_src`: 検定回路のCソースコード
- `PYNQ`: PYNQ-Z1 で動作するデモシステムのソースコード一式
  - `ip_repo`: デモシステムで使用する IP コア一式
  - `jupyter`: 動作確認用の Jupyter Notebook
- `rand_data`: Cテストベンチで使用する乱数データ

------------------------------------------------------------------------

ソースコードの使い方
--------------------

### 動作確認

ひとまず動作を確認したい場合は，`PYNQ/jupyter` フォルダのファイルを使います．

これらを PYNQ の jupyter_notebooks フォルダ以下の適当な場所にアップロードし，
PYNQ 上の Jupyter Notebook から TRNG_Test.ipynb を開いてください．

### 高位合成

検定回路を高位合成する場合は，`C_src` フォルダのファイルを使います．

Vitis HLS でプロジェクトを作成し，countone.cpp, define.hpp, prob_table.hpp
を Design Files として，main.cpp を Testbench Files として，それぞれ指定し
ます．高位合成対象の関数は countone です．

論文中でパラメータとしている，chsq, ev の小数部分のビット幅は，define.hpp
でそれぞれ CHSQ_F, EV_F として定義されています．C シミュレーションを行うと，
その設定における平均エラー率（浮動小数点実装と比べた）が測定できます．

### デモシステムの論理合成

デモシステムは，ブロック図から作成します．
詳細は，`PYNQ` フォルダの How_to_create_design_ja.txt を参照してください．

------------------------------------------------------------------------

著作権
------

本リポジトリの `C_src` フォルダ中のCソースコード，および `PYNQ/jupyter`
フォルダ中のノートブック（Python）は，<a href="https://aitech.ac.jp/~dslab/nf/">藤枝 直輝</a>により開発され，
愛知工業大学 ディジタルシステム研究室が著作権を保有します．
Cソースコードの一部には，大矢 龍聖による貢献を含みます．

なお，`PYNQ/ip_repo` フォルダには https://github.com/nfproc/TRNG_IP で公開
されている真性乱数生成器のソースコードが含まれます．

ライセンスは New BSD です．詳細は LICENSE.txt を確認してください．

Copyright (C) 2022-2023 Digital Systems Laboratory. All rights reserved.
