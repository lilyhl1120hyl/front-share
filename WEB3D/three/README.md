# three-app

## Project setup
```
yarn install
```

### Compiles and hot-reloads for development
```
yarn serve
```

### Compiles and minifies for production
```
yarn build
```

### Lints and fixes files
```
yarn lint
```

### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).


### 1.fbx转.glb格式
由3D软件导出的带有纹理和颜色的.fbx模型 , 可以通过win10自带的3D查看器来打开 , 并且另存为.glb格式。

### 2.压缩 gltf/glb 模型
可以通过nodejs的npm下载用苦啊压缩gltf/glb的包。
没安装nodejs的先安装nodejs
## 安装完成nodejs之后， 在安装路径的这个路径：例如C:\Program Files\nodejs\node_modules\npm下执行命令
```
  npm install -g gltf-pipeline
```

## 使用gltf-pipeline将gltf转为glb
```
gltf-pipeline -i model.gltf -o model.glb
```
## 打开命令行,cd或者powershell到.glb/gltf模型的文件夹,输入如下 命令进行压缩：
```
gltf-pipeline -i mao.gltf -o maoDraco.gltf -d
```
model.gltf为初始模型的名称
modelDraco.gltf为结果模型名称

等待一段时间后，即可在该文件夹得到压缩后的模型。

### 3.THREEJS加载gltf格式

//加载GLTF格式的模型,Web页面速度快,兼容性好
    var loader = new THREE.GLTFLoader();

// Optional:DRACOLoader提供压缩的gltf/glb的解码,对于压缩过一遍的gltf需要使用这个选项
    var dracoLoader = new THREE.DRACOLoader();
    dracoLoader.setDecoderPath('../build/libs/draco/');
    loader.setDRACOLoader( dracoLoader );

// Load a glTF resource
    loader.load('ThreeJs/gltf/company2.gltf',
        // called when the resource is loaded
        function ( gltf ) {
            gltf.scene.scale.set(0.0001,0.0001,0.0001);

            //gltf.scene是所有模型的group对象,存着所有的模型
            console.log(gltf.scene);
        }
    )