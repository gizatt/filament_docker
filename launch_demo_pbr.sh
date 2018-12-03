cd /filament/out/cmake-release/samples
wget https://raw.githubusercontent.com/KhronosGroup/glTF-Sample-Models/master/2.0/DamagedHelmet/glTF-Embedded/DamagedHelmet.gltf
./gltf_viewer -i envs/venetian_crossroads/ DamagedHelmet.gltf

# Alt: 
# ./material_sandbox -i envs/venetian_crossroads/ assets/models/monkey/monkey.obj