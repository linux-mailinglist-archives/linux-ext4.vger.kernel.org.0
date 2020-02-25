Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1227A16C400
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Feb 2020 15:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbgBYOew (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Feb 2020 09:34:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56238 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729189AbgBYOew (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 Feb 2020 09:34:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582641291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RqeHMlIId/RZ+ZTgAnSGv9m1lAvQY0yxoNemzfQHX+4=;
        b=T0yorn9GUF37ph6MDz2/2iOpG75uPY/Z9N2IUBmRadvdcRCekQ46g5uzTja70lY2qkLjYP
        YIj0O9n5s/rYRiBWUiOBGlHC+HJqoOWqcQnLcIephrt6WDYrAoWTB+JoxvidZ4lqKt/aJS
        DKP4bVm5KZBiJiQ54B6E39RMVHzruLk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-G_waKcD_MYKXkl5H8I_L0w-1; Tue, 25 Feb 2020 09:34:49 -0500
X-MC-Unique: G_waKcD_MYKXkl5H8I_L0w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E52FB1083E86;
        Tue, 25 Feb 2020 14:34:48 +0000 (UTC)
Received: from localhost.localdomain (ovpn-204-127.brq.redhat.com [10.40.204.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6E081001902;
        Tue, 25 Feb 2020 14:34:47 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Zdenek Kabelac <zkabelac@redhat.com>,
        Karel Zak <kzak@redhat.com>
Subject: [PATCH] libext2fs/ismounted.c: check open(O_EXCL) before mntent file
Date:   Tue, 25 Feb 2020 15:34:45 +0100
Message-Id: <20200225143445.13182-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Currently the ext2fs_check_mount_point() will use the open(O_EXCL) check
on linux after all the other checks are done. However it is not
necessary to check mntent if open(O_EXCL) succeeds because it means that
the device is not mounted.

Moreover the commit ea4d53b7 introduced a regression where a following
set of commands fails:

vgcreate mygroup /dev/sda
lvcreate -L 1G -n lvol0 mygroup
mkfs.ext4 /dev/mygroup/lvol0
mount /dev/mygroup/lvol0 /mnt
lvrename /dev/mygroup/lvol0 /dev/mygroup/lvol1
lvcreate -L 1G -n lvol0 mygroup
mkfs.ext4 /dev/mygroup/lvol0   <<<--- This fails

It fails because it thinks that /dev/mygroup/lvol0 is mounted because
the device name in /proc/mounts is not updated following the lvrename.

Move the open(O_EXCL) check before the mntent check and return
immediatelly if the device is not busy.

Fixes: ea4d53b7 ("libext2fs/ismounted.c: check device id in advance to sk=
ip false device names")
Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Reported-by: Zdenek Kabelac <zkabelac@redhat.com>
Reported-by: Karel Zak <kzak@redhat.com>
---
 lib/ext2fs/ismounted.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/lib/ext2fs/ismounted.c b/lib/ext2fs/ismounted.c
index c0215692..f4ef012f 100644
--- a/lib/ext2fs/ismounted.c
+++ b/lib/ext2fs/ismounted.c
@@ -352,6 +352,7 @@ errcode_t ext2fs_check_mount_point(const char *device=
, int *mount_flags,
 				  char *mtpt, int mtlen)
 {
 	errcode_t	retval =3D 0;
+	int 		busy =3D 0;
=20
 	if (getenv("EXT2FS_PRETEND_RO_MOUNT")) {
 		*mount_flags =3D EXT2_MF_MOUNTED | EXT2_MF_READONLY;
@@ -366,6 +367,29 @@ errcode_t ext2fs_check_mount_point(const char *devic=
e, int *mount_flags,
 		return 0;
 	}
=20
+#ifdef __linux__ /* This only works on Linux 2.6+ systems */
+	{
+		struct stat st_buf;
+
+		if (stat(device, &st_buf) =3D=3D 0 &&
+		    ext2fsP_is_disk_device(st_buf.st_mode)) {
+			int fd =3D open(device, O_RDONLY | O_EXCL);
+
+			if (fd >=3D 0) {
+				/*
+				 * The device is not busy so it's
+				 * definitelly not mounted. No need to
+				 * to perform any more checks.
+				 */
+				close(fd);
+				*mount_flags =3D 0;
+				return 0;
+			} else if (errno =3D=3D EBUSY)
+				busy =3D 1;
+		}
+	}
+#endif
+
 	if (is_swap_device(device)) {
 		*mount_flags =3D EXT2_MF_MOUNTED | EXT2_MF_SWAP;
 		strncpy(mtpt, "<swap>", mtlen);
@@ -386,21 +410,8 @@ errcode_t ext2fs_check_mount_point(const char *devic=
e, int *mount_flags,
 	if (retval)
 		return retval;
=20
-#ifdef __linux__ /* This only works on Linux 2.6+ systems */
-	{
-		struct stat st_buf;
-
-		if (stat(device, &st_buf) =3D=3D 0 &&
-		    ext2fsP_is_disk_device(st_buf.st_mode)) {
-			int fd =3D open(device, O_RDONLY | O_EXCL);
-
-			if (fd >=3D 0)
-				close(fd);
-			else if (errno =3D=3D EBUSY)
-				*mount_flags |=3D EXT2_MF_BUSY;
-		}
-	}
-#endif
+	if (busy)
+		*mount_flags |=3D EXT2_MF_BUSY;
=20
 	return 0;
 }
--=20
2.21.1

