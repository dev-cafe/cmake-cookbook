def configure_file(input_file, output_file, vars_dict):

    with input_file.open('r') as f:
        template = f.read()

    for var in vars_dict:
        template = template.replace('@' + var + '@', vars_dict[var])

    with output_file.open('w') as f:
        f.write(template)
