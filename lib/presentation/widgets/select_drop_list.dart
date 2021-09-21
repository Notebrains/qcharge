import 'package:flutter/material.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';

class SelectDropList extends StatefulWidget {
  final IconData ic;
  final Color icColor;
  final OptionItem itemSelected;
  final DropListModel dropListModel;
  final Function(OptionItem optionItem) onOptionSelected;

  SelectDropList({required this.ic, required this.icColor, required this.itemSelected, required this.dropListModel, required this.onOptionSelected});

  @override
  _SelectDropListState createState() => _SelectDropListState();
}

class _SelectDropListState extends State<SelectDropList> with SingleTickerProviderStateMixin {

  late AnimationController expandController;
  late Animation<double> animation;

  bool isShow = false;


  @override
  void initState() {
    super.initState();
    expandController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 350)
    );
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    _runExpandCheck();
  }

  void _runExpandCheck() {
    if(isShow) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
          decoration: new BoxDecoration(
            border: Border.all(color: Colors.grey.shade600),
            borderRadius: BorderRadius.circular(5.0),
            //color: Color(0xC9212121),
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  color: Colors.black26,
                  offset: Offset(0, 2))
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Icon(widget.ic, color: widget.icColor,),
              ),

              Expanded(
                  child: GestureDetector(
                    onTap: () {
                      this.isShow = !this.isShow;
                      _runExpandCheck();
                      setState(() {

                      });
                    },
                    child: Text(widget.itemSelected.title, style: TextStyle(
                        color: AppColor.app_txt_white,
                        fontSize: 14),),
                  )
              ),
              Align(
                alignment: Alignment(1, 0),
                child: Icon(
                  isShow ? Icons.arrow_drop_down : Icons.arrow_right,
                  color: AppColor.app_txt_white,
                  size: 15,
                ),
              ),
            ],
          ),
        ),
        SizeTransition(
            axisAlignment: 1.0,
            sizeFactor: animation,
            child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.only(bottom: 10),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                  color: AppColor.grey,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 4,
                        color: Colors.black26,
                        offset: Offset(0, 4))
                  ],
                ),
                child: _buildDropListOptions(widget.dropListModel.listOptionItems, context)
            )
        ),
//          Divider(color: Colors.grey.shade300, height: 1,)
      ],
    );
  }

  Column _buildDropListOptions(List<OptionItem> items, BuildContext context) {
    return Column(
      children: items.map((item) => _buildSubMenu(item, context)).toList(),
    );
  }

  Widget _buildSubMenu(OptionItem item, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 26.0, top: 5, bottom: 5),
      child: GestureDetector(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  //border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1)),
                ),
                child: Text(
                    item.title,
                    style: TextStyle(
                        color: AppColor.app_txt_white,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                    ),
                    maxLines: 3,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          widget.onOptionSelected(item);
          isShow = false;
          expandController.reverse();
          widget.onOptionSelected(item);
        },
      ),
    );
  }

}

class DropListModel {
  DropListModel(this.listOptionItems);

  final List<OptionItem> listOptionItems;
}

class OptionItem {
  final String id;
  final String title;

  OptionItem({required this.id, required this.title});
}