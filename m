Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BAA7A5610
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Sep 2023 01:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjIRXGc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Sep 2023 19:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIRXGc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Sep 2023 19:06:32 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4663110E5
        for <linux-ext4@vger.kernel.org>; Mon, 18 Sep 2023 16:06:24 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bf55a81eeaso37108345ad.0
        for <linux-ext4@vger.kernel.org>; Mon, 18 Sep 2023 16:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1695078383; x=1695683183; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=s8cEhM9oKmPPnfsLmQMoDwmGEq4+4P8VlN6gvizbqII=;
        b=cn16j52Jes8PccLe0BU9g8F5svQR+w9sB74ODdzqv3l1R+cr8cgr8FvwOs7tjiHHcJ
         YembUgBywOnY+purVAHwyzKYAd+Vn1MzekcL5jCe9e2F5yWeXGDsi702fBycoy9+SlMX
         r6ZFriswNTz3T92EZ5E6ODdtMf4+2ZueHzFLJvgJ+YHh908SZeJ3BFye6NqujL7KAQyp
         rDxwXDwCkhW8Ju2G6SxYsqudy9WO6mGs5GdrOSyEIznhM7l8x6lbbXwDtPQRYnV13xc+
         osxtVQ1Ovp4Amn9GNHcI/tsE6RLCl9b2SdLEgxva4/WP+zl7IKN5Zp3b34l7Vv7krIOE
         aa0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695078383; x=1695683183;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s8cEhM9oKmPPnfsLmQMoDwmGEq4+4P8VlN6gvizbqII=;
        b=ZBhH4rzvaKG5kB35cIEgv6t4MjVXAspr4MUJRgL3MuunIdV5A6EqV/OANybZH2iiuV
         q8pYZkzjFpu3RSn2cXPEM9rJ+kbE0ElHmwSrcMtC1VGLUSTSZCYPj8hlQnuB3oICdkVS
         z2SDxSgPWcBg5euO3bdYXu77eQ5NFluOxAuXiS7yF1YFes3xEvkWPZpD8ED63Af1YMZv
         JdotH47VxMo9YcEzzgZ4sAUTg0e5GysqNWmpuOoJvla0R5vkEe+tx+448pvVhS1MjFT+
         +qx9N8m9PV3ToqvT8T61Hcejs0/G016QSzafDZa7swEMVaya77FeVMBLeorihUSX0GqR
         P3tg==
X-Gm-Message-State: AOJu0YzENExIjPmg+5hZX3ZXa+Qqa3AlhD+MTpVGwX3vG54aR3KLE8U5
        m0uuqfw10X8YSPg1LkMPxbucFA==
X-Google-Smtp-Source: AGHT+IEEGpeshEvEAI6LVCc6KLbDYWlGPPfH1oo2sUanXL83+d9MTzh9zyFF2AEd+tmb/ZsYThx7dw==
X-Received: by 2002:a17:902:dac4:b0:1bd:bba1:be78 with SMTP id q4-20020a170902dac400b001bdbba1be78mr11384398plx.23.1695078383394;
        Mon, 18 Sep 2023 16:06:23 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id jj1-20020a170903048100b001bc6e6069a6sm4161503plb.122.2023.09.18.16.06.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Sep 2023 16:06:22 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <DF933AE1-8999-4AAE-90C6-FC276705D685@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_DBB671A0-A985-4DC7-912F-83EE17091D99";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/5] move a jfs_user.h to better place.
Date:   Mon, 18 Sep 2023 17:06:20 -0600
In-Reply-To: <20220804095618.887684-1-alexey.lyashkov@gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>
To:     Alexey Lyashkov <alexey.lyashkov@gmail.com>
References: <20220804095618.887684-1-alexey.lyashkov@gmail.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_DBB671A0-A985-4DC7-912F-83EE17091D99
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 4, 2022, at 3:56 AM, Alexey Lyashkov <alexey.lyashkov@gmail.com> =
wrote:
>=20
> jfs_user.h used in the debugfs and e2fsck, so
> libsupport is better place for it.
> just move a header into new place.

Alexey, this patch is missing a Signed-off-by: line.

The only other suggestion I would have is to rename the new file
"jbd2_user.h" since the "jfs" filesystem name is conflicting.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> debugfs/Makefile.in                | 16 +++++++---------
> debugfs/debugfs.c                  |  2 +-
> debugfs/journal.h                  |  2 +-
> debugfs/logdump.c                  |  2 +-
> e2fsck/Makefile.in                 |  8 ++++----
> e2fsck/journal.c                   |  2 +-
> e2fsck/recovery.c                  |  2 +-
> e2fsck/revoke.c                    |  2 +-
> e2fsck/unix.c                      |  2 +-
> lib/ext2fs/Makefile.in             | 18 ++++++++----------
> {e2fsck =3D> lib/support}/jfs_user.h |  0
> misc/Makefile.in                   | 12 +++++-------
> 12 files changed, 31 insertions(+), 37 deletions(-)
> rename {e2fsck =3D> lib/support}/jfs_user.h (100%)
>=20
> diff --git a/debugfs/Makefile.in b/debugfs/Makefile.in
> index ed4ea8d8..33658eea 100644
> --- a/debugfs/Makefile.in
> +++ b/debugfs/Makefile.in
> @@ -47,9 +47,7 @@ STATIC_DEPLIBS=3D $(STATIC_LIBEXT2FS) =
$(DEPSTATIC_LIBSS) \
> 		$(DEPSTATIC_LIBCOM_ERR) $(DEPSTATIC_LIBUUID) \
> 		$(DEPSTATIC_LIBE2P)
>=20
> -# This nastiness is needed because of jfs_user.h hackery; when we =
finally
> -# clean up this mess, we should be able to drop it
> -LOCAL_CFLAGS =3D -I$(srcdir)/../e2fsck -DDEBUGFS
> +LOCAL_CFLAGS =3D -DDEBUGFS
> DEPEND_CFLAGS =3D -I$(srcdir)
>=20
> .c.o:
> @@ -186,7 +184,7 @@ debugfs.o: $(srcdir)/debugfs.c =
$(top_builddir)/lib/config.h \
>  $(top_srcdir)/lib/e2p/e2p.h $(top_srcdir)/lib/support/quotaio.h \
>  $(top_srcdir)/lib/support/dqblk_v2.h \
>  $(top_srcdir)/lib/support/quotaio_tree.h $(top_srcdir)/version.h \
> - $(srcdir)/../e2fsck/jfs_user.h $(top_srcdir)/lib/ext2fs/kernel-jbd.h =
\
> + $(top_srcdir)/lib/support/jfs_user.h =
$(top_srcdir)/lib/ext2fs/kernel-jbd.h \
>  $(top_srcdir)/lib/ext2fs/jfs_compat.h =
$(top_srcdir)/lib/ext2fs/kernel-list.h \
>  $(top_srcdir)/lib/ext2fs/compiler.h =
$(top_srcdir)/lib/support/plausible.h
> util.o: $(srcdir)/util.c $(top_builddir)/lib/config.h \
> @@ -277,7 +275,7 @@ logdump.o: $(srcdir)/logdump.c =
$(top_builddir)/lib/config.h \
>  $(top_srcdir)/lib/ext2fs/bitops.h $(srcdir)/../misc/create_inode.h \
>  $(top_srcdir)/lib/e2p/e2p.h $(top_srcdir)/lib/support/quotaio.h \
>  $(top_srcdir)/lib/support/dqblk_v2.h \
> - $(top_srcdir)/lib/support/quotaio_tree.h =
$(srcdir)/../e2fsck/jfs_user.h \
> + $(top_srcdir)/lib/support/quotaio_tree.h =
$(top_srcdir)/lib/support/jfs_user.h \
>  $(top_srcdir)/lib/ext2fs/kernel-jbd.h =
$(top_srcdir)/lib/ext2fs/jfs_compat.h \
>  $(top_srcdir)/lib/ext2fs/kernel-list.h =
$(top_srcdir)/lib/ext2fs/compiler.h \
>  $(top_srcdir)/lib/ext2fs/fast_commit.h
> @@ -382,7 +380,7 @@ quota.o: $(srcdir)/quota.c =
$(top_builddir)/lib/config.h \
>  $(top_srcdir)/lib/support/quotaio_tree.h
> journal.o: $(srcdir)/journal.c $(top_builddir)/lib/config.h \
>  $(top_builddir)/lib/dirpaths.h $(srcdir)/journal.h \
> - $(srcdir)/../e2fsck/jfs_user.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
> + $(top_srcdir)/lib/support/jfs_user.h =
$(top_srcdir)/lib/ext2fs/ext2_fs.h \
>  $(top_builddir)/lib/ext2fs/ext2_types.h =
$(top_srcdir)/lib/ext2fs/ext2fs.h \
>  $(top_srcdir)/lib/ext2fs/ext3_extents.h =
$(top_srcdir)/lib/et/com_err.h \
>  $(top_srcdir)/lib/ext2fs/ext2_io.h =
$(top_builddir)/lib/ext2fs/ext2_err.h \
> @@ -390,7 +388,7 @@ journal.o: $(srcdir)/journal.c =
$(top_builddir)/lib/config.h \
>  $(top_srcdir)/lib/ext2fs/bitops.h =
$(top_srcdir)/lib/ext2fs/kernel-jbd.h \
>  $(top_srcdir)/lib/ext2fs/jfs_compat.h =
$(top_srcdir)/lib/ext2fs/kernel-list.h \
>  $(top_srcdir)/lib/ext2fs/compiler.h
> -revoke.o: $(srcdir)/../e2fsck/revoke.c $(srcdir)/../e2fsck/jfs_user.h =
\
> +revoke.o: $(srcdir)/../e2fsck/revoke.c =
$(top_srcdir)/lib/support/jfs_user.h \
>  $(top_srcdir)/lib/ext2fs/ext2_fs.h =
$(top_builddir)/lib/ext2fs/ext2_types.h \
>  $(top_srcdir)/lib/ext2fs/ext2fs.h =
$(top_srcdir)/lib/ext2fs/ext3_extents.h \
>  $(top_srcdir)/lib/et/com_err.h $(top_srcdir)/lib/ext2fs/ext2_io.h \
> @@ -399,7 +397,7 @@ revoke.o: $(srcdir)/../e2fsck/revoke.c =
$(srcdir)/../e2fsck/jfs_user.h \
>  $(top_srcdir)/lib/ext2fs/bitops.h =
$(top_srcdir)/lib/ext2fs/kernel-jbd.h \
>  $(top_srcdir)/lib/ext2fs/jfs_compat.h =
$(top_srcdir)/lib/ext2fs/kernel-list.h \
>  $(top_srcdir)/lib/ext2fs/compiler.h
> -recovery.o: $(srcdir)/../e2fsck/recovery.c =
$(srcdir)/../e2fsck/jfs_user.h \
> +recovery.o: $(srcdir)/../e2fsck/recovery.c =
$(top_srcdir)/lib/support/jfs_user.h \
>  $(top_srcdir)/lib/ext2fs/ext2_fs.h =
$(top_builddir)/lib/ext2fs/ext2_types.h \
>  $(top_srcdir)/lib/ext2fs/ext2fs.h =
$(top_srcdir)/lib/ext2fs/ext3_extents.h \
>  $(top_srcdir)/lib/et/com_err.h $(top_srcdir)/lib/ext2fs/ext2_io.h \
> @@ -421,4 +419,4 @@ do_journal.o: $(srcdir)/do_journal.c =
$(top_builddir)/lib/config.h \
>  $(top_srcdir)/lib/support/quotaio_tree.h \
>  $(top_srcdir)/lib/ext2fs/kernel-jbd.h =
$(top_srcdir)/lib/ext2fs/jfs_compat.h \
>  $(top_srcdir)/lib/ext2fs/kernel-list.h =
$(top_srcdir)/lib/ext2fs/compiler.h \
> - $(srcdir)/journal.h $(srcdir)/../e2fsck/jfs_user.h
> + $(srcdir)/journal.h $(top_srcdir)/lib/support/jfs_user.h
> diff --git a/debugfs/debugfs.c b/debugfs/debugfs.c
> index b67a88bc..00b261ac 100644
> --- a/debugfs/debugfs.c
> +++ b/debugfs/debugfs.c
> @@ -37,7 +37,7 @@ extern char *optarg;
> #include <ext2fs/ext2_ext_attr.h>
>=20
> #include "../version.h"
> -#include "jfs_user.h"
> +#include "support/jfs_user.h"
> #include "support/plausible.h"
>=20
> #ifndef BUFSIZ
> diff --git a/debugfs/journal.h b/debugfs/journal.h
> index 10b638eb..4d889834 100644
> --- a/debugfs/journal.h
> +++ b/debugfs/journal.h
> @@ -12,7 +12,7 @@
>  * any later version.
>  */
>=20
> -#include "jfs_user.h"
> +#include "support/jfs_user.h"
>=20
> /* journal.c */
> errcode_t ext2fs_open_journal(ext2_filsys fs, journal_t **j);
> diff --git a/debugfs/logdump.c b/debugfs/logdump.c
> index 4154ef2a..f5427d5c 100644
> --- a/debugfs/logdump.c
> +++ b/debugfs/logdump.c
> @@ -32,7 +32,7 @@ extern char *optarg;
>=20
> #include "debugfs.h"
> #include "blkid/blkid.h"
> -#include "jfs_user.h"
> +#include "support/jfs_user.h"
> #if __GNUC_PREREQ (4, 6)
> #pragma GCC diagnostic push
> #pragma GCC diagnostic ignored "-Wunused-function"
> diff --git a/e2fsck/Makefile.in b/e2fsck/Makefile.in
> index 71ac3cf5..a6e11417 100644
> --- a/e2fsck/Makefile.in
> +++ b/e2fsck/Makefile.in
> @@ -383,7 +383,7 @@ pass5.o: $(srcdir)/pass5.c =
$(top_builddir)/lib/config.h \
>  $(top_srcdir)/lib/ext2fs/kernel-list.h =
$(top_srcdir)/lib/ext2fs/compiler.h \
>  $(srcdir)/problem.h
> journal.o: $(srcdir)/journal.c $(top_builddir)/lib/config.h \
> - $(top_builddir)/lib/dirpaths.h $(srcdir)/jfs_user.h =
$(srcdir)/e2fsck.h \
> + $(top_builddir)/lib/dirpaths.h $(top_srcdir)/lib/support/jfs_user.h =
$(srcdir)/e2fsck.h \
>  $(top_srcdir)/lib/ext2fs/ext2_fs.h =
$(top_builddir)/lib/ext2fs/ext2_types.h \
>  $(top_srcdir)/lib/ext2fs/ext2fs.h =
$(top_srcdir)/lib/ext2fs/ext3_extents.h \
>  $(top_srcdir)/lib/et/com_err.h $(top_srcdir)/lib/ext2fs/ext2_io.h \
> @@ -396,7 +396,7 @@ journal.o: $(srcdir)/journal.c =
$(top_builddir)/lib/config.h \
>  $(top_srcdir)/lib/ext2fs/fast_commit.h =
$(top_srcdir)/lib/ext2fs/jfs_compat.h \
>  $(top_srcdir)/lib/ext2fs/kernel-list.h =
$(top_srcdir)/lib/ext2fs/compiler.h \
>  $(top_srcdir)/lib/ext2fs/kernel-jbd.h $(srcdir)/problem.h
> -recovery.o: $(srcdir)/recovery.c $(srcdir)/jfs_user.h \
> +recovery.o: $(srcdir)/recovery.c $(top_srcdir)/lib/support/jfs_user.h =
\
>  $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
>  $(srcdir)/e2fsck.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
>  $(top_builddir)/lib/ext2fs/ext2_types.h =
$(top_srcdir)/lib/ext2fs/ext2fs.h \
> @@ -410,7 +410,7 @@ recovery.o: $(srcdir)/recovery.c =
$(srcdir)/jfs_user.h \
>  $(top_srcdir)/lib/ext2fs/fast_commit.h =
$(top_srcdir)/lib/ext2fs/jfs_compat.h \
>  $(top_srcdir)/lib/ext2fs/kernel-list.h =
$(top_srcdir)/lib/ext2fs/compiler.h \
>  $(top_srcdir)/lib/ext2fs/kernel-jbd.h
> -revoke.o: $(srcdir)/revoke.c $(srcdir)/jfs_user.h \
> +revoke.o: $(srcdir)/revoke.c $(top_srcdir)/lib/support/jfs_user.h \
>  $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
>  $(srcdir)/e2fsck.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
>  $(top_builddir)/lib/ext2fs/ext2_types.h =
$(top_srcdir)/lib/ext2fs/ext2fs.h \
> @@ -464,7 +464,7 @@ unix.o: $(srcdir)/unix.c =
$(top_builddir)/lib/config.h \
>  $(top_srcdir)/lib/support/quotaio_tree.h \
>  $(top_srcdir)/lib/ext2fs/fast_commit.h =
$(top_srcdir)/lib/ext2fs/jfs_compat.h \
>  $(top_srcdir)/lib/ext2fs/kernel-list.h =
$(top_srcdir)/lib/ext2fs/compiler.h \
> - $(srcdir)/problem.h $(srcdir)/jfs_user.h \
> + $(srcdir)/problem.h $(top_srcdir)/lib/support/jfs_user.h \
>  $(top_srcdir)/lib/ext2fs/kernel-jbd.h $(top_srcdir)/version.h
> dirinfo.o: $(srcdir)/dirinfo.c $(top_builddir)/lib/config.h \
>  $(top_builddir)/lib/dirpaths.h $(srcdir)/e2fsck.h \
> diff --git a/e2fsck/journal.c b/e2fsck/journal.c
> index 2e867234..d3002a62 100644
> --- a/e2fsck/journal.c
> +++ b/e2fsck/journal.c
> @@ -23,7 +23,7 @@
> #endif
>=20
> #define E2FSCK_INCLUDE_INLINE_FUNCS
> -#include "jfs_user.h"
> +#include "support/jfs_user.h"
> #include "problem.h"
> #include "uuid/uuid.h"
>=20
> diff --git a/e2fsck/recovery.c b/e2fsck/recovery.c
> index 8ca35271..c7328cc5 100644
> --- a/e2fsck/recovery.c
> +++ b/e2fsck/recovery.c
> @@ -11,7 +11,7 @@
>  */
>=20
> #ifndef __KERNEL__
> -#include "jfs_user.h"
> +#include "support/jfs_user.h"
> #else
> #include <linux/time.h>
> #include <linux/fs.h>
> diff --git a/e2fsck/revoke.c b/e2fsck/revoke.c
> index fa608788..1d5f910b 100644
> --- a/e2fsck/revoke.c
> +++ b/e2fsck/revoke.c
> @@ -78,7 +78,7 @@
>  */
>=20
> #ifndef __KERNEL__
> -#include "jfs_user.h"
> +#include "support/jfs_user.h"
> #else
> #include <linux/time.h>
> #include <linux/fs.h>
> diff --git a/e2fsck/unix.c b/e2fsck/unix.c
> index ae231f93..474dde2d 100644
> --- a/e2fsck/unix.c
> +++ b/e2fsck/unix.c
> @@ -54,7 +54,7 @@ extern int optind;
> #include "support/plausible.h"
> #include "e2fsck.h"
> #include "problem.h"
> -#include "jfs_user.h"
> +#include "support/jfs_user.h"
> #include "../version.h"
>=20
> /* Command line options */
> diff --git a/lib/ext2fs/Makefile.in b/lib/ext2fs/Makefile.in
> index f6a050a2..5fa9693a 100644
> --- a/lib/ext2fs/Makefile.in
> +++ b/lib/ext2fs/Makefile.in
> @@ -5,10 +5,8 @@ top_builddir =3D ../..
> my_dir =3D lib/ext2fs
> INSTALL =3D @INSTALL@
> MKDIR_P =3D @MKDIR_P@
> -DEPEND_CFLAGS =3D -I$(top_srcdir)/debugfs -I$(srcdir)/../../e2fsck =
-DDEBUGFS
> -# This nastiness is needed because of jfs_user.h hackery; when we =
finally
> -# clean up this mess, we should be able to drop it
> -DEBUGFS_CFLAGS =3D -I$(srcdir)/../../e2fsck $(ALL_CFLAGS) -DDEBUGFS
> +DEPEND_CFLAGS =3D -I$(top_srcdir)/debugfs -DDEBUGFS
> +DEBUGFS_CFLAGS =3D $(ALL_CFLAGS) -DDEBUGFS
>=20
> @MCONFIG@
>=20
> @@ -1231,7 +1229,7 @@ debugfs.o: $(top_srcdir)/debugfs/debugfs.c =
$(top_builddir)/lib/config.h \
>  $(top_srcdir)/debugfs/../misc/create_inode.h =
$(top_srcdir)/lib/e2p/e2p.h \
>  $(top_srcdir)/lib/support/quotaio.h =
$(top_srcdir)/lib/support/dqblk_v2.h \
>  $(top_srcdir)/lib/support/quotaio_tree.h =
$(top_srcdir)/debugfs/../version.h \
> - $(srcdir)/../../e2fsck/jfs_user.h $(srcdir)/kernel-jbd.h \
> + $(top_srcdir)/lib/support/jfs_user.h $(srcdir)/kernel-jbd.h \
>  $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h $(srcdir)/compiler.h \
>  $(top_srcdir)/lib/support/plausible.h
> util.o: $(top_srcdir)/debugfs/util.c $(top_builddir)/lib/config.h \
> @@ -1321,7 +1319,7 @@ logdump.o: $(top_srcdir)/debugfs/logdump.c =
$(top_builddir)/lib/config.h \
>  $(srcdir)/hashmap.h $(srcdir)/bitops.h \
>  $(top_srcdir)/debugfs/../misc/create_inode.h =
$(top_srcdir)/lib/e2p/e2p.h \
>  $(top_srcdir)/lib/support/quotaio.h =
$(top_srcdir)/lib/support/dqblk_v2.h \
> - $(top_srcdir)/lib/support/quotaio_tree.h =
$(srcdir)/../../e2fsck/jfs_user.h \
> + $(top_srcdir)/lib/support/quotaio_tree.h =
$(top_srcdir)/lib/support/jfs_user.h \
>  $(srcdir)/kernel-jbd.h $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h =
\
>  $(srcdir)/compiler.h $(srcdir)/fast_commit.h
> htree.o: $(top_srcdir)/debugfs/htree.c $(top_builddir)/lib/config.h \
> @@ -1422,20 +1420,20 @@ create_inode.o: =
$(top_srcdir)/misc/create_inode.c \
>  $(top_srcdir)/lib/e2p/e2p.h $(top_srcdir)/lib/support/nls-enable.h
> journal.o: $(top_srcdir)/debugfs/journal.c =
$(top_builddir)/lib/config.h \
>  $(top_builddir)/lib/dirpaths.h $(top_srcdir)/debugfs/journal.h \
> - $(srcdir)/../../e2fsck/jfs_user.h $(srcdir)/ext2_fs.h \
> + $(top_srcdir)/lib/support/jfs_user.h $(srcdir)/ext2_fs.h \
>  $(top_builddir)/lib/ext2fs/ext2_types.h $(srcdir)/ext2fs.h \
>  $(srcdir)/ext3_extents.h $(top_srcdir)/lib/et/com_err.h =
$(srcdir)/ext2_io.h \
>  $(top_builddir)/lib/ext2fs/ext2_err.h $(srcdir)/ext2_ext_attr.h \
>  $(srcdir)/hashmap.h $(srcdir)/bitops.h $(srcdir)/kernel-jbd.h \
>  $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h $(srcdir)/compiler.h
> -revoke.o: $(top_srcdir)/e2fsck/revoke.c =
$(top_srcdir)/e2fsck/jfs_user.h \
> +revoke.o: $(top_srcdir)/e2fsck/revoke.c =
$(top_srcdir)/lib/support/jfs_user.h \
>  $(srcdir)/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
>  $(srcdir)/ext2fs.h $(srcdir)/ext3_extents.h =
$(top_srcdir)/lib/et/com_err.h \
>  $(srcdir)/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
>  $(srcdir)/ext2_ext_attr.h $(srcdir)/hashmap.h $(srcdir)/bitops.h \
>  $(srcdir)/kernel-jbd.h $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h =
\
>  $(srcdir)/compiler.h
> -recovery.o: $(top_srcdir)/e2fsck/recovery.c =
$(top_srcdir)/e2fsck/jfs_user.h \
> +recovery.o: $(top_srcdir)/e2fsck/recovery.c =
$(top_srcdir)/lib/support/jfs_user.h \
>  $(srcdir)/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
>  $(srcdir)/ext2fs.h $(srcdir)/ext3_extents.h =
$(top_srcdir)/lib/et/com_err.h \
>  $(srcdir)/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
> @@ -1454,4 +1452,4 @@ do_journal.o: $(top_srcdir)/debugfs/do_journal.c =
$(top_builddir)/lib/config.h \
>  $(top_srcdir)/lib/support/quotaio.h =
$(top_srcdir)/lib/support/dqblk_v2.h \
>  $(top_srcdir)/lib/support/quotaio_tree.h $(srcdir)/kernel-jbd.h \
>  $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h $(srcdir)/compiler.h \
> - $(top_srcdir)/debugfs/journal.h $(srcdir)/../../e2fsck/jfs_user.h
> + $(top_srcdir)/debugfs/journal.h $(top_srcdir)/lib/support/jfs_user.h
> diff --git a/e2fsck/jfs_user.h b/lib/support/jfs_user.h
> similarity index 100%
> rename from e2fsck/jfs_user.h
> rename to lib/support/jfs_user.h
> diff --git a/misc/Makefile.in b/misc/Makefile.in
> index 4db59cdf..2d4c8087 100644
> --- a/misc/Makefile.in
> +++ b/misc/Makefile.in
> @@ -124,10 +124,8 @@ DEPLIBS_E2P=3D $(LIBE2P) $(DEPLIBCOM_ERR)
>=20
> COMPILE_ET=3D	_ET_DIR_OVERRIDE=3D$(srcdir)/../lib/et/et =
../lib/et/compile_et
>=20
> -# This nastiness is needed because of jfs_user.h hackery; when we =
finally
> -# clean up this mess, we should be able to drop it
> -JOURNAL_CFLAGS =3D -I$(srcdir)/../e2fsck $(ALL_CFLAGS) -DDEBUGFS
> -DEPEND_CFLAGS =3D -I$(top_srcdir)/e2fsck
> +JOURNAL_CFLAGS =3D -I $(ALL_CFLAGS) -DDEBUGFS
> +DEPEND_CFLAGS =3D
>=20
> .c.o:
> 	$(E) "	CC $<"
> @@ -878,7 +876,7 @@ check_fuzzer.o: $(srcdir)/check_fuzzer.c =
$(top_srcdir)/lib/ext2fs/ext2_fs.h \
>  $(top_srcdir)/lib/ext2fs/bitops.h
> journal.o: $(srcdir)/../debugfs/journal.c $(top_builddir)/lib/config.h =
\
>  $(top_builddir)/lib/dirpaths.h $(srcdir)/../debugfs/journal.h \
> - $(top_srcdir)/e2fsck/jfs_user.h $(top_srcdir)/e2fsck/e2fsck.h \
> + $(top_srcdir)/lib/support/jfs_user.h $(top_srcdir)/e2fsck/e2fsck.h \
>  $(top_srcdir)/lib/ext2fs/ext2_fs.h =
$(top_builddir)/lib/ext2fs/ext2_types.h \
>  $(top_srcdir)/lib/ext2fs/ext2fs.h =
$(top_srcdir)/lib/ext2fs/ext3_extents.h \
>  $(top_srcdir)/lib/et/com_err.h $(top_srcdir)/lib/ext2fs/ext2_io.h \
> @@ -891,7 +889,7 @@ journal.o: $(srcdir)/../debugfs/journal.c =
$(top_builddir)/lib/config.h \
>  $(top_srcdir)/lib/ext2fs/fast_commit.h =
$(top_srcdir)/lib/ext2fs/jfs_compat.h \
>  $(top_srcdir)/lib/ext2fs/kernel-list.h =
$(top_srcdir)/lib/ext2fs/compiler.h \
>  $(top_srcdir)/lib/ext2fs/kernel-jbd.h
> -revoke.o: $(srcdir)/../e2fsck/revoke.c $(srcdir)/../e2fsck/jfs_user.h =
\
> +revoke.o: $(srcdir)/../e2fsck/revoke.c =
$(top_srcdir)/lib/support/jfs_user.h \
>  $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
>  $(srcdir)/../e2fsck/e2fsck.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
>  $(top_builddir)/lib/ext2fs/ext2_types.h =
$(top_srcdir)/lib/ext2fs/ext2fs.h \
> @@ -905,7 +903,7 @@ revoke.o: $(srcdir)/../e2fsck/revoke.c =
$(srcdir)/../e2fsck/jfs_user.h \
>  $(top_srcdir)/lib/ext2fs/fast_commit.h =
$(top_srcdir)/lib/ext2fs/jfs_compat.h \
>  $(top_srcdir)/lib/ext2fs/kernel-list.h =
$(top_srcdir)/lib/ext2fs/compiler.h \
>  $(top_srcdir)/lib/ext2fs/kernel-jbd.h
> -recovery.o: $(srcdir)/../e2fsck/recovery.c =
$(srcdir)/../e2fsck/jfs_user.h \
> +recovery.o: $(srcdir)/../e2fsck/recovery.c =
$(top_srcdir)/lib/support/jfs_user.h \
>  $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
>  $(srcdir)/../e2fsck/e2fsck.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
>  $(top_builddir)/lib/ext2fs/ext2_types.h =
$(top_srcdir)/lib/ext2fs/ext2fs.h \
> --
> 2.31.1
>=20


Cheers, Andreas






--Apple-Mail=_DBB671A0-A985-4DC7-912F-83EE17091D99
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmUI1+wACgkQcqXauRfM
H+DWNxAAvyE+tmGT87OtdA4JZJ7J7+TJEG9A/zimgkUp9UeZAKfnTPOSvKQigC5b
mcvMNHFck1iAFuHiy/J3GwQI4nQCp55fQ5xWFsO6TzB6+2XkLuXN9WbSQpS6B6ox
xhfBVGgkz0wc0IH3Mj3tv3OuFMtTtbTLCqp3DSyGAG7/db/IyR+8MJXiRyLQemUK
+e7BCSKy9gxrBhWtYUoz9XJiMk6ZhhonFb6bAgMiDvPSrqLuWQHVCheeQTNpqjlS
lgULBlbFtre5olrd3fmnUxiELe69rfYnhIZvIr8ZwQba7bswhHudsG5C+wuMEHcF
jrJN250YrwEiQlgV9ShQ3GHixZNRydvhv2GBZayx6YUxtnPuz5F5jGJ2wKPm+Bbc
C8A8hJ2P4O0/2+qhuhnwHSAvYGr4qH7X069M/lIFhsvvwMmC+2hCnSZYXPZoysEv
5g6BsBYW4Lz4EPA2nQyEgUxCqNMteZYKK00wSe0nNvxh2BysO6RTdYl90eFpHtoy
lqhVMEQ5aBN3zWfSiMPeJS6P6vS+ooZhDL5b2Z29+yoK6VSNVQJGxjkjcgqVA1Cf
eWuiTdVHxyhQdHVp+MZPraW+pgXUerkAl3XjF0P0JvG4LP0IHZjg874I837pS9Ou
2W/YVnT1RzyBky63XJ4oyhhw7e88AI80ZiCaAXaB4+/aMCKQCtQ=
=e+TJ
-----END PGP SIGNATURE-----

--Apple-Mail=_DBB671A0-A985-4DC7-912F-83EE17091D99--
