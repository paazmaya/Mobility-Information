import QtQuick 1.1
import com.nokia.meego 1.1
import QtMultimediaKit 1.1

Page {
    id: page
    tools: commonTools

    property string title : qsTr("Multimedia Camera")

    Image {
        id: pageHeader
        anchors {
            top: page.top
            left: page.left
            right: page.right
        }

        height: parent.width < parent.height ? 72 : 46
        width: parent.width
        source: "image://theme/meegotouch-view-header-fixed-inverted"
        z: 1

        Label {
            id: header
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 16
            }
            platformStyle: LabelStyle {
                fontFamily: "Nokia Pure Text Light"
                fontPixelSize: 32
            }
            text: page.title
        }
    }

    Item {
        id: pageContent
        anchors {
            top: pageHeader.bottom
            bottom: page.bottom
            left: page.left
            right: page.right
            margins: 16
        }


        // http://doc.qt.nokia.com/qtmobility-1.2/qml-camera.html
        Camera {
            focus : visible // to receive focus and capture key events when visible
            anchors.fill: parent

            flashMode: Camera.FlashOff
            whiteBalanceMode: Camera.WhiteBalanceManual
            exposureCompensation: -1.0
            exposureMode: Camera.ExposureManual



            /*
              exposureMode
            ExposureManual	Manual mode.
            ExposureAuto	Automatic mode.
            ExposureNight	Night mode.
            ExposureBacklight	Backlight exposure mode.
            ExposureSpotlight	Spotlight exposure mode.
            ExposureSports	Spots exposure mode.
            ExposureSnow	Snow exposure mode.
            ExposureBeach	Beach exposure mode.
            ExposureLargeAperture	Use larger aperture with small depth of field.
            ExposureSmallAperture	Use smaller aperture.
            ExposurePortrait	Portrait exposure mode.
            ExposureModeVendor	The base value for device specific exposure modes.
            */

            /*
            apertureChanged: {
                console.log("Camera. apertureChanged. aperture: " + aperture);
            }*/
            cameraStateChanged: {
                console.log("Camera. cameraStateChanged. cameraState: " + cameraState);
            }
            captureResolutionChanged: {
                console.log("Camera. captureResolutionChanged. captureResolution: " + captureResolution);
            }
            /* N9 does not find
            digitalZoomChanged: {
                console.log("Camera. digitalZoomChanged. digitalZoom: " + digitalZoom);
            }*/
            /*
            errorChanged: {
                console.log("Camera. errorChanged. error: " + error);
            }*/
            exposureCompensationChanged: {
                console.log("Camera. exposureCompensationChanged. exposureCompensation: " + exposureCompensation);
            }
            /*
            exposureModeChanged: {
                console.log("Camera. exposureModeChanged. exposureMode: " + exposureMode);
            }*/
            flashModeChanged: {
                console.log("Camera. flashModeChanged. flashMode: " + flashMode);
            }
            /*
            imageCaptured: {
                console.log("Camera. imageCaptured. ");
            }*/
            /*
            imageSaved: {
                console.log("Camera. imageSaved. ");
            }*/
            /*
            isoSensitivityChanged: {
                console.log("Camera. isoSensitivityChanged. isoSensitivity: " + isoSensitivity);
            }*/
            /*
            lockStatusChanged: {
                console.log("Camera. lockStatusChanged. lockStatus: " + lockStatus);
            }*/
            manualWhiteBalanceChanged: {
                console.log("Camera. manualWhiteBalanceChanged. manualWhiteBalance: " + manualWhiteBalance);
            }
            /* N9 does not find
            maximumDigitalZoomChanged: {
                console.log("Camera. maximumDigitalZoomChanged. maximumDigitalZoom: " + maximumDigitalZoom);
            }*/
            maximumOpticalZoomChanged: {
                console.log("Camera. maximumOpticalZoomChanged. maximumOpticalZoom: " + maximumOpticalZoom);
            }
            onCaptureFailed: {
                console.log("Camera. onCaptureFailed. message: " + message);
            }
            onError: {
                console.log("Camera. onError. error: " + error + ", errorString: " + errorString);
            }
            onImageCaptured: {
                console.log("Camera. onImageCaptured. preview: " + preview);
            }
            onImageSaved: {
                console.log("Camera. onImageSaved. path: " + path);
            }
            opticalZoomChanged: {
                console.log("Camera. opticalZoomChanged. opticalZoom: " + opticalZoom);
            }
            /*
            shutterSpeedChanged: {
                console.log("Camera. shutterSpeedChanged. shutterSpeed: " + shutterSpeed);
            }*/
            stateChanged: {
                console.log("Camera. stateChanged. state: " + state);
            }
            whiteBalanceModeChanged: {
                console.log("Camera. whiteBalanceModeChanged. whiteBalanceMode: " + whiteBalanceMode);
            }

        }

    }


}
