# Generate / import a `SSH` key pair

## Create a new key

```bash
ssh-keygen -t rsa -b 2048 -f ~/.ssh/<filename-for-the-private-key> -C "<human-name-for-the-key>" -N <super-strong-passphrase>
ssh-add ~/.ssh/<filename-for-the-private-key>
```

- `<filename-for-the-private-key>`: you might end up having multiple key pairs for different purpose / environments. Choose a meaningful name.
- `<human-name-for-the-key>`: will be part of the public key. It's useful to identify what a SSH public key is used for.
- `<super-strong-passphrase>`: generate it randomly and store it securely, the longer the better.

## Import an existing key

- Create a new file in the `~/.ssh/` directory with the content of the `Private Key`.
- Type `ssh-add ~/.ssh/<filename-for-the-private-key>`.

## Export the public key

```bash
cat ~/.ssh/<filename-for-the-private-key>.pub
```

### SSH

```bash
ssh -i ~/.ssh/<filename-for-the-private-key> <address>
```

## Troubleshooting adding the key pair

If you get this error when typing `ssh-add`:

```bash
Could not open a connection to your authentication agent.
```

Run this:

```bash
eval "$(ssh-agent -s)"
```