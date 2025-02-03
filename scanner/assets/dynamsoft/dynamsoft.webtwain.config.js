//
// Dynamsoft JavaScript Library for Basic Initiation of Dynamic Web TWAIN
// More info on DWT: http://www.dynamsoft.com/Products/WebTWAIN_Overview.aspx
//
// Copyright 2022, Dynamsoft Corporation 
// Author: Dynamsoft Team
// Version: 17.2
//
/// <reference path="dynamsoft.webtwain.initiate.js" />
var Dynamsoft = Dynamsoft || { DWT: {} };

///
Dynamsoft.DWT.AutoLoad = true;
///
Dynamsoft.DWT.Containers = [{ ContainerId: 'dwtcontrolContainer', Width: 800 }];

/////////////////////////////////////////////////////////////////////////////////////
//  WARNING:  The productKey in this file is protected by copyright law            //
//  and international treaty provisions. Unauthorized reproduction or              //
//  distribution of this  productKey, or any portion of it, may result in severe   //
//  criminal and civil penalties, and will be prosecuted to the maximum            //
//  extent possible under the law.  Further, you may not reverse engineer,         //
//  decompile, disassemble, or modify the productKey .                             //
/////////////////////////////////////////////////////////////////////////////////////
/// If you need to use multiple keys on the same server, you can combine keys and write like this
/// To get a free trial, please visit https://www.dynamsoft.com/customer/license/trialLicense?product=dwt&utm_source=installer.
//Dynamsoft.DWT.ProductKey = 't0068MgAAADT4FzjRQp6jSnt3Nv//Hb0QdZbF75NzVLQbUJKWGTpL5x/Rzq8MFjzqGzA2B6l/HIMmd5N/nZwSAvY0GFFHkLc=;t0068MgAAAGk35AyvPpwlJ0yFeeQGYu7VK+abjbybHxA3bQbr3S54p0gP0Wt0Ubx9UV6v4r+yfXQmbInbnOgJcjWHfEACdEA='
//Dynamsoft.DWT.ProductKey = 't0068UwAAAF5nEEtcmFYuM333qGXU1ObgZo8b8YpUCB6MuTHRPSSfOOdR3qFZ5h0puR784nsjbR9IoyIBclP3vxWKuwjVLnA=;t0068UwAAABLX9eGc2B5zyDF+8egxZA9i0OXJSlaT7kjJBxM/ot3iPp52RsRIOfDC0e+NU+TMtwjcxrlZeDTX9H9k5n+CzF8='
//Dynamsoft.DWT.ProductKey = 't0154KQMAAKGqLf07clXrf9G+tOh5AQJzU0QPo8eSE+BWTHvQoQSpJkoMEaAPuV4muRabCYfKH1wxpdvxefMJ/7IrOBs14kyxkTw2hGOwFZG/lWwKjeFpXsVoNbip8zflrDvzxvmjU6cxnDA6NqU/feNm/vWQfubWcMLo2LiZG+P3OSe7x0Mhe80sPcMJo2NTM19NDPYmcpQP+82epA=='
//Dynamsoft.DWT.ProductKey = 't0154KQMAAAXmLZPyqn2Ly5/w450hqkCo7GRv+c2BM/EipDTSWB/NNMJNSRj3onE203U8AqMnowGrDgZGTY9V+hk+s9zYXg83VOaG4RhUE+VbSafQGT7Ny4w0g5s6f2N33Zk3zh+DOp3hBSNzY/0ZGzfzr4fsZ+4NLxiZGzdzZ/w+l6TveOjB3jLTyPCCkblpma8mxgyuOX0AT4ie5A==';
//Dynamsoft.DWT.ProductKey = "t01529gIAAEMWMlqlX0oCpdcrw8GEMpncyzBEuK+Z9WUVNqleMiSn3IPB6HVd44/ogpiomLe9ssCg2yVA2pWYNFr+GpMcKj5qQ1obRmKwutB3J9taMPwCNwcyAGKTPfBXfsBdPtWsQwBcASmAT+MPOA75nRUnISPgCkgBjkMGkExS7ZvaQ0DbCEkp4ApIAUbIALo26NrxBGT8lmE=";
//Dynamsoft.DWT.ProductKey = "t01539gIAAA6SW+XPVkIqC8BLpf2rVGCGQ3S6k/BEeYjf8PkxFq/YJmeOeQrMwWzglCthVuIZMBGRbxngxnKd7ZZgnQ8aNXfcSM2NHY4Nmov6qmRTCUaf4OqAHSAWOQL/yxe48X06qxCAZoAJ8G78AOOQn17pJGQEmgEmYBwygEknq11TuROy95AyBZoBJqCHDGC151IhlwdfGpZW";
//Dynamsoft.DWT.ProductKey = "t01529gIAAFRNa1ZrYzeIZzs0uItRg3zx6U0x3/qa5+PI+n9JGsspIlflHDCosggd/URkuuJMrTEq75mNLG2RjGS8UJUxPSVuqOaGERg0E3Wv1KfiDG9gMSADwBc5A3vlB7zkuI0qOMAZkARYN/6A65DfXnEQ0gPOgCTgOqQDQSdr/6byFtA6QlIIOAOSgBHSgbkICpF+AFCvmb0=";
//Dynamsoft.DWT.ProductKey = "t01539gIAAJWp3e+MyaJl1kb/UrO3fM0bReEK5y3QDxtC/2TVrhTy+KKZY2ILh7+pDVh8cu/ezyNa6+VJrOGd2PyAhjzWwKrkhjQ3jMBg7ULflWwqzvAOHh3IAPBFjqCf8gM2+fyNKjjAGZAE9G78Aechv73iIKQHnAFJwHlIB4JOql1TedqDayMkhYAzIAkYIR1YZqWiVV9hr542";
//Dynamsoft.DWT.ProductKey = "t01529gIAAFBExBn6NfiJkRvJTJ+ig4vsrXumzuiveJdLijX74TPi0wQcG7ZIpOqU6GtmvZKJzZ4G30uwlSY3UKsrvBwtkS3khjQ3jMDg1oW+KtlUnOEnWDqQAeCLHEF/5Qvc5X0bVXCAMyAJ6N34Ac5DfnrFQUgPOAOSgPOQDgSdVPum8hDQNkJSCDgDkoAR0oGqqBDVHRxWnfY=";
//Dynamsoft.DWT.ProductKey = "t01519gIAAEjLALi+tl8+YlEYPpg8ED9LRbtfplUQM9iH0u+lf/x2A8gAREoM1XNjbDp39IIiprPqfXwW8/V6F6bHxWUE0lSRmhtFYFr2veo+qR3FGd3AowMOAD/kDPorX+DJTzea4IBmgAno2/gBrkMeu9IgpAeaASbgOqQDwSZr+6byImQdISUEmgEmYIR0wECbZ8Mb70OWFg==";
//Dynamsoft.DWT.ProductKey = "t01529gIAAJzkdCJ/AxWoQQXDyFaXfQh5KYH3q65bVe/L/N/JiSoZD1FasNjlqUwRnx+9R4DmU23WM4tqceGvuZyVYxtWCZ9yYzU3xMBgaaK+K/k0B8MXuDagDhCLbEG75Qfc9DkdVQiAGVACWjf+gP2Q315xEDICZkAJ2A8ZwKCT1Z9pfgi29pA2BMyAEtBDBlDIRax6AoVtmgE=";
//Dynamsoft.DWT.ProductKey = "t01529gIAAAfG4fQ1y6zpF8U3y0qi3S5UhvZbGSsJyD8Qm/x9QxpiXYK/4W8wJ7fqloz3cY/fOM1W1r8NI4PTKill9RdUtmgN9dowEoPZRT8q2STB8A4WBzoAYpEz8K9cwEs/p1mFALgCWgDvxg9wH/LbK05CRsAV0ALchwwg6WS33yRvBa0jJKWAK6AFGCEDsGtOs134DYgjlcA=";
//Dynamsoft.DWT.ProductKey = "t01539gIAALLBLxczbvEtJ8Tc7nLj5Gz0mdosCKu/pqgxbXOrnZRVRJO+g4nF4K81Bg0ekougANNefCeqxquqP8RxRDy0DzduSHNjl2OD5kKPSjaVYPgFbg6kA8QiZ+CvfIG7vG9nFQLgDEgCvBs/wDjkp1c8CRkBZ0ASMA4ZwKSTat9UHgLae0iaAs6AJKCHDKBuK5em7QnbJJYE";
//Dynamsoft.DWT.ProductKey = "t01529gIAAIzwVvox9p8vMvuFxPnuRqe8Vh8UZ8p5+hCbVwNjC47NuOw1LJtgRjY0kYBlel6o0eSy2YzISgkJx/GylJqPU+kNjd4wCoNriPGq5JMkw09wC6ATIBfZgzjlC9z1/beqkAB3QBsQ3fgBjkN+esVFyAy4A9qA45AJFJ0cfk2yKWidIakE3AFtwAyZgNll+FvXB/1xmmg=";
//Dynamsoft.DWT.ProductKey = "t01489gIAADcUpErIG04eexZmtrcfo8bCbKBvNBOtu0/CisiIonDpXdIIPM+gI1/mTKsOJLQruRmSg/rk4u/ob+38y7SUO0RquWEEBt1EG530KM7wG6wGZAL4Jldgr3yBTT7VqIMDnAFJgE3jB7gPec6Kg5AecAYkAfchHQgm2fSbyktA+wxJIeAMSAJmSAdq72Mfhn2aNA==";
//Dynamsoft.DWT.ProductKey = "t01519gIAAHFcOWPXnHPhwi6zHcowHsliykn03NkB3UKsJrUk5q9OLCXTSxykGcJmGa6m4b/OEXYH2hiB3ddGKkBosQAn4ltYYmOYGNQuyqtT21Zn7AmuHWgA+CZ70F/5Aje9q7MODlgEFIA+jR/gOORnVjYJ6YFFQAE4DunAZJKlfdN6F7iNkJwCi4ACMEI6UFiRlC4PKauWNg==";
DWObject.ProductKey = "t01898AUAAFI2dqdd6qhAtJwiVbIp3yqHm5pca2Zjq8ifagRJqUBodcZouee2X5hR39JwyO7iYhwFJ6EhrEisEZjbDoEDHbbdfjnVwGn1nYb6TjZw6pITeEzDOJ92+MblAGXgOQG2XocVYAnMueyAoVtyowfIA8wBzMuBHnC6iuPmC/sCKf/+c6CjUw2cVt9ZFkgdJxs4dcmZCqSPCO+02vdcICxvzgaQB9gpwOUhOxQI9oA8wA5AIKIF0wcsczF3";  // Replace with your actual product key
///
Dynamsoft.DWT.ResourcesPath = 'assets/js/';

///
Dynamsoft.DWT.IfAddMD5InUploadHeader = false;

///
Dynamsoft.DWT.IfConfineMaskWithinTheViewer = false;

///
/*Dynamsoft.DWT.CustomizableDisplayInfo = {

    errorMessages: {

        // launch
        ERR_MODULE_NOT_INSTALLED: 'Error: The Dynamic Web TWAIN module is not installed.',
        ERR_BROWSER_NOT_SUPPORT: 'Error: This browser is currently not supported.',
        ERR_CreateID_MustNotInContainers: 'Error: Duplicate ID detected for creating Dynamic Web TWAIN objects, please check and modify.',
		ERR_CreateID_NotContainer: 'Error: The ID of the DIV for creating the new DWT object is invalid.',
        ERR_DWT_NOT_DOWNLOADED: 'Error: Failed to download the Dynamic Web TWAIN module.',

        // image view
        limitReachedForZoomIn: "Error: You have reached the limit for zooming in",
        limitReachedForZoomOut: "Error: You have reached the limit for zooming out",

        // image editor
        insufficientParas: 'Error: Not enough parameters.',
        invalidAngle: 'Error: The angle you entered is invalid.',
        invalidHeightOrWidth: "Error: The height or width you entered is invalid.",
        imageNotChanged: "Error: You have not changed the current image."

    },

    // launch
    generalMessages: {
        checkingDWTVersion: 'Checking WebTwain version ...',
        updatingDService: 'Dynamsoft Service is updating ...',
        downloadingDWTModule: 'Downloading the Dynamic Web TWAIN module.',
        refreshNeeded: 'Please REFRESH your browser.',
        downloadNeeded: 'Please download and install the Dynamic Web TWAIN.',
        DWTmoduleLoaded: 'The Dynamic Web TWAIN module is loaded.'
    },

    customProgressText: {

        // html5 event
        upload: 'Uploading...',
        download: 'Downloading...',
        load: 'Loading...',
        decode: 'Processing...',
        decodeTIFF: 'Processing tiff...',
        decodePDF: 'Processing pdf...',
        encode: 'Processing...',
        encodeTIFF: 'Processing tiff...',
        encodePDF: 'Processing pdf...',

        // image control
        canvasLoading: 'Loading ...'
    },

    // image editor
    buttons: {
        titles: {
            'previous': 'Previous Image',
            'next': 'Next Image',
            'print': 'Print Image',
            'scan': 'Acquire new Image(s)',
            'load': 'Load local Image(s)',
            'rotateleft': 'Rotate Left',
            'rotate': 'Rotate',
            'rotateright': 'Rotate Right',
            'deskew': 'Deskew',
            'crop': 'Crop Selected Area',
            'cut': 'Cut Selected Area',
            'changeimagesize': 'Change Image Size',
            'flip': 'Flip Image',
            'mirror': 'Mirror Image',
            'zoomin': 'Zoom In',
            'originalsize': 'Show Original Size',
            'zoomout': 'Zoom Out',
            'stretch': 'Stretch Mode',
            'fit': 'Fit Window',
            'fitw': 'Fit Horizontally',
            'fith': 'Fit Vertically',
            'hand': 'Hand Mode',
            'rectselect': 'Select Mode',
            'zoom': 'Click to Zoom In',
            'restore': 'Restore Orginal Image',
            'save': 'Save Changes',
            'close': 'Close the Editor',
            'removeall': 'Remove All Images',
            'removeselected': 'Remove All Selected Images'
        }
    },

    dialogText: {
        dlgRotateAnyAngle: ['Angle :', 'Interpolation:', 'Keep size', '  OK  ', 'Cancel'],
        dlgChangeImageSize: ['New Height :', 'New Width :', 'Interpolation method:', '  OK  ', 'Cancel'],
        saveChangedImage: ['You have changed the image, do you want to keep the change(s)?', '  Yes  ', '  No  '],
        selectSource: ['Select Source:', 'Select', 'Cancel', 'There is no source available!']
    }
};*/


/// All callbacks are defined in the dynamsoft.webtwain.install.js file, you can customize them.
// Dynamsoft.DWT.RegisterEvent('OnWebTwainReady', function(){
// 		// webtwain has been inited
// });

