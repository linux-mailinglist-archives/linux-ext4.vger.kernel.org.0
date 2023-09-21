Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A25C7AA23F
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Sep 2023 23:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjIUVOR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Sep 2023 17:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbjIUVNl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Sep 2023 17:13:41 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806E5E39D
        for <linux-ext4@vger.kernel.org>; Thu, 21 Sep 2023 10:07:54 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9a9f139cd94so154720766b.2
        for <linux-ext4@vger.kernel.org>; Thu, 21 Sep 2023 10:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695316073; x=1695920873; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hk04+R3IgtsnD5xpysChT7msrZpiSzuzW77WhM/qDzM=;
        b=XaVoMtfUK9sQZ4bjNoLMabJ9gyGDLIeRqNVjwIzDCC29TggM1uDG8YWJctYpfQnXo1
         16eoMGxp+lhCzZuEEYkFIQeIZAq6G1XE3cFNpTT+2BT8pbv3EW+SLtzeGZk/il+ZjnQv
         NxL05kRF7zOdhHIHbJEUnqeQZb2X1nSZP+dMMA0TFdJMhoSx+haoHFzKF2CbvcXFwZrQ
         9RO69O6jxkomLfnf5ggOyrToD9f3e9geGCKBN/UhlXW4ZiAIImbJNuy/DkG2z++gCv0W
         5allzY5N1qcSJAR8NEDeQGgdQM4LWNHx8LFOhSQotFnDTBxL1z+Kis2W+X9HTB3U3NnK
         jYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316073; x=1695920873;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hk04+R3IgtsnD5xpysChT7msrZpiSzuzW77WhM/qDzM=;
        b=EqVh5Qm3Ov6QeySRj3zuqKq3i78vcbPg2SrC4x2XAk0CR+rS7mmoissJbfFhxR34wl
         laC2XDfu5ipxX1RCrf4ION9TGSQe8h8wjkTave5SFdkCHCh0WB8vsyDpt8H8Wvb8AzKn
         ZJrDZBu5v2D2vGk4EYcHSWQbkSKanMSzfoMdOehy0Djww43IpeJTbU6bacwvjUvTNPi/
         JPBDr/Kc4eu6u5RyoljZmMEO54jqak2i39glqHX0Be7I71FhWh/jp6ak2EKj3ex/9dMY
         vQa5MJJ/WurNPBYNV/XjAG0cctBr6p96Lh+N20r6B87A/Tv1ZvgzXhBsJxIShKLa3dXs
         5oxA==
X-Gm-Message-State: AOJu0YzOr1t64EDejZrd7kEBYFDIgzArle7UtrWvBjhSjvkyWDvVMIkR
        5ZLvGoNejIlZ7iBFgTihwm5hBuwLM+Hspw==
X-Google-Smtp-Source: AGHT+IHWoV44W81/9E7g20PXj2c/5L3NAL7/nxlIaBV8APxjQVIwmJYxGftQEhxTtqBTVD+vNxk2qw==
X-Received: by 2002:a2e:bb88:0:b0:2c1:2890:f7d1 with SMTP id y8-20020a2ebb88000000b002c12890f7d1mr2683675lje.32.1695305979210;
        Thu, 21 Sep 2023 07:19:39 -0700 (PDT)
Received: from smtpclient.apple ([188.126.90.69])
        by smtp.gmail.com with ESMTPSA id i25-20020a2e8099000000b002b6d7682050sm369733ljg.89.2023.09.21.07.19.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Sep 2023 07:19:38 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH 1/5] move a jfs_user.h to better place.
From:   Alexey Lyahkov <alexey.lyashkov@gmail.com>
In-Reply-To: <DF933AE1-8999-4AAE-90C6-FC276705D685@dilger.ca>
Date:   Thu, 21 Sep 2023 17:19:36 +0300
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D813602A-E52A-4F0D-91AC-C9AC93B8F004@gmail.com>
References: <20220804095618.887684-1-alexey.lyashkov@gmail.com>
 <DF933AE1-8999-4AAE-90C6-FC276705D685@dilger.ca>
To:     Andreas Dilger <adilger@dilger.ca>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Andreas,

Thanks for rebase to top of master branch. Adding a Signed-off-by: line =
is OK.

Alex

> On 19 Sep 2023, at 02:06, Andreas Dilger <adilger@dilger.ca> wrote:
>=20
> On Aug 4, 2022, at 3:56 AM, Alexey Lyashkov =
<alexey.lyashkov@gmail.com> wrote:
>>=20
>> jfs_user.h used in the debugfs and e2fsck, so
>> libsupport is better place for it.
>> just move a header into new place.
>=20
> Alexey, this patch is missing a Signed-off-by: line.
>=20
> The only other suggestion I would have is to rename the new file
> "jbd2_user.h" since the "jfs" filesystem name is conflicting.
>=20
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
>=20
>> ---
>> debugfs/Makefile.in                | 16 +++++++---------
>> debugfs/debugfs.c                  |  2 +-
>> debugfs/journal.h                  |  2 +-
>> debugfs/logdump.c                  |  2 +-
>> e2fsck/Makefile.in                 |  8 ++++----
>> e2fsck/journal.c                   |  2 +-
>> e2fsck/recovery.c                  |  2 +-
>> e2fsck/revoke.c                    |  2 +-
>> e2fsck/unix.c                      |  2 +-
>> lib/ext2fs/Makefile.in             | 18 ++++++++----------
>> {e2fsck =3D> lib/support}/jfs_user.h |  0
>> misc/Makefile.in                   | 12 +++++-------
>> 12 files changed, 31 insertions(+), 37 deletions(-)
>> rename {e2fsck =3D> lib/support}/jfs_user.h (100%)
>>=20
>> diff --git a/debugfs/Makefile.in b/debugfs/Makefile.in
>> index ed4ea8d8..33658eea 100644
>> --- a/debugfs/Makefile.in
>> +++ b/debugfs/Makefile.in
>> @@ -47,9 +47,7 @@ STATIC_DEPLIBS=3D $(STATIC_LIBEXT2FS) =
$(DEPSTATIC_LIBSS) \
>> 		$(DEPSTATIC_LIBCOM_ERR) $(DEPSTATIC_LIBUUID) \
>> 		$(DEPSTATIC_LIBE2P)
>>=20
>> -# This nastiness is needed because of jfs_user.h hackery; when we =
finally
>> -# clean up this mess, we should be able to drop it
>> -LOCAL_CFLAGS =3D -I$(srcdir)/../e2fsck -DDEBUGFS
>> +LOCAL_CFLAGS =3D -DDEBUGFS
>> DEPEND_CFLAGS =3D -I$(srcdir)
>>=20
>> .c.o:
>> @@ -186,7 +184,7 @@ debugfs.o: $(srcdir)/debugfs.c =
$(top_builddir)/lib/config.h \
>> $(top_srcdir)/lib/e2p/e2p.h $(top_srcdir)/lib/support/quotaio.h \
>> $(top_srcdir)/lib/support/dqblk_v2.h \
>> $(top_srcdir)/lib/support/quotaio_tree.h $(top_srcdir)/version.h \
>> - $(srcdir)/../e2fsck/jfs_user.h =
$(top_srcdir)/lib/ext2fs/kernel-jbd.h \
>> + $(top_srcdir)/lib/support/jfs_user.h =
$(top_srcdir)/lib/ext2fs/kernel-jbd.h \
>> $(top_srcdir)/lib/ext2fs/jfs_compat.h =
$(top_srcdir)/lib/ext2fs/kernel-list.h \
>> $(top_srcdir)/lib/ext2fs/compiler.h =
$(top_srcdir)/lib/support/plausible.h
>> util.o: $(srcdir)/util.c $(top_builddir)/lib/config.h \
>> @@ -277,7 +275,7 @@ logdump.o: $(srcdir)/logdump.c =
$(top_builddir)/lib/config.h \
>> $(top_srcdir)/lib/ext2fs/bitops.h $(srcdir)/../misc/create_inode.h \
>> $(top_srcdir)/lib/e2p/e2p.h $(top_srcdir)/lib/support/quotaio.h \
>> $(top_srcdir)/lib/support/dqblk_v2.h \
>> - $(top_srcdir)/lib/support/quotaio_tree.h =
$(srcdir)/../e2fsck/jfs_user.h \
>> + $(top_srcdir)/lib/support/quotaio_tree.h =
$(top_srcdir)/lib/support/jfs_user.h \
>> $(top_srcdir)/lib/ext2fs/kernel-jbd.h =
$(top_srcdir)/lib/ext2fs/jfs_compat.h \
>> $(top_srcdir)/lib/ext2fs/kernel-list.h =
$(top_srcdir)/lib/ext2fs/compiler.h \
>> $(top_srcdir)/lib/ext2fs/fast_commit.h
>> @@ -382,7 +380,7 @@ quota.o: $(srcdir)/quota.c =
$(top_builddir)/lib/config.h \
>> $(top_srcdir)/lib/support/quotaio_tree.h
>> journal.o: $(srcdir)/journal.c $(top_builddir)/lib/config.h \
>> $(top_builddir)/lib/dirpaths.h $(srcdir)/journal.h \
>> - $(srcdir)/../e2fsck/jfs_user.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
>> + $(top_srcdir)/lib/support/jfs_user.h =
$(top_srcdir)/lib/ext2fs/ext2_fs.h \
>> $(top_builddir)/lib/ext2fs/ext2_types.h =
$(top_srcdir)/lib/ext2fs/ext2fs.h \
>> $(top_srcdir)/lib/ext2fs/ext3_extents.h =
$(top_srcdir)/lib/et/com_err.h \
>> $(top_srcdir)/lib/ext2fs/ext2_io.h =
$(top_builddir)/lib/ext2fs/ext2_err.h \
>> @@ -390,7 +388,7 @@ journal.o: $(srcdir)/journal.c =
$(top_builddir)/lib/config.h \
>> $(top_srcdir)/lib/ext2fs/bitops.h =
$(top_srcdir)/lib/ext2fs/kernel-jbd.h \
>> $(top_srcdir)/lib/ext2fs/jfs_compat.h =
$(top_srcdir)/lib/ext2fs/kernel-list.h \
>> $(top_srcdir)/lib/ext2fs/compiler.h
>> -revoke.o: $(srcdir)/../e2fsck/revoke.c =
$(srcdir)/../e2fsck/jfs_user.h \
>> +revoke.o: $(srcdir)/../e2fsck/revoke.c =
$(top_srcdir)/lib/support/jfs_user.h \
>> $(top_srcdir)/lib/ext2fs/ext2_fs.h =
$(top_builddir)/lib/ext2fs/ext2_types.h \
>> $(top_srcdir)/lib/ext2fs/ext2fs.h =
$(top_srcdir)/lib/ext2fs/ext3_extents.h \
>> $(top_srcdir)/lib/et/com_err.h $(top_srcdir)/lib/ext2fs/ext2_io.h \
>> @@ -399,7 +397,7 @@ revoke.o: $(srcdir)/../e2fsck/revoke.c =
$(srcdir)/../e2fsck/jfs_user.h \
>> $(top_srcdir)/lib/ext2fs/bitops.h =
$(top_srcdir)/lib/ext2fs/kernel-jbd.h \
>> $(top_srcdir)/lib/ext2fs/jfs_compat.h =
$(top_srcdir)/lib/ext2fs/kernel-list.h \
>> $(top_srcdir)/lib/ext2fs/compiler.h
>> -recovery.o: $(srcdir)/../e2fsck/recovery.c =
$(srcdir)/../e2fsck/jfs_user.h \
>> +recovery.o: $(srcdir)/../e2fsck/recovery.c =
$(top_srcdir)/lib/support/jfs_user.h \
>> $(top_srcdir)/lib/ext2fs/ext2_fs.h =
$(top_builddir)/lib/ext2fs/ext2_types.h \
>> $(top_srcdir)/lib/ext2fs/ext2fs.h =
$(top_srcdir)/lib/ext2fs/ext3_extents.h \
>> $(top_srcdir)/lib/et/com_err.h $(top_srcdir)/lib/ext2fs/ext2_io.h \
>> @@ -421,4 +419,4 @@ do_journal.o: $(srcdir)/do_journal.c =
$(top_builddir)/lib/config.h \
>> $(top_srcdir)/lib/support/quotaio_tree.h \
>> $(top_srcdir)/lib/ext2fs/kernel-jbd.h =
$(top_srcdir)/lib/ext2fs/jfs_compat.h \
>> $(top_srcdir)/lib/ext2fs/kernel-list.h =
$(top_srcdir)/lib/ext2fs/compiler.h \
>> - $(srcdir)/journal.h $(srcdir)/../e2fsck/jfs_user.h
>> + $(srcdir)/journal.h $(top_srcdir)/lib/support/jfs_user.h
>> diff --git a/debugfs/debugfs.c b/debugfs/debugfs.c
>> index b67a88bc..00b261ac 100644
>> --- a/debugfs/debugfs.c
>> +++ b/debugfs/debugfs.c
>> @@ -37,7 +37,7 @@ extern char *optarg;
>> #include <ext2fs/ext2_ext_attr.h>
>>=20
>> #include "../version.h"
>> -#include "jfs_user.h"
>> +#include "support/jfs_user.h"
>> #include "support/plausible.h"
>>=20
>> #ifndef BUFSIZ
>> diff --git a/debugfs/journal.h b/debugfs/journal.h
>> index 10b638eb..4d889834 100644
>> --- a/debugfs/journal.h
>> +++ b/debugfs/journal.h
>> @@ -12,7 +12,7 @@
>> * any later version.
>> */
>>=20
>> -#include "jfs_user.h"
>> +#include "support/jfs_user.h"
>>=20
>> /* journal.c */
>> errcode_t ext2fs_open_journal(ext2_filsys fs, journal_t **j);
>> diff --git a/debugfs/logdump.c b/debugfs/logdump.c
>> index 4154ef2a..f5427d5c 100644
>> --- a/debugfs/logdump.c
>> +++ b/debugfs/logdump.c
>> @@ -32,7 +32,7 @@ extern char *optarg;
>>=20
>> #include "debugfs.h"
>> #include "blkid/blkid.h"
>> -#include "jfs_user.h"
>> +#include "support/jfs_user.h"
>> #if __GNUC_PREREQ (4, 6)
>> #pragma GCC diagnostic push
>> #pragma GCC diagnostic ignored "-Wunused-function"
>> diff --git a/e2fsck/Makefile.in b/e2fsck/Makefile.in
>> index 71ac3cf5..a6e11417 100644
>> --- a/e2fsck/Makefile.in
>> +++ b/e2fsck/Makefile.in
>> @@ -383,7 +383,7 @@ pass5.o: $(srcdir)/pass5.c =
$(top_builddir)/lib/config.h \
>> $(top_srcdir)/lib/ext2fs/kernel-list.h =
$(top_srcdir)/lib/ext2fs/compiler.h \
>> $(srcdir)/problem.h
>> journal.o: $(srcdir)/journal.c $(top_builddir)/lib/config.h \
>> - $(top_builddir)/lib/dirpaths.h $(srcdir)/jfs_user.h =
$(srcdir)/e2fsck.h \
>> + $(top_builddir)/lib/dirpaths.h $(top_srcdir)/lib/support/jfs_user.h =
$(srcdir)/e2fsck.h \
>> $(top_srcdir)/lib/ext2fs/ext2_fs.h =
$(top_builddir)/lib/ext2fs/ext2_types.h \
>> $(top_srcdir)/lib/ext2fs/ext2fs.h =
$(top_srcdir)/lib/ext2fs/ext3_extents.h \
>> $(top_srcdir)/lib/et/com_err.h $(top_srcdir)/lib/ext2fs/ext2_io.h \
>> @@ -396,7 +396,7 @@ journal.o: $(srcdir)/journal.c =
$(top_builddir)/lib/config.h \
>> $(top_srcdir)/lib/ext2fs/fast_commit.h =
$(top_srcdir)/lib/ext2fs/jfs_compat.h \
>> $(top_srcdir)/lib/ext2fs/kernel-list.h =
$(top_srcdir)/lib/ext2fs/compiler.h \
>> $(top_srcdir)/lib/ext2fs/kernel-jbd.h $(srcdir)/problem.h
>> -recovery.o: $(srcdir)/recovery.c $(srcdir)/jfs_user.h \
>> +recovery.o: $(srcdir)/recovery.c =
$(top_srcdir)/lib/support/jfs_user.h \
>> $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
>> $(srcdir)/e2fsck.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
>> $(top_builddir)/lib/ext2fs/ext2_types.h =
$(top_srcdir)/lib/ext2fs/ext2fs.h \
>> @@ -410,7 +410,7 @@ recovery.o: $(srcdir)/recovery.c =
$(srcdir)/jfs_user.h \
>> $(top_srcdir)/lib/ext2fs/fast_commit.h =
$(top_srcdir)/lib/ext2fs/jfs_compat.h \
>> $(top_srcdir)/lib/ext2fs/kernel-list.h =
$(top_srcdir)/lib/ext2fs/compiler.h \
>> $(top_srcdir)/lib/ext2fs/kernel-jbd.h
>> -revoke.o: $(srcdir)/revoke.c $(srcdir)/jfs_user.h \
>> +revoke.o: $(srcdir)/revoke.c $(top_srcdir)/lib/support/jfs_user.h \
>> $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
>> $(srcdir)/e2fsck.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
>> $(top_builddir)/lib/ext2fs/ext2_types.h =
$(top_srcdir)/lib/ext2fs/ext2fs.h \
>> @@ -464,7 +464,7 @@ unix.o: $(srcdir)/unix.c =
$(top_builddir)/lib/config.h \
>> $(top_srcdir)/lib/support/quotaio_tree.h \
>> $(top_srcdir)/lib/ext2fs/fast_commit.h =
$(top_srcdir)/lib/ext2fs/jfs_compat.h \
>> $(top_srcdir)/lib/ext2fs/kernel-list.h =
$(top_srcdir)/lib/ext2fs/compiler.h \
>> - $(srcdir)/problem.h $(srcdir)/jfs_user.h \
>> + $(srcdir)/problem.h $(top_srcdir)/lib/support/jfs_user.h \
>> $(top_srcdir)/lib/ext2fs/kernel-jbd.h $(top_srcdir)/version.h
>> dirinfo.o: $(srcdir)/dirinfo.c $(top_builddir)/lib/config.h \
>> $(top_builddir)/lib/dirpaths.h $(srcdir)/e2fsck.h \
>> diff --git a/e2fsck/journal.c b/e2fsck/journal.c
>> index 2e867234..d3002a62 100644
>> --- a/e2fsck/journal.c
>> +++ b/e2fsck/journal.c
>> @@ -23,7 +23,7 @@
>> #endif
>>=20
>> #define E2FSCK_INCLUDE_INLINE_FUNCS
>> -#include "jfs_user.h"
>> +#include "support/jfs_user.h"
>> #include "problem.h"
>> #include "uuid/uuid.h"
>>=20
>> diff --git a/e2fsck/recovery.c b/e2fsck/recovery.c
>> index 8ca35271..c7328cc5 100644
>> --- a/e2fsck/recovery.c
>> +++ b/e2fsck/recovery.c
>> @@ -11,7 +11,7 @@
>> */
>>=20
>> #ifndef __KERNEL__
>> -#include "jfs_user.h"
>> +#include "support/jfs_user.h"
>> #else
>> #include <linux/time.h>
>> #include <linux/fs.h>
>> diff --git a/e2fsck/revoke.c b/e2fsck/revoke.c
>> index fa608788..1d5f910b 100644
>> --- a/e2fsck/revoke.c
>> +++ b/e2fsck/revoke.c
>> @@ -78,7 +78,7 @@
>> */
>>=20
>> #ifndef __KERNEL__
>> -#include "jfs_user.h"
>> +#include "support/jfs_user.h"
>> #else
>> #include <linux/time.h>
>> #include <linux/fs.h>
>> diff --git a/e2fsck/unix.c b/e2fsck/unix.c
>> index ae231f93..474dde2d 100644
>> --- a/e2fsck/unix.c
>> +++ b/e2fsck/unix.c
>> @@ -54,7 +54,7 @@ extern int optind;
>> #include "support/plausible.h"
>> #include "e2fsck.h"
>> #include "problem.h"
>> -#include "jfs_user.h"
>> +#include "support/jfs_user.h"
>> #include "../version.h"
>>=20
>> /* Command line options */
>> diff --git a/lib/ext2fs/Makefile.in b/lib/ext2fs/Makefile.in
>> index f6a050a2..5fa9693a 100644
>> --- a/lib/ext2fs/Makefile.in
>> +++ b/lib/ext2fs/Makefile.in
>> @@ -5,10 +5,8 @@ top_builddir =3D ../..
>> my_dir =3D lib/ext2fs
>> INSTALL =3D @INSTALL@
>> MKDIR_P =3D @MKDIR_P@
>> -DEPEND_CFLAGS =3D -I$(top_srcdir)/debugfs -I$(srcdir)/../../e2fsck =
-DDEBUGFS
>> -# This nastiness is needed because of jfs_user.h hackery; when we =
finally
>> -# clean up this mess, we should be able to drop it
>> -DEBUGFS_CFLAGS =3D -I$(srcdir)/../../e2fsck $(ALL_CFLAGS) -DDEBUGFS
>> +DEPEND_CFLAGS =3D -I$(top_srcdir)/debugfs -DDEBUGFS
>> +DEBUGFS_CFLAGS =3D $(ALL_CFLAGS) -DDEBUGFS
>>=20
>> @MCONFIG@
>>=20
>> @@ -1231,7 +1229,7 @@ debugfs.o: $(top_srcdir)/debugfs/debugfs.c =
$(top_builddir)/lib/config.h \
>> $(top_srcdir)/debugfs/../misc/create_inode.h =
$(top_srcdir)/lib/e2p/e2p.h \
>> $(top_srcdir)/lib/support/quotaio.h =
$(top_srcdir)/lib/support/dqblk_v2.h \
>> $(top_srcdir)/lib/support/quotaio_tree.h =
$(top_srcdir)/debugfs/../version.h \
>> - $(srcdir)/../../e2fsck/jfs_user.h $(srcdir)/kernel-jbd.h \
>> + $(top_srcdir)/lib/support/jfs_user.h $(srcdir)/kernel-jbd.h \
>> $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h $(srcdir)/compiler.h \
>> $(top_srcdir)/lib/support/plausible.h
>> util.o: $(top_srcdir)/debugfs/util.c $(top_builddir)/lib/config.h \
>> @@ -1321,7 +1319,7 @@ logdump.o: $(top_srcdir)/debugfs/logdump.c =
$(top_builddir)/lib/config.h \
>> $(srcdir)/hashmap.h $(srcdir)/bitops.h \
>> $(top_srcdir)/debugfs/../misc/create_inode.h =
$(top_srcdir)/lib/e2p/e2p.h \
>> $(top_srcdir)/lib/support/quotaio.h =
$(top_srcdir)/lib/support/dqblk_v2.h \
>> - $(top_srcdir)/lib/support/quotaio_tree.h =
$(srcdir)/../../e2fsck/jfs_user.h \
>> + $(top_srcdir)/lib/support/quotaio_tree.h =
$(top_srcdir)/lib/support/jfs_user.h \
>> $(srcdir)/kernel-jbd.h $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h =
\
>> $(srcdir)/compiler.h $(srcdir)/fast_commit.h
>> htree.o: $(top_srcdir)/debugfs/htree.c $(top_builddir)/lib/config.h \
>> @@ -1422,20 +1420,20 @@ create_inode.o: =
$(top_srcdir)/misc/create_inode.c \
>> $(top_srcdir)/lib/e2p/e2p.h $(top_srcdir)/lib/support/nls-enable.h
>> journal.o: $(top_srcdir)/debugfs/journal.c =
$(top_builddir)/lib/config.h \
>> $(top_builddir)/lib/dirpaths.h $(top_srcdir)/debugfs/journal.h \
>> - $(srcdir)/../../e2fsck/jfs_user.h $(srcdir)/ext2_fs.h \
>> + $(top_srcdir)/lib/support/jfs_user.h $(srcdir)/ext2_fs.h \
>> $(top_builddir)/lib/ext2fs/ext2_types.h $(srcdir)/ext2fs.h \
>> $(srcdir)/ext3_extents.h $(top_srcdir)/lib/et/com_err.h =
$(srcdir)/ext2_io.h \
>> $(top_builddir)/lib/ext2fs/ext2_err.h $(srcdir)/ext2_ext_attr.h \
>> $(srcdir)/hashmap.h $(srcdir)/bitops.h $(srcdir)/kernel-jbd.h \
>> $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h $(srcdir)/compiler.h
>> -revoke.o: $(top_srcdir)/e2fsck/revoke.c =
$(top_srcdir)/e2fsck/jfs_user.h \
>> +revoke.o: $(top_srcdir)/e2fsck/revoke.c =
$(top_srcdir)/lib/support/jfs_user.h \
>> $(srcdir)/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
>> $(srcdir)/ext2fs.h $(srcdir)/ext3_extents.h =
$(top_srcdir)/lib/et/com_err.h \
>> $(srcdir)/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
>> $(srcdir)/ext2_ext_attr.h $(srcdir)/hashmap.h $(srcdir)/bitops.h \
>> $(srcdir)/kernel-jbd.h $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h =
\
>> $(srcdir)/compiler.h
>> -recovery.o: $(top_srcdir)/e2fsck/recovery.c =
$(top_srcdir)/e2fsck/jfs_user.h \
>> +recovery.o: $(top_srcdir)/e2fsck/recovery.c =
$(top_srcdir)/lib/support/jfs_user.h \
>> $(srcdir)/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
>> $(srcdir)/ext2fs.h $(srcdir)/ext3_extents.h =
$(top_srcdir)/lib/et/com_err.h \
>> $(srcdir)/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
>> @@ -1454,4 +1452,4 @@ do_journal.o: =
$(top_srcdir)/debugfs/do_journal.c $(top_builddir)/lib/config.h \
>> $(top_srcdir)/lib/support/quotaio.h =
$(top_srcdir)/lib/support/dqblk_v2.h \
>> $(top_srcdir)/lib/support/quotaio_tree.h $(srcdir)/kernel-jbd.h \
>> $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h $(srcdir)/compiler.h \
>> - $(top_srcdir)/debugfs/journal.h $(srcdir)/../../e2fsck/jfs_user.h
>> + $(top_srcdir)/debugfs/journal.h =
$(top_srcdir)/lib/support/jfs_user.h
>> diff --git a/e2fsck/jfs_user.h b/lib/support/jfs_user.h
>> similarity index 100%
>> rename from e2fsck/jfs_user.h
>> rename to lib/support/jfs_user.h
>> diff --git a/misc/Makefile.in b/misc/Makefile.in
>> index 4db59cdf..2d4c8087 100644
>> --- a/misc/Makefile.in
>> +++ b/misc/Makefile.in
>> @@ -124,10 +124,8 @@ DEPLIBS_E2P=3D $(LIBE2P) $(DEPLIBCOM_ERR)
>>=20
>> COMPILE_ET=3D	_ET_DIR_OVERRIDE=3D$(srcdir)/../lib/et/et =
../lib/et/compile_et
>>=20
>> -# This nastiness is needed because of jfs_user.h hackery; when we =
finally
>> -# clean up this mess, we should be able to drop it
>> -JOURNAL_CFLAGS =3D -I$(srcdir)/../e2fsck $(ALL_CFLAGS) -DDEBUGFS
>> -DEPEND_CFLAGS =3D -I$(top_srcdir)/e2fsck
>> +JOURNAL_CFLAGS =3D -I $(ALL_CFLAGS) -DDEBUGFS
>> +DEPEND_CFLAGS =3D
>>=20
>> .c.o:
>> 	$(E) "	CC $<"
>> @@ -878,7 +876,7 @@ check_fuzzer.o: $(srcdir)/check_fuzzer.c =
$(top_srcdir)/lib/ext2fs/ext2_fs.h \
>> $(top_srcdir)/lib/ext2fs/bitops.h
>> journal.o: $(srcdir)/../debugfs/journal.c =
$(top_builddir)/lib/config.h \
>> $(top_builddir)/lib/dirpaths.h $(srcdir)/../debugfs/journal.h \
>> - $(top_srcdir)/e2fsck/jfs_user.h $(top_srcdir)/e2fsck/e2fsck.h \
>> + $(top_srcdir)/lib/support/jfs_user.h $(top_srcdir)/e2fsck/e2fsck.h =
\
>> $(top_srcdir)/lib/ext2fs/ext2_fs.h =
$(top_builddir)/lib/ext2fs/ext2_types.h \
>> $(top_srcdir)/lib/ext2fs/ext2fs.h =
$(top_srcdir)/lib/ext2fs/ext3_extents.h \
>> $(top_srcdir)/lib/et/com_err.h $(top_srcdir)/lib/ext2fs/ext2_io.h \
>> @@ -891,7 +889,7 @@ journal.o: $(srcdir)/../debugfs/journal.c =
$(top_builddir)/lib/config.h \
>> $(top_srcdir)/lib/ext2fs/fast_commit.h =
$(top_srcdir)/lib/ext2fs/jfs_compat.h \
>> $(top_srcdir)/lib/ext2fs/kernel-list.h =
$(top_srcdir)/lib/ext2fs/compiler.h \
>> $(top_srcdir)/lib/ext2fs/kernel-jbd.h
>> -revoke.o: $(srcdir)/../e2fsck/revoke.c =
$(srcdir)/../e2fsck/jfs_user.h \
>> +revoke.o: $(srcdir)/../e2fsck/revoke.c =
$(top_srcdir)/lib/support/jfs_user.h \
>> $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
>> $(srcdir)/../e2fsck/e2fsck.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
>> $(top_builddir)/lib/ext2fs/ext2_types.h =
$(top_srcdir)/lib/ext2fs/ext2fs.h \
>> @@ -905,7 +903,7 @@ revoke.o: $(srcdir)/../e2fsck/revoke.c =
$(srcdir)/../e2fsck/jfs_user.h \
>> $(top_srcdir)/lib/ext2fs/fast_commit.h =
$(top_srcdir)/lib/ext2fs/jfs_compat.h \
>> $(top_srcdir)/lib/ext2fs/kernel-list.h =
$(top_srcdir)/lib/ext2fs/compiler.h \
>> $(top_srcdir)/lib/ext2fs/kernel-jbd.h
>> -recovery.o: $(srcdir)/../e2fsck/recovery.c =
$(srcdir)/../e2fsck/jfs_user.h \
>> +recovery.o: $(srcdir)/../e2fsck/recovery.c =
$(top_srcdir)/lib/support/jfs_user.h \
>> $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
>> $(srcdir)/../e2fsck/e2fsck.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
>> $(top_builddir)/lib/ext2fs/ext2_types.h =
$(top_srcdir)/lib/ext2fs/ext2fs.h \
>> --
>> 2.31.1
>>=20
>=20
>=20
> Cheers, Andreas
>=20
>=20
>=20
>=20
>=20

