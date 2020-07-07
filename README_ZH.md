
Language:[English](https://github.com/asjqkkkk/easy_model/blob/master/README.md)

![image](https://user-images.githubusercontent.com/30992818/82860003-f7158380-9f4a-11ea-8836-448fb5879c15.png)

# 💼 easy_model

[![support](https://img.shields.io/badge/platform-flutter%7Cdart%20vm-ff69b4.svg?style=flat-square)](https://github.com/asjqkkkk/easy_model)
[![Flutter Web](https://github.com/asjqkkkk/easy_model/workflows/Flutter%20Web/badge.svg)](https://github.com/asjqkkkk/easy_model/actions)
[![pub package](https://img.shields.io/pub/v/easy_model.svg)](https://pub.dartlang.org/packages/easy_model)
[![demo](https://img.shields.io/badge/demo-online-brightgreen)](http://oldben.gitee.io/easy_model/#/)

易于使用的flutter状态管理组件，支持局部状态管理与全局状态管理

- 支持 `initState()` 与 `dispose()`
- 支持全局获取 `Model` 对象

## 🚀 开始

在开始之前,你可以先体验一下 [在线demo](http://oldben.gitee.io/easy_model/#/) 点击体验

### 🔑 简单使用

首先定义你的 `Model` 对象

```
class YourModel extends Model {
  @override
  void initState() {...}

  @override
  void dispose() {...}

  int value = 0;
}
```

当你想要把它与某个Widget或页面结合使用时，可以像下面这样

```
ModelWidget<YourModel>(
  childBuilder: (ctx, model) => YourWidgetOrPage(),
  modelBuilder: () => YourModel(),
),
```
### 🔄 获取数据与刷新

获取数据


```
final model = ModelGroup.findModel<YourModel>();
```

刷新

```
model.refresh();
```

### 📃 相同的Page和Model

如果有以下使用场景

<img src="https://user-images.githubusercontent.com/30992818/82787545-35eb0100-9e99-11ea-9c27-913ad2190bd2.png" width=250>

使用 `ModelGroup.findModel<T>()` 是无法获取每一个 `Page` 对应的 `Model` 的，这时可以使用 `ModelGroup.findModelByKey<T>(modelKey)` 来获取对应的 `Model` ，但需要注意在创建 `ModelWidget` 时必须指定不同的 `modelKey`


```
ModelWidget<YourModel>(
  childBuilder: (ctx, model) => YourWidgetOrPage(),
  modelBuilder: () => YourModel(),
  modelKey: 'YourModelKey'
),

///获取Model
final model = ModelGroup.findModelByKey<YourModel>('YourModelKey');
```


### 🦋 局部刷新

通过新的 `ModelWidget` 与新的 `Model`, 你可以实现局部刷新的效果，但是如果你嫌 `Model` 创建的太频繁，那么你可以使用 `PartModelWidget` 来实现局部刷新


```
ModelWidget<YourModel>(
  childBuilder: (ctx, model) => YourWidgetOrPage(),
  modelBuilder: () => YourModel(),
  modelKey: 'YourModelKey'
)


class PageTwo extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ChildOne(),
            ChildTwo(),
            PartModelWidget<YourModel>(
              childBuilder: (ctx,YourModel model) => ChildThree(),
              partKey: 'YourKey',
            ),
          ],
        );
  }
}
```

在上面的例子中，想要单独刷新 `ChildThree()` , 可以通过调用以下方法来实现


```
model.refreshPart('YourKey')
```

这样就避免了频繁的创建 `Model` 了，如果多个 `PartModelWidget` 对应相同的 `partKey`, 则每次刷新时，他们都可以一起刷新哦！

## 🤗 欢迎提交issue和pr

点击 [这里](https://github.com/asjqkkkk/easy_model/issues/new) 创建一个issue

点击 [这里](https://github.com/asjqkkkk/easy_model/compare) 提交一个pr (请fork `dev` 分支来提交)