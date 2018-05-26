"""
This script updates the table of contents and all readmes in place.
"""

import glob
import os
import pathlib


def generate_chapter_readmes(directory_of_this_script, chapters, chapter_titles,
                             recipes, recipe_titles):

    for chapter in chapters:
        readme = directory_of_this_script / '..' / chapter / 'README.md'
        with open(readme, 'w') as f:
            number = int(chapter.split('-')[-1])
            f.write('# Chapter {0}: {1}\n\n'.format(number,
                                                    chapter_titles[chapter]))
            for recipe in recipes[chapter]:
                f.write('- [{0}]({1}/README.md)\n'.format(
                    recipe_titles[(chapter, recipe)], recipe))


def generate_recipe_readmes(directory_of_this_script, chapters, recipes,
                            recipe_titles):

    default_abstract = 'Abstract to be written ...'

    for chapter in chapters:
        for recipe in recipes[chapter]:
            readme = directory_of_this_script / '..' / chapter / recipe / 'README.md'

            abstract_file = directory_of_this_script / '..' / chapter / recipe / 'abstract.md'
            if os.path.isfile(abstract_file):
                with open(abstract_file, 'r') as f:
                    abstract = f.read()
            else:
                abstract = default_abstract

            with open(readme, 'w') as f:

                f.write('# {0}\n\n'.format(recipe_titles[(chapter, recipe)]))
                f.write(abstract)
                f.write('\n\n')

                paths = pathlib.Path(directory_of_this_script / '..' / chapter /
                                     recipe).glob('*example*')
                examples = sorted((path.parts[-1] for path in paths))
                for example in examples:
                    f.write('- [{0}]({1}/)\n'.format(example, example))


def generate_main_readme(directory_of_this_script, chapters, chapter_titles,
                         recipes, recipe_titles):

    readme = directory_of_this_script / '..' / 'README.md'
    with open(readme, 'w') as f:
        f.write("""
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://raw.githubusercontent.com/dev-cafe/cmake-cookbook/master/LICENSE)

[![Travis branch](https://img.shields.io/travis/dev-cafe/cmake-cookbook/master.svg?style=flat-square)](https://travis-ci.org/dev-cafe/cmake-cookbook)
[![AppVeyor branch](https://img.shields.io/appveyor/ci/bast/cmake-cookbook/master.svg?style=flat-square)](https://ci.appveyor.com/project/bast/cmake-cookbook/branch/master)

[![GitHub issues](https://img.shields.io/github/issues/dev-cafe/cmake-cookbook.svg?style=flat-square)](https://github.com/dev-cafe/cmake-cookbook/issues)
[![GitHub forks](https://img.shields.io/github/forks/dev-cafe/cmake-cookbook.svg?style=flat-square)](https://github.com/dev-cafe/cmake-cookbook/network)
[![GitHub stars](https://img.shields.io/github/stars/dev-cafe/cmake-cookbook.svg?style=flat-square)](https://github.com/dev-cafe/cmake-cookbook/stargazers)


# CMake cookbook recipes

- [Testing](testing/README.md)
- [Contributing](contributing/README.md)


## Table of contents

""")

        for chapter in chapters:
            number = int(chapter.split('-')[-1])
            f.write('\n\n### [Chapter {0}: {1}]({2}/README.md)\n\n'.format(
                number, chapter_titles[chapter], chapter))
            for recipe in recipes[chapter]:
                f.write('- [{0}]({1}/{2}/README.md)\n'.format(
                    recipe_titles[(chapter, recipe)], chapter, recipe))

        # chapter 16 is hard-coded
        # since it points to an outside diff
        f.write(
            '\n\n### [Chapter 16: Porting a Project to CMake](https://github.com/dev-cafe/vim/compare/master...cmake-support)\n'
        )


def locate_chapters_and_recipes(directory_of_this_script):
    """
    Returns a list of chapters and a dictionary of chapter -> list of recipes.
    """
    paths = pathlib.Path(directory_of_this_script / '..').glob('chapter-*')
    chapters = sorted((path.parts[-1] for path in paths))

    recipes = {}
    for chapter in chapters:
        paths = pathlib.Path(
            directory_of_this_script / '..' / chapter).glob('recipe-*')
        _recipes = sorted((path.parts[-1] for path in paths))
        recipes[chapter] = _recipes

    return chapters, recipes


def get_titles(directory_of_this_script, chapters, recipes):

    chapter_titles = {}
    for chapter in chapters:
        with open(directory_of_this_script / '..' / chapter / 'title.txt',
                  'r') as f:
            chapter_titles[chapter] = f.readline().strip()

    recipe_titles = {}
    for chapter in chapters:
        for recipe in recipes[chapter]:
            with open(directory_of_this_script / '..' / chapter / recipe /
                      'title.txt', 'r') as f:
                recipe_titles[(chapter, recipe)] = f.readline().strip()

    return chapter_titles, recipe_titles


if __name__ == '__main__':
    directory_of_this_script = pathlib.Path(
        os.path.dirname(os.path.realpath(__file__)))

    chapters, recipes = locate_chapters_and_recipes(directory_of_this_script)

    chapter_titles, recipe_titles = get_titles(directory_of_this_script,
                                               chapters, recipes)

    generate_main_readme(directory_of_this_script, chapters, chapter_titles,
                         recipes, recipe_titles)

    generate_chapter_readmes(directory_of_this_script, chapters, chapter_titles,
                             recipes, recipe_titles)

    generate_recipe_readmes(directory_of_this_script, chapters, recipes,
                            recipe_titles)
