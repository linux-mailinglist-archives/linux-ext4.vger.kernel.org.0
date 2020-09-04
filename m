Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1E725E356
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Sep 2020 23:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgIDVeb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Sep 2020 17:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgIDVea (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Sep 2020 17:34:30 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AE1C061244
        for <linux-ext4@vger.kernel.org>; Fri,  4 Sep 2020 14:34:30 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id u13so4985281pgh.1
        for <linux-ext4@vger.kernel.org>; Fri, 04 Sep 2020 14:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:mime-version:subject:date:references:cc:to:message-id;
        bh=Nvm5ixnsX7umo2+Hn8rx4s7xvIUmVSHJvnCU8v1R0jg=;
        b=fj5xk0Cfg+ywu1p1ETVxNe3Xj5HjXXRiRrqBNPa3nJIB8YUxm6RkeWD84eeufIVsIk
         zO5oAq/jnIi/42etceO2/udJhKdR4bLqZXrB6XkqjQqiDdK+Nt+rKXj965aw627eDZwL
         YIH9kCKmeo8X31LyqiyHaNplRcZU8l/kUczjiXxFINvcBMqsIyLFAuSjowT0mgSqQUuI
         je/rJd47mII/8BS/8JG/CpL1IWmhNSTcIjaEc4+GfX8RaYmuZ3/7SeD5HLP+JPeu+LVP
         S2GaeFOM/q5bJ56MsqpVvZy3sAN48KSp5zGc64/qmkCe8xpiV4QgyUs11xnUvVKIRLUo
         7jGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:subject:date:references:cc:to
         :message-id;
        bh=Nvm5ixnsX7umo2+Hn8rx4s7xvIUmVSHJvnCU8v1R0jg=;
        b=PomvyYkg1nYgjaM2uAWIZBve5BT2+K9eyi7EZmtRzIahmZJHhzRlAFYOoMGOj6o8c4
         InSrHGFbNjm+XxbwDewkKptWX9w614aqd7UJcWQ7N9Ky6pzwHcM1d1/r5qOv9+OwrFws
         CbbCX5PnqMQFtbFKOKInj+yCG66Fq5CCgAbsaNkws0fvC7rI4GXsdX8RAtpHPnCGdhMG
         SDVpQT1z6T8lDqjuEjZrqkEFthXKJ9W3N3YOKu47Ld3Hd90akUnrf/JHYeXnDHb9guaP
         RxMXEmmWD1di5u6+AIOT+fl4CIPvK+xtIBTA2Fhr9t8JaI4hfK8KxPXNlu3Me2NPm5fW
         HyJA==
X-Gm-Message-State: AOAM532b976f0H8M1vFCWDN7x9rOObC1+x+msAlSxNSKx1vG6c1xz0iS
        pxorUnRUJYm8QNt3Xr36tbSUBWoVdilGA+6W
X-Google-Smtp-Source: ABdhPJx2SEP/lP7rBumYnYB5dRSDClFnxscWkq0IamJbV1WVdwt+55TiCn8TxMKrpNynoE2FoD3izg==
X-Received: by 2002:a63:dc4a:: with SMTP id f10mr8446922pgj.394.1599255269439;
        Fri, 04 Sep 2020 14:34:29 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id x9sm6836779pgi.87.2020.09.04.14.34.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2020 14:34:28 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_89CB6BFF-D1AB-4847-92BE-4A431E9364B7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Fwd: [PATCH] [RFC] ext2fs: parallel bitmap loading
Date:   Fri, 4 Sep 2020 15:34:26 -0600
References: <CA+OwuSj-WjaPbfOSDpg5Mz2tm_W0p40N-L=meiWEDZ6j1ccq=Q@mail.gmail.com>
Cc:     Wang Shilong <wangshilong1991@gmail.com>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Message-Id: <132401FE-6D25-41B3-99D1-50E7BC746237@dilger.ca>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_89CB6BFF-D1AB-4847-92BE-4A431E9364B7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

This is a patch that is part of the parallel e2fsck series that Shilong =
is working on,
and does not work by itself, but was requested during discussion on the =
ext4
concall today.


Cheers, Andreas
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46rom dba9e324999727e6cc2ca158cc01f0053a701db9 Mon Sep 17 00:00:00 2001
From: Wang Shilong <wshilong@ddn.com>
Date: Thu, 3 Sep 2020 10:51:49 +0800
Subject: [PATCH] RFC ext2fs: parallel bitmap loading

In our benchmarking for PiB size filesystem, pass5 takes
10446s to finish and 99.5% of time taken on reading bitmaps.

It makes sense to read the bitmaps using multiple threads,
a quickly benchmark show 10446s to 883s with 64 threads.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 lib/ext2fs/rw_bitmaps.c | 260 ++++++++++++++++++++++++++++++++++------
 1 file changed, 224 insertions(+), 36 deletions(-)

diff --git a/lib/ext2fs/rw_bitmaps.c b/lib/ext2fs/rw_bitmaps.c
index d80c9eb8..323949f5 100644
--- a/lib/ext2fs/rw_bitmaps.c
+++ b/lib/ext2fs/rw_bitmaps.c
@@ -23,6 +23,7 @@
 #ifdef HAVE_SYS_TYPES_H
 #include <sys/types.h>
 #endif
+#include <pthread.h>

 #include "ext2_fs.h"
 #include "ext2fs.h"
@@ -205,22 +206,12 @@ static int bitmap_tail_verify(unsigned char =
*bitmap, int first, int last)
 	return 1;
 }

-static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int =
do_block)
+static errcode_t read_bitmaps_range_prepare(ext2_filsys fs, int =
do_inode, int do_block)
 {
-	dgrp_t i;
-	char *block_bitmap =3D 0, *inode_bitmap =3D 0;
-	char *buf;
 	errcode_t retval;
 	int block_nbytes =3D EXT2_CLUSTERS_PER_GROUP(fs->super) / 8;
 	int inode_nbytes =3D EXT2_INODES_PER_GROUP(fs->super) / 8;
-	int tail_flags =3D 0;
-	int csum_flag;
-	unsigned int	cnt;
-	blk64_t	blk;
-	blk64_t	blk_itr =3D EXT2FS_B2C(fs, =
fs->super->s_first_data_block);
-	blk64_t   blk_cnt;
-	ext2_ino_t ino_itr =3D 1;
-	ext2_ino_t ino_cnt;
+	char *buf;

 	EXT2_CHECK_MAGIC(fs, EXT2_ET_MAGIC_EXT2FS_FILSYS);

@@ -230,11 +221,10 @@ static errcode_t read_bitmaps(ext2_filsys fs, int =
do_inode, int do_block)

 	fs->write_bitmaps =3D ext2fs_write_bitmaps;

-	csum_flag =3D ext2fs_has_group_desc_csum(fs);
-
 	retval =3D ext2fs_get_mem(strlen(fs->device_name) + 80, &buf);
 	if (retval)
 		return retval;
+
 	if (do_block) {
 		if (fs->block_map)
 			ext2fs_free_block_bitmap(fs->block_map);
@@ -243,11 +233,8 @@ static errcode_t read_bitmaps(ext2_filsys fs, int =
do_inode, int do_block)
 		retval =3D ext2fs_allocate_block_bitmap(fs, buf, =
&fs->block_map);
 		if (retval)
 			goto cleanup;
-		retval =3D io_channel_alloc_buf(fs->io, 0, =
&block_bitmap);
-		if (retval)
-			goto cleanup;
-	} else
-		block_nbytes =3D 0;
+	}
+
 	if (do_inode) {
 		if (fs->inode_map)
 			ext2fs_free_inode_bitmap(fs->inode_map);
@@ -256,12 +243,60 @@ static errcode_t read_bitmaps(ext2_filsys fs, int =
do_inode, int do_block)
 		retval =3D ext2fs_allocate_inode_bitmap(fs, buf, =
&fs->inode_map);
 		if (retval)
 			goto cleanup;
+	}
+	ext2fs_free_mem(&buf);
+
+	return retval;
+
+cleanup:
+	if (do_block) {
+		ext2fs_free_block_bitmap(fs->block_map);
+		fs->block_map =3D 0;
+	}
+	if (do_inode) {
+		ext2fs_free_inode_bitmap(fs->inode_map);
+		fs->inode_map =3D 0;
+	}
+	if (buf)
+		ext2fs_free_mem(&buf);
+	return retval;
+}
+
+static errcode_t read_bitmaps_range_start(ext2_filsys fs, int do_inode, =
int do_block,
+					  dgrp_t start, dgrp_t end, =
pthread_mutex_t *mutex)
+{
+	dgrp_t i;
+	char *block_bitmap =3D 0, *inode_bitmap =3D 0;
+	char *buf;
+	errcode_t retval;
+	int block_nbytes =3D EXT2_CLUSTERS_PER_GROUP(fs->super) / 8;
+	int inode_nbytes =3D EXT2_INODES_PER_GROUP(fs->super) / 8;
+	int tail_flags =3D 0;
+	int csum_flag;
+	unsigned int	cnt;
+	blk64_t	blk;
+	blk64_t	blk_itr =3D EXT2FS_B2C(fs, =
fs->super->s_first_data_block);
+	blk64_t   blk_cnt;
+	ext2_ino_t ino_itr =3D 1;
+	ext2_ino_t ino_cnt;
+
+	csum_flag =3D ext2fs_has_group_desc_csum(fs);
+
+	if (do_block) {
+		retval =3D io_channel_alloc_buf(fs->io, 0, =
&block_bitmap);
+		if (retval)
+			goto cleanup;
+	} else {
+		block_nbytes =3D 0;
+	}
+
+	if (do_inode) {
 		retval =3D io_channel_alloc_buf(fs->io, 0, =
&inode_bitmap);
 		if (retval)
 			goto cleanup;
-	} else
+	} else {
 		inode_nbytes =3D 0;
-	ext2fs_free_mem(&buf);
+	}

 	if (fs->flags & EXT2_FLAG_IMAGE_FILE) {
 		blk =3D =
(ext2fs_le32_to_cpu(fs->image_header->offset_inodemap) / fs->blocksize);
@@ -303,7 +338,9 @@ static errcode_t read_bitmaps(ext2_filsys fs, int =
do_inode, int do_block)
 		goto success_cleanup;
 	}

-	for (i =3D 0; i < fs->group_desc_count; i++) {
+	blk_itr +=3D (block_nbytes << 3) * start;
+	ino_itr +=3D (inode_nbytes << 3) * start;
+	for (i =3D start; i <=3D end; i++) {
 		if (block_bitmap) {
 			blk =3D ext2fs_block_bitmap_loc(fs, i);
 			if ((csum_flag &&
@@ -333,8 +370,12 @@ static errcode_t read_bitmaps(ext2_filsys fs, int =
do_inode, int do_block)
 			} else
 				memset(block_bitmap, 0, block_nbytes);
 			cnt =3D block_nbytes << 3;
+			if (mutex)
+				pthread_mutex_lock(mutex);
 			retval =3D =
ext2fs_set_block_bitmap_range2(fs->block_map,
 					       blk_itr, cnt, =
block_bitmap);
+			if (mutex)
+				pthread_mutex_unlock(mutex);
 			if (retval)
 				goto cleanup;
 			blk_itr +=3D block_nbytes << 3;
@@ -369,29 +410,28 @@ static errcode_t read_bitmaps(ext2_filsys fs, int =
do_inode, int do_block)
 			} else
 				memset(inode_bitmap, 0, inode_nbytes);
 			cnt =3D inode_nbytes << 3;
+			if (mutex)
+				pthread_mutex_lock(mutex);
 			retval =3D =
ext2fs_set_inode_bitmap_range2(fs->inode_map,
 					       ino_itr, cnt, =
inode_bitmap);
+			if (mutex)
+				pthread_mutex_unlock(mutex);
 			if (retval)
 				goto cleanup;
 			ino_itr +=3D inode_nbytes << 3;
 		}
 	}

-	/* Mark group blocks for any BLOCK_UNINIT groups */
-	if (do_block) {
-		retval =3D mark_uninit_bg_group_blocks(fs);
-		if (retval)
-			goto cleanup;
-	}
-
 success_cleanup:
-	if (inode_bitmap) {
-		ext2fs_free_mem(&inode_bitmap);
-		fs->flags &=3D ~EXT2_FLAG_IBITMAP_TAIL_PROBLEM;
-	}
-	if (block_bitmap) {
-		ext2fs_free_mem(&block_bitmap);
-		fs->flags &=3D ~EXT2_FLAG_BBITMAP_TAIL_PROBLEM;
+	if (start =3D=3D 0 && end =3D=3D fs->group_desc_count - 1) {
+		if (inode_bitmap) {
+			ext2fs_free_mem(&inode_bitmap);
+			fs->flags &=3D ~EXT2_FLAG_IBITMAP_TAIL_PROBLEM;
+		}
+		if (block_bitmap) {
+			ext2fs_free_mem(&block_bitmap);
+			fs->flags &=3D ~EXT2_FLAG_BBITMAP_TAIL_PROBLEM;
+		}
 	}
 	fs->flags |=3D tail_flags;
 	return 0;
@@ -412,6 +452,154 @@ cleanup:
 	if (buf)
 		ext2fs_free_mem(&buf);
 	return retval;
+
+}
+
+static errcode_t read_bitmaps_range_end(ext2_filsys fs, int do_inode, =
int do_block)
+{
+	errcode_t retval =3D 0;
+
+	/* Mark group blocks for any BLOCK_UNINIT groups */
+	if (do_block) {
+		retval =3D mark_uninit_bg_group_blocks(fs);
+		if (retval)
+			goto cleanup;
+	}
+
+	return retval;
+cleanup:
+	if (do_block) {
+		ext2fs_free_block_bitmap(fs->block_map);
+		fs->block_map =3D 0;
+	}
+	if (do_inode) {
+		ext2fs_free_inode_bitmap(fs->inode_map);
+		fs->inode_map =3D 0;
+	}
+	return retval;
+}
+
+static errcode_t read_bitmaps_range(ext2_filsys fs, int do_inode, int =
do_block,
+				    dgrp_t start, dgrp_t end)
+{
+	errcode_t retval;
+
+	retval =3D read_bitmaps_range_prepare(fs, do_inode, do_block);
+	if (retval)
+		return retval;
+
+	retval =3D read_bitmaps_range_start(fs, do_inode, do_block, =
start, end, NULL);
+	if (retval)
+		return retval;
+
+	return read_bitmaps_range_end(fs, do_inode, do_block);
+}
+
+struct read_bitmaps_thread_info {
+	ext2_filsys	rbt_fs;
+	int 		rbt_do_inode;
+	int		rbt_do_block;
+	dgrp_t		rbt_grp_start;
+	dgrp_t		rbt_grp_end;
+	errcode_t	rbt_retval;
+	pthread_mutex_t *rbt_mutex;
+};
+
+static void* read_bitmaps_thread(void *data)
+{
+	struct read_bitmaps_thread_info *rbt =3D data;
+
+	rbt->rbt_retval =3D read_bitmaps_range_start(rbt->rbt_fs,
+				rbt->rbt_do_inode, rbt->rbt_do_block,
+				rbt->rbt_grp_start, rbt->rbt_grp_end,
+				rbt->rbt_mutex);
+	return NULL;
+}
+
+static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int =
do_block)
+{
+	pthread_attr_t	attr;
+	int num_threads =3D fs->fs_num_threads;
+	pthread_t *thread_ids =3D NULL;
+	struct read_bitmaps_thread_info *thread_infos =3D NULL;
+	pthread_mutex_t rbt_mutex =3D PTHREAD_MUTEX_INITIALIZER;
+	errcode_t retval;
+	errcode_t rc;
+	dgrp_t average_group;
+	int i;
+
+	if (num_threads <=3D 1 || (fs->flags & EXT2_FLAG_IMAGE_FILE))
+		return read_bitmaps_range(fs, do_inode, do_block, 0, =
fs->group_desc_count - 1);
+
+	retval =3D pthread_attr_init(&attr);
+	if (retval)
+		return retval;
+
+	thread_ids =3D calloc(sizeof(pthread_t), num_threads);
+	if (!thread_ids)
+		return -ENOMEM;
+
+	thread_infos =3D calloc(sizeof(struct read_bitmaps_thread_info),
+				num_threads);
+	if (!thread_infos)
+		goto out;
+
+	average_group =3D fs->group_desc_count / num_threads;
+	if (average_group =3D=3D 0)
+		average_group =3D 1;
+
+	retval =3D read_bitmaps_range_prepare(fs, do_inode, do_block);
+	if (retval)
+		goto out;
+
+	fprintf(stdout, "Multiple threads triggered to read bitmaps\n");
+	for (i =3D 0; i < num_threads; i++) {
+		thread_infos[i].rbt_fs =3D fs;
+		thread_infos[i].rbt_do_inode =3D do_inode;
+		thread_infos[i].rbt_do_block =3D do_block;
+		thread_infos[i].rbt_mutex =3D &rbt_mutex;
+		if (i =3D=3D 0)
+			thread_infos[i].rbt_grp_start =3D 0;
+		else
+			thread_infos[i].rbt_grp_start =3D average_group =
* i + 1;
+
+		if (i =3D=3D num_threads - 1)
+			thread_infos[i].rbt_grp_end =3D =
fs->group_desc_count - 1;
+		else
+			thread_infos[i].rbt_grp_end =3D average_group * =
(i + 1);
+		retval =3D pthread_create(&thread_ids[i], &attr,
+					&read_bitmaps_thread, =
&thread_infos[i]);
+		if (retval)
+			break;
+	}
+	for (i =3D 0; i < num_threads; i++) {
+		if (!thread_ids[i])
+			break;
+		rc =3D pthread_join(thread_ids[i], NULL);
+		if (rc && !retval)
+			retval =3D rc;
+		rc =3D thread_infos[i].rbt_retval;
+		if (rc && !retval)
+			retval =3D rc;
+	}
+out:
+	rc =3D pthread_attr_destroy(&attr);
+	if (rc && !retval)
+		retval =3D rc;
+	free(thread_infos);
+	free(thread_ids);
+
+	if (!retval)
+		retval =3D read_bitmaps_range_end(fs, do_inode, =
do_block);
+
+	if (!retval) {
+		if (do_inode)
+			fs->flags &=3D ~EXT2_FLAG_IBITMAP_TAIL_PROBLEM;
+		if (do_block)
+			fs->flags &=3D ~EXT2_FLAG_BBITMAP_TAIL_PROBLEM;
+	}
+
+	return retval;
 }

 errcode_t ext2fs_read_inode_bitmap(ext2_filsys fs)
--
2.25.4

Cheers, Andreas






--Apple-Mail=_89CB6BFF-D1AB-4847-92BE-4A431E9364B7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl9SsuIACgkQcqXauRfM
H+Ah0w/+JCHJCtqMpSRzlkUsXs9BwPT6EqqaGX0+GywxVAX5NKF/qwhgBhNheADX
AuAvEX7oo/3uug2UE6vnoFIVuDdb78HTyCVqEwDWCgXl4qrCZ6BSN0oR7lWurlCj
wO3imQiEkribPx9kjj2SQH2UfjIb16deP2zkcBRieMfqq43cyimlpteZQ9Xo0GMb
63nW79v76uTC2j7N3Mn9+oxOCR4bcogmVBWQIT34tklhBf504fHdLpn8hCmkkEjS
Q6bfLEl77Y5HeS+zFLKRl8pPkmgdWNsE42/fOSPN7yjpEIBhmXZxpeAptr0SQoXR
A07K5mstNA0GIZ9HrM13rEUkf1mW/J70MU2ibRJ4bXfpB++exQF2M1672aaHKbx0
BmkqHu/7jQcI3VBpd1/bfp6ztY9RUfp77eTLtV3UfjYezHfRIjPZ42WOPo/WNZIK
ov0zq+qT1H2UJ8xgaYrrNdFFVns0srCUpmWBBYKCyLbzwWwoJEZhpOJ5tdYBq1/k
IteMvgiRrYhrpO48zB/aQrowYjchMz96jfY7JXEwL9TjAH7O4fg8nP+rjy1N6v5w
zAu232tXh1HwM8N8LDrLNJidx89VfT64A12mJpur6eZ3nOXuo18PxzsXRTCgh6wD
qFtp/1izLzirp1Y5q2YXaoUl8P4fU83FWrdamXneMIUvKAwFk1E=
=Myk4
-----END PGP SIGNATURE-----

--Apple-Mail=_89CB6BFF-D1AB-4847-92BE-4A431E9364B7--
