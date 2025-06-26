# library
import sys
import pandas as pd

# show command-line arguments as a list
print(sys.argv)

# argument 0 is the name of file (pipeline.py)
day = sys.argv[1]
print(f"job finished successfully for day = {day}")