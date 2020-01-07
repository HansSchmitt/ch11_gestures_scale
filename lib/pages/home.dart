import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Offset _startLastOffset, _lastOffset, _currentOffset = Offset.zero;
  double _lastScale, _currentScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context){
    return GestureDetector(
      onScaleStart: _onScaleStart,
      onScaleUpdate: _onScaleUpdate,
      onDoubleTap: _onDoubleTap,
      onLongPress: _onLongPress,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _transformScaleAndTranslate(),
          //_transformMatrix4(),
          _positionedStatusBar(context)
        ],
      ),
    );
  }

  Widget _transformScaleAndTranslate(){
    return Transform.scale(
      scale: _currentScale,
      child: Transform.translate(offset: _currentOffset,
      child: Image(
        image: AssetImage('assets/images/picture.jpg'),
      ),),
    )
  }

  Widget _transformMatrix4(){
    return Transform(
      transform: Matrix4.identity()
      ..scale(_currentScale, _currentScale)
      ..translate(_currentOffset.dx, _currentOffset.dy),
      alignment: FractionalOffset.center,
      child: Image(
        image: AssetImage('assets/images/picture.jpg'),
      ),
    )
  }

  Widget _positionedStatusBar(BuildContext context){
    return Positioned(
      top: 0.0,
      width: MediaQuery.of(context).size.width,
      child: Container(
        color: Colors.white54,
        height: 50.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              'Scale: ${_currentScale.toStringAsFixed(4)}',
            ),
            Text(
              'Current: $_currentOffset',
            ),
          ],
        ),
      ),
    );
  }

  void _onScaleStart(ScaleStartDetails details){
    print('ScaleStartDetails $details');

    _startLastOffset = details.focalPoint;
    _lastOffset = _currentOffset;
    _lastScale = _currentScale;
  }

  void onScaleUpdate(ScaleUpdateDetails details){
    print('Scaleupdatedetails $details - scale ${details.scale}');

    if(details.scale != 1.0){
      double currentScale = _lastScale * details.scale;
      if(currentScale < 0.5){
        currentScale = 0.5;
      }

      setState(() {
        _currentScale = currentScale;
      });

      print('_scale $_currentScale - last scale $_lastScale');
    }
  }

}
