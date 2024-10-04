# latexmkrc
$out_dir = '';  # 指定输出目录
$aux_dir = 'temp';    # 指定临时文件目录

# 创建输出目录和临时文件目录
system("mkdir -p $aux_dir");
# system("mkdir -p $out_dir");

# 设置latexmk的参数
$latex = 'pdflatex -synctex=1 -output-directory=$out_dir -aux-directory=$aux_dir %O %S';
$bibtex = 'bibtex $out_dir/%B';
$biber = 'biber --output-directory $out_dir %O %B';
$makeindex = 'makeindex -o $out_dir/%D %S';
$dvipdf = 'dvipdfmx -o $out_dir/%D %S';
$dvips = 'dvips -o $out_dir/%D %S';
$ps2pdf = 'ps2pdf %O %S $out_dir/%D';