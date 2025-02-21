# PORTNAME block
PORTNAME=       flameshot
DISTVERSION=    g20250201
CATEGORIES=     deskutils
MASTER_SITES=   GH
PKGNAMESUFFIX=  -dev
DISTNAME=       ${PORTNAME}-${GH_TAGNAME}
DIST_SUBDIR=    ${PORTNAME}${PKGNAMESUFFIX}

# Maintainer block
MAINTAINER=     nope@nothere
COMMENT=	Powerful yet simple to use screenshot software
WWW=		https://flameshot.org/

# License block
LICENSE=	GPLv3
LICENSE_FILE=   ${WRKSRC}/LICENSE

# dependencies
#BUILD_DEPENDS=
#LIB_DEPENDS=
#RUN_DEPENDS=

# uses block
USES=		cmake qmake qt:5
#USES=		cmake compiler:c++17-lang qmake qt:5
USE_GITHUB=     nodefault
GH_ACCOUNT=     flameshot-org
GH_PROJECT=     flameshot
GH_TAGNAME=	61a6074bec8d07b6528b85cbb45bb3be7dd6ac0b

USE_GL=		gl
USE_QT=		core dbus gui linguist network svg widgets buildtools:build

# uses=cmake related variables
CMAKE_ARGS=	\
			-DCMAKE_BUILD_TYPE="MinSizeRel"
# This variable is necessary to get a proper pkg-plist
CMAKE_INSTALL_PREFIX=${STAGEDIR}/${PREFIX}

# conflicts
CONFLICTS=	flameshot

# wrksrc block
WRKSRC=	${WRKDIR}/${PORTNAME}-${GH_TAGNAME}

# packaging list block
#DOCS=		*
#PORTDATA=	*

# options definitions

# options descriptions

# options helpers

#.include <bsd.port.options.mk>

post-patch:
	@${REINPLACE_CMD} \
	-e 's,$${CMAKE_INSTALL_FULL_BINDIR},${LOCALBASE}/bin,1' \
    -e 's,^\(Exec=\)@LAUNCHER_EXECUTABLE@,\1${LOCALBASE}/bin/${PORTNAME},1' \
	${WRKSRC}/data/dbus/org.flameshot.Flameshot.service.in \
	${WRKSRC}/data/desktopEntry/package/org.flameshot.Flameshot.desktop

.include <bsd.port.mk>
