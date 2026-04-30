# PORTNAME block
PORTNAME=       flameshot
DISTVERSION=    g20260425
CATEGORIES=     deskutils
MASTER_SITES=   GH
#MASTER_SITES=   GH,GL
PKGNAMESUFFIX=  -dev
DISTNAME=       ${PORTNAME}-${GH_TAGNAME}
DIST_SUBDIR=    ${PORTNAME}${PKGNAMESUFFIX}

# Maintainer block
MAINTAINER=     nope@nothere
COMMENT=		Powerful yet simple to use screenshot software
WWW=			https://flameshot.org/

# License block
LICENSE=       GPLv3
LICENSE_FILE=   ${WRKDIR}/${PORTNAME}-${GH_TAGNAME}/LICENSE

# dependencies
LIB_DEPENDS=	libkdsingleapplication-qt6.so:devel/kdsingleapplication \
				libQtColorWidgets-Qt52.so:x11-toolkits/color-widgets-qt5 \
				libQt6Core5Compat.so:devel/qt6-5compat
#				libQt6Designer.so:devel/qt6-tools

# uses block
USES=			cmake qmake qt:5 qt:6 desktop-file-utils gl pkgconfig:build

USE_GITHUB=     nodefault
GH_ACCOUNT=     flameshot-org
GH_PROJECT=     flameshot
GH_TAGNAME=		a6694bf45ace6a8552351d5f9ca6f006786ce6f9

USE_GL=			gl
USE_QT6=		tools_build

# uses=cmake related variables
CMAKE_ARGS=		-DCMAKE_BUILD_TYPE="MinSizeRel" \
				-DFETCHCONTENT_FULLY_DISCONNECTED=1 \
				-DUSE_KDSINGLEAPPLICATION=1 \
				-DUSE_BUNDLED_KDSINGLEAPPLICATION=0 \
				-DQTCOLORWIDGETS_BUILD_STATIC_LIBS=0 \
				-DCOLOR_WIDGETS_QT_SUFFIX=1 \
				-DQTCOLORWIDGETS_DESIGNER_PLUGIN=1 \
				-DDISABLE_UPDATE_CHECKER=1

# conflicts
CONFLICTS=		flameshot

# wrksrc block
WRKSRC=			${WRKDIR}/${PORTNAME}-${GH_TAGNAME}

# packaging list block
#DOCS=		*
#PORTDATA=	*

# options definitions

# options descriptions

# options helpers

#.include <bsd.port.options.mk>

# Is there any other way to do this, is it truly necessary?
#post-patch:
#	@${REINPLACE_CMD} \
#	-e 's,$${CMAKE_INSTALL_FULL_BINDIR},${LOCALBASE}/bin,1' \
#    -e 's,^\(Exec=\)@LAUNCHER_EXECUTABLE@,\1${LOCALBASE}/bin/${PORTNAME},1' \
#	${WRKSRC}/data/dbus/org.flameshot.Flameshot.service.in \
#	${WRKSRC}/data/desktopEntry/package/org.flameshot.Flameshot.desktop

# patch in files cures this
# ld: error: unable to find library -lQtColorWidgets

.include <bsd.port.mk>
