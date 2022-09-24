Developed for Unix-based systems.

Pre-reqs:

1. Generate a Github personal access token. [Docs found here.](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)
2. Install [Github CLI](https://cli.github.com/) ... Linux instructions [here](https://github.com/cli/cli/blob/trunk/docs/install_linux.md) for running on server (recommended).
3. Login with Github CLI: `$ gh auth login`

To Start Run:

```bash
gh repo clone julianwagle/kommit-king &&
cd kommit-king &&
bash kommit.sh -u <YOUR_GITHUB_USERNAME> -e <YOUR_GITHUB_EMAIL> -t <YOUR_GITHUB_TOKEN>
```

To Stop Run:

```bash
cd kommit-king && crontab blank.txt
```

You will now have your github profile updated every ten minutes.
Note that if running locally it will only update while your computer is open and connected to the internet.
Fow this reason it is recommended that you run from a server.

Congrats, in one year you will look like the ultimate baller.

![cook kid](https://media.giphy.com/media/xTiTngBQncyTMceuXK/giphy.gif)
