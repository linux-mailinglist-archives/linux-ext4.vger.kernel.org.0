Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9A064D1A7
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Dec 2022 22:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiLNVRP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Dec 2022 16:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLNVRM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Dec 2022 16:17:12 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4EE33C02
        for <linux-ext4@vger.kernel.org>; Wed, 14 Dec 2022 13:17:11 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so569268pje.5
        for <linux-ext4@vger.kernel.org>; Wed, 14 Dec 2022 13:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8FX4tC7p+JOYCnGnRcDqk2SFBRANa3otX9d200AfRAw=;
        b=uw9df6GjGa845u9jLvw30FiC+q2vn3WzpjWW11+bfc+NQgukfd+fsw2wyIK5t6h2SS
         +TPADEPXGyhhW/OIsSQO239HasjBC9d428J+yASkv58tAem/4hbMwRg7YT2mH/H+Fo/R
         5MhSCKZD1OwMS/ETp9nhUxKiBpsOKnxU9tu2SGv0hW9hlk+SMJBYQAz6I+u2cm74h8ui
         l5r8TuPNGjhsBUNVltkZ70qFxhBPm+9qOK/sUWGz6bhKoeHyWzD6jiG+cSqBAzh2feSc
         U1WHJx0oWPRxb/CFt9cXuq5mWliuPuWe24Qa2YPOyB3OYEbdvr9DMSnyqvfTa5jPbXgx
         vyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8FX4tC7p+JOYCnGnRcDqk2SFBRANa3otX9d200AfRAw=;
        b=ywKQPNjbnSu++5pGGWXRQWJM4AX5Jdv3/qkhuDnAPL5M81QES0w/cQJ1uH+9YMmPvp
         FN9+GGeU54y/HvCWWS3zMr/+Fh7cWs86ywc83gJN6CUxGm/CefKQ1/UNomNJAx+WcvoF
         TuVa/2BmKlH+2ZykP0WDb7d+eGF6LPZCdlQGq3wvBkGIV1RM9JmT7F7eTZDBlnnKePJ9
         NqwcqmDay39oNIyl283kCz7/gztSH1/xt2J378xnGfQn4cNlCOcivBID91xDxGnoXFuc
         8PJYkvL6U58HDTiSro3MNAjnsNnIXxBBvJdFubfmGg1HyB5Zi8b1PYlhKuTeHBhANTVJ
         06vg==
X-Gm-Message-State: ANoB5pkkjtrU698mUCIzDyaFH1wMjkaKLUHAJNk3sEYiAZGzKzI9jRHa
        QO/V6WKzjnz3XCqQe9rHxukdag==
X-Google-Smtp-Source: AA0mqf6FXWZRAYDe7zgrqA22/Xz9LgSo98uwQ9/MCosGXiwgpsREZloBkrFD2RueBn2zs/JdIWkUtg==
X-Received: by 2002:a17:902:8494:b0:186:5f5a:5842 with SMTP id c20-20020a170902849400b001865f5a5842mr28618546plo.11.1671052630827;
        Wed, 14 Dec 2022 13:17:10 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id t9-20020a1709027fc900b001888cadf8f6sm2313013plb.49.2022.12.14.13.17.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Dec 2022 13:17:10 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <6EAF2A5A-FECE-42DE-9876-F1F06503F841@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_AFC4DC49-4C50-4304-ABF0-F4C09AC2802E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFCv1 16/72] tst_libext2fs_pthread: Add libext2fs merge/clone
 unit tests
Date:   Wed, 14 Dec 2022 14:17:08 -0700
In-Reply-To: <97f434ef290e793ef050cb5348bda7dd955be937.1667822611.git.ritesh.list@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wangshilong1991@gmail.com>, Li Xi <lixi@ddn.com>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
References: <cover.1667822611.git.ritesh.list@gmail.com>
 <97f434ef290e793ef050cb5348bda7dd955be937.1667822611.git.ritesh.list@gmail.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_AFC4DC49-4C50-4304-ABF0-F4C09AC2802E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 7, 2022, at 5:21 AM, Ritesh Harjani (IBM) <ritesh.list@gmail.com> =
wrote:
>=20
> This adds a unit tests for libext2fs merge/clone apis and uses =
pthreads
> to test the functionality correctly.
>=20
> TODO:
> We can also add EXT2FS_CLONE_BADBLOCKS and EXT2FS_CLONE_DBLIST test as =
well
> into it.
>=20
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> lib/ext2fs/Makefile.in             |  17 +-
> lib/ext2fs/tst_libext2fs_pthread.c | 315 +++++++++++++++++++++++++++++
> 2 files changed, 330 insertions(+), 2 deletions(-)
> create mode 100644 lib/ext2fs/tst_libext2fs_pthread.c
>=20
> diff --git a/lib/ext2fs/Makefile.in b/lib/ext2fs/Makefile.in
> index c0694175..5fde9900 100644
> --- a/lib/ext2fs/Makefile.in
> +++ b/lib/ext2fs/Makefile.in
> @@ -229,6 +229,7 @@ SRCS=3D ext2_err.c \
> 	$(srcdir)/tst_libext2fs.c \
> 	$(srcdir)/tst_bitmaps_standalone.c \
> 	$(srcdir)/tst_bitmaps_pthread.c \
> +	$(srcdir)/tst_libext2fs_pthread.c \
> 	$(DEBUG_SRCS)
>=20
> HFILES=3D bitops.h ext2fs.h ext2_io.h ext2_fs.h ext2_ext_attr.h =
ext3_extents.h \
> @@ -374,6 +375,11 @@ tst_bitmaps_pthread: tst_bitmaps_pthread.o =
$(STATIC_LIBEXT2FS) $(DEPSTATIC_LIBCO
> 	$(Q) $(CC) -o tst_bitmaps_pthread tst_bitmaps_pthread.o =
$(ALL_LDFLAGS) \
> 		$(STATIC_LIBEXT2FS) $(STATIC_LIBCOM_ERR) $(SYSLIBS)
>=20
> +tst_libext2fs_pthread: tst_libext2fs_pthread.o $(STATIC_LIBEXT2FS) =
$(DEPSTATIC_LIBCOM_ERR)
> +	$(E) "	LD $@"
> +	$(Q) $(CC) -o tst_libext2fs_pthread tst_libext2fs_pthread.o =
$(ALL_LDFLAGS) \
> +		$(STATIC_LIBEXT2FS) $(STATIC_LIBCOM_ERR) $(SYSLIBS)
> +
> ext2_tdbtool: tdbtool.o
> 	$(E) "	LD $@"
> 	$(Q) $(CC) -o ext2_tdbtool tdbtool.o tdb.o $(ALL_LDFLAGS) =
$(SYSLIBS)
> @@ -546,7 +552,7 @@ fullcheck check:: tst_bitops tst_badblocks =
tst_iscan tst_types tst_icount \
>     tst_super_size tst_types tst_inode_size tst_csum tst_crc32c =
tst_bitmaps \
>     tst_inline tst_inline_data tst_libext2fs tst_sha256 tst_sha512 \
>     tst_digest_encode tst_getsize tst_getsectsize =
tst_bitmaps_standalone \
> -	tst_bitmaps_pthread
> +	tst_bitmaps_pthread tst_libext2fs_pthread
> 	$(TESTENV) ./tst_bitops
> 	$(TESTENV) ./tst_badblocks
> 	$(TESTENV) ./tst_iscan
> @@ -571,6 +577,7 @@ fullcheck check:: tst_bitops tst_badblocks =
tst_iscan tst_types tst_icount \
> 	$(TESTENV) ./tst_digest_encode
> 	$(TESTENV) ./tst_bitmaps_standalone
> 	$(TESTENV) ./tst_bitmaps_pthread
> +	$(TESTENV) ./tst_libext2fs_pthread
>=20
> installdirs::
> 	$(E) "	MKDIR_P $(libdir) $(includedir)/ext2fs"
> @@ -606,7 +613,7 @@ clean::
> 		tst_bitmaps tst_bitmaps_out tst_extents tst_inline \
> 		tst_inline_data tst_inode_size tst_bitmaps_cmd.c \
> 		tst_digest_encode tst_sha256 tst_sha512  =
tst_bitmaps_standalone \
> -		tst_bitmaps_pthread \
> +		tst_bitmaps_pthread tst_libext2fs_pthread \
> 		ext2_tdbtool mkjournal debug_cmds.c tst_cmds.c =
extent_cmds.c \
> 		../libext2fs.a ../libext2fs_p.a ../libext2fs_chk.a \
> 		crc32c_table.h gen_crc32ctable tst_crc32c tst_libext2fs =
\
> @@ -1184,6 +1191,12 @@ tst_bitmaps_pthread.o: =
$(srcdir)/tst_bitmaps_pthread.c $(top_builddir)/lib/confi
>  $(srcdir)/ext2_fs.h $(srcdir)/ext3_extents.h =
$(top_srcdir)/lib/et/com_err.h \
>  $(srcdir)/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
>  $(srcdir)/ext2_ext_attr.h $(srcdir)/hashmap.h $(srcdir)/bitops.h
> +tst_libext2fs_pthread.o: $(srcdir)/tst_libext2fs_pthread.c =
$(top_builddir)/lib/config.h \
> + $(top_builddir)/lib/dirpaths.h $(srcdir)/ext2_fs.h \
> + $(top_builddir)/lib/ext2fs/ext2_types.h $(srcdir)/ext2fs.h \
> + $(srcdir)/ext2_fs.h $(srcdir)/ext3_extents.h =
$(top_srcdir)/lib/et/com_err.h \
> + $(srcdir)/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
> + $(srcdir)/ext2_ext_attr.h $(srcdir)/hashmap.h $(srcdir)/bitops.h
> undo_io.o: $(srcdir)/undo_io.c $(top_builddir)/lib/config.h \
>  $(top_builddir)/lib/dirpaths.h $(srcdir)/ext2_fs.h \
>  $(top_builddir)/lib/ext2fs/ext2_types.h $(srcdir)/ext2fs.h \
> diff --git a/lib/ext2fs/tst_libext2fs_pthread.c =
b/lib/ext2fs/tst_libext2fs_pthread.c
> new file mode 100644
> index 00000000..a5bb6fcd
> --- /dev/null
> +++ b/lib/ext2fs/tst_libext2fs_pthread.c
> @@ -0,0 +1,315 @@
> +#include "config.h"
> +#include <stdio.h>
> +#include <string.h>
> +#include <assert.h>
> +#if HAVE_UNISTD_H
> +#include <unistd.h>
> +#endif
> +#include <fcntl.h>
> +#include <time.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#if HAVE_ERRNO_H
> +#include <errno.h>
> +#endif
> +#if HAVE_PTHREAD
> +#include <pthread.h>
> +#endif
> +
> +#include "ext2_fs.h"
> +#include "ext2fs.h"
> +
> +#ifdef HAVE_PTHREAD
> +int test_fail =3D 0;
> +ext2_filsys testfs;
> +ext2fs_inode_bitmap	inode_used_map;
> +ext2fs_block_bitmap block_used_map;
> +ext2_filsys childfs[2];
> +pthread_t pthread_infos[2];
> +
> +#define nr_bits 16384
> +int nr_threads =3D 2;
> +
> +int should_mark_bit()
> +{
> +	return rand() % 2 =3D=3D 0;
> +}
> +
> +void setupfs()
> +{
> +	errcode_t retval;
> +	struct ext2_super_block param;
> +
> +	initialize_ext2_error_table();
> +
> +	memset(&param, 0, sizeof(param));
> +	ext2fs_blocks_count_set(&param, nr_bits);
> +	retval =3D ext2fs_initialize("test fs", EXT2_FLAG_64BITS, =
&param,
> +							   =
test_io_manager, &testfs);
> +	if (retval) {
> +		com_err("setup", retval, "while initializing =
filesystem");
> +		exit(1);
> +	}
> +
> +	retval =3D ext2fs_allocate_tables(testfs);
> +	if (retval) {
> +		com_err("setup", retval, "while allocating tables for =
testfs");
> +		exit(1);
> +	}
> +}
> +
> +void setup_used_bitmaps()
> +{
> +	int saved_type =3D testfs->default_bitmap_type;
> +	ext2_inode_scan scan;
> +	struct ext2_inode inode;
> +	ext2_ino_t ino;
> +	errcode_t retval;
> +	int i;
> +
> +	testfs->default_bitmap_type =3D EXT2FS_BMAP64_BITARRAY;
> +
> +	/* allocate block and inode used bitmaps */
> +	retval =3D ext2fs_allocate_block_bitmap(testfs, "block used =
map", &block_used_map);
> +	if (retval)
> +		goto out;
> +
> +	retval =3D ext2fs_allocate_inode_bitmap(testfs, "inode used =
map", &inode_used_map);
> +	if (retval)
> +		goto out;
> +
> +	/* setup block and inode used bitmaps */
> +	for (i =3D 1; i < nr_bits; i++) {
> +		/*
> +		 * we check for testfs->block_map as well since there =
could be some
> +		 * blocks already set as part of the FS metadata.
> +		 */
> +		if (should_mark_bit() || =
ext2fs_test_block_bitmap2(testfs->block_map, i)) {
> +			ext2fs_mark_block_bitmap2(block_used_map, i);
> +		}
> +	}
> +
> +	retval =3D ext2fs_open_inode_scan(testfs, 8, &scan);
> +	if (retval) {
> +		com_err("setup_inode_map", retval, "while open inode =
scan");
> +		exit(1);
> +	}
> +
> +	retval =3D ext2fs_get_next_inode(scan, &ino, &inode);
> +	if (retval) {
> +		com_err("setup_inode_map", retval, "while getting next =
inode");
> +		exit(1);
> +	}
> +
> +	while (ino) {
> +		if (should_mark_bit())
> +			ext2fs_mark_inode_bitmap2(inode_used_map, ino);
> +
> +		retval =3D ext2fs_get_next_inode(scan, &ino, &inode);
> +		if (retval) {
> +			com_err("setup_inode_map", retval, "while =
getting next inode");
> +			exit(1);
> +		}
> +	}
> +	ext2fs_close_inode_scan(scan);
> +
> +	testfs->default_bitmap_type =3D saved_type;
> +	return;
> +out:
> +	com_err("setup_used_bitmaps", retval, "while setting up =
bitmaps\n");
> +	exit(1);
> +}
> +
> +void setup_childfs()
> +{
> +	errcode_t retval;
> +	int i;
> +
> +	for (i =3D 0; i < nr_threads; i++) {
> +		retval =3D ext2fs_clone_fs(testfs, &childfs[i], =
EXT2FS_CLONE_INODE | EXT2FS_CLONE_BLOCK);
> +		if (retval) {
> +			com_err("setup_childfs", retval, "while clone =
testfs for childfs");
> +			exit(1);
> +		}
> +
> +		retval =3D =
childfs[i]->io->manager->open(childfs[i]->device_name,
> +										=
	IO_FLAG_THREADS | IO_FLAG_NOCACHE, &childfs[i]->io);
> +		if (retval) {
> +			com_err("setup_pthread", retval, "while opening =
childfs");
> +			exit(1);
> +		}
> +		assert(childfs[i]->parent =3D=3D testfs);
> +	}
> +}
> +
> +static errcode_t scan_callback(ext2_filsys fs,
> +			       ext2_inode_scan scan =
EXT2FS_ATTR((unused)),
> +			       dgrp_t group, void *priv_data)
> +{
> +	pthread_t id =3D *((pthread_t *)priv_data);
> +
> +	printf("%s: Called for group %d via thread %d\n", __func__, =
group,
> +			pthread_equal(pthread_infos[1], id));
> +	if (pthread_equal(pthread_infos[0], id)) {
> +		if (group >=3D fs->group_desc_count / 2 - 1)
> +			return 1;
> +	}
> +	return 0;
> +}
> +
> +static void *run_pthread(void *arg)
> +{
> +	errcode_t retval =3D 0;
> +	int i =3D 0, start, end;
> +	ext2fs_block_bitmap test_block_bitmap;
> +	ext2fs_inode_bitmap test_inode_bitmap;
> +	ext2_inode_scan scan;
> +	struct ext2_inode inode;
> +	ext2_ino_t ino;
> +	pthread_t id =3D pthread_self();
> +
> +	if (pthread_equal(pthread_infos[0], id)) {
> +		start =3D 1;
> +		end =3D nr_bits/2;
> +		test_block_bitmap =3D childfs[0]->block_map;
> +		test_inode_bitmap =3D childfs[0]->inode_map;
> +
> +		retval =3D ext2fs_open_inode_scan(childfs[0], 8, &scan);
> +		if (retval) {
> +			com_err("setup_inode_map", retval, "while open =
inode scan");
> +			exit(1);
> +		}
> +
> +	} else {
> +		start =3D nr_bits / 2 + 1;;
> +		end =3D nr_bits - 1;
> +		test_block_bitmap =3D childfs[1]->block_map;
> +		test_inode_bitmap =3D childfs[1]->inode_map;
> +
> +		retval =3D ext2fs_open_inode_scan(childfs[1], 8, &scan);
> +		if (retval) {
> +			com_err("setup_inode_map", retval, "while open =
inode scan");
> +			exit(1);
> +		}
> +		ext2fs_inode_scan_goto_blockgroup(scan, =
testfs->group_desc_count/2);
> +	}
> +
> +	ext2fs_set_inode_callback(scan, scan_callback, &id);
> +
> +	/* blocks scan */
> +	for (i =3D start; i <=3D end; i++) {
> +		if (ext2fs_test_block_bitmap2(block_used_map, i)) {
> +			ext2fs_mark_block_bitmap2(test_block_bitmap, i);
> +		}
> +	}
> +
> +	/* inodes scan */
> +	retval =3D ext2fs_get_next_inode(scan, &ino, &inode);
> +	if (retval) {
> +		com_err("setup_inode_map", retval, "while getting next =
inode");
> +		exit(1);
> +	}
> +
> +	while (ino) {
> +		if (ext2fs_test_inode_bitmap2(inode_used_map, ino)) {
> +			ext2fs_mark_inode_bitmap2(test_inode_bitmap, =
ino);
> +		}
> +
> +		retval =3D ext2fs_get_next_inode(scan, &ino, &inode);
> +		if (retval)
> +			break;
> +	}
> +	ext2fs_close_inode_scan(scan);
> +	return NULL;
> +}
> +
> +void run_pthreads()
> +{
> +	errcode_t retval;
> +	int i;
> +
> +	for (i =3D 0; i < nr_threads; i++) {
> +		printf("Starting thread (%d)\n", i);
> +		retval =3D pthread_create(&pthread_infos[i], NULL, =
&run_pthread, NULL);
> +		if (retval) {
> +			com_err("run_pthreads", retval, "while =
pthread_create");
> +			exit(1);
> +		}
> +	}
> +
> +	for (i =3D 0; i < nr_threads; i++) {
> +		void *status;
> +		int ret;
> +		retval =3D pthread_join(pthread_infos[i], &status);
> +		if (retval) {
> +			com_err("run_pthreads", retval, "while joining =
pthreads");
> +			exit(1);
> +
> +		}
> +		ret =3D status =3D=3D NULL ? 0 : *(int*)status;
> +		if (ret) {
> +			com_err("run_pthreads", ret, "pthread returned =
error");
> +			test_fail++;
> +		}
> +
> +		printf("Closing thread (%d), ret(%d)\n", i, ret);
> +	}
> +
> +	assert(ext2fs_merge_fs(&childfs[0]) =3D=3D 0);
> +	assert(ext2fs_merge_fs(&childfs[1]) =3D=3D 0);
> +}
> +
> +void test_bitmaps()
> +{
> +	errcode_t retval;
> +	retval =3D ext2fs_compare_block_bitmap(testfs->block_map, =
block_used_map);
> +	if (retval) {
> +		printf("Block bitmap compare -- NOT OK!! (%ld)\n", =
retval);
> +		test_fail++;
> +	}
> +
> +	printf("Block compare bitmap  -- OK!!\n");
> +	retval =3D ext2fs_compare_inode_bitmap(testfs->inode_map, =
inode_used_map);
> +	if (retval) {
> +		printf("Inode bitmap compare -- NOT OK!! (%ld)\n", =
retval);
> +		test_fail++;
> +	}
> +	printf("Inode compare bitmap  -- OK!!\n");
> +}
> +
> +void free_used_bitmaps()
> +{
> +	ext2fs_free_block_bitmap(block_used_map);
> +	ext2fs_free_inode_bitmap(inode_used_map);
> +}
> +
> +#endif
> +
> +int main(int argc, char *argv[])
> +{
> +	int i;
> +
> +#ifndef HAVE_PTHREAD
> +	printf("No PTHREAD support, exiting...\n");
> +	return 0;
> +#else
> +
> +	srand(time(0));
> +
> +	setupfs();
> +	setup_used_bitmaps();
> +
> +	setup_childfs();
> +	run_pthreads();
> +	test_bitmaps(i);
> +
> +	if (test_fail)
> +		printf("%s: Test libext2fs clone/merge with pthreads NOT =
OK!!\n", argv[0]);
> +	else
> +		printf("%s: Test libext2fs clone/merge with pthreads =
OK!!\n", argv[0]);
> +	free_used_bitmaps();
> +	ext2fs_free(testfs);
> +
> +	return test_fail;
> +#endif
> +}
> --
> 2.37.3
>=20


Cheers, Andreas






--Apple-Mail=_AFC4DC49-4C50-4304-ABF0-F4C09AC2802E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmOaPVQACgkQcqXauRfM
H+B6KQ//a/Xbk+WHcwMQ5CAkUWOqk3MLWYp09nFXfyyvGKDMNLELTtfGEuh0RkH9
58VK2SlQSlZXF5puPlerxm2W1iuo95SK9A/lqTWLapS7EH/Q7luDTozoBZ+u+WNp
gnNc1JSWxHHB8vfhNWdQ4zLLIUFFZJxX5l0dcjf0tGQTaK3eL6Kr7TRty4nwPYv/
13nAJhDtH3/UuC09JDtX9OHrj85n3MReTu60GkWIF0a6uxWTOTYFJfqqjpD/tECe
6Ja3KepPwLukteLEi4BN//4CFjQCUSrGJuNpcQnjbh3utp0xcQvZyN+9WGvB6b19
77cKVHTDQ2PtqHD+alvMIt82yGm8Laxwc2CBbUqjGVcmAiz+pNjMdGbTTXQNK0+k
EqkVSDV0sRtfjT6lPbSHFlB2FITSNZLdejDla324kGPjT34oie0FHaVi8+WapicA
q48APXmF8HGTd9AS8T6lUFKisEFvUaDL2SsTizA0F6DggBvDxAE3wqV7QrF7kLKb
gsiOFvfdtaZe2nXqkErTECeryQcQaFmHEwlw1fatbqUonct/NwVYx368PRLX09VP
RXfIII3DAo8MQsQbStd5BQUXih86VefosSnC2nuRJn/5lOt9xC7HncP+gO9ZWmb2
ijTRugw7J58MqViwgm/S8CuelchMjxH0v1TwF8R02rIt7zJbBvA=
=hZHl
-----END PGP SIGNATURE-----

--Apple-Mail=_AFC4DC49-4C50-4304-ABF0-F4C09AC2802E--
