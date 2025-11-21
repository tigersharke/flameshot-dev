# PORTNAME block
PORTNAME=       flameshot
DISTVERSION=    g20251118
CATEGORIES=     deskutils
MASTER_SITES=   GH
PKGNAMESUFFIX=  -dev
DISTNAME=       ${PORTNAME}-${GH_TAGNAME}
DIST_SUBDIR=    ${PORTNAME}${PKGNAMESUFFIX}

# Maintainer block
MAINTAINER=     nope@nothere
COMMENT=		Powerful yet simple to use screenshot software
WWW=			https://flameshot.org/

# License block
LICENSE=		GPLv3
LICENSE_FILE=   ${WRKSRC}/LICENSE

# dependencies
BUILD_DEPENDS=	qt6-5compat>0:devel/qt6-5compat \
				qt6-tools>0:devel/qt6-tools \
				color-widgets-qt5>0:x11-toolkits/color-widgets-qt5
LIB_DEPENDS=	libkdsingleapplication-qt6.so:devel/kdsingleapplication
#RUN_DEPENDS=

# uses block
USES=			cmake qt:6 desktop-file-utils pkgconfig:build
#USES=			cmake qmake qt:6 pkgconfig:build
#USES=			cmake compiler:c++17-lang qmake qt:5
USE_GITHUB=     nodefault
GH_ACCOUNT=     flameshot-org
GH_PROJECT=     flameshot
GH_TAGNAME=		0f37bf09972c7e66ed78ad0460d2ebce97b82809

USE_GL=			gl
USE_QT=			5compat base declarative multimedia svg tools:build translations:build
#USE_QT=		core dbus gui linguist network svg widgets buildtools:build

# uses=cmake related variables
CMAKE_ARGS=		-DCMAKE_BUILD_TYPE="MinSizeRel" \
				-DUSE_EXTERNAL_SINGLEAPPLICATION="ON" \
				-DFETCHCONTENT_FULLY_DISCONNECTED="FALSE"

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
post-patch:
	@${REINPLACE_CMD} \
	-e 's,$${CMAKE_INSTALL_FULL_BINDIR},${LOCALBASE}/bin,1' \
    -e 's,^\(Exec=\)@LAUNCHER_EXECUTABLE@,\1${LOCALBASE}/bin/${PORTNAME},1' \
	${WRKSRC}/data/dbus/org.flameshot.Flameshot.service.in \
	${WRKSRC}/data/desktopEntry/package/org.flameshot.Flameshot.desktop

.include <bsd.port.mk>
