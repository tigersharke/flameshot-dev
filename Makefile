# PORTNAME block
PORTNAME=       flameshot
DISTVERSION=    g20240702
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
GH_TAGNAME=	ccb5a27b136a633911b3b1006185530d9beeea5d
USE_GL=		gl
USE_QT=		core dbus gui network svg widgets buildtools:build

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
#OPTIONS=					SHARED DEBUG UPDATE GENERATE
#OPTIONS_DEFAULT=
#OPTIONS_GROUP=              BUILD DATABASE MISC NEEDS SYSTEM

# options descriptions
#BENCHMARKS_DESC=            Build benchmarks (Adds some benchmark chat commands)
#BUILD_DESC=                 Admin/Dev needs

# options helpers
#CLIENT_LIB_DEPENDS=			libpng16.so:graphics/png
#CLIENT_USES=				gl xorg jpeg sdl
#CLIENT_USE= \
#							GL+=glu \
#							SDL=sdl2,ttf2 \
#							XORG=ice,sm,x11,xext,xcb,xres,xshmfence,xau,xaw,xcomposite,xcursor,xdamage,xdmcp,\
#							xfixes,xft,xi,xinerama,xkbfile,xmu,xpm,xrandr,xrender,xscreensaver,xt,xtst,xv,xxf86vm

#CLIENT_CMAKE_BOOL=          BUILD_CLIENT

.include <bsd.port.options.mk>

post-patch:
	@${REINPLACE_CMD} \
	-e 's,$${CMAKE_INSTALL_FULL_BINDIR},${LOCALBASE}/bin,1' \
    -e 's,^\(Exec=\)@LAUNCHER_EXECUTABLE@,\1${LOCALBASE}/bin/${PORTNAME},1' \
	${WRKSRC}/data/dbus/org.flameshot.Flameshot.service.in \
	${WRKSRC}/data/desktopEntry/package/org.flameshot.Flameshot.desktop

#post-patch:
#    @${REINPLACE_CMD} \
#	-e 's,$${CMAKE_INSTALL_FULL_BINDIR},${LOCALBASE}/bin,1' \
#    -e 's,^\(Exec=\)@LAUNCHER_EXECUTABLE@,\1${LOCALBASE}/bin/${PORTNAME},1' \
#    ${WRKSRC}/data/dbus/org.flameshot.Flameshot.service.in \
#    ${WRKSRC}/data/desktopEntry/package/org.flameshot.Flameshot.desktop
#post-patch:
#	@${REINPLACE_CMD} -e 's,$${CMAKE_INSTALL_FULL_BINDIR},${LOCALBASE}/bin,1' \
#	-e 's,^\(Exec=\)/usr\(/bin\),\1${LOCALBASE}\2,1' \
#	${WRKSRC}/data/dbus/org.flameshot.Flameshot.service.in \
#	${WRKSRC}/data/desktopEntry/package/org.flameshot.Flameshot.desktop
#
# Compile-time pacman -S cmake base-devel git qt5-base qt5-tools
# Compile-time apt install g++ cmake build-essential qt5-default qttools5-dev-tools libqt5svg5-dev qttools5-dev
# Run-time apt install libqt5dbus5 libqt5network5 libqt5core5a libqt5widgets5 libqt5gui5 libqt5svg5
# Run-time pacman -S qt5-svg
# Optional pacman -S openssl ca-certificates
# Optional apt install git openssl ca-certificates
#
#Flameshot predefined color palette large: false
#git found: /usr/local/bin/git in version     2.35.1
#fatal: not a git repository (or any parent up to mount point /usr/home)
#Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set).
#---
#CMAKE_BUILD_TYPE:STRING=RelWithDebInfo
#DISABLE_UPDATE_CHECKER:BOOL=OFF
QTCOLORWIDGETS_DESIGNER_PLUGIN:BOOL=ON
#---
#Shared Libs required:
#        libQt5Widgets.so.5
#        libQt5Svg.so.5
#        libQt5Network.so.5
#        libQt5Gui.so.5
#        libQt5DBus.so.5
#        libQt5Core.so.5

.include <bsd.port.mk>
