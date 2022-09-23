Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD505E7BD4
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Sep 2022 15:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiIWN2o (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Sep 2022 09:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiIWN2e (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Sep 2022 09:28:34 -0400
Received: from shell.v3.sk (mail.v3.sk [167.172.186.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4559613BCE3
        for <linux-ext4@vger.kernel.org>; Fri, 23 Sep 2022 06:28:33 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 7D2F4E388A;
        Fri, 23 Sep 2022 13:14:59 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 7c61O-K0wscc; Fri, 23 Sep 2022 13:14:59 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 30B2FE388C;
        Fri, 23 Sep 2022 13:14:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lG-8kUw-xDL2; Fri, 23 Sep 2022 13:14:59 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 06DD1E388A;
        Fri, 23 Sep 2022 13:14:59 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] tune2fs: print error message when closing the fs fails
Date:   Fri, 23 Sep 2022 15:28:17 +0200
Message-Id: <20220923132817.1701711-1-lkundrak@v3.sk>
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

I encountered an I/O error on writing the superblock on a drive:

  ...
  pwrite64(3, ..., 114688, 97844727808) =3D 114688
  fsync(3) =3D -1 EIO (Input/output error)
  close(3) =3D 0
  ...

The error was silently ignored, only indicated by the exit value. Let's
print an error message.

The error message was taken from mke2fs in order to reuse the
translations.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 misc/tune2fs.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 088f87e5..d8ba4415 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -3745,5 +3745,13 @@ closefs:
=20
 	if (feature_64bit)
 		convert_64bit(fs, feature_64bit);
-	return (ext2fs_close_free(&fs) ? 1 : rc);
+
+	retval =3D ext2fs_close_free(&fs);
+	if (retval) {
+		com_err("tune2fs", retval,
+			_("while writing out and closing file system"));
+		rc =3D 1;
+	}
+
+	return rc;
 }
--=20
2.37.3

