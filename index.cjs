async function loadApp() {
    try {
      const {app} = await import('./public/index.js');
    } catch (e) {
      console.log(e);
    }
  }
  
  loadApp()