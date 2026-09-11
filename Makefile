# PORTNAME block
PORTNAME=       flameshot
DISTVERSION=    g20260910
CATEGORIES=     deskutils
MASTER_SITES=   GH GL
PKGNAMESUFFIX=  -dev
#DISTNAME=      ${PORTNAME}-${GH_TAGNAME}
DIST_SUBDIR=    ${PORTNAME}${PKGNAMESUFFIX}

# Maintainer block
MAINTAINER=     nope@nothere
COMMENT=	Powerful yet simple to use screenshot software
WWW=		https://flameshot.org/

# License block
LICENSE=	GPLv3
LICENSE_FILE=   ${WRKDIR}/${PORTNAME}-${GH_TAGNAME}/LICENSE

# dependencies
LIB_DEPENDS=	libQt6Core5Compat.so:devel/qt6-5compat \
		libQtColorWidgets-Qt52.so:x11-toolkits/color-widgets-qt5 \
		libQt6Designer.so:devel/qt6-tools \
		libkdsingleapplication-qt6.so:devel/kdsingleapplication \
		libQt6Svg.so:graphics/qt6-svg
#	libKF6GuiAddons.so:x11-toolkits/kf6-kguiaddons \

LDFLAGS+=	-L${LOCALBASE}/lib -L${LOCALBASE}/lib/QtColorWidgets-Qt52
# uses block
USES=		cmake ninja qt:6 desktop-file-utils gl pkgconfig

USE_GITHUB=     yes
GH_ACCOUNT=     flameshot-org
GH_PROJECT=     flameshot
GH_TAGNAME=	29a33f5e6ea87859f2ca79e67c62008e98fbc2d8

#USE_GITLAB=	nodefault
#GL_ACCOUNT=	mattbas
#GL_PROJECT=	Qt-Color-Widgets
#GL_TAGNAME=	5d52e907e50dc88cf969b41cea44665ff6c475b1
#GL_SUBDIR=	_deps/qtcolorwidgets-src

USE_GL=		gl
USE_QT6=	tools_build
USE_QT+=	base
#USE_QT=	core dbus gui linguist network svg widgets buildtools:build

# uses=cmake related variables
CMAKE_ENV= 	FETCHCONTENT_FULLY_DISCONNECTED=1 \
		USE_WAYLAND_CLIPBOARD=0 \
	 	USE_KDSINGLEAPPLICATION=0 \
		CMAKE_CXX_SCAN_FOR_MODULES=0 \
		FLAMESHOT_GIT_HASH=$(GH_TAGNAME}
CMAKE_ARGS=	-DUSE_WAYLAND_CLIPBOARD=0 \
	 	-DUSE_KDSINGLEAPPLICATION=0 \
		-DUSE_BUNDLED_KDSINGLEAPPLICATION=0 \
		-DQT_DEBUG_FIND_PACKAGE=1 \
		-DCMAKE_FIND_DEBUG_MODE=1 \
		-DCMAKE_BUILD_TYPE=DEBUG \
		-DCMAKE_AUTORCC=ON \
		-DCMAKE_AUTOMOC=ON \
		-DCMAKE_AUTOUIC=ON

# Fixes:
# 1/0 for boolean variables. Disallow wayland clipboard means no kf6-kguiaddons. And one small patch to rename the QtColorWidget library.

# conflicts
CONFLICTS=	flameshot

# wrksrc block

# packaging list block

# options definitions

# options descriptions

# options helpers

.include <bsd.port.options.mk>

.include <bsd.port.mk>
