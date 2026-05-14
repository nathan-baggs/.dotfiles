import sys
import json
import subprocess
import threading

# Get the WSL UNC prefix dynamically!
try:
    wsl_root = subprocess.check_output(["wslpath", "-w", "/"]).decode('utf-8').strip()
    if wsl_root.endswith("\\"):
        wsl_root = wsl_root[:-1]
except Exception:
    wsl_root = "\\\\wsl.localhost\\Ubuntu"

wsl_root_json = wsl_root.replace("\\", "\\\\")

def rewrite_paths(obj):
    if isinstance(obj, dict):
        for k, v in obj.items():
            if k == "path" and isinstance(v, str):
                if wsl_root in v:
                    obj[k] = v.replace(wsl_root, "").replace("\\", "/")
                elif wsl_root_json in v:
                    obj[k] = v.replace(wsl_root_json, "").replace("\\", "/")
            else:
                rewrite_paths(v)
    elif isinstance(obj, list):
        for item in obj:
            rewrite_paths(item)

def main():
    cmd = ["/mnt/c/opt/mingw64/bin/gdb.exe", "-i", "dap"]
    
    proc = subprocess.Popen(
        cmd,
        stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        stderr=sys.stderr
    )

    def read_stdout():
        while True:
            header = proc.stdout.readline().decode('utf-8')
            if not header: break
            if header.startswith("Content-Length: "):
                length = int(header[16:].strip())
                proc.stdout.readline()
                content = proc.stdout.read(length).decode('utf-8')
                
                try:
                    msg = json.loads(content)
                    rewrite_paths(msg)
                    new_content = json.dumps(msg)
                    sys.stdout.write(f"Content-Length: {len(new_content)}\r\n\r\n{new_content}")
                    sys.stdout.flush()
                except json.JSONDecodeError:
                    sys.stdout.write(f"Content-Length: {length}\r\n\r\n{content}")
                    sys.stdout.flush()

    def read_stdin():
        while True:
            header = sys.stdin.readline()
            if not header: break
            if header.startswith("Content-Length: "):
                length = int(header[16:].strip())
                sys.stdin.readline()
                content = sys.stdin.read(length)
                
                proc.stdin.write(f"Content-Length: {length}\r\n\r\n{content}".encode('utf-8'))
                proc.stdin.flush()

    t1 = threading.Thread(target=read_stdout, daemon=True)
    t2 = threading.Thread(target=read_stdin, daemon=True)
    
    t1.start()
    t2.start()
    
    proc.wait()

if __name__ == "__main__":
    main()

