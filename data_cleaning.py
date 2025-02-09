from datetime import datetime
# Open the file in read mode
with open('assessment_dataset(in).csv', 'r') as file:
    next(file)
    
    lines = file.readlines()  # Read all lines into a list
    total_lines = len(lines)
    # The dataset is split into 5 segments for easy import into SQL Workbench.
    chunks = 5
    
    lines_per_file = total_lines // chunks
    remaining_lines = total_lines % chunks 
    
    # Loop through ranges for no. of lines for each file
    for j in range(chunks):
        start = j*lines_per_file
        end = start + lines_per_file
        if j==4:
            end += remaining_lines #last file may not have exact no. of lines as lines_per_file
        
        chunk = lines[start:end]
        with open(f'formatted_data_{j+1}.csv', 'w') as output_file:
            for line in chunk:
                fragments = line.split(',')
                
                #formating NULL values
                for i in range(19):
                    if(fragments[i] == ''):
                        fragments[i] = 'NULL'
                #formatting datetime for SQL 
                date_str = fragments[2]
                if(date_str != 'NULL'): 
                    date_obj = datetime.strptime(date_str, '%m/%d/%Y %H:%M')
                    formatted_date = date_obj.strftime('%Y-%m-%d %H:%M:%S')
                    fragments[2] = formatted_date
                new_line = ','.join(fragments)
                output_file.write(new_line)