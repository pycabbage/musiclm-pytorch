from setuptools import setup, find_packages

setup(
  name = 'musiclm-pytorch',
  packages = find_packages(exclude=[]),
  version = '0.2.1',
  license='MIT',
  description = 'MusicLM - AudioLM + Audio CLIP to text to music synthesis',
  author = 'Phil Wang',
  author_email = 'lucidrains@gmail.com',
  long_description_content_type = 'text/markdown',
  url = 'https://github.com/lucidrains/musiclm-pytorch',
  keywords = [
    'artificial intelligence',
    'deep learning',
    'transformers',
    'attention mechanism',
    'text to music',
    'contrastive learning'
  ],
  install_requires=open('requirements.txt').read().splitlines(),
  classifiers=[
    'Development Status :: 4 - Beta',
    'Intended Audience :: Developers',
    'Topic :: Scientific/Engineering :: Artificial Intelligence',
    'License :: OSI Approved :: MIT License',
    'Programming Language :: Python :: 3.6',
  ],
)
