# Troubleshooting

Here are some issues experienced by users.

# VSCode Dev-Container
* If you don't get the pop-up, you might have disabled them and you can reenable it by
  running the `remote-containers.showReopenInContainerNotificationReset` command in vscode.
* If the starting the container fails, in particular with a message `Error: network xyz not found`,
  you might have deleted stuff from docker via your shell. Try deleting the container and image
  explicitely in VSCode (left side, "Docker" icon). Then reopen vscode and let it rebuild the
  container. (this will again take some time)
* On a working dev container setup, http://localhost:3000 should directly redirect you to http://localhost:3000/#/g/local/game, try if the latter is accessible.


# Manual Installation
Here are known issues/pitfalls with the local setup using `npm`.

* If `CDPATH` is set on your mac/linux system, it might provide issues with `npm start` resulting in a server crash or blank screen. In particular `npm start` will display
  ```
  [server] sh: line 0: cd: server: No such file or directory
  [server] npm run start_server exited with code 1
  ```
  As a fix you might need to delete your manually set `CDPATH` environment variable.