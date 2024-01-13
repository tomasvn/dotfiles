@REM Nix
c=clear
..=cd ..
.2=cd ../../
.3=cd ../../../
.4=cd ../../../../

@REM Git alias
ga=git add -A
gc=git checkout
gs=git status
gsw=git switch -
gcm=git commit -m $1
gu=git push
guu=git push -u origin HEAD
gp=git pull
gm=git merge $1
gf=git fetch --all
gfp=git fetch --prune
grh=git reset --hard
gl=git log --abbrev-commit
gll=git log --all --graph --decorate --oneline
gd=git diff
gds=git diff --staged
gb=git branch
gbr=git branch --remote
gsl=git stash list
gss=git status --short
gsh=git stash show $1

@REM Build specific
pn=pnpm
pni=pnpm i
pns=pnpm start
pnb=pnpm build

np=npm
npi=npm i
nps=npm start