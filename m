Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F62714DB71
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Jan 2020 14:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgA3NVa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Jan 2020 08:21:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60027 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727107AbgA3NVa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 Jan 2020 08:21:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580390489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IBzUATVju8YTQ/uviNYY3Cvxp+1AyiDXnfoMaHE/e/I=;
        b=ZzJq7tuX+KSke4wurkY7GRnIzIatfMAaS6BCpCsHosDQJ5g4uCxE807uPrvwpZQFnxCJxy
        vcMAWfSXO7TQJ4Kx5/zH3O76vamE94BO3EHZwri5euIkpH/rZlOTjw/v2GfivIzTHToVi7
        qt367nx4WvGf/ZiPMUlOAGcFoPKgXOk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-AajAqSq-Pw-7U_wsj_oDCA-1; Thu, 30 Jan 2020 08:21:27 -0500
X-MC-Unique: AajAqSq-Pw-7U_wsj_oDCA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CE0F800D41;
        Thu, 30 Jan 2020 13:21:26 +0000 (UTC)
Received: from localhost.localdomain (ovpn-204-170.brq.redhat.com [10.40.204.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7456F77950;
        Thu, 30 Jan 2020 13:21:25 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu
Subject: [PATCH] tst_libext2fs: Avoid multiple definition of global variables
Date:   Thu, 30 Jan 2020 14:21:22 +0100
Message-Id: <20200130132122.21150-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

gcc version 10 changed the default from -fcommon to -fno-common and as a
result e2fsprogs unit tests fail because tst_libext2fs.c end up with a
build error.

This is because it defines two global variables debug_prog_name and
extra_cmds that are already defined in debugfs/debugfs.c. With -fcommon
linker was able to resolve those into the same object, however with
-fno-common it's no longer able to do it and we end up with
multiple definition errors.

Fix the problem by creating an extern declaration of said variables in
debugfs.h and just setting them in tst_libext2fs.c without additional
declaration.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 debugfs/debugfs.h          | 2 ++
 lib/ext2fs/tst_libext2fs.c | 5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/debugfs/debugfs.h b/debugfs/debugfs.h
index 477d9bbb..956517bc 100644
--- a/debugfs/debugfs.h
+++ b/debugfs/debugfs.h
@@ -123,6 +123,8 @@ extern void do_set_block_group_descriptor(int argc, c=
har **, int sci_idx, void *
 extern void do_dump_unused(int argc, char **argv, int sci_idx, void *inf=
op);
=20
 /* debugfs.c */
+extern ss_request_table *extra_cmds;
+extern const char *debug_prog_name;
 extern void internal_dump_inode(FILE *, const char *, ext2_ino_t,
 				struct ext2_inode *, int);
=20
diff --git a/lib/ext2fs/tst_libext2fs.c b/lib/ext2fs/tst_libext2fs.c
index 3e7497cd..43f0d153 100644
--- a/lib/ext2fs/tst_libext2fs.c
+++ b/lib/ext2fs/tst_libext2fs.c
@@ -28,9 +28,7 @@
  * Hook in new commands into debugfs
  * Override debugfs's prompt
  */
-const char *debug_prog_name =3D "tst_libext2fs";
 extern ss_request_table libext2fs_cmds;
-ss_request_table *extra_cmds =3D &libext2fs_cmds;
=20
 static int print_blocks_proc(ext2_filsys fs EXT2FS_ATTR((unused)),
 			     blk64_t *blocknr, e2_blkcnt_t blockcnt,
@@ -51,6 +49,9 @@ void do_block_iterate(int argc, char **argv, int sci_id=
x EXT2FS_ATTR((unused)),
 	int		err =3D 0;
 	int		flags =3D 0;
=20
+	debug_prog_name =3D "tst_libext2fs";
+	extra_cmds =3D &libext2fs_cmds;
+
 	if (common_args_process(argc, argv, 2, 3, argv[0], usage, 0))
 		return;
=20
--=20
2.21.1

