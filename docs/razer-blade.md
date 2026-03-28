# Razer Blade 15 Advanced 2021 (RTX 3070)

## Hardware Específico

| Componente | Detalle |
|------------|---------|
| CPU | Intel Core i7-11800H (11th Gen) |
| GPU | NVIDIA GeForce RTX 3070 (8GB) + Intel UHD Graphics |
| RAM | 16GB/32GB DDR4 |
| Display | 15.6" QHD (2560x1440) 165Hz |
| Almacenamiento | NVMe SSD |

## Características de la Configuración

### GPU Híbrida (Optimus/PRIME)

El portátil tiene graphics híbridas - una Intel integrada y una NVIDIA dedicada. La configuración incluye:

- **PRIME Sync**: Sincronización de frames para evitar tearing
- **Power Management**: Escalado dinámico de frecuencia NVIDIA
- **Drivers propietarios**: NVIDIA driver estable

#### Verificar Bus IDs

Los IDs de bus PCI pueden variar. Ejecuta:

```bash
lspci | grep -E "VGA|3D"
```

Deberías ver algo como:
```
00:02.0 VGA compatible controller: Intel Corporation
01:00.0 VGA compatible controller: NVIDIA Corporation GA104M [GeForce RTX 3070 Mobile / Max-Q]
```

Los IDs típicos son:
- Intel iGPU: `PCI:0:2:0`
- NVIDIA GPU: `PCI:1:0:0`

Si difieren, ajusta en `nixos/modules/razer-blade.nix`:
```nix
prime = {
  intelBusId = "PCI:0:2:0";  # Tu ID de Intel
  nvidiaBusId = "PCI:1:0:0"; # Tu ID de NVIDIA
};
```

### Openrazer (RGB)

El módulo configura **Openrazer** para controlar el teclado RGB:

- **Daemon**: `openrazer-daemon` corre en background
- **GUI**: `polychromatic` para control visual
- **CLI**: `razercfg` como alternativa

#### Permisos

El usuario debe estar en el grupo `openrazer`:
```nix
users.users.th3g3ntl3man.extraGroups = [ "openrazer" ];
```

### TLP (Power Management)

Configuración optimizada para RTX 3070:
- **Batería**: Modo powersave, freq limitada
- **Cargador**: Modo performance
- **NVIDIA**: Power profile dinámico

### Variables de Entorno para Wayland + NVIDIA

```bash
export LIBVA_DRIVER_NAME=nvidia
export GBM_BACKEND=nvidia-drm
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export NVD_BACKEND=direct
```

## Problemas Conocidos y Soluciones

### Pantalla negra al iniciar

Si tienes problemas con Wayland + NVIDIA:
1. Verifica que PRIME sync esté habilitado
2. Añade a `/etc/nixos/configuration.nix`:
   ```nix
   services.xserver.videoDrivers = [ "nvidia" ];
   ```

### Problemas con la tapa (lid)

El kernel parameter `button.lid_init_state=open` solve algunos problemas:
- Cierra y no suspende correctamente
- No detecta cambios de estado

Si persisten, remuévelo de `boot.kernelParams`.

### Sobrecalentamiento

1. Instala `lm_sensors` y verifica temperaturas:
   ```bash
   sensors
   ```
2. Considera `thermald` para gestión térmica automática
3. Ajusta el TLP NVIDIA power profile

### Reproducción de video con aceleración GPU

Para hardware decode con NVIDIA:
```nix
environment.sessionVariables = {
  NVD_BACKEND = "direct";
};
```

## Comandos Útiles

```bash
# Info de GPU
nvidia-smi

# Configuración NVIDIA
nvidia-settings

# Monitor GPU en tiempo real
nvtop

# Sensores de temperatura
sensors

# Verificar Bus IDs
lspci | grep -E "VGA|3D"

# Estado de Openrazer
systemctl status openrazer-daemon

# Ver variables de entorno de sesión
echo $LIBVA_DRIVER_NAME
```

## Scripts Útiles

### nvidia-offload (para usar GPU dedicada en apps específicas)

Crea `/home/th3g3ntl3man/.local/bin/nvidia-offload`:
```bash
#!/usr/bin/env bash
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export NVD_BACKEND=direct
exec "$@"
```

Uso:
```bash
nvidia-offload glxinfo | grep "OpenGL renderer"
```

## Archivos Relacionados

- `nixos/modules/razer-blade.nix` - Módulo principal
- `hosts/fs0ciety/configuration.nix` - Configuración del host
- `hosts/fs0ciety/hardware-configuration.nix` - Hardware detectado

## Referencias

- [NVIDIA + Wayland](https://wiki.archlinux.org/title/NVIDIA#Wayland)
- [TLP](https://linrunner.de/tlp/)
- [Openrazer](https://openrazer.github.io/)
- [Razer Blade Linux](https://github.com/morar/razer-linux-drivers)