name: Build LaTeX CV
on: [push, pull_request]

jobs:
  build_latex:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Compile LaTeX document
        uses: xu-cheng/latex-action@v3
        id: latex_compile
        with:
          root_file: CV.tex
          compiler: xelatex
          args: -interaction=nonstopmode -file-line-error  # 显示具体错误行

      # 关键：即使编译失败，也上传日志文件
      - name: Upload log files (even if failed)
        uses: actions/upload-artifact@v4
        if: always()  # 无论编译成功/失败都执行
        with:
          name: latex-logs
          path: |
            CV.log
            CV.aux
            CV.fls
