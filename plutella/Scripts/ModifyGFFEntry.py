__author__ = 'riteshk'
'''
    Modify text in an entire column - also across the line for a GFF file
'''
def modify_column(column_number, mod_text,input_file, output_file):

    with open(output_file, encoding='utf-8') as out_file:
        with open(input_file,encoding='utf-8') as in_file:
            for line in in_file:
                if line.startswith('##'):
                    out_file.write(line + '\n')
                    continue

                fields = line.split('\t')
                if len(fields) == 9:
                    col_text = fields[column_number]
                    new_text = col_text + '|' + mod_text
                    new_line = line.replace(col_text,new_text)
                    out_file.write(new_line + '\n')
                else :
                    out_file.write(line + '\n')

if __name__ == "__main__":
    column_number = 1
    mod_text = 'quiver'
    input_file = ''
    output_file = ''

    modify_column(column_number,mod_text,input_file,output_file)



