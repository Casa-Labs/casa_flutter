# casa_flutter

Flutter app for CASA

## Getting Started

# Go Router Navigation

Here’s a list of all possible navigation methods in **GoRouter**, with one-liner explanations:

### **1. Basic Navigation**

- **`context.go('/route')`** → Replaces the current screen with a new one (no back stack).
- **`context.goNamed('routeName')`** → Same as `go()`, but using a named route.

### **2. Push Navigation (Stack-Based)**

- **`context.push('/route')`** → Pushes a new screen onto the stack (allows going back).
- **`context.pushNamed('routeName')`** → Same as `push()`, but using a named route.

### **3. Back Navigation**

- **`context.pop()`** → Goes back to the previous screen (only works if the screen was pushed, not if it was replaced using `go()`).

### **4. Replace Current Screen**

- **`context.replace('/route')`** → Replaces the current screen without adding to the back stack.
- **`context.replaceNamed('routeName')`** → Same as `replace()`, but using a named route.

### **5. Remove All Previous Screens**

- **`context.go('/route', extra: someData)`** → Navigates and clears all previous routes.
- **`context.pushReplacement('/route')`** → Pushes a new screen and removes the previous one from the stack.

### **6. Passing Data**

- **`context.go('/route?param=value')`** → Passes query parameters via the URL.
- **`context.push('/route', extra: someData)`** → Passes extra data while pushing a route.

### **7. Pop Until a Specific Route**

- **`context.popUntil((route) => route.settings.name == 'targetRoute')`** → Pops multiple screens until reaching a specific route.

---

Use **`go()`** when you don’t need back navigation, and **`push()`** when you want a back button.  