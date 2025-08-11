+++
date = '2025-07-16T17:27:25+08:00'
draft = true
title = 'Pycharm20240104版本bug记录'

+++


D:\Python311\python.exe "D:/Pycharm/PyCharm Community Edition 2024.1.7/plugins/python-ce/helpers/pydev/pydevconsole.py" --mode=client --host=127.0.0.1 --port=60844 
Traceback (most recent call last):
  File "D:\Pycharm\PyCharm Community Edition 2024.1.7\plugins\python-ce\helpers\pydev\pydevconsole.py", line 570, in <module>
    pydevconsole.start_client(host, port)
  File "D:\Pycharm\PyCharm Community Edition 2024.1.7\plugins\python-ce\helpers\pydev\pydevconsole.py", line 484, in start_client
    interpreter = InterpreterInterface(threading.current_thread(), rpc_client=client)
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "D:\Pycharm\PyCharm Community Edition 2024.1.7\plugins\python-ce\helpers\pydev\_pydev_bundle\pydev_ipython_console.py", line 19, in __init__
    self.interpreter = get_pydev_ipython_frontend(rpc_client)
                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "D:\Pycharm\PyCharm Community Edition 2024.1.7\plugins\python-ce\helpers\pydev\_pydev_bundle\pydev_ipython_console_011.py", line 472, in get_pydev_ipython_frontend
    _PyDevFrontEndContainer._instance = _PyDevIPythonFrontEnd(is_jupyter_debugger)
                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "D:\Pycharm\PyCharm Community Edition 2024.1.7\plugins\python-ce\helpers\pydev\_pydev_bundle\pydev_ipython_console_011.py", line 293, in __init__
    self.ipython = self._init_ipy_app(PyDevTerminalInteractiveShell).shell
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "D:\Pycharm\PyCharm Community Edition 2024.1.7\plugins\python-ce\helpers\pydev\_pydev_bundle\pydev_ipython_console_011.py", line 300, in _init_ipy_app
    application.initialize(shell_cls)
  File "D:\Pycharm\PyCharm Community Edition 2024.1.7\plugins\python-ce\helpers\pydev\_pydev_bundle\pydev_ipython_console_011.py", line 258, in initialize
    self.init_shell(shell_cls)
  File "D:\Pycharm\PyCharm Community Edition 2024.1.7\plugins\python-ce\helpers\pydev\_pydev_bundle\pydev_ipython_console_011.py", line 263, in init_shell
    self.shell = shell_cls.instance()
                 ^^^^^^^^^^^^^^^^^^^^
  File "D:\Python311\Lib\site-packages\traitlets\config\configurable.py", line 583, in instance
    inst = cls(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^
  File "D:\Pycharm\PyCharm Community Edition 2024.1.7\plugins\python-ce\helpers\pydev\_pydev_bundle\pydev_ipython_console_011.py", line 122, in __init__
    super(PyDevTerminalInteractiveShell, self).__init__(*args, **kwargs)
  File "D:\Python311\Lib\site-packages\IPython\terminal\interactiveshell.py", line 977, in __init__
    super(TerminalInteractiveShell, self).__init__(*args, **kwargs)
  File "D:\Python311\Lib\site-packages\IPython\core\interactiveshell.py", line 627, in __init__
    self.init_syntax_highlighting()
  File "D:\Python311\Lib\site-packages\IPython\core\interactiveshell.py", line 774, in init_syntax_highlighting
    pyformat = PyColorize.Parser(theme_name=self.colors).format
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "D:\Python311\Lib\site-packages\IPython\utils\PyColorize.py", line 364, in __init__
    assert theme_name == theme_name.lower()
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
AssertionError
无法连接到控制台进程。
进程已结束，退出代码为 1


https://youtrack.jetbrains.com/issue/PY-79657/Python-Console-AssertionError-Bug.-Fix-included.

original code:

    colors = Unicode("NoColor")

new code:

    colors = Unicode("nocolor")
