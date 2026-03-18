import 'package:flutter/material.dart';
import '../../widgets/appBar.dart';
import '../../services/auth_service.dart';

class UserFormScreen extends StatefulWidget {
  const UserFormScreen({super.key});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final AuthService _authService = AuthService();
  bool _isLoading = false;

  String patternEmail = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';

  // Listas para profilees y statuss
  final List<String> _roles = ['Admin', 'Client', 'Test'];
  final List<String> _statuss = ['Active', 'Inactive', 'Blocked', 'Delete'];

  // Valores seleccionados
  String? _roleSeleccionado;
  String? _statusSeleccionado;

  Future<void> _addApiUser() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Las contraseñas no coinciden')),
        );
        return;
      }

      // Validar que se haya seleccionado un profile y status
      if (_roleSeleccionado == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor seleccione un rol')),
        );
        return;
      }

      if (_statusSeleccionado == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor seleccione un status')),
        );
        return;
      }

      setState(() => _isLoading = true);

      final userData = {
        'user': _usernameController.text,
        'password': _passwordController.text,
        'status': _statusSeleccionado,
        'role': _roleSeleccionado,
        
      };

      try {
        final response = await _authService.addApiUser(userData);
        
        print('📦 Respuesta completa: $response');
        
       if (response['status'] == 201 || response['data'] != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✅ Registro exitoso'),
              backgroundColor: Colors.green,
            ),
          );
          
          Navigator.pop(context, {
            'username': _usernameController.text,
            'password': _passwordController.text,
          });
        } else {
          // Mostrar el error específico
          String errorMsg = response['error'] ?? 'Error desconocido';
          if (response['details'] != null) {
            errorMsg += '\n${response['details']}';
        }
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('❌ $errorMsg'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 5),
            ),
          );
        }
      } catch (e) {
        print('🔥 Error no manejado: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() => _isLoading = false);
      }

    }
  }

  void _cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const CustomAppBar(title: 'Registrar Usuario', showBackButton: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Image.asset(
                'assets/img/logos/stamp.png',
                height: 100,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Usuario',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un usuario';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Dropdown para seleccionar profile
              DropdownButtonFormField<String>(
                value: _roleSeleccionado,
                decoration: const InputDecoration(
                  labelText: 'role',
                  prefixIcon: Icon(Icons.assignment_ind),
                  border: OutlineInputBorder(),
                ),
                items: _roles.map((String role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                onChanged: (String? nuevoValor) {
                  setState(() {
                    _roleSeleccionado = nuevoValor;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor seleccione un role';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una contraseña';
                  }
                  if (value.length < 6) {
                    return 'La contraseña debe tener al menos 6 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirmar Contraseña',
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor confirme su contraseña';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Dropdown para seleccionar status
              DropdownButtonFormField<String>(
                value: _statusSeleccionado,
                decoration: const InputDecoration(
                  labelText: 'status',
                  prefixIcon: Icon(Icons.toggle_on),
                  border: OutlineInputBorder(),
                ),
                items: _statuss.map((String status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (String? nuevoValor) {
                  setState(() {
                    _statusSeleccionado = nuevoValor;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor seleccione un status';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _addApiUser,
                      child: const Text('Registrar'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _cancel,
                      child: const Text('Cancelar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
