Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C68881777D7
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Mar 2020 14:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgCCNx5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Mar 2020 08:53:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44251 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727585AbgCCNx5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Mar 2020 08:53:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583243636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ou45CDmoGgxQtOQjQhYGAj4mIV8n4ICScH2/4oWCOoM=;
        b=AinVYJM/FHHUx6ZRJb76aqlmKMuDuEDKGx1csvsbW2dZk0CIU1Lq6LDc+u2H8RrOCGgUql
        UdJcCLpgpB24sz2mOoTNxRpB/i6pAkDC6nKXqLd1lcVygNVYVmHUnbpKDWXRjyvhF2kOXY
        2LC8UHYASXoUDtB+dY3kyGNXtvseCxk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-fWPXsB2lMbyekBSw3drjMA-1; Tue, 03 Mar 2020 08:53:54 -0500
X-MC-Unique: fWPXsB2lMbyekBSw3drjMA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E5FC13E4;
        Tue,  3 Mar 2020 13:53:53 +0000 (UTC)
Received: from localhost.localdomain (ovpn-205-84.brq.redhat.com [10.40.205.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A2BFD5C1D8;
        Tue,  3 Mar 2020 13:53:49 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Zdenek Kabelac <zkabelac@redhat.com>,
        Karel Zak <kzak@redhat.com>,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: [PATCH v2] libext2fs/ismounted.c: check open(O_EXCL) before mntent file
Date:   Tue,  3 Mar 2020 14:53:48 +0100
Message-Id: <20200303135348.20827-1-lczerner@redhat.com>
In-Reply-To: <20200225143445.13182-1-lczerner@redhat.com>
References: <20200225143445.13182-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 lib/ext2fs/ismounted.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/lib/ext2fs/ismounted.c b/lib/ext2fs/ismounted.c
index c0215692..46d330d9 100644
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
@@ -366,6 +367,30 @@ errcode_t ext2fs_check_mount_point(const char *devic=
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
+			} else if (errno =3D=3D EBUSY) {
+				busy =3D 1;
+			}
+		}
+	}
+#endif
+
 	if (is_swap_device(device)) {
 		*mount_flags =3D EXT2_MF_MOUNTED | EXT2_MF_SWAP;
 		strncpy(mtpt, "<swap>", mtlen);
@@ -386,21 +411,8 @@ errcode_t ext2fs_check_mount_point(const char *devic=
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

