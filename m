Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375437A340B
	for <lists+linux-ext4@lfdr.de>; Sun, 17 Sep 2023 09:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjIQHDw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 17 Sep 2023 03:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjIQHDm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 17 Sep 2023 03:03:42 -0400
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD6612F
        for <linux-ext4@vger.kernel.org>; Sun, 17 Sep 2023 00:03:35 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id hloaqFL4Xr3Xehlobq2VOd; Sun, 17 Sep 2023 09:03:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1694934213;
        bh=2fqQXXMdIZvdAOxGhxK9XXxf9aMwLimzUQK9Weept9E=;
        h=From:To:Cc:Subject:Date;
        b=bx88y+Xvyg2H9W+pXyxhRjj4NoS/c5bSDvXGmSc5u2cwRU11/YekmvOSmlhAW5tdS
         2W/xOYiyZLjPOY+PRtnbyiPFmp/RbtP+LX/FFLS9QsHCykOdbkuGKpc5zgu1p7gqzQ
         kMJYktJKrEwxwPgx7XRJUzcIlkU3QH38pSWcuv223YJM3rW0Xxl26NAncKThJ4OaTG
         HAevUPMqR+DXtf4tnEmhvlCA1UO6oGgUph9xKDrAhNRWt2F6TQjRTZKNC3CKuJBJEu
         +U1nhvUrnh099UipBYu9X6s9PN6rctGAPcXCAw4dIC4UnPTFgddefLIGxLe3WEVtGE
         jDDRzev93RBkA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 17 Sep 2023 09:03:33 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-ext4@vger.kernel.org
Subject: [PATCH v2] ext4: Simplify code in ext4_decode_error()
Date:   Sun, 17 Sep 2023 09:03:28 +0200
Message-Id: <4c299692e35a0a14add58a5dd399d07843a4d350.1694934182.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

snprintf() returns the number of characters which would be generated,
excluding the trailing NULL. Here the value is always >= 7, so the test
is always true.

Instead of fixing the test, just remove it. What matters is that the
string is NULL terminated.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2:
   - remove the bogus check, instead of fixing it
   - Remove the Fixes tag (was: ac27a0ec112a ("[PATCH] ext4: initial copy of files from ext3"))

v1:
   https://lore.kernel.org/all/2c0edffd8557807c6cd6d55111482c5cad7c8f2f.1694275603.git.christophe.jaillet@wanadoo.fr/

The comment about nbuf being NULL or not, and the related test could be
removed, but keeping it is harmless and more future proof.
---
 fs/ext4/super.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 2684ed69403e..86ed931f402a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -947,9 +947,8 @@ const char *ext4_decode_error(struct super_block *sb, int errno,
 		 * errors, textualise them now.  Else we just return
 		 * NULL. */
 		if (nbuf) {
-			/* Check for truncated error codes... */
-			if (snprintf(nbuf, 16, "error %d", -errno) >= 0)
-				errstr = nbuf;
+			snprintf(nbuf, 16, "error %d", -errno);
+			errstr = nbuf;
 		}
 		break;
 	}
-- 
2.34.1

