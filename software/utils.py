import re

def open_data_file(src):
    with open('./Vset_sample.txt') as f:
        s = f.read()
    d = parse_data(s)
    return d

def parse_data(data):
    s = re.sub(r'\]\s*\[', ',', re.sub(r'\s+', ' ', data.replace('\n', ' ').strip())).replace('[', '').replace(']', '')
    d = [[float(v) for v in re.split(r'\s+', t.strip())] for t in s.split(',')]
    return d

def validate_data(data):
    if not (len(data) > 0):
        return False
    l = [len(x) for x in data]
    return all([(lambda x: x == len(data[0]))(len(d)) for d in data])

