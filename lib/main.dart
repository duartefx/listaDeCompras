import 'package:flutter/material.dart';

void main() {
  runApp(AppCrud());
}

//classe com os atributos
class Itens {
  String nome;
  String categoria;
  String precomax;

  Itens({required this.nome, required this.categoria, required this.precomax});
}

class AppCrud extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Avaliação Formativa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

//parte do login
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 236, 166), //cor de fundo
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                //imagem do logo
                Image.asset(
                  'images/logo.png',
                  height: 244,
                  width: 275,
                ),
              ],
            ),
            //inputs
            SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'User (digite "gi")'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha (digite "123")'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // senha e user corretos
                if (_usernameController.text == 'gi' &&
                    _passwordController.text == '123') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StudentListPage()),
                  );
                } else {
                  // mensagem de erro
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Credenciais inválidas')),
                  );
                }
              },

              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25)),
              //botão para entrar
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Text(''),
            Text(''),
            Text(
              'Giovana Duarte/ grupo 08',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

//lista dos itens
class StudentListPage extends StatefulWidget {
  @override
  _StudentListPageState createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  List<Itens> students = [
    Itens(nome: 'Arroz', categoria: 'comida', precomax: '10,00'),
    Itens(nome: 'Leite', categoria: 'bebida', precomax: '4,00'),
    Itens(nome: 'Amaciante', categoria: 'item de limpeza', precomax: '8,00'),
    Itens(nome: 'Celular', categoria: 'eletrônico', precomax: '5000,00'),
    Itens(nome: 'Sofá', categoria: 'móvel', precomax: '2000,00'),
    Itens(nome: 'Salgadinho', categoria: 'comida', precomax: '10,00'),
    Itens(nome: 'Fone de Ouvido', categoria: 'eletrônico', precomax: '30,00'),
    Itens(nome: 'Cobertor', categoria: 'item de casa', precomax: '40,00'),
    Itens(nome: 'Chocolate', categoria: 'comida', precomax: '5,00'),
    Itens(nome: 'Esmalte', categoria: 'item de beleza', precomax: '5,00'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 236, 166),
      appBar: AppBar(
        title: Text('Lista de Compras'),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(students[index].nome),
            subtitle: Text(
                students[index].categoria + ' || ' + students[index].precomax),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Excluir item
                students.removeAt(index);
                // Atualizar a interface
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Item removido')),
                );
                // Atualizar a lista de alunos
                setState(() {});
              },
            ),
            onTap: () async {
              // Editar o item
              Itens updatedStudent = await showDialog(
                context: context,
                builder: (context) {
                  TextEditingController _nomeController =
                      TextEditingController(text: students[index].nome);
                  TextEditingController _categoriaController =
                      TextEditingController(text: students[index].categoria);
                  TextEditingController _precomaxController =
                      TextEditingController(text: students[index].precomax);
                  //
                  return AlertDialog(
                    title: Text('Editar Item'),
                    content: Column(
                      children: [
                        TextField(
                          controller: _nomeController,
                          decoration: InputDecoration(labelText: 'Nome'),
                        ),
                        TextField(
                          controller: _categoriaController,
                          decoration: InputDecoration(labelText: 'Categoria'),
                        ),
                        TextField(
                          controller: _precomaxController,
                          decoration: InputDecoration(labelText: 'preço'),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Validar e salvar as alterações
                          if (_nomeController.text.isNotEmpty &&
                              _categoriaController.text.isNotEmpty &&
                              _precomaxController.text.isNotEmpty) {
                            Navigator.pop(
                              context,
                              Itens(
                                  nome: _nomeController.text.trim(),
                                  categoria: _categoriaController.text.trim(),
                                  precomax: _precomaxController.text.trim()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Preencha todos os campos corretamente')),
                            );
                          }
                        },
                        child: Text('Salvar'),
                      ),
                    ],
                  );
                },
              );

              if (updatedStudent != null) {
                // Atualizar o item na lista
                students[index] = updatedStudent;
                // Atualizar a interface
                setState(() {});
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Adicionar novo item
          Itens newStudent = await showDialog(
            context: context,
            builder: (context) {
              TextEditingController _nomeController = TextEditingController();
              TextEditingController _categoriaController =
                  TextEditingController();
              TextEditingController _precomaxController =
                  TextEditingController();

              // Adicionar novo item
              return AlertDialog(
                title: Text('Novo Item'),
                content: Column(
                  children: [
                    TextField(
                      controller: _nomeController,
                      decoration: InputDecoration(labelText: 'Nome'),
                    ),
                    TextField(
                      controller: _categoriaController,
                      decoration: InputDecoration(labelText: 'Categoria'),
                    ),
                    TextField(
                      controller: _precomaxController,
                      decoration: InputDecoration(labelText: 'Preço'),
                    ),
                  ],
                ),

                // Cancelar operação
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancelar'),
                  ),

                  // Validar e adicionar o novo aluno
                  TextButton(
                    onPressed: () {
                      if (_nomeController.text.isNotEmpty &&
                          _categoriaController.text.isNotEmpty &&
                          _precomaxController.text.isNotEmpty) {
                        Navigator.pop(
                          context,
                          Itens(
                            nome: _nomeController.text.trim(),
                            categoria: _categoriaController.text.trim(),
                            precomax: _precomaxController.text.trim(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Preencha todos os campos corretamente')),
                        );
                      }
                    },
                    child: Text('Adicionar'),
                  ),
                ],
              );
            },
          );

          // Verificar espaço a ser alocado para a adição do novo aluno
          if (newStudent != null) {
            // Adicionar o novo aluno à lista
            students.add(newStudent);

            // Atualizar a tela
            setState(() {});
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
