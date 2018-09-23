"""
This script updates the table of contents and all readmes in place.
"""

import glob
import os
import pathlib


def generate_chapter_readmes(directory_of_this_script, chapters, chapter_titles,
                             recipes, recipe_titles):

    for chapter in chapters:
        readme = directory_of_this_script.parent / chapter / 'README.md'
        with readme.open(mode='w') as f:
            number = int(chapter.split('-')[-1])
            f.write('# Chapter {0}: {1}\n\n'.format(number,
                                                    chapter_titles[chapter]))
            for i, recipe in enumerate(recipes[chapter]):
                f.write('- [{0}. {1}]({2}/README.md)\n'.format(
                    i+1, recipe_titles[(chapter, recipe)], recipe))


def generate_recipe_readmes(directory_of_this_script, chapters, recipes,
                            recipe_titles):

    default_abstract = 'Abstract to be written ...'

    for chapter in chapters:
        for recipe in recipes[chapter]:
            readme = directory_of_this_script.parent / chapter / recipe / 'README.md'

            abstract_file = directory_of_this_script.parent / chapter / recipe / 'abstract.md'
            if abstract_file.is_file():
                with abstract_file.open() as f:
                    abstract = f.read()
            else:
                abstract = default_abstract

            with readme.open(mode='w') as f:

                f.write('# {0}\n\n'.format(recipe_titles[(chapter, recipe)]))
                f.write(abstract)
                f.write('\n\n')

                paths = (directory_of_this_script.parent / chapter /
                         recipe).glob('*example*')
                examples = sorted((path.parts[-1] for path in paths))
                for example in examples:
                    f.write('- [{0}]({1}/)\n'.format(example, example))


def generate_main_readme(directory_of_this_script, chapters, chapter_titles,
                         recipes, recipe_titles):

    readme = directory_of_this_script.parent / 'README.md'
    with readme.open(mode='w') as f:
        f.write("""
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://raw.githubusercontent.com/dev-cafe/cmake-cookbook/master/LICENSE)

[![Travis](https://travis-ci.org/dev-cafe/cmake-cookbook.svg?branch=master)](https://travis-ci.org/dev-cafe/cmake-cookbook)
[![AppVeyor](https://ci.appveyor.com/api/projects/status/fvmidu9lcqvy52g8?svg=true)](https://ci.appveyor.com/project/bast/cmake-cookbook)
[![CircleCI](https://circleci.com/gh/dev-cafe/cmake-cookbook.svg?style=svg)](https://circleci.com/gh/dev-cafe/cmake-cookbook)

[![GitHub issues](https://img.shields.io/github/issues/dev-cafe/cmake-cookbook.svg?style=flat-square)](https://github.com/dev-cafe/cmake-cookbook/issues)
[![GitHub forks](https://img.shields.io/github/forks/dev-cafe/cmake-cookbook.svg?style=flat-square)](https://github.com/dev-cafe/cmake-cookbook/network)
[![GitHub stars](https://img.shields.io/github/stars/dev-cafe/cmake-cookbook.svg?style=flat-square)](https://github.com/dev-cafe/cmake-cookbook/stargazers)


# CMake Cookbook

This repository collects sources for the recipes contained in the
[CMake Cookbook](https://www.packtpub.com/application-development/cmake-cookbook)
published by Packt and authored by [Radovan Bast](https://github.com/bast) and
[Roberto Di Remigio](https://github.com/robertodr)

- [Contributing](.github/CONTRIBUTING.md)
- [Testing](testing/README.md)


## Table of contents

""")

        for chapter in chapters:
            number = int(chapter.split('-')[-1])
            f.write('\n\n### [Chapter {0}: {1}]({2}/README.md)\n\n'.format(
                number, chapter_titles[chapter], chapter))
            for i, recipe in enumerate(recipes[chapter]):
                f.write('- [{0}. {1}]({2}/{3}/README.md)\n'.format(
                    i+1, recipe_titles[(chapter, recipe)], chapter, recipe))

        # chapter 15 is hard-coded
        # since it points to an outside diff
        f.write(
            '\n\n### [Chapter 15: Porting a Project to CMake](chapter-15/README.md)\n'
        )


def locate_chapters_and_recipes(directory_of_this_script):
    """
    Returns a list of chapters and a dictionary of chapter -> list of recipes.
    """
    paths = (directory_of_this_script.parent).glob('chapter-*')
    chapters = sorted((path.parts[-1] for path in paths))

    # chapter 15 is different and "hardcoded"
    # so we remove it from the list of chapters to process
    chapters.remove('chapter-15')

    recipes = {}
    for chapter in chapters:
        paths = (directory_of_this_script.parent / chapter).glob('recipe-*')
        _recipes = sorted((path.parts[-1] for path in paths))
        recipes[chapter] = _recipes

    return chapters, recipes


def get_titles(directory_of_this_script, chapters, recipes):

    chapter_titles = {}
    for chapter in chapters:
        with (directory_of_this_script.parent / chapter /
              'title.txt').open() as f:
            chapter_titles[chapter] = f.readline().strip()

    recipe_titles = {}
    for chapter in chapters:
        for recipe in recipes[chapter]:
            with (directory_of_this_script.parent / chapter / recipe /
                  'title.txt').open() as f:
                recipe_titles[(chapter, recipe)] = f.readline().strip()

    return chapter_titles, recipe_titles


if __name__ == '__main__':
    directory_of_this_script = pathlib.Path(__file__).resolve().parent

    chapters, recipes = locate_chapters_and_recipes(directory_of_this_script)

    chapter_titles, recipe_titles = get_titles(directory_of_this_script,
                                               chapters, recipes)

    generate_main_readme(directory_of_this_script, chapters, chapter_titles,
                         recipes, recipe_titles)

    generate_chapter_readmes(directory_of_this_script, chapters, chapter_titles,
                             recipes, recipe_titles)

    generate_recipe_readmes(directory_of_this_script, chapters, recipes,
                            recipe_titles)
