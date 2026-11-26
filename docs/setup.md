# Setup tutorial

You need a local checkout and an agent that can read files. Native Agent Skills discovery is convenient, not required. Running repository checks requires Python 3 and Bash. Using the Pi examples requires Pi; bpstack does not install a model, configure credentials, or grant new tool permissions.

## 1. Clone and inspect

```sh
git clone https://github.com/AntuBattle/bpstack.git
cd bpstack
python3 scripts/check_catalog.py
```

If GitHub restricts access to this repository, sign in with an account that can read it before cloning. Review the skills before giving an agent access to the checkout. Install one copy of any given skill name: another stack with `poteto-mode` may shadow this one.

## 2. Try it in one session

From the bpstack checkout, start Pi with just these skills and no extension discovery:

```sh
pi --no-extensions --no-skills --skill "$PWD/skills"
```

Open `/skill:poteto-mode` and try a read-only prompt:

```text
/skill:poteto-mode Explain how this repository discovers skills and validates its catalog. Do not edit files. Cite the code you inspected and name one thing those checks do not prove.
```

Expect the agent to select the investigation playbook, inspect the installer and checker, and separate what it verified from what it inferred. On another host, paste the same request with “Read `skills/poteto-mode/SKILL.md` first.” Refer to your host's documentation for its own command syntax.

## 3. Install for a user or a project

Run from the bpstack checkout. Choose **one** destination:

```sh
# User-wide Agent Skills directory (Pi and other hosts that discover it).
bash scripts/install-skills.sh

# Or, while still in the bpstack checkout, install into a specific project.
bash scripts/install-skills.sh /absolute/path/to/your-project/.agents/skills
```

The installer copies only the skill files listed in `skills.manifest`, plus the license and attribution notices. It leaves unrelated destination entries alone, does not install `AGENTS.md`, and refuses to overwrite a differing skill or follow a per-skill symlink. Rerunning with identical content is safe. Equal copies are skipped. When it reports a conflict, compare the two versions and move the installed directory to a backup location **outside** the discovery directory before retrying. Don't delete a local variant you haven't backed up.

Restart your host after adding skills; in Pi you can also use `/reload`. Inspect the skills shown in the chooser and invoke `poteto-mode` once to confirm the expected routing. If duplicate names remain, remove the duplicate from the host's discovery configuration or use the one-session invocation above.

## 4. Make routing the default (optional)

Merge the guidance from [the Pi global profile](../profiles/pi/AGENTS.md) into your own global instructions; don't replace a working `AGENTS.md` wholesale. For a project, add equivalent guidance to its `AGENTS.md` and point to the installed `SKILL.md`. The root [AGENTS.md](../AGENTS.md) applies to contributions to this repo; its file paths assume the bpstack checkout. [The home profile](../profiles/AGENTS.home.md) records the original routing rules this stack was built from.

Keep personal reviewer accounts and credentials local. Add reviewer identities only on the correct hosting platform, and verify account names there before assigning them. `treehouse` is optional; use your host's normal worktree mechanism when it is unavailable.

## 5. Update or remove

Pull the latest revision in your checkout and inspect changes before updating a live agent environment. Move only the bpstack-owned skill directories you intend to update to a backup location, then rerun the installer. To uninstall, remove only copies you installed or stop passing `--skill`; leave unrelated skills intact. The clone and all unrelated host configuration can remain unchanged.

See the [skill catalog](skills.md) for examples and the [workflow guide](workflows.md) for what evidence to expect.
