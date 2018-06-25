def configure_file(input_file, output_file, vars_dict):

    with open(input_file, 'r') as f:
        template = f.read()

    for var in vars_dict:
        template = template.replace('@' + var + '@', vars_dict[var])

    with open(output_file, 'w') as f:
        f.write(template)
