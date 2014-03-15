# Heroku Deploy

[![Code Climate](https://codeclimate.com/github/hyperoslo/heroku-deploy.png)](https://codeclimate.com/github/hyperoslo/heroku-deploy)

Deploying your applications to Heroku should never involve manually chaining shell commands together.

**Supported Ruby versions: 1.9.3 or higher**

Licensed under the **MIT** license, see LICENSE for more information.

![Heroku Deploy](http://office.moonsphere.net/heroku-deploy.png)


## Installation

This is a Heroku client plugin and as such requires the [Heroku Toolbelt](https://toolbelt.heroku.com/) to be installed.

```shell
heroku plugins:install https://github.com/hyperoslo/heroku-deploy.git
```


## Usage

By default, the `master` branch will be deployed to your Heroku app:

```shell
heroku deploy
```

A different branch may be provided:

```shell
heroku deploy feature/plus-ux
```

If you have multiple apps, you may specify either app or remote:

```shell
heroku deploy -a hyper-rocks-staging
heroku deploy -r staging
```


## Deploy Packs

At present, only the Rails deploy pack is provided.

Deploying any other applications? Please open a pull request!


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create pull request


## Credits

Hyper made this. We're a digital communications agency with a passion for good code,
and if you're using this library we probably want to hire you.
