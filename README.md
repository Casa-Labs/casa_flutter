# casa_flutter

Flutter app for CASA

## Getting Started

### - use below credentials for proper test data
### userid - user1@example.com and password - asdf@1234

### **Steps for Handling Conflicts in CASA Project and How to create MR**

1) **Push your branch to your own GitHub repo**
    - If you haven’t pushed your local branch yet, push it using:
      ```bash
      git push origin <task-branch>
      ```

2) **Sync fork from the CASA development branch to your own repo's development branch**
    - Fetch updates from the CASA repository:
      ```bash
      git checkout development
      git fetch upstream development
      git merge upstream/development
      ```  
    - Push the updated development branch to your repo:
      ```bash
      git push origin development
      ```

3) **Merge your repo’s development branch into your task branch**
    - Switch to your task branch:
      ```bash
      git checkout <task-branch>
      ```
    - Merge development into your task branch:
      ```bash
      git merge development
      ```

4) **Resolve conflicts if they occur**
    - If there are mismatches, Git will show conflicts.
    - Open VS Code, resolve conflicts manually.
    - Once resolved, mark them as resolved:
      ```bash
      git add .
      git commit -m "Resolved merge conflicts"
      ```

5) **Push your updated task branch to your repo**
   ```bash
   git push origin <task-branch>
   ```

6) **Raise a merge request (PR) from your repo’s task branch to CASA’s development branch**
    - Open GitHub and create a pull request from `<your-repo>/<task-branch>` → `CASA/development`.
    - Add relevant details and request reviews if needed.

This process ensures that your fork is always in sync with CASA’s latest changes while minimizing conflicts.


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