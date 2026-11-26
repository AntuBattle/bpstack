#!/usr/bin/env python3
"""Check skill discovery metadata, routing and the two reference indexes."""

import re
from pathlib import Path
from urllib.parse import unquote, urlsplit

ROOT = Path(__file__).resolve().parents[1]
SKILLS = ROOT / 'skills'
PLAYBOOKS = SKILLS / 'poteto-mode' / 'playbooks'
MARKDOWN_LINK = re.compile(r'\]\(([^\s)]+)\)')
errors = []


def local_targets(path):
    for raw in MARKDOWN_LINK.findall(path.read_text(encoding='utf-8')):
        url = urlsplit(raw)
        if url.scheme or url.netloc or not url.path:
            continue
        target = (path.parent / unquote(url.path)).resolve()
        if ROOT not in target.parents and target != ROOT:
            errors.append(f'{path.relative_to(ROOT)}: link leaves checkout: {raw}')
        elif not target.exists():
            errors.append(f'{path.relative_to(ROOT)}: broken link: {raw}')
        yield target


manifest = (ROOT / 'skills.manifest').read_text(encoding='utf-8').splitlines()
packaged = sorted(str(path.relative_to(ROOT)) for path in SKILLS.rglob('*') if path.is_file())
if manifest != packaged or any(path.startswith('skills/synced/') for path in manifest):
    errors.append('skills.manifest must list exactly the packaged skill files in sorted order, excluding synced content')

skills = set(SKILLS.glob('*/SKILL.md'))
playbooks = set(PLAYBOOKS.glob('*.md'))
for skill in sorted(skills):
    text = skill.read_text(encoding='utf-8')
    frontmatter = re.match(r'\A---\n(.*?)\n---\n', text, re.DOTALL)
    if frontmatter is None:
        errors.append(f'{skill.relative_to(ROOT)}: missing frontmatter')
        continue
    fields = dict(re.findall(r'^([\w-]+):\s*([^\n]*)$', frontmatter[1], re.MULTILINE))
    name = fields.get('name', '')
    if name != skill.parent.name or not re.fullmatch(r'[a-z0-9]+(?:-[a-z0-9]+)*', name) or len(name) > 64:
        errors.append(f'{skill.relative_to(ROOT)}: invalid name or directory mismatch')
    if not 1 <= len(fields.get('description', '').strip()) <= 1024:
        errors.append(f'{skill.relative_to(ROOT)}: missing or invalid description')

router = (SKILLS / 'poteto-mode' / 'SKILL.md').read_text(encoding='utf-8')
routing = router.split('## Routing\n', 1)[1].split('\n## ', 1)[0]
routed = set(re.findall(r'^- `([a-z-]+)`:', routing, re.MULTILINE))
expected = {path.stem for path in playbooks} - {'review-and-verify'}
if routed != expected:
    errors.append(f'Router/playbook mismatch: missing {sorted(expected - routed)}, extra {sorted(routed - expected)}')

for guide, expected_paths in [('skills.md', skills), ('playbooks.md', playbooks)]:
    linked = set(local_targets(ROOT / 'docs' / guide))
    for missing in sorted(expected_paths - linked):
        errors.append(f'docs/{guide}: missing {missing.relative_to(ROOT)}')

for section in (ROOT, ROOT / 'docs', ROOT / 'profiles', SKILLS):
    paths = section.glob('*.md') if section == ROOT else section.rglob('*.md')
    for doc in paths:
        if doc.name not in ('skills.md', 'playbooks.md'):
            list(local_targets(doc))

if errors:
    raise SystemExit('\n'.join(errors))
print(f'Catalog verified: {len(skills)} skills, {len(playbooks)} playbooks, relative links and router coverage.')
