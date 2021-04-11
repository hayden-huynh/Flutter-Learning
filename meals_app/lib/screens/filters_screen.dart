import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegan = widget.currentFilters['vegan'];
    _vegetarian = widget.currentFilters['vegetarian'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Filters'),
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final selectedFilters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                };
                widget.saveFilters(selectedFilters);
              },
            ),
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  SwitchListTile(
                    value: _glutenFree,
                    onChanged: (newVal) {
                      setState(() {
                        _glutenFree = newVal;
                      });
                    },
                    title: Text('Gluten-free'),
                    subtitle: Text('Only include gluten-free meals'),
                  ),
                  SwitchListTile(
                    value: _lactoseFree,
                    onChanged: (newVal) {
                      setState(() {
                        _lactoseFree = newVal;
                      });
                    },
                    title: Text('Lactose-free'),
                    subtitle: Text('Only include lactose-free meals'),
                  ),
                  SwitchListTile(
                    value: _vegan,
                    onChanged: (newVal) {
                      setState(() {
                        _vegan = newVal;
                      });
                    },
                    title: Text('Vegan'),
                    subtitle: Text('Only include vegan meals'),
                  ),
                  SwitchListTile(
                    value: _vegetarian,
                    onChanged: (newVal) {
                      setState(() {
                        _vegetarian = newVal;
                      });
                    },
                    title: Text('Vegetarian'),
                    subtitle: Text('Only include Vegetarian meals'),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
