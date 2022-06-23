import logo from './logo.svg';
import PostShow from './components/PostShow';
import Header from './components/Header';

function App() {
  
  return (
    <div>
      <Header />
      <div className='container'>
        <PostShow />
      </div>
    </div>
  );
}

export default App;
