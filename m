Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFD25E7BD0
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Sep 2022 15:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiIWN1y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Sep 2022 09:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiIWN1v (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Sep 2022 09:27:51 -0400
X-Greylist: delayed 97 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Sep 2022 06:27:49 PDT
Received: from shell.v3.sk (mail.v3.sk [167.172.186.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81B812578B
        for <linux-ext4@vger.kernel.org>; Fri, 23 Sep 2022 06:27:49 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 9D834E388A;
        Fri, 23 Sep 2022 13:14:16 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id OMSlAu1y-a6v; Fri, 23 Sep 2022 13:14:16 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 2344FE388C;
        Fri, 23 Sep 2022 13:14:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id M9D6GjivpmpN; Fri, 23 Sep 2022 13:14:15 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id C22E8E388A;
        Fri, 23 Sep 2022 13:14:15 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] tune2fs: fix a NULL dereference on failed journal replay
Date:   Fri, 23 Sep 2022 15:27:35 +0200
Message-Id: <20220923132735.1701587-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Got a crash:

  Starting program: e2fsprogs-1.46.5/misc/tune2fs -O ^has_journal -ff /de=
v/sdh2
  tune2fs 1.46.5 (30-Dec-2021)
  Recovering journal.
  tune2fs: Unknown code ____ 251 while recovering journal.
  Please run e2fsck -fy /dev/sdh2.

  Program received signal SIGSEGV, Segmentation fault.
  0x00007ffff7f8565a in ext2fs_mmp_stop (fs=3D0x0) at ../mmp.c:405
  405		if (!ext2fs_has_feature_mmp(fs->super) ||
  (gdb) bt
  #0  0x00007ffff7f8565a in ext2fs_mmp_stop (fs=3D0x0) at ../mmp.c:405
  #1  0x000055555555acd8 in main (argc=3D<optimized out>, argv=3D<optimiz=
ed out>) at /home/lkundrak/fedora/e2fsprogs/e2fsprogs-1.46.5/misc/tune2fs=
.c:3441
  (gdb)

Turns out, ext2fs_run_ext3_journal() can close fs and then fail. If that
happened, we shall not jump to closefs:, quit right away instead.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 misc/tune2fs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 088f87e5..96cfd001 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -3345,7 +3345,10 @@ _("Warning: The journal is dirty. You may wish to =
replay the journal like:\n\n"
 				"while recovering journal.\n");
 			printf(_("Please run e2fsck -fy %s.\n"), argv[1]);
 			rc =3D 1;
-			goto closefs;
+			if (fs)
+				goto closefs;
+			else
+				return 1;
 		}
 		sb =3D fs->super;
 	}
--=20
2.37.3

