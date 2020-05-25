
Language:[简体中文](https://github.com/asjqkkkk/easy_model/blob/master/README_ZH.md)

# 💼 easy_model

[![support](https://img.shields.io/badge/platform-flutter%7Cdart%20vm-ff69b4.svg?style=flat-square)](https://github.com/asjqkkkk/easy_model)
[![Flutter Web](https://github.com/asjqkkkk/easy_model/workflows/Flutter%20Web/badge.svg)](https://github.com/asjqkkkk/easy_model/actions)
[![pub package](https://img.shields.io/pub/v/easy_model.svg)](https://pub.dartlang.org/packages/easy_model)
[![demo](https://img.shields.io/badge/demo-online-brightgreen)](https://oldchen.top/easy_model/#/)

A simple flutter state management package, supporting local state management and global state management

- support `initState()` and `dispose()`
- Support global access to `Model` objects

## 🚀 Getting Started

Before the introduction, you can have a try for [Online Demo](https://oldchen.top/easy_model/#/)

### 🔑 Useage

First define your `Model` object

```
class YourModel extends Model {
  @override
  void initState() {...}

  @override
  void dispose() {...}

  int value = 0;
}
```

When you want to use it in combination with a Widget or Page, you can do like this

```
ModelWidget<YourModel>(
  childBuilder: (ctx, model) => YourWidgetOrPage(),
  modelBuilder: () => YourModel(),
),
```

### 🔄 Get data and refresh

get data

```
final model = ModelGroup.findModel<YourModel>();
```

refresh

```
model.refresh();
```

### 📃 Same pages and models


If you have the following usage scenarios

<img src="https://user-images.githubusercontent.com/30992818/82787545-35eb0100-9e99-11ea-9c27-913ad2190bd2.png" width=250>

Using `ModelGroup.findModel <T> ()` is unable to get the `Model` object corresponding to each` Page`

Then you can use `ModelGroup.findModelByKey <T> (modelKey)` to obtain the corresponding `Model`, but it should be noted that a different `modelKey` must be specified when creating` ModelWidget`

```
ModelWidget<YourModel>(
  childBuilder: (ctx, model) => YourWidgetOrPage(),
  modelBuilder: () => YourModel(),
  modelKey: 'YourModelKey'
),

///get model
final model = ModelGroup.findModelByKey<YourModel>('YourModelKey');
```

## 🤗 Welcome for issue and pr

Click [here](https://github.com/asjqkkkk/easy_model/issues/new) to create an issue

Click [here](https://github.com/asjqkkkk/easy_model/compare) to submit a pull request (please submit pr by forking the `dev` branch)