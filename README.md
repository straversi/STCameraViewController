# STCameraViewController

I took Apple's Swift AVCam and updated it so that it is not dependent on any storyboard files.

AVCam is a standalone project meant to showcase AVFoundation's camera capabilities, but it is difficult to port its main view controller to your own project because it is tied to the storyboard.

STCameraViewController can be instantiated programmatically and animated in as a popover, for example, unlike AVCam's CameraViewController.

## Further updates

I will be modifying this controller so that the UI mimics the default iOS camera.

## Dependencies

I've added Cartography and KYShutterButton as dependencies for now.

### Installing dependencies

```
gem install cocoapods
```

```
pod repo update
pod install
```

## Licensing

Apple's license for AV Cam allows editing and distribution, only requiring inclusion of their license when the source is unmodified. I will most likely add an MIT license to this project.

