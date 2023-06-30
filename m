Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6050F743F35
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Jun 2023 17:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjF3Pvk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 30 Jun 2023 11:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjF3Pvf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 30 Jun 2023 11:51:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBF535A5
        for <linux-ext4@vger.kernel.org>; Fri, 30 Jun 2023 08:51:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7868461789
        for <linux-ext4@vger.kernel.org>; Fri, 30 Jun 2023 15:51:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E30C433C0;
        Fri, 30 Jun 2023 15:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688140288;
        bh=ktJMZ6pYiztYIpG2WWFceogaHdTR+P+pzrC23ZFRrK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DeJQ+GvcjHaEblKwmvQt6/9z96BJdPQGGJm8R0ksGDY0mJ4CFX1UFhnbErh/R+sDr
         1lB+cFCM0FFHD6LRMR6bMF8PxMxtFujgrRApqT0Cn9bpwkNMYwo/GWSIw23iA3PCFH
         pRnE44T5O3OamxXB4cnP8xTZy176/q3Zv4JO/b8M/Hiq6HVK/JhqVC/YIcVgZNDb+F
         5xfVK2/SMDdKBuB50HRaO4sIMRmHkblJSs64RG9aMmS0Png/vlTGG+hd+WXeY/RWkw
         lO08sPi4fUIgL12INyz6udmAYEecEYzqM+3jj3r1kKWegPTUvtTlgemvY5d7XXXRfn
         1c6OfMb3skoug==
Date:   Fri, 30 Jun 2023 08:51:28 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Johannes Schauer Marin Rodrigues <josch@mister-muffin.de>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/1] mke2fs: the -d option can now handle tarball input
Message-ID: <20230630155128.GA11419@frogsfrogsfrogs>
References: <20230620121641.469078-1-josch@mister-muffin.de>
 <20230620121641.469078-2-josch@mister-muffin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620121641.469078-2-josch@mister-muffin.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jun 20, 2023 at 02:16:41PM +0200, Johannes Schauer Marin Rodrigues wrote:
> If archive.h is available during compilation, enable mke2fs to read a
> tarball as input. Since libarchive.so.13 is opened with dlopen,
> libarchive is not a hard library dependency of the resulting binary.

I can't say I'm in favor of adding build dependencies to e2fsprogs,
since the point of -d taking a directory arg was to *avoid* having to
understand anything other than posix(ish) directory tree walking APIs.

> This enables the creation of filesystems containing files which would
> otherwise need superuser privileges to create (like device nodes, which
> are also not allowed in unshared user namespaces). By reading from
> standard input when the filename is a dash (-), mke2fs can be used as
> part of a shell pipeline without temporary files.

What if the argument is actually a Microsoft CAB archive (which
libarchive claims to support)?  Will it actually copy the cab archive
into an ext4 image?

--D

> A round-trip from tarball to ext4 to tarball yields bit-by-bit identical
> results.
> ---
>  MCONFIG.in                     |   1 +
>  configure                      |  52 +++
>  configure.ac                   |   9 +
>  debugfs/Makefile.in            |   2 +-
>  lib/config.h.in                |   3 +
>  lib/ext2fs/Makefile.in         |   2 +-
>  misc/Makefile.in               |   2 +-
>  misc/create_inode.c            | 621 ++++++++++++++++++++++++++++++++-
>  misc/mke2fs.8.in               |  10 +-
>  misc/mke2fs.c                  |  12 +-
>  tests/m_rootgnutar/expect      | 188 ++++++++++
>  tests/m_rootgnutar/output.sed  |   5 +
>  tests/m_rootgnutar/script      |  88 +++++
>  tests/m_rootpaxtar/expect      |  87 +++++
>  tests/m_rootpaxtar/mkpaxtar.pl |  69 ++++
>  tests/m_rootpaxtar/output.sed  |   5 +
>  tests/m_rootpaxtar/script      |  44 +++
>  tests/m_roottar/expect         | 208 +++++++++++
>  tests/m_roottar/mktar.pl       |  62 ++++
>  tests/m_roottar/output.sed     |   5 +
>  tests/m_roottar/script         |  57 +++
>  21 files changed, 1513 insertions(+), 19 deletions(-)
>  create mode 100644 tests/m_rootgnutar/expect
>  create mode 100644 tests/m_rootgnutar/output.sed
>  create mode 100644 tests/m_rootgnutar/script
>  create mode 100644 tests/m_rootpaxtar/expect
>  create mode 100644 tests/m_rootpaxtar/mkpaxtar.pl
>  create mode 100644 tests/m_rootpaxtar/output.sed
>  create mode 100644 tests/m_rootpaxtar/script
>  create mode 100644 tests/m_roottar/expect
>  create mode 100644 tests/m_roottar/mktar.pl
>  create mode 100644 tests/m_roottar/output.sed
>  create mode 100644 tests/m_roottar/script
> 
> diff --git a/MCONFIG.in b/MCONFIG.in
> index 82c75a28..cb3ec759 100644
> --- a/MCONFIG.in
> +++ b/MCONFIG.in
> @@ -141,6 +141,7 @@ LIBFUSE = @FUSE_LIB@
>  LIBSUPPORT = $(LIBINTL) $(LIB)/libsupport@STATIC_LIB_EXT@
>  LIBBLKID = @LIBBLKID@ @PRIVATE_LIBS_CMT@ $(LIBUUID)
>  LIBINTL = @LIBINTL@
> +LIBARCHIVE = @ARCHIVE_LIB@
>  SYSLIBS = @LIBS@ @PTHREAD_LIBS@
>  DEPLIBSS = $(LIB)/libss@LIB_EXT@
>  DEPLIBCOM_ERR = $(LIB)/libcom_err@LIB_EXT@
> diff --git a/configure b/configure
> index 72c39b4d..d0e3410b 100755
> --- a/configure
> +++ b/configure
> @@ -704,6 +704,7 @@ SEM_INIT_LIB
>  FUSE_CMT
>  FUSE_LIB
>  CLOCK_GETTIME_LIB
> +ARCHIVE_LIB
>  MAGIC_LIB
>  SOCKET_LIB
>  SIZEOF_TIME_T
> @@ -13539,6 +13540,57 @@ if test "$ac_cv_func_dlopen" = yes ; then
>     MAGIC_LIB=$DLOPEN_LIB
>  fi
>  
> +{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for archive_read_new in -larchive" >&5
> +printf %s "checking for archive_read_new in -larchive... " >&6; }
> +if test ${ac_cv_lib_archive_archive_read_new+y}
> +then :
> +  printf %s "(cached) " >&6
> +else $as_nop
> +  ac_check_lib_save_LIBS=$LIBS
> +LIBS="-larchive  $LIBS"
> +cat confdefs.h - <<_ACEOF >conftest.$ac_ext
> +/* end confdefs.h.  */
> +
> +/* Override any GCC internal prototype to avoid an error.
> +   Use char because int might match the return type of a GCC
> +   builtin and then its argument prototype would still apply.  */
> +char archive_read_new ();
> +int
> +main (void)
> +{
> +return archive_read_new ();
> +  ;
> +  return 0;
> +}
> +_ACEOF
> +if ac_fn_c_try_link "$LINENO"
> +then :
> +  ac_cv_lib_archive_archive_read_new=yes
> +else $as_nop
> +  ac_cv_lib_archive_archive_read_new=no
> +fi
> +rm -f core conftest.err conftest.$ac_objext conftest.beam \
> +    conftest$ac_exeext conftest.$ac_ext
> +LIBS=$ac_check_lib_save_LIBS
> +fi
> +{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: $ac_cv_lib_archive_archive_read_new" >&5
> +printf "%s\n" "$ac_cv_lib_archive_archive_read_new" >&6; }
> +if test "x$ac_cv_lib_archive_archive_read_new" = xyes
> +then :
> +  ARCHIVE_LIB=-larchive
> +ac_fn_c_check_header_compile "$LINENO" "archive.h" "ac_cv_header_archive_h" "$ac_includes_default"
> +if test "x$ac_cv_header_archive_h" = xyes
> +then :
> +  printf "%s\n" "#define HAVE_ARCHIVE_H 1" >>confdefs.h
> +
> +fi
> +
> +fi
> +
> +if test "$ac_cv_func_dlopen" = yes ; then
> +   ARCHIVE_LIB=$DLOPEN_LIB
> +fi
> +
>  { printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for clock_gettime in -lrt" >&5
>  printf %s "checking for clock_gettime in -lrt... " >&6; }
>  if test ${ac_cv_lib_rt_clock_gettime+y}
> diff --git a/configure.ac b/configure.ac
> index b905e999..69fbbd27 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1296,6 +1296,15 @@ if test "$ac_cv_func_dlopen" = yes ; then
>  fi
>  AC_SUBST(MAGIC_LIB)
>  dnl
> +dnl libarchive
> +dnl
> +AC_CHECK_LIB(archive, archive_read_new, [ARCHIVE_LIB=-larchive
> +AC_CHECK_HEADERS([archive.h])])
> +if test "$ac_cv_func_dlopen" = yes ; then
> +   ARCHIVE_LIB=$DLOPEN_LIB
> +fi
> +AC_SUBST(ARCHIVE_LIB)
> +dnl
>  dnl Check to see if librt is required for clock_gettime() (glibc < 2.17)
>  dnl
>  AC_CHECK_LIB(rt, clock_gettime, [CLOCK_GETTIME_LIB=-lrt])
> diff --git a/debugfs/Makefile.in b/debugfs/Makefile.in
> index 67f8d0b6..8162df33 100644
> --- a/debugfs/Makefile.in
> +++ b/debugfs/Makefile.in
> @@ -36,7 +36,7 @@ SRCS= debug_cmds.c $(srcdir)/debugfs.c $(srcdir)/util.c $(srcdir)/ls.c \
>  	$(srcdir)/../e2fsck/recovery.c $(srcdir)/do_journal.c
>  
>  LIBS= $(LIBSUPPORT) $(LIBEXT2FS) $(LIBE2P) $(LIBSS) $(LIBCOM_ERR) $(LIBBLKID) \
> -	$(LIBUUID) $(LIBMAGIC) $(SYSLIBS)
> +	$(LIBUUID) $(LIBMAGIC) $(SYSLIBS) $(LIBARCHIVE)
>  DEPLIBS= $(DEPLIBSUPPORT) $(LIBEXT2FS) $(LIBE2P) $(DEPLIBSS) $(DEPLIBCOM_ERR) \
>  	$(DEPLIBBLKID) $(DEPLIBUUID)
>  
> diff --git a/lib/config.h.in b/lib/config.h.in
> index 076c3823..30477698 100644
> --- a/lib/config.h.in
> +++ b/lib/config.h.in
> @@ -40,6 +40,9 @@
>  /* Define to 1 if you have the `add_key' function. */
>  #undef HAVE_ADD_KEY
>  
> +/* Define to 1 if you have the <archive.h> header file. */
> +#undef HAVE_ARCHIVE_H
> +
>  /* Define to 1 if you have the <attr/xattr.h> header file. */
>  #undef HAVE_ATTR_XATTR_H
>  
> diff --git a/lib/ext2fs/Makefile.in b/lib/ext2fs/Makefile.in
> index 798ff609..e365793a 100644
> --- a/lib/ext2fs/Makefile.in
> +++ b/lib/ext2fs/Makefile.in
> @@ -499,7 +499,7 @@ tst_libext2fs: $(DEBUG_OBJS) \
>  	$(Q) $(CC) -o tst_libext2fs $(ALL_LDFLAGS) -DDEBUG $(DEBUG_OBJS) \
>  		$(STATIC_LIBSS) $(STATIC_LIBE2P) $(LIBSUPPORT) \
>  		$(STATIC_LIBEXT2FS) $(LIBBLKID) $(LIBUUID) $(LIBMAGIC) \
> -		$(STATIC_LIBCOM_ERR) $(SYSLIBS) -I $(top_srcdir)/debugfs
> +		$(STATIC_LIBCOM_ERR) $(SYSLIBS) $(LIBARCHIVE) -I $(top_srcdir)/debugfs
>  
>  tst_inline: $(srcdir)/inline.c $(STATIC_LIBEXT2FS) $(DEPSTATIC_LIBCOM_ERR)
>  	$(E) "	LD $@"
> diff --git a/misc/Makefile.in b/misc/Makefile.in
> index e5420bbd..c42d1f45 100644
> --- a/misc/Makefile.in
> +++ b/misc/Makefile.in
> @@ -281,7 +281,7 @@ mke2fs: $(MKE2FS_OBJS) $(DEPLIBS) $(LIBE2P) $(DEPLIBBLKID) $(DEPLIBUUID) \
>  	$(E) "	LD $@"
>  	$(Q) $(CC) $(ALL_LDFLAGS) -o mke2fs $(MKE2FS_OBJS) $(LIBS) $(LIBBLKID) \
>  		$(LIBUUID) $(LIBEXT2FS) $(LIBE2P) $(LIBINTL) \
> -		$(SYSLIBS) $(LIBMAGIC)
> +		$(SYSLIBS) $(LIBMAGIC) $(LIBARCHIVE)
>  
>  mke2fs.static: $(MKE2FS_OBJS) $(STATIC_DEPLIBS) $(STATIC_LIBE2P) $(DEPSTATIC_LIBUUID) \
>  		$(DEPSTATIC_LIBBLKID)
> diff --git a/misc/create_inode.c b/misc/create_inode.c
> index a3a34cd9..0c9009a5 100644
> --- a/misc/create_inode.c
> +++ b/misc/create_inode.c
> @@ -39,6 +39,164 @@
>  #include "create_inode.h"
>  #include "support/nls-enable.h"
>  
> +#ifdef HAVE_ARCHIVE_H
> +#include <locale.h>
> +#include <libgen.h>
> +#include <archive.h>
> +#include <archive_entry.h>
> +
> +static const char *(*dl_archive_entry_hardlink)(struct archive_entry *);
> +static const char *(*dl_archive_entry_pathname)(struct archive_entry *);
> +static const struct stat *(*dl_archive_entry_stat)(struct archive_entry *);
> +static const char *(*dl_archive_entry_symlink)(struct archive_entry *);
> +static int (*dl_archive_entry_xattr_count)(struct archive_entry *);
> +static int (*dl_archive_entry_xattr_next)(struct archive_entry *, const char **, const void **, size_t *);
> +static int (*dl_archive_entry_xattr_reset)(struct archive_entry *);
> +static const char *(*dl_archive_error_string)(struct archive *);
> +static int (*dl_archive_read_close)(struct archive *);
> +static la_ssize_t (*dl_archive_read_data)(struct archive *, void *, size_t);
> +static int (*dl_archive_read_free)(struct archive *);
> +static struct archive *(*dl_archive_read_new)(void);
> +static int (*dl_archive_read_next_header)(struct archive *, struct archive_entry **);
> +static int (*dl_archive_read_open_filename)(struct archive *, const char *filename, size_t);
> +static int (*dl_archive_read_support_filter_all)(struct archive *);
> +static int (*dl_archive_read_support_format_all)(struct archive *);
> +
> +#ifdef HAVE_DLOPEN
> +#include <dlfcn.h>
> +
> +static void *libarchive_handle;
> +
> +static int libarchive_available(void) {
> +	if (!libarchive_handle) {
> +		libarchive_handle = dlopen("libarchive.so.13", RTLD_NOW);
> +		if (!libarchive_handle)
> +			return 0;
> +
> +		dl_archive_entry_hardlink =
> +			(const char *(*)(struct archive_entry *))
> +			dlsym(libarchive_handle, "archive_entry_hardlink");
> +		if (!dl_archive_entry_hardlink) {
> +			return 0;
> +		}
> +		dl_archive_entry_pathname =
> +			(const char *(*)(struct archive_entry *))
> +			dlsym(libarchive_handle, "archive_entry_pathname");
> +		if (!dl_archive_entry_pathname) {
> +			return 0;
> +		}
> +		dl_archive_entry_stat =
> +			(const struct stat *(*)(struct archive_entry *))
> +			dlsym(libarchive_handle, "archive_entry_stat");
> +		if (!dl_archive_entry_stat) {
> +			return 0;
> +		}
> +		dl_archive_entry_symlink =
> +			(const char *(*)(struct archive_entry *))
> +			dlsym(libarchive_handle, "archive_entry_symlink");
> +		if (!dl_archive_entry_symlink) {
> +			return 0;
> +		}
> +		dl_archive_entry_xattr_count =
> +			(int (*)(struct archive_entry *))
> +			dlsym(libarchive_handle, "archive_entry_xattr_count");
> +		if (!dl_archive_entry_xattr_count) {
> +			return 0;
> +		}
> +		dl_archive_entry_xattr_next =
> +			(int (*)(struct archive_entry *, const char **, const void **, size_t *))
> +			dlsym(libarchive_handle, "archive_entry_xattr_next");
> +		if (!dl_archive_entry_xattr_next) {
> +			return 0;
> +		}
> +		dl_archive_entry_xattr_reset =
> +			(int (*)(struct archive_entry *))
> +			dlsym(libarchive_handle, "archive_entry_xattr_reset");
> +		if (!dl_archive_entry_xattr_reset) {
> +			return 0;
> +		}
> +		dl_archive_error_string =
> +			(const char *(*)(struct archive *))
> +			dlsym(libarchive_handle, "archive_error_string");
> +		if (!dl_archive_error_string) {
> +			return 0;
> +		}
> +		dl_archive_read_close =
> +			(int (*)(struct archive *))
> +			dlsym(libarchive_handle, "archive_read_close");
> +		if (!dl_archive_read_close) {
> +			return 0;
> +		}
> +		dl_archive_read_data =
> +			(la_ssize_t (*)(struct archive *, void *, size_t))
> +			dlsym(libarchive_handle, "archive_read_data");
> +		if (!dl_archive_read_data) {
> +			return 0;
> +		}
> +		dl_archive_read_free =
> +			(int (*)(struct archive *))
> +			dlsym(libarchive_handle, "archive_read_free");
> +		if (!dl_archive_read_free) {
> +			return 0;
> +		}
> +		dl_archive_read_new =
> +			(struct archive *(*)(void))
> +			dlsym(libarchive_handle, "archive_read_new");
> +		if (!dl_archive_read_new) {
> +			return 0;
> +		}
> +		dl_archive_read_next_header =
> +			(int (*)(struct archive *, struct archive_entry **))
> +			dlsym(libarchive_handle, "archive_read_next_header");
> +		if (!dl_archive_read_next_header) {
> +			return 0;
> +		}
> +		dl_archive_read_open_filename =
> +			(int (*)(struct archive *, const char *filename, size_t))
> +			dlsym(libarchive_handle, "archive_read_open_filename");
> +		if (!dl_archive_read_open_filename) {
> +			return 0;
> +		}
> +		dl_archive_read_support_filter_all =
> +			(int (*)(struct archive *))
> +			dlsym(libarchive_handle, "archive_read_support_filter_all");
> +		if (!dl_archive_read_support_filter_all) {
> +			return 0;
> +		}
> +		dl_archive_read_support_format_all =
> +			(int (*)(struct archive *))
> +			dlsym(libarchive_handle, "archive_read_support_format_all");
> +		if (!dl_archive_read_support_format_all) {
> +			return 0;
> +		}
> +	}
> +
> +	return 1;
> +}
> +#elif
> +static int libarchive_available(void) {
> +	dl_archive_entry_hardlink = archive_entry_hardlink;
> +	dl_archive_entry_pathname = archive_entry_pathname;
> +	dl_archive_entry_stat = archive_entry_stat;
> +	dl_archive_entry_symlink = archive_entry_symlink;
> +	dl_archive_entry_xattr_count = archive_entry_xattr_count;
> +	dl_archive_entry_xattr_next = archive_entry_xattr_next;
> +	dl_archive_entry_xattr_reset = archive_entry_xattr_reset;
> +	dl_archive_error_string = archive_error_string;
> +	dl_archive_read_close = archive_read_close;
> +	dl_archive_read_data = archive_read_data;
> +	dl_archive_read_free = archive_read_free;
> +	dl_archive_read_new = archive_read_new;
> +	dl_archive_read_next_header = archive_read_next_header;
> +	dl_archive_read_open_filename = archive_read_open_filename;
> +	dl_archive_read_support_filter_all = archive_read_support_filter_all;
> +	dl_archive_read_support_format_all = archive_read_support_format_all;
> +
> +	return 1;
> +}
> +#endif
> +#endif
> +
>  /* 64KiB is the minimum blksize to best minimize system call overhead. */
>  #define COPY_FILE_BUFLEN	65536
>  
> @@ -109,7 +267,7 @@ static errcode_t add_link(ext2_filsys fs, ext2_ino_t parent_ino,
>  
>  /* Set the uid, gid, mode and time for the inode */
>  static errcode_t set_inode_extra(ext2_filsys fs, ext2_ino_t ino,
> -				 struct stat *st)
> +				 const struct stat *st)
>  {
>  	errcode_t		retval;
>  	struct ext2_inode	inode;
> @@ -1043,8 +1201,429 @@ out:
>  	return retval;
>  }
>  
> +#ifdef HAVE_ARCHIVE_H
> +static errcode_t __find_path(ext2_filsys fs, ext2_ino_t root, const char *name,
> +		ext2_ino_t *inode) {
> +	errcode_t	retval;
> +	ext2_ino_t tmpino;
> +	char *p, *n, *n2 = strdup(name);
> +	if (n2 == NULL) {
> +		retval = errno;
> +		goto out;
> +	}
> +	n = n2;
> +	*inode = root;
> +	// any number of leading slashes
> +	while(*n == '/') {
> +		n++;
> +	}
> +	while(*n) {
> +		// replace the next slash by a NULL, if any
> +		if((p = strchr(n, '/')))
> +			(*p) = 0;
> +		// find the inode of the next component
> +		retval = ext2fs_lookup(fs, *inode, n, strlen(n), 0, &tmpino);
> +		if (retval) {
> +			goto out;
> +		}
> +		*inode = tmpino;
> +		// continue the search at the character after the slash
> +		if(p)
> +			n = p + 1;
> +		else
> +			break;
> +	}
> +
> +out:
> +	free(n2);
> +	return retval;
> +}
> +
> +/* Rounds qty upto a multiple of siz. siz should be a power of 2 */
> +static inline unsigned int __rndup(unsigned int qty, unsigned int siz) {
> +	return (qty + (siz - 1)) & ~(siz - 1);
> +}
> +
> +static errcode_t copy_file_chunk_tar(ext2_filsys fs, struct archive *archive, ext2_file_t e2_file,
> +				 off_t start, off_t end, char *buf,
> +				 char *zerobuf)
> +{
> +	off_t off, bpos;
> +	ssize_t got, blen;
> +	unsigned int written;
> +	char *ptr;
> +	errcode_t err = 0;
> +
> +	for (off = start; off < end; off += COPY_FILE_BUFLEN) {
> +		got = dl_archive_read_data(archive, buf, COPY_FILE_BUFLEN);
> +		if (got < 0) {
> +			err = errno;
> +			goto fail;
> +		}
> +		for (bpos = 0, ptr = buf; bpos < got; bpos += fs->blocksize) {
> +			blen = fs->blocksize;
> +			if (blen > got - bpos)
> +				blen = got - bpos;
> +			if (memcmp(ptr, zerobuf, blen) == 0) {
> +				ptr += blen;
> +				continue;
> +			}
> +			err = ext2fs_file_llseek(e2_file, off + bpos,
> +						 EXT2_SEEK_SET, NULL);
> +			if (err)
> +				goto fail;
> +			while (blen > 0) {
> +				err = ext2fs_file_write(e2_file, ptr, blen,
> +							&written);
> +				if (err)
> +					goto fail;
> +				if (written == 0) {
> +					err = EIO;
> +					goto fail;
> +				}
> +				blen -= written;
> +				ptr += written;
> +			}
> +		}
> +	}
> +fail:
> +	return err;
> +}
> +static errcode_t copy_file_tar(ext2_filsys fs, struct archive *archive, const struct stat *statbuf,
> +			   ext2_ino_t ino)
> +{
> +	ext2_file_t e2_file;
> +	char *buf = NULL, *zerobuf = NULL;
> +	errcode_t err, close_err;
> +
> +	err = ext2fs_file_open(fs, ino, EXT2_FILE_WRITE, &e2_file);
> +	if (err)
> +		return err;
> +
> +	err = ext2fs_get_mem(COPY_FILE_BUFLEN, &buf);
> +	if (err)
> +		goto out;
> +
> +	err = ext2fs_get_memzero(fs->blocksize, &zerobuf);
> +	if (err)
> +		goto out;
> +
> +	err = copy_file_chunk_tar(fs, archive, e2_file, 0, statbuf->st_size, buf,
> +			      zerobuf);
> +out:
> +	ext2fs_free_mem(&zerobuf);
> +	ext2fs_free_mem(&buf);
> +	close_err = ext2fs_file_close(e2_file);
> +	if (err == 0)
> +		err = close_err;
> +	return err;
> +}
> +
> +
> +errcode_t do_write_internal_tar(ext2_filsys fs, ext2_ino_t cwd, struct archive *archive,
> +			    const char *dest, const struct stat *statbuf)
> +{
> +	ext2_ino_t	newfile;
> +	errcode_t	retval;
> +	struct ext2_inode inode;
> +	char		*cp;
> +	retval = ext2fs_new_inode(fs, cwd, 010755, 0, &newfile);
> +	if (retval)
> +		goto out;
> +#ifdef DEBUGFS
> +	printf("Allocated inode: %u\n", newfile);
> +#endif
> +	retval = ext2fs_link(fs, cwd, dest, newfile, EXT2_FT_REG_FILE);
> +	if (retval == EXT2_ET_DIR_NO_SPACE) {
> +		retval = ext2fs_expand_dir(fs, cwd);
> +		if (retval)
> +			goto out;
> +		retval = ext2fs_link(fs, cwd, dest, newfile,
> +					EXT2_FT_REG_FILE);
> +	}
> +	if (retval)
> +		goto out;
> +	if (ext2fs_test_inode_bitmap2(fs->inode_map, newfile))
> +		com_err(__func__, 0, "Warning: inode already set");
> +	ext2fs_inode_alloc_stats2(fs, newfile, +1, 0);
> +	memset(&inode, 0, sizeof(inode));
> +	inode.i_mode = (statbuf->st_mode & ~S_IFMT) | LINUX_S_IFREG;
> +	inode.i_atime = inode.i_ctime = inode.i_mtime =
> +		fs->now ? fs->now : time(0);
> +	inode.i_links_count = 1;
> +	retval = ext2fs_inode_size_set(fs, &inode, statbuf->st_size);
> +	if (retval)
> +		goto out;
> +	if (ext2fs_has_feature_inline_data(fs->super)) {
> +		inode.i_flags |= EXT4_INLINE_DATA_FL;
> +	} else if (ext2fs_has_feature_extents(fs->super)) {
> +		ext2_extent_handle_t handle;
> +
> +		inode.i_flags &= ~EXT4_EXTENTS_FL;
> +		retval = ext2fs_extent_open2(fs, newfile, &inode, &handle);
> +		if (retval)
> +			goto out;
> +		ext2fs_extent_free(handle);
> +	}
> +
> +	retval = ext2fs_write_new_inode(fs, newfile, &inode);
> +	if (retval)
> +		goto out;
> +	if (inode.i_flags & EXT4_INLINE_DATA_FL) {
> +		retval = ext2fs_inline_data_init(fs, newfile);
> +		if (retval)
> +			goto out;
> +	}
> +	if (LINUX_S_ISREG(inode.i_mode)) {
> +		retval = copy_file_tar(fs, archive, statbuf, newfile);
> +		if (retval)
> +			goto out;
> +	}
> +out:
> +	return retval;
> +}
> +
> +static errcode_t set_inode_xattr_tar(ext2_filsys fs, ext2_ino_t ino,
> +				 struct archive_entry *entry)
> +{
> +	errcode_t			retval, close_retval;
> +	struct ext2_xattr_handle	*handle;
> +	ssize_t				size;
> +	const char *name;
> +	const void *value;
> +	size_t value_size;
> +
> +	if (no_copy_xattrs)
> +		return 0;
> +
> +	size = dl_archive_entry_xattr_count(entry);
> +	if (size == 0) {
> +		return 0;
> +	}
> +
> +	retval = ext2fs_xattrs_open(fs, ino, &handle);
> +	if (retval) {
> +		if (retval == EXT2_ET_MISSING_EA_FEATURE)
> +			return 0;
> +		com_err(__func__, retval, _("while opening inode %u"), ino);
> +		return retval;
> +	}
> +
> +	retval = ext2fs_xattrs_read(handle);
> +	if (retval) {
> +		com_err(__func__, retval,
> +			_("while reading xattrs for inode %u"), ino);
> +		goto out;
> +	}
> +
> +	dl_archive_entry_xattr_reset(entry);
> +	while (dl_archive_entry_xattr_next(entry, &name, &value, &value_size) == ARCHIVE_OK) {
> +		if (strcmp(name, "security.capability") != 0) {
> +			continue;
> +		}
> +
> +		retval = ext2fs_xattr_set(handle, name, value, value_size);
> +		if (retval) {
> +			com_err(__func__, retval,
> +				_("while writing attribute \"%s\" to inode %u"),
> +				name, ino);
> +			break;
> +		}
> +
> +	}
> + out:
> +	close_retval = ext2fs_xattrs_close(&handle);
> +	if (close_retval) {
> +		com_err(__func__, retval, _("while closing inode %u"), ino);
> +		retval = retval ? retval : close_retval;
> +	}
> +	return retval;
> +}
> +
> +static errcode_t __populate_fs_from_tar(ext2_filsys fs, ext2_ino_t root_ino,
> +			       const char *source_tar, ext2_ino_t root,
> +			       struct hdlinks_s *hdlinks,
> +			       struct file_info *target,
> +			       struct fs_ops_callbacks *fs_callbacks)
> +{
> +	char *path2, *path3, *dir, *name, *ln_target;
> +	unsigned int uid, gid, mode;
> +	unsigned long ctime, mtime;
> +	struct archive *a;
> +	struct archive_entry *entry;
> +	errcode_t	retval = 0;
> +	locale_t archive_locale;
> +	locale_t old_locale;
> +	ext2_ino_t dirinode, tmpino;
> +	const struct stat *st;
> +
> +	if (!libarchive_available()) {
> +		com_err(__func__, 0, _("you need libarchive to be able to process tarballs"));
> +		return 1;
> +	}
> +
> +	archive_locale = newlocale(LC_CTYPE_MASK, "", (locale_t)0);
> +	old_locale = uselocale(archive_locale);
> +	a = dl_archive_read_new();
> +	if (a == NULL) {
> +		retval = 1;
> +		com_err(__func__, retval, _("while creating archive reader"));
> +		goto out;
> +	}
> +	if (dl_archive_read_support_filter_all(a) != ARCHIVE_OK) {
> +		retval = 1;
> +		com_err(__func__, retval, _("while enabling decompression"));
> +		goto out;
> +	}
> +	if (dl_archive_read_support_format_all(a) != ARCHIVE_OK) {
> +		retval = 1;
> +		com_err(__func__, retval, _("while enabling reader formats"));
> +		goto out;
> +	}
> +
> +	if ((retval = dl_archive_read_open_filename(a, source_tar, 4096))) {
> +		com_err(__func__, retval, _("while opening \"%s\""), dl_archive_error_string(a));
> +		goto out;
> +	}
> +
> +	for (;;) {
> +		retval = dl_archive_read_next_header(a, &entry);
> +		if (retval == ARCHIVE_EOF) {
> +			retval = 0;
> +			break;
> +		}
> +		if (retval != ARCHIVE_OK) {
> +			com_err(__func__, retval, _("cannot read archive header: \"%s\""),
> +				dl_archive_error_string(a));
> +			goto out;
> +		}
> +		path2 = strdup(dl_archive_entry_pathname(entry));
> +		path3 = strdup(dl_archive_entry_pathname(entry));
> +		name = basename(path2);
> +		dir = dirname(path3);
> +		if(retval = __find_path(fs, root_ino, dir, &dirinode)) {
> +			com_err(__func__, retval,
> +				_("cannot find directory \"%s\" to create \"%s\""), dir, name);
> +			goto out;
> +		}
> +		st = dl_archive_entry_stat(entry);
> +		retval = ext2fs_namei(fs, root, dirinode, name, &tmpino);
> +		if (!retval) {
> +			// repeated element in tar
> +			// FIXME: if regular file, update content
> +		} else {
> +			// no special casing for sockets and symlinks on windows is needed
> +			// because even on windows we can have tarballs containing those files
> +			switch(st->st_mode & S_IFMT)
> +			{
> +				case S_IFCHR:
> +				case S_IFBLK:
> +				case S_IFIFO:
> +				case S_IFSOCK:
> +					retval = do_mknod_internal(fs, dirinode, name,
> +								   st->st_mode, st->st_rdev);
> +					if (retval) {
> +						com_err(__func__, retval,
> +							_("while creating special file "
> +							  "\"%s\""), name);
> +						goto out;
> +					}
> +					break;
> +				case S_IFLNK:
> +					ln_target = calloc(1, __rndup(strlen(dl_archive_entry_symlink(entry)), 1024));
> +					strcpy(ln_target, dl_archive_entry_symlink(entry));
> +					retval = do_symlink_internal(fs, dirinode, name,
> +									 ln_target, root);
> +					free(ln_target);
> +					if (retval) {
> +						com_err(__func__, retval,
> +							_("while writing symlink\"%s\""),
> +							name);
> +						goto out;
> +					}
> +					break;
> +				case S_IFREG:
> +					retval = do_write_internal_tar(fs, dirinode, a, name, st);
> +					if (retval) {
> +						com_err(__func__, retval,
> +							_("while writing file \"%s\""), name);
> +						goto out;
> +					}
> +					break;
> +				case S_IFDIR:
> +					retval = do_mkdir_internal(fs, dirinode, name, root);
> +					if (retval) {
> +						com_err(__func__, retval,
> +							_("while making dir \"%s\""), name);
> +						goto out;
> +					}
> +					break;
> +				default:
> +					if (dl_archive_entry_hardlink(entry) != NULL) {
> +						if(retval = __find_path(fs, root_ino, dl_archive_entry_hardlink(entry), &tmpino)) {
> +							com_err(__func__, retval,
> +								_("cannot find hardlink destination \"%s\" to create \"%s\""), dl_archive_entry_hardlink(entry), name);
> +							goto out;
> +						}
> +						retval = add_link(fs, dirinode,
> +								  tmpino,
> +								  name);
> +						if (retval) {
> +							com_err(__func__, retval,
> +								"while linking %s", name);
> +							goto out;
> +						}
> +					} else {
> +						com_err(__func__, 0,
> +							_("ignoring entry \"%s\""), dl_archive_entry_pathname(entry));
> +					}
> +			}
> +
> +			retval = ext2fs_namei(fs, root, dirinode, name, &tmpino);
> +			if (retval) {
> +				com_err(name, retval, _("while looking up \"%s\""),
> +					name);
> +				goto out;
> +			}
> +		}
> +
> +		retval = set_inode_extra(fs, tmpino, st);
> +		if (retval) {
> +			com_err(__func__, retval,
> +				_("while setting inode for \"%s\""), name);
> +			goto out;
> +		}
> +
> +		retval = set_inode_xattr_tar(fs, tmpino, entry);
> +		if (retval) {
> +			com_err(__func__, retval,
> +				_("while setting xattrs for \"%s\""), name);
> +			goto out;
> +		}
> +
> +		if (fs_callbacks && fs_callbacks->end_create_new_inode) {
> +			retval = fs_callbacks->end_create_new_inode(fs,
> +				target->path, name, dirinode, root,
> +				st->st_mode & S_IFMT);
> +			if (retval)
> +				goto out;
> +		}
> +
> +		free(path2);
> +		free(path3);
> +	}
> +
> +out:
> +	dl_archive_read_close(a);
> +	dl_archive_read_free(a);
> +	uselocale(old_locale);
> +	freelocale(archive_locale);
> +	return retval;
> +}
> +#endif
> +
>  errcode_t populate_fs2(ext2_filsys fs, ext2_ino_t parent_ino,
> -		       const char *source_dir, ext2_ino_t root,
> +		       const char *source, ext2_ino_t root,
>  		       struct fs_ops_callbacks *fs_callbacks)
>  {
>  	struct file_info file_info;
> @@ -1069,14 +1648,44 @@ errcode_t populate_fs2(ext2_filsys fs, ext2_ino_t parent_ino,
>  	file_info.path_max_len = 255;
>  	file_info.path = calloc(file_info.path_max_len, 1);
>  
> -	retval = set_inode_xattr(fs, root, source_dir);
> +	/* interpret input as tarball either if it's "-" (stdin) or if it's
> +	 * a regular file (or a symlink pointing to a regular file) */
> +	if (strcmp(source, "-") == 0) {
> +#ifdef HAVE_ARCHIVE_H
> +		retval = __populate_fs_from_tar(fs, parent_ino, NULL, root, &hdlinks,
> +					   &file_info, fs_callbacks);
> +#else
> +		com_err(__func__, 0, _("you need to compile e2fsprogs with libarchive to be able to process tarballs"));
> +		retval = 1;
> +#endif
> +		goto out;
> +	} else {
> +		struct stat st;
> +		if (stat(source, &st)) {
> +			retval = errno;
> +			com_err(__func__, retval, _("while calling stat"));
> +			return retval;
> +		}
> +		if (S_ISREG(st.st_mode)) {
> +#ifdef HAVE_ARCHIVE_H
> +			retval = __populate_fs_from_tar(fs, parent_ino, source, root, &hdlinks,
> +						   &file_info, fs_callbacks);
> +#else
> +			com_err(__func__, 0, _("you need to compile e2fsprogs with libarchive to be able to process tarballs"));
> +			retval = 1;
> +#endif
> +			goto out;
> +		}
> +	}
> +
> +	retval = set_inode_xattr(fs, root, source);
>  	if (retval) {
>  		com_err(__func__, retval,
>  			_("while copying xattrs on root directory"));
>  		goto out;
>  	}
>  
> -	retval = __populate_fs(fs, parent_ino, source_dir, root, &hdlinks,
> +	retval = __populate_fs(fs, parent_ino, source, root, &hdlinks,
>  			       &file_info, fs_callbacks);
>  
>  out:
> @@ -1086,7 +1695,7 @@ out:
>  }
>  
>  errcode_t populate_fs(ext2_filsys fs, ext2_ino_t parent_ino,
> -		      const char *source_dir, ext2_ino_t root)
> +		      const char *source, ext2_ino_t root)
>  {
> -	return populate_fs2(fs, parent_ino, source_dir, root, NULL);
> +	return populate_fs2(fs, parent_ino, source, root, NULL);
>  }
> diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
> index 30f97bb5..744e9b11 100644
> --- a/misc/mke2fs.8.in
> +++ b/misc/mke2fs.8.in
> @@ -23,7 +23,7 @@ mke2fs \- create an ext2/ext3/ext4 file system
>  ]
>  [
>  .B \-d
> -.I root-directory
> +.I root-directory|tarball
>  ]
>  [
>  .B \-D
> @@ -239,9 +239,11 @@ enabled.  (See the
>  man page for more details about bigalloc.)   The default cluster size if
>  bigalloc is enabled is 16 times the block size.
>  .TP
> -.BI \-d " root-directory"
> -Copy the contents of the given directory into the root directory of the
> -file system.
> +.BI \-d " root-directory|tarball"
> +Copy the contents of the given directory or tarball into the root directory of the
> +file system. Tarball input is only available if mke2fs was compiled with
> +libarchive support enabled and if the libarchive shared library is available
> +at run-time. The special value "-" will read a tarball from standard input.
>  .TP
>  .B \-D
>  Use direct I/O when writing to the disk.  This avoids mke2fs dirtying a
> diff --git a/misc/mke2fs.c b/misc/mke2fs.c
> index 4a9c1b09..4ffa9748 100644
> --- a/misc/mke2fs.c
> +++ b/misc/mke2fs.c
> @@ -117,7 +117,7 @@ static char *mount_dir;
>  char *journal_device;
>  static int sync_kludge;	/* Set using the MKE2FS_SYNC env. option */
>  char **fs_types;
> -const char *src_root_dir;  /* Copy files from the specified directory */
> +const char *src_root;  /* Copy files from the specified directory or tarball */
>  static char *undo_file;
>  
>  static int android_sparse_file; /* -E android_sparse */
> @@ -134,7 +134,7 @@ static void usage(void)
>  	"[-C cluster-size]\n\t[-i bytes-per-inode] [-I inode-size] "
>  	"[-J journal-options]\n"
>  	"\t[-G flex-group-size] [-N number-of-inodes] "
> -	"[-d root-directory]\n"
> +	"[-d root-directory|tarball]\n"
>  	"\t[-m reserved-blocks-percentage] [-o creator-os]\n"
>  	"\t[-g blocks-per-group] [-L volume-label] "
>  	"[-M last-mounted-directory]\n\t[-O feature[,...]] "
> @@ -1712,7 +1712,7 @@ profile_error:
>  			}
>  			break;
>  		case 'd':
> -			src_root_dir = optarg;
> +			src_root = optarg;
>  			break;
>  		case 'D':
>  			direct_io = 1;
> @@ -3551,12 +3551,12 @@ no_journal:
>  	retval = mk_hugefiles(fs, device_name);
>  	if (retval)
>  		com_err(program_name, retval, "while creating huge files");
> -	/* Copy files from the specified directory */
> -	if (src_root_dir) {
> +	/* Copy files from the specified directory or tarball */
> +	if (src_root) {
>  		if (!quiet)
>  			printf("%s", _("Copying files into the device: "));
>  
> -		retval = populate_fs(fs, EXT2_ROOT_INO, src_root_dir,
> +		retval = populate_fs(fs, EXT2_ROOT_INO, src_root,
>  				     EXT2_ROOT_INO);
>  		if (retval) {
>  			com_err(program_name, retval, "%s",
> diff --git a/tests/m_rootgnutar/expect b/tests/m_rootgnutar/expect
> new file mode 100644
> index 00000000..336e159e
> --- /dev/null
> +++ b/tests/m_rootgnutar/expect
> @@ -0,0 +1,188 @@
> +Filesystem volume name:   <none>
> +Last mounted on:          <not available>
> +Filesystem magic number:  0xEF53
> +Filesystem revision #:    1 (dynamic)
> +Filesystem features:      has_journal ext_attr resize_inode dir_index filetype extent 64bit flex_bg sparse_super huge_file dir_nlink extra_isize metadata_csum
> +Default mount options:    (none)
> +Filesystem state:         clean
> +Errors behavior:          Continue
> +Filesystem OS type:       Linux
> +Inode count:              1024
> +Block count:              16384
> +Reserved block count:     819
> +Overhead clusters:        1543
> +Free blocks:              14791
> +Free inodes:              1005
> +First block:              1
> +Block size:               1024
> +Fragment size:            1024
> +Group descriptor size:    64
> +Reserved GDT blocks:      127
> +Blocks per group:         8192
> +Fragments per group:      8192
> +Inodes per group:         512
> +Inode blocks per group:   128
> +Flex block group size:    16
> +Mount count:              0
> +Check interval:           15552000 (6 months)
> +Reserved blocks uid:      0
> +Reserved blocks gid:      0
> +First inode:              11
> +Inode size:	          256
> +Required extra isize:     32
> +Desired extra isize:      32
> +Journal inode:            8
> +Default directory hash:   half_md4
> +Journal backup:           inode blocks
> +Checksum type:            crc32c
> +Journal features:         (none)
> +Total journal size:       1024k
> +Total journal blocks:     1024
> +Max transaction length:   1024
> +Fast commit length:       0
> +Journal sequence:         0x00000001
> +Journal start:            0
> +
> +
> +Group 0: (Blocks 1-8192)
> +  Primary superblock at 1, Group descriptors at 2-2
> +  Reserved GDT blocks at 3-129
> +  Block bitmap at 130 (+129)
> +  Inode bitmap at 132 (+131)
> +  Inode table at 134-261 (+133)
> +  7753 free blocks, 493 free inodes, 5 directories, 493 unused inodes
> +  Free blocks: 440-8192
> +  Free inodes: 20-512
> +Group 1: (Blocks 8193-16383) [INODE_UNINIT]
> +  Backup superblock at 8193, Group descriptors at 8194-8194
> +  Reserved GDT blocks at 8195-8321
> +  Block bitmap at 131 (bg #0 + 130)
> +  Inode bitmap at 133 (bg #0 + 132)
> +  Inode table at 262-389 (bg #0 + 261)
> +  7038 free blocks, 512 free inodes, 0 directories, 512 unused inodes
> +  Free blocks: 9346-16383
> +  Free inodes: 513-1024
> +debugfs: stat /test/emptyfile
> +Inode: III   Type: regular    
> +Size: 0
> +Fragment:  Address: 0    Number: 0    Size: 0
> +debugfs: stat /test/bigfile
> +Inode: III   Type: regular    
> +Size: 32768
> +Fragment:  Address: 0    Number: 0    Size: 0
> +debugfs: stat /test/zerofile
> +Inode: III   Type: regular    
> +Size: 1025
> +Fragment:  Address: 0    Number: 0    Size: 0
> +debugfs: stat /test/silly_bs_link
> +Inode: III   Type: symlink    
> +Size: 14
> +Fragment:  Address: 0    Number: 0    Size: 0
> +debugfs: stat /test/emptydir
> +Inode: III   Type: directory    
> +Size: 1024
> +Fragment:  Address: 0    Number: 0    Size: 0
> +debugfs: stat /test/dir
> +Inode: III   Type: directory    
> +Size: 1024
> +Fragment:  Address: 0    Number: 0    Size: 0
> +debugfs: stat /test/dir/file
> +Inode: III   Type: regular    
> +Size: 8
> +Fragment:  Address: 0    Number: 0    Size: 0
> +debugfs: ex /test/emptyfile
> +Level Entries       Logical      Physical Length Flags
> +debugfs: ex /test/bigfile
> +Level Entries       Logical      Physical Length Flags
> +X 0/0 1/1 0-31 AAA-BBB 32 
> +debugfs: ex /test/zerofile
> +Level Entries       Logical      Physical Length Flags
> +debugfs: ex /test/silly_bs_link
> +/test/silly_bs_link: does not uses extent block maps
> +debugfs: ex /test/emptydir
> +Level Entries       Logical      Physical Length Flags
> +X 0/0 1/1 0-0 AAA-BBB 1 
> +debugfs: ex /test/dir
> +Level Entries       Logical      Physical Length Flags
> +X 0/0 1/1 0-0 AAA-BBB 1 
> +debugfs: ex /test/dir/file
> +Level Entries       Logical      Physical Length Flags
> +X 0/0 1/1 0-0 AAA-BBB 1 
> +Filesystem volume name:   <none>
> +Last mounted on:          <not available>
> +Filesystem magic number:  0xEF53
> +Filesystem revision #:    1 (dynamic)
> +Filesystem features:      has_journal ext_attr resize_inode dir_index filetype extent 64bit flex_bg sparse_super huge_file dir_nlink extra_isize metadata_csum
> +Default mount options:    (none)
> +Filesystem state:         clean
> +Errors behavior:          Continue
> +Filesystem OS type:       Linux
> +Inode count:              1024
> +Block count:              16384
> +Reserved block count:     819
> +Overhead clusters:        1543
> +Free blocks:              14791
> +Free inodes:              1005
> +First block:              1
> +Block size:               1024
> +Fragment size:            1024
> +Group descriptor size:    64
> +Reserved GDT blocks:      127
> +Blocks per group:         8192
> +Fragments per group:      8192
> +Inodes per group:         512
> +Inode blocks per group:   128
> +Flex block group size:    16
> +Mount count:              0
> +Check interval:           15552000 (6 months)
> +Reserved blocks uid:      0
> +Reserved blocks gid:      0
> +First inode:              11
> +Inode size:	          256
> +Required extra isize:     32
> +Desired extra isize:      32
> +Journal inode:            8
> +Default directory hash:   half_md4
> +Journal backup:           inode blocks
> +Checksum type:            crc32c
> +Journal features:         (none)
> +Total journal size:       1024k
> +Total journal blocks:     1024
> +Max transaction length:   1024
> +Fast commit length:       0
> +Journal sequence:         0x00000001
> +Journal start:            0
> +
> +
> +Group 0: (Blocks 1-8192)
> +  Primary superblock at 1, Group descriptors at 2-2
> +  Reserved GDT blocks at 3-129
> +  Block bitmap at 130 (+129)
> +  Inode bitmap at 132 (+131)
> +  Inode table at 134-261 (+133)
> +  7753 free blocks, 493 free inodes, 5 directories, 493 unused inodes
> +  Free blocks: 440-8192
> +  Free inodes: 20-512
> +Group 1: (Blocks 8193-16383) [INODE_UNINIT]
> +  Backup superblock at 8193, Group descriptors at 8194-8194
> +  Reserved GDT blocks at 8195-8321
> +  Block bitmap at 131 (bg #0 + 130)
> +  Inode bitmap at 133 (bg #0 + 132)
> +  Inode table at 262-389 (bg #0 + 261)
> +  7038 free blocks, 512 free inodes, 0 directories, 512 unused inodes
> +  Free blocks: 9346-16383
> +  Free inodes: 513-1024
> +test/
> +test/bigfile
> +test/dir/
> +test/dir/file
> +test/emptydir/
> +test/emptyfile
> +test/silly_bs_link
> +test/zerofile
> +Pass 1: Checking inodes, blocks, and sizes
> +Pass 2: Checking directory structure
> +Pass 3: Checking directory connectivity
> +Pass 4: Checking reference counts
> +Pass 5: Checking group summary information
> +test.img: 19/1024 files (0.0% non-contiguous), 1593/16384 blocks
> diff --git a/tests/m_rootgnutar/output.sed b/tests/m_rootgnutar/output.sed
> new file mode 100644
> index 00000000..2e769678
> --- /dev/null
> +++ b/tests/m_rootgnutar/output.sed
> @@ -0,0 +1,5 @@
> +s/^[[:space:]]*\([0-9]*\)\/[[:space:]]*\([0-9]*\)[[:space:]]*\([0-9]*\)\/[[:space:]]*\([0-9]*\)[[:space:]]*\([0-9]*\)[[:space:]]*-[[:space:]]*\([0-9]*\)[[:space:]]*[0-9]*[[:space:]]*-[[:space:]]*[0-9]*[[:space:]]*\([0-9]*\)/X \1\/\2 \3\/\4 \5-\6 AAA-BBB \7/g
> +s/^[[:space:]]*\([0-9]*\)\/[[:space:]]*\([0-9]*\)[[:space:]]*\([0-9]*\)\/[[:space:]]*\([0-9]*\)[[:space:]]*\([0-9]*\)[[:space:]]*-[[:space:]]*\([0-9]*\)[[:space:]]*[0-9]*[[:space:]]*\([0-9]*\)/Y \1\/\2 \3\/\4 \5-\6 AAA \7/g
> +s/Mode:.*$//g
> +s/User:.*Size:/Size:/g
> +s/^Inode: [0-9]*/Inode: III/g
> diff --git a/tests/m_rootgnutar/script b/tests/m_rootgnutar/script
> new file mode 100644
> index 00000000..949d9b5f
> --- /dev/null
> +++ b/tests/m_rootgnutar/script
> @@ -0,0 +1,88 @@
> +# vim: filetype=sh
> +
> +test_description="create fs image from GNU tarball"
> +if ! test -x $DEBUGFS_EXE; then
> +	echo "$test_name: $test_description: skipped (no debugfs)"
> +	return 0
> +fi
> +if [ "$(grep -c 'define HAVE_ARCHIVE_H' ../lib/config.h)" -eq 0 ]; then
> +	echo "$test_name: skipped (no libarchive)"
> +	exit 0
> +fi
> +
> +MKFS_TAR=$TMPFILE.tar
> +MKFS_DIR=$TMPFILE.dir
> +OUT=$test_name.log
> +EXP=$test_dir/expect
> +
> +# we put everything in a subdir because we cannot rdump the root as that would
> +# require permissions to changing ownership of /lost+found
> +rm -rf $MKFS_DIR
> +mkdir -p $MKFS_DIR/test
> +touch $MKFS_DIR/test/emptyfile
> +dd if=/dev/zero bs=1024 count=32 2> /dev/null | tr '\0' 'a' > $MKFS_DIR/test/bigfile
> +dd if=/dev/zero of=$MKFS_DIR/test/zerofile bs=1 count=1 seek=1024 2> /dev/null
> +ln -s /silly_bs_link $MKFS_DIR/test/silly_bs_link
> +mkdir $MKFS_DIR/test/emptydir
> +mkdir $MKFS_DIR/test/dir
> +echo "Test me" > $MKFS_DIR/test/dir/file
> +
> +tar --sort=name -C $MKFS_DIR --format=gnu -cf $MKFS_TAR test
> +rm -r $MKFS_DIR
> +
> +$MKE2FS -q -F -o Linux -T ext4 -O metadata_csum,64bit -E lazy_itable_init=1 -b 1024 -d $MKFS_TAR $TMPFILE 16384 > $OUT 2>&1
> +
> +$DUMPE2FS $TMPFILE >> $OUT 2>&1
> +cat > $TMPFILE.cmd << ENDL
> +stat /test/emptyfile
> +stat /test/bigfile
> +stat /test/zerofile
> +stat /test/silly_bs_link
> +stat /test/emptydir
> +stat /test/dir
> +stat /test/dir/file
> +ENDL
> +$DEBUGFS -f $TMPFILE.cmd $TMPFILE 2>&1 | egrep "(stat|Size:|Type:)" >> $OUT
> +
> +cat > $TMPFILE.cmd << ENDL
> +ex /test/emptyfile
> +ex /test/bigfile
> +ex /test/zerofile
> +ex /test/silly_bs_link
> +ex /test/emptydir
> +ex /test/dir
> +ex /test/dir/file
> +ENDL
> +$DEBUGFS -f $TMPFILE.cmd $TMPFILE >> $OUT 2>&1
> +
> +$DUMPE2FS $TMPFILE >> $OUT 2>&1
> +
> +$DEBUGFS -R "dump /test/dir/file $TMPFILE.testme" $TMPFILE >> $OUT 2>&1
> +
> +# extract the files and directories from the image and tar them again to make
> +# sure that a tarball from the image contents is bit-by-bit identical to the
> +# tarball the image was created from -- essentially this checks whether a
> +# roundtrip from tar to ext4 to tar remains identical
> +mkdir "$MKFS_DIR"
> +$DEBUGFS -R "rdump /test $MKFS_DIR" $TMPFILE >> $OUT 2>&1
> +tar --sort=name -C $MKFS_DIR --format=gnu -cvf $TMPFILE.new.tar test >> $OUT 2>&1
> +
> +$FSCK -f -n $TMPFILE >> $OUT 2>&1
> +
> +sed -f $cmd_dir/filter.sed -f $test_dir/output.sed -e "s;$TMPFILE;test.img;" < $OUT > $OUT.tmp
> +mv $OUT.tmp $OUT
> +
> +# Do the verification
> +cmp -s $OUT $EXP && echo "Test me" | cmp -s - $TMPFILE.testme && cmp $MKFS_TAR $TMPFILE.new.tar
> +status=$?
> +
> +if [ "$status" = 0 ] ; then
> +	echo "$test_name: $test_description: ok"
> +	touch $test_name.ok
> +else
> +	echo "$test_name: $test_description: failed"
> +	diff $DIFF_OPTS $EXP $OUT > $test_name.failed
> +fi
> +
> +rm -rf $MKFS_TAR $MKFS_DIR $TMPFILE.cmd $TMPFILE.test_rel.c $TMPFILE.new.tar
> +unset MKFS_TAR MKFS_DIR OUT EXP
> diff --git a/tests/m_rootpaxtar/expect b/tests/m_rootpaxtar/expect
> new file mode 100644
> index 00000000..54a2d4b6
> --- /dev/null
> +++ b/tests/m_rootpaxtar/expect
> @@ -0,0 +1,87 @@
> +Filesystem volume name:   <none>
> +Last mounted on:          <not available>
> +Filesystem magic number:  0xEF53
> +Filesystem revision #:    1 (dynamic)
> +Filesystem features:      has_journal ext_attr resize_inode dir_index filetype extent 64bit flex_bg sparse_super huge_file dir_nlink extra_isize metadata_csum
> +Default mount options:    (none)
> +Filesystem state:         clean
> +Errors behavior:          Continue
> +Filesystem OS type:       Linux
> +Inode count:              1024
> +Block count:              16384
> +Reserved block count:     819
> +Overhead clusters:        1543
> +Free blocks:              14827
> +Free inodes:              1012
> +First block:              1
> +Block size:               1024
> +Fragment size:            1024
> +Group descriptor size:    64
> +Reserved GDT blocks:      127
> +Blocks per group:         8192
> +Fragments per group:      8192
> +Inodes per group:         512
> +Inode blocks per group:   128
> +Flex block group size:    16
> +Mount count:              0
> +Check interval:           15552000 (6 months)
> +Reserved blocks uid:      0
> +Reserved blocks gid:      0
> +First inode:              11
> +Inode size:	          256
> +Required extra isize:     32
> +Desired extra isize:      32
> +Journal inode:            8
> +Default directory hash:   half_md4
> +Journal backup:           inode blocks
> +Checksum type:            crc32c
> +Journal features:         (none)
> +Total journal size:       1024k
> +Total journal blocks:     1024
> +Max transaction length:   1024
> +Fast commit length:       0
> +Journal sequence:         0x00000001
> +Journal start:            0
> +
> +
> +Group 0: (Blocks 1-8192)
> +  Primary superblock at 1, Group descriptors at 2-2
> +  Reserved GDT blocks at 3-129
> +  Block bitmap at 130 (+129)
> +  Inode bitmap at 132 (+131)
> +  Inode table at 134-261 (+133)
> +  7789 free blocks, 500 free inodes, 2 directories, 500 unused inodes
> +  Free blocks: 404-8192
> +  Free inodes: 13-512
> +Group 1: (Blocks 8193-16383) [INODE_UNINIT]
> +  Backup superblock at 8193, Group descriptors at 8194-8194
> +  Reserved GDT blocks at 8195-8321
> +  Block bitmap at 131 (bg #0 + 130)
> +  Inode bitmap at 133 (bg #0 + 132)
> +  Inode table at 262-389 (bg #0 + 261)
> +  7038 free blocks, 512 free inodes, 0 directories, 512 unused inodes
> +  Free blocks: 9346-16383
> +  Free inodes: 513-1024
> +debugfs: stat /file
> +Inode: III   Type: regular    
> +Generation: 0    Version: 0x00000000:00000000
> +Size: 0
> +File ACL: 0
> +Links: 1   Blockcount: 0
> +Fragment:  Address: 0    Number: 0    Size: 0
> + ctime: 0x00000000:00000000 -- Thu Jan  1 00:00:00 1970
> + atime: 0x00000000:00000000 -- Thu Jan  1 00:00:00 1970
> + mtime: 0x00000000:00000000 -- Thu Jan  1 00:00:00 1970
> +Size of extra inode fields: 32
> +Extended attributes:
> +  security.capability (20) = 01 00 00 02 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> +EXTENTS:
> +debugfs: ea_list /file
> +Extended attributes:
> +  security.capability (20) = 01 00 00 02 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> +Pass 1: Checking inodes, blocks, and sizes
> +Pass 2: Checking directory structure
> +Pass 3: Checking directory connectivity
> +Pass 4: Checking reference counts
> +Pass 5: Checking group summary information
> +test.img: 12/1024 files (0.0% non-contiguous), 1557/16384 blocks
> diff --git a/tests/m_rootpaxtar/mkpaxtar.pl b/tests/m_rootpaxtar/mkpaxtar.pl
> new file mode 100644
> index 00000000..9152828b
> --- /dev/null
> +++ b/tests/m_rootpaxtar/mkpaxtar.pl
> @@ -0,0 +1,69 @@
> +#!/usr/bin/env perl
> +
> +use strict;
> +use warnings;
> +
> +my @entries = (
> +    # filename            mode      type content
> +    ['./PaxHeaders/file', oct(644), 'x', "57 SCHILY.xattr.security.capability=\x01\0\0\x02\0\x20\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x0a"],
> +    ['file',              oct(644), 0,   ''],
> +);
> +
> +my $num_entries = 0;
> +
> +foreach my $file (@entries) {
> +    my ( $fname, $mode, $type, $content) = @{$file};
> +    my $entry = pack(
> +        'a100 a8 a8 a8 a12 a12 A8 a1 a100 a6 a2 a32 a32 a8 a8 a155 x12',
> +        $fname,
> +        sprintf( '%07o',  $mode ),
> +        sprintf( '%07o',  0 ), # uid
> +        sprintf( '%07o',  0 ), # gid
> +        sprintf( '%011o', length $content ), # size
> +        sprintf( '%011o', 0 ), # mtime
> +        '',                    # checksum
> +        $type,
> +        '',                    # linkname
> +        "ustar",               # magic
> +        "00",                  # version
> +        '',                    # username
> +        '',                    # groupname
> +        '',                    # dev major
> +        '',                    # dev minor
> +        '',                    # prefix
> +    );
> +
> +    # compute and insert checksum
> +    substr( $entry, 148, 7 ) =
> +      sprintf( "%06o\0", unpack( "%16C*", $entry ) );
> +    print $entry;
> +    $num_entries += 1;
> +
> +    if (length $content) {
> +	print(pack 'a512', $content);
> +	$num_entries += 1;
> +    }
> +}
> +
> +# https://www.gnu.org/software/tar/manual/html_node/Standard.html
> +#
> +# Physically, an archive consists of a series of file entries terminated by an
> +# end-of-archive entry, which consists of two 512 blocks of zero bytes. At the
> +# end of the archive file there are two 512-byte blocks filled with binary
> +# zeros as an end-of-file marker.
> +
> +print(pack 'a512', '');
> +print(pack 'a512', '');
> +$num_entries += 2;
> +
> +# https://www.gnu.org/software/tar/manual/html_section/tar_76.html
> +#
> +# Some devices requires that all write operations be a multiple of a certain
> +# size, and so, tar pads the archive out to the next record boundary.
> +#
> +# The default blocking factor is 20. With a block size of 512 bytes, we get a
> +# record size of 10240.
> +
> +for (my $i = $num_entries; $i < 20; $i++) {
> +    print(pack 'a512', '');
> +}
> diff --git a/tests/m_rootpaxtar/output.sed b/tests/m_rootpaxtar/output.sed
> new file mode 100644
> index 00000000..2e769678
> --- /dev/null
> +++ b/tests/m_rootpaxtar/output.sed
> @@ -0,0 +1,5 @@
> +s/^[[:space:]]*\([0-9]*\)\/[[:space:]]*\([0-9]*\)[[:space:]]*\([0-9]*\)\/[[:space:]]*\([0-9]*\)[[:space:]]*\([0-9]*\)[[:space:]]*-[[:space:]]*\([0-9]*\)[[:space:]]*[0-9]*[[:space:]]*-[[:space:]]*[0-9]*[[:space:]]*\([0-9]*\)/X \1\/\2 \3\/\4 \5-\6 AAA-BBB \7/g
> +s/^[[:space:]]*\([0-9]*\)\/[[:space:]]*\([0-9]*\)[[:space:]]*\([0-9]*\)\/[[:space:]]*\([0-9]*\)[[:space:]]*\([0-9]*\)[[:space:]]*-[[:space:]]*\([0-9]*\)[[:space:]]*[0-9]*[[:space:]]*\([0-9]*\)/Y \1\/\2 \3\/\4 \5-\6 AAA \7/g
> +s/Mode:.*$//g
> +s/User:.*Size:/Size:/g
> +s/^Inode: [0-9]*/Inode: III/g
> diff --git a/tests/m_rootpaxtar/script b/tests/m_rootpaxtar/script
> new file mode 100644
> index 00000000..41dc7c38
> --- /dev/null
> +++ b/tests/m_rootpaxtar/script
> @@ -0,0 +1,44 @@
> +# vim: filetype=sh
> +
> +test_description="create fs image from pax tarball with xattrs"
> +if ! test -x $DEBUGFS_EXE; then
> +	echo "$test_name: $test_description: skipped (no debugfs)"
> +	return 0
> +fi
> +if [ "$(grep -c 'define HAVE_ARCHIVE_H' ../lib/config.h)" -eq 0 ]; then
> +	echo "$test_name: skipped (no libarchive)"
> +	exit 0
> +fi
> +
> +OUT=$test_name.log
> +EXP=$test_dir/expect
> +
> +perl $test_dir/mkpaxtar.pl \
> +	| $MKE2FS -q -F -o Linux -T ext4 -O metadata_csum,64bit -E lazy_itable_init=1 -b 1024 -d - $TMPFILE 16384 > $OUT 2>&1
> +
> +$DUMPE2FS $TMPFILE >> $OUT 2>&1
> +cat > $TMPFILE.cmd << ENDL
> +stat /file
> +ea_list /file
> +ENDL
> +$DEBUGFS -f $TMPFILE.cmd $TMPFILE 2>&1 | egrep -v '^(crtime|Inode checksum):' >> $OUT
> +
> +$FSCK -f -n $TMPFILE >> $OUT 2>&1
> +
> +sed -f $cmd_dir/filter.sed -f $test_dir/output.sed -e "s;$TMPFILE;test.img;" < $OUT > $OUT.tmp
> +mv $OUT.tmp $OUT
> +
> +# Do the verification
> +cmp -s $OUT $EXP
> +status=$?
> +
> +if [ "$status" = 0 ] ; then
> +	echo "$test_name: $test_description: ok"
> +	touch $test_name.ok
> +else
> +        echo "$test_name: $test_description: failed"
> +        diff $DIFF_OPTS $EXP $OUT > $test_name.failed
> +fi
> +
> +rm -rf $TMPFILE.cmd
> +unset OUT EXP
> diff --git a/tests/m_roottar/expect b/tests/m_roottar/expect
> new file mode 100644
> index 00000000..78e86c55
> --- /dev/null
> +++ b/tests/m_roottar/expect
> @@ -0,0 +1,208 @@
> +Filesystem volume name:   <none>
> +Last mounted on:          <not available>
> +Filesystem magic number:  0xEF53
> +Filesystem revision #:    1 (dynamic)
> +Filesystem features:      has_journal ext_attr resize_inode dir_index filetype extent 64bit flex_bg sparse_super huge_file dir_nlink extra_isize metadata_csum
> +Default mount options:    (none)
> +Filesystem state:         clean
> +Errors behavior:          Continue
> +Filesystem OS type:       Linux
> +Inode count:              1024
> +Block count:              16384
> +Reserved block count:     819
> +Overhead clusters:        1543
> +Free blocks:              14824
> +Free inodes:              998
> +First block:              1
> +Block size:               1024
> +Fragment size:            1024
> +Group descriptor size:    64
> +Reserved GDT blocks:      127
> +Blocks per group:         8192
> +Fragments per group:      8192
> +Inodes per group:         512
> +Inode blocks per group:   128
> +Flex block group size:    16
> +Mount count:              0
> +Check interval:           15552000 (6 months)
> +Reserved blocks uid:      0
> +Reserved blocks gid:      0
> +First inode:              11
> +Inode size:	          256
> +Required extra isize:     32
> +Desired extra isize:      32
> +Journal inode:            8
> +Default directory hash:   half_md4
> +Journal backup:           inode blocks
> +Checksum type:            crc32c
> +Journal features:         (none)
> +Total journal size:       1024k
> +Total journal blocks:     1024
> +Max transaction length:   1024
> +Fast commit length:       0
> +Journal sequence:         0x00000001
> +Journal start:            0
> +
> +
> +Group 0: (Blocks 1-8192)
> +  Primary superblock at 1, Group descriptors at 2-2
> +  Reserved GDT blocks at 3-129
> +  Block bitmap at 130 (+129)
> +  Inode bitmap at 132 (+131)
> +  Inode table at 134-261 (+133)
> +  7786 free blocks, 486 free inodes, 5 directories, 486 unused inodes
> +  Free blocks: 407-8192
> +  Free inodes: 27-512
> +Group 1: (Blocks 8193-16383) [INODE_UNINIT]
> +  Backup superblock at 8193, Group descriptors at 8194-8194
> +  Reserved GDT blocks at 8195-8321
> +  Block bitmap at 131 (bg #0 + 130)
> +  Inode bitmap at 133 (bg #0 + 132)
> +  Inode table at 262-389 (bg #0 + 261)
> +  7038 free blocks, 512 free inodes, 0 directories, 512 unused inodes
> +  Free blocks: 9346-16383
> +  Free inodes: 513-1024
> +debugfs: stat /dev/
> +Inode: III   Type: directory    
> +Generation: 0    Version: 0x00000000:00000000
> +Size: 1024
> +File ACL: 0
> +Links: 4   Blockcount: 2
> +Fragment:  Address: 0    Number: 0    Size: 0
> +Size of extra inode fields: 32
> +EXTENTS:
> +(0):404
> +debugfs: stat /dev/console
> +Inode: III   Type: character special    
> +Generation: 0    Version: 0x00000000:00000000
> +Size: 0
> +File ACL: 0
> +Links: 1   Blockcount: 0
> +Fragment:  Address: 0    Number: 0    Size: 0
> +Size of extra inode fields: 32
> +Device major/minor number: 05:01 (hex 05:01)
> +debugfs: stat /dev/fd
> +Inode: III   Type: symlink    
> +Generation: 0    Version: 0x00000000:00000000
> +Size: 13
> +File ACL: 0
> +Links: 1   Blockcount: 0
> +Fragment:  Address: 0    Number: 0    Size: 0
> +Size of extra inode fields: 32
> +Fast link dest: "/proc/self/fd"
> +debugfs: stat /dev/full
> +Inode: III   Type: character special    
> +Generation: 0    Version: 0x00000000:00000000
> +Size: 0
> +File ACL: 0
> +Links: 1   Blockcount: 0
> +Fragment:  Address: 0    Number: 0    Size: 0
> +Size of extra inode fields: 32
> +Device major/minor number: 01:07 (hex 01:07)
> +debugfs: stat /dev/null
> +Inode: III   Type: character special    
> +Generation: 0    Version: 0x00000000:00000000
> +Size: 0
> +File ACL: 0
> +Links: 1   Blockcount: 0
> +Fragment:  Address: 0    Number: 0    Size: 0
> +Size of extra inode fields: 32
> +Device major/minor number: 01:03 (hex 01:03)
> +debugfs: stat /dev/ptmx
> +Inode: III   Type: character special    
> +Generation: 0    Version: 0x00000000:00000000
> +Size: 0
> +File ACL: 0
> +Links: 1   Blockcount: 0
> +Fragment:  Address: 0    Number: 0    Size: 0
> +Size of extra inode fields: 32
> +Device major/minor number: 05:02 (hex 05:02)
> +debugfs: stat /dev/pts/
> +Inode: III   Type: directory    
> +Generation: 0    Version: 0x00000000:00000000
> +Size: 1024
> +File ACL: 0
> +Links: 2   Blockcount: 2
> +Fragment:  Address: 0    Number: 0    Size: 0
> +Size of extra inode fields: 32
> +EXTENTS:
> +(0):405
> +debugfs: stat /dev/random
> +Inode: III   Type: character special    
> +Generation: 0    Version: 0x00000000:00000000
> +Size: 0
> +File ACL: 0
> +Links: 1   Blockcount: 0
> +Fragment:  Address: 0    Number: 0    Size: 0
> +Size of extra inode fields: 32
> +Device major/minor number: 01:08 (hex 01:08)
> +debugfs: stat /dev/shm/
> +Inode: III   Type: directory    
> +Generation: 0    Version: 0x00000000:00000000
> +Size: 1024
> +File ACL: 0
> +Links: 2   Blockcount: 2
> +Fragment:  Address: 0    Number: 0    Size: 0
> +Size of extra inode fields: 32
> +EXTENTS:
> +(0):406
> +debugfs: stat /dev/stderr
> +Inode: III   Type: symlink    
> +Generation: 0    Version: 0x00000000:00000000
> +Size: 15
> +File ACL: 0
> +Links: 1   Blockcount: 0
> +Fragment:  Address: 0    Number: 0    Size: 0
> +Size of extra inode fields: 32
> +Fast link dest: "/proc/self/fd/2"
> +debugfs: stat /dev/stdin
> +Inode: III   Type: symlink    
> +Generation: 0    Version: 0x00000000:00000000
> +Size: 15
> +File ACL: 0
> +Links: 1   Blockcount: 0
> +Fragment:  Address: 0    Number: 0    Size: 0
> +Size of extra inode fields: 32
> +Fast link dest: "/proc/self/fd/0"
> +debugfs: stat /dev/stdout
> +Inode: III   Type: symlink    
> +Generation: 0    Version: 0x00000000:00000000
> +Size: 15
> +File ACL: 0
> +Links: 1   Blockcount: 0
> +Fragment:  Address: 0    Number: 0    Size: 0
> +Size of extra inode fields: 32
> +Fast link dest: "/proc/self/fd/1"
> +debugfs: stat /dev/tty
> +Inode: III   Type: character special    
> +Generation: 0    Version: 0x00000000:00000000
> +Size: 0
> +File ACL: 0
> +Links: 1   Blockcount: 0
> +Fragment:  Address: 0    Number: 0    Size: 0
> +Size of extra inode fields: 32
> +Device major/minor number: 05:00 (hex 05:00)
> +debugfs: stat /dev/urandom
> +Inode: III   Type: character special    
> +Generation: 0    Version: 0x00000000:00000000
> +Size: 0
> +File ACL: 0
> +Links: 1   Blockcount: 0
> +Fragment:  Address: 0    Number: 0    Size: 0
> +Size of extra inode fields: 32
> +Device major/minor number: 01:09 (hex 01:09)
> +debugfs: stat /dev/zero
> +Inode: III   Type: character special    
> +Generation: 0    Version: 0x00000000:00000000
> +Size: 0
> +File ACL: 0
> +Links: 1   Blockcount: 0
> +Fragment:  Address: 0    Number: 0    Size: 0
> +Size of extra inode fields: 32
> +Device major/minor number: 01:05 (hex 01:05)
> +Pass 1: Checking inodes, blocks, and sizes
> +Pass 2: Checking directory structure
> +Pass 3: Checking directory connectivity
> +Pass 4: Checking reference counts
> +Pass 5: Checking group summary information
> +test.img: 26/1024 files (0.0% non-contiguous), 1560/16384 blocks
> diff --git a/tests/m_roottar/mktar.pl b/tests/m_roottar/mktar.pl
> new file mode 100644
> index 00000000..3a555afe
> --- /dev/null
> +++ b/tests/m_roottar/mktar.pl
> @@ -0,0 +1,62 @@
> +#!/usr/bin/env perl
> +
> +use strict;
> +use warnings;
> +
> +# type codes:
> +#   0 -> normal file
> +#   1 -> hardlink
> +#   2 -> symlink
> +#   3 -> character special
> +#   4 -> block special
> +#   5 -> directory
> +my @devfiles = (
> +    # filename  mode      type link target        major  minor
> +    ["",        oct(755), 5,   '',                undef, undef],
> +    ["console", oct(666), 3,   '',                5,     1],
> +    ["fd",      oct(777), 2,   '/proc/self/fd',   undef, undef],
> +    ["full",    oct(666), 3,   '',                1,     7],
> +    ["null",    oct(666), 3,   '',                1,     3],
> +    ["ptmx",    oct(666), 3,   '',                5,     2],
> +    ["pts/",    oct(755), 5,   '',                undef, undef],
> +    ["random",  oct(666), 3,   '',                1,     8],
> +    ["shm/",    oct(755), 5,   '',                undef, undef],
> +    ["stderr",  oct(777), 2,   '/proc/self/fd/2', undef, undef],
> +    ["stdin",   oct(777), 2,   '/proc/self/fd/0', undef, undef],
> +    ["stdout",  oct(777), 2,   '/proc/self/fd/1', undef, undef],
> +    ["tty",     oct(666), 3,   '',                5,     0],
> +    ["urandom", oct(666), 3,   '',                1,     9],
> +    ["zero",    oct(666), 3,   '',                1,     5],
> +);
> +
> +my $mtime = time;
> +if (exists $ENV{SOURCE_DATE_EPOCH}) {
> +    $mtime = $ENV{SOURCE_DATE_EPOCH} + 0;
> +}
> +
> +foreach my $file (@devfiles) {
> +    my ( $fname, $mode, $type, $linkname, $devmajor, $devminor ) = @{$file};
> +    my $entry = pack(
> +        'a100 a8 a8 a8 a12 a12 A8 a1 a100 a8 a32 a32 a8 a8 a155 x12',
> +        "./dev/$fname",
> +        sprintf( '%07o',  $mode ),
> +        sprintf( '%07o',  0 ),        # uid
> +        sprintf( '%07o',  0 ),        # gid
> +        sprintf( '%011o', 0 ),        # size
> +        sprintf( '%011o', $mtime ),
> +        '',                           # checksum
> +        $type,
> +        $linkname,
> +        "ustar  ",
> +        '',                           # username
> +        '',                           # groupname
> +        defined($devmajor) ? sprintf( '%07o', $devmajor ) : '',
> +        defined($devminor) ? sprintf( '%07o', $devminor ) : '',
> +        '',                           # prefix
> +    );
> +
> +    # compute and insert checksum
> +    substr( $entry, 148, 7 ) =
> +      sprintf( "%06o\0", unpack( "%16C*", $entry ) );
> +    print $entry;
> +}
> diff --git a/tests/m_roottar/output.sed b/tests/m_roottar/output.sed
> new file mode 100644
> index 00000000..2e769678
> --- /dev/null
> +++ b/tests/m_roottar/output.sed
> @@ -0,0 +1,5 @@
> +s/^[[:space:]]*\([0-9]*\)\/[[:space:]]*\([0-9]*\)[[:space:]]*\([0-9]*\)\/[[:space:]]*\([0-9]*\)[[:space:]]*\([0-9]*\)[[:space:]]*-[[:space:]]*\([0-9]*\)[[:space:]]*[0-9]*[[:space:]]*-[[:space:]]*[0-9]*[[:space:]]*\([0-9]*\)/X \1\/\2 \3\/\4 \5-\6 AAA-BBB \7/g
> +s/^[[:space:]]*\([0-9]*\)\/[[:space:]]*\([0-9]*\)[[:space:]]*\([0-9]*\)\/[[:space:]]*\([0-9]*\)[[:space:]]*\([0-9]*\)[[:space:]]*-[[:space:]]*\([0-9]*\)[[:space:]]*[0-9]*[[:space:]]*\([0-9]*\)/Y \1\/\2 \3\/\4 \5-\6 AAA \7/g
> +s/Mode:.*$//g
> +s/User:.*Size:/Size:/g
> +s/^Inode: [0-9]*/Inode: III/g
> diff --git a/tests/m_roottar/script b/tests/m_roottar/script
> new file mode 100644
> index 00000000..134b9a2e
> --- /dev/null
> +++ b/tests/m_roottar/script
> @@ -0,0 +1,57 @@
> +# vim: filetype=sh
> +
> +test_description="create fs image from tarball"
> +if ! test -x $DEBUGFS_EXE; then
> +	echo "$test_name: $test_description: skipped (no debugfs)"
> +	return 0
> +fi
> +if [ "$(grep -c 'define HAVE_ARCHIVE_H' ../lib/config.h)" -eq 0 ]; then
> +	echo "$test_name: skipped (no libarchive)"
> +	exit 0
> +fi
> +
> +OUT=$test_name.log
> +EXP=$test_dir/expect
> +
> +perl $test_dir/mktar.pl \
> +	| $MKE2FS -q -F -o Linux -T ext4 -O metadata_csum,64bit -E lazy_itable_init=1 -b 1024 -d - $TMPFILE 16384 > $OUT 2>&1
> +
> +$DUMPE2FS $TMPFILE >> $OUT 2>&1
> +cat > $TMPFILE.cmd << ENDL
> +stat /dev/
> +stat /dev/console
> +stat /dev/fd
> +stat /dev/full
> +stat /dev/null
> +stat /dev/ptmx
> +stat /dev/pts/
> +stat /dev/random
> +stat /dev/shm/
> +stat /dev/stderr
> +stat /dev/stdin
> +stat /dev/stdout
> +stat /dev/tty
> +stat /dev/urandom
> +stat /dev/zero
> +ENDL
> +$DEBUGFS -f $TMPFILE.cmd $TMPFILE 2>&1 | egrep -v "(time|checksum):" >> $OUT
> +
> +$FSCK -f -n $TMPFILE >> $OUT 2>&1
> +
> +sed -f $cmd_dir/filter.sed -f $test_dir/output.sed -e "s;$TMPFILE;test.img;" < $OUT > $OUT.tmp
> +mv $OUT.tmp $OUT
> +
> +# Do the verification
> +cmp -s $OUT $EXP
> +status=$?
> +
> +if [ "$status" = 0 ] ; then
> +	echo "$test_name: $test_description: ok"
> +	touch $test_name.ok
> +else
> +        echo "$test_name: $test_description: failed"
> +        diff $DIFF_OPTS $EXP $OUT > $test_name.failed
> +fi
> +
> +rm -rf $TMPFILE.cmd
> +unset OUT EXP
> -- 
> 2.40.0
> 
