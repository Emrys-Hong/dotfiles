from notebook.auth import passwd
import os
# from IPython.lib import passwd

# generated_password = passwd()
pw = input('Key in password for jupyter notebook: ')
string = "# c.NotebookApp.ip = '*', this might have error\n" + \
        "c.NotebookApp.ip = '0.0.0.0'\n" + "c.NotebookApp.open_browser = False\n" + \
        "c.NotebookApp.password = '{passwd}'\n".format(passwd=passwd(pw)) + \
        "# c.NotebookApp.port = 8888\n" + \
        "# c.NotebookApp.notebook_dir = '/which/path/to/save/file'"

with open('jupyter_notebook_config.py', 'w') as f:
    f.write(string)

home_dir = os.path.expanduser('~')
jupyter_path = os.path.join(home_dir, '.jupyter')

if not os.path.exists(jupyter_path): 
    print("Making folder '.jupyter' in home directory")
    os.mkdir(jupyter_path)

cmd = 'mv jupyter_notebook_config.py ' + os.path.join(jupyter_path, 'jupyter_notebook_config.py') 
print(cmd)
os.system(cmd)

## the python file came from this tutorial
## https://www.jianshu.com/p/08f276d48669?utm_campaign=maleskine&utm_content=note&utm_medium=seo_notes&utm_source=recommendation
