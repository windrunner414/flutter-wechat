import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:wechat/constant.dart';
import 'package:wechat/model/user.dart';
import 'package:wechat/util/screen.dart';
import 'package:wechat/view/base.dart';
import 'package:wechat/viewmodel/add_friend.dart';
import 'package:wechat/widget/app_bar.dart';
import 'package:wechat/widget/image.dart';
import 'package:wechat/widget/unfocus_scope.dart';

class AddFriendPage extends BaseView<AddFriendViewModel> {
  @override
  Widget build(BuildContext context, AddFriendViewModel viewModel) =>
      UnFocusScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: IAppBar(title: '添加好友'),
          body: Container(
            color: const Color(AppColor.BackgroundColor),
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: TextField(
                            controller: viewModel.textEditingController,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black87,
                            ),
                            decoration: const InputDecoration(
                              hintText: '账号',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 6),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      FlatButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          viewModel.search();
                        },
                        child: Text(
                          '搜索',
                          style:
                              TextStyle(fontSize: 16.sp, color: Colors.white),
                        ),
                        color: const Color(AppColor.LoginInputActive),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 6),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: StreamBuilder<List<User>>(
                    stream: viewModel.result,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<User>> snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      } else if (snapshot.data.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '无符合条件的用户',
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        );
                      }
                      return EasyRefresh.custom(
                        onLoad: viewModel.loadMore,
                        slivers: <Widget>[
                          SliverFixedExtentList(
                            itemExtent: 56,
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) => Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                height: 56.height,
                                color: Colors.white,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 0.5,
                                        color: Color(AppColor.DividerColor),
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          UImage(
                                            snapshot.data[index].userAvatar,
                                            placeholder: Icon(
                                              const IconData(
                                                0xe642,
                                                fontFamily:
                                                    Constant.IconFontFamily,
                                              ),
                                              size: 36.sp,
                                            ),
                                            width: 36.sp,
                                            height: 36.sp,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            snapshot.data[index].userName,
                                            style: TextStyle(fontSize: 16.sp),
                                          ),
                                        ],
                                      ),
                                      FlatButton(
                                        onPressed: () {},
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 6),
                                        color: const Color(
                                            AppColor.LoginInputNormal),
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        child: Text(
                                          '添加',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              childCount: snapshot.data.length,
                              addAutomaticKeepAlives: false,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
