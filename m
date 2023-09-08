Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FAE79841A
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Sep 2023 10:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbjIHIdl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Sep 2023 04:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjIHIdk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Sep 2023 04:33:40 -0400
X-Greylist: delayed 485 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Sep 2023 01:33:35 PDT
Received: from forward203a.mail.yandex.net (forward203a.mail.yandex.net [178.154.239.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C9B173B;
        Fri,  8 Sep 2023 01:33:35 -0700 (PDT)
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d101])
        by forward203a.mail.yandex.net (Yandex) with ESMTP id 3355049E67;
        Fri,  8 Sep 2023 11:25:35 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c22:d84:0:640:51d4:0])
        by forward101a.mail.yandex.net (Yandex) with ESMTP id DF56D46CF2;
        Fri,  8 Sep 2023 11:25:27 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id wOVVrT8sBGk0-PaIM82ev;
        Fri, 08 Sep 2023 11:25:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
        s=mail; t=1694161527;
        bh=6LlgzI/85Pk4J8qFq//D8a9U2PULpp5tGzFPXAv+w98=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=XJyDho6ncCc1cRwPObnh2C+Ax7jeKkj2/P3pqvdqaWMXsuO1QKa8G53AJdRvze3Ue
         tBlFJSgxVAW6HczFb+oXzVybC9ULPMuDmS3xwTuqEGb8/dyrGwJGKxWu9RGRjq0O5i
         GGr28faaVSLBgcdE+oTuTs092pIuxZPRIA0bxAwk=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From:   onur-ozkan <work@onurozkan.dev>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        onur-ozkan <work@onurozkan.dev>
Subject: [PATCH] fs: micro optimizations in ext4/xattr
Date:   Fri,  8 Sep 2023 11:24:56 +0300
Message-ID: <20230908082456.25983-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Improve the `ext4_xattr_inode_read` function slightly by using the
constant literal(from `MAX_BHS_SIZE`) for the `bhs_inline` initialization
and in the size checking condition as a replacement for `ARRAY_SIZE`.

Additionally, in the `ext4_xattr_cmp function, remove the `if` block to
improve code readability and clarity.

Signed-off-by: onur-ozkan <work@onurozkan.dev>
---
 fs/ext4/xattr.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 92ba28cebac6..e749aab8a152 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -376,6 +376,8 @@ static void ext4_xattr_inode_set_hash(struct inode *ea_inode, u32 hash)
 	ea_inode->i_atime.tv_sec = hash;
 }
 
+#define MAX_BHS_SIZE 8
+
 /*
  * Read the EA value from an inode.
  */
@@ -384,11 +386,11 @@ static int ext4_xattr_inode_read(struct inode *ea_inode, void *buf, size_t size)
 	int blocksize = 1 << ea_inode->i_blkbits;
 	int bh_count = (size + blocksize - 1) >> ea_inode->i_blkbits;
 	int tail_size = (size % blocksize) ?: blocksize;
-	struct buffer_head *bhs_inline[8];
+	struct buffer_head *bhs_inline[MAX_BHS_SIZE];
 	struct buffer_head **bhs = bhs_inline;
 	int i, ret;
 
-	if (bh_count > ARRAY_SIZE(bhs_inline)) {
+	if (bh_count > MAX_BHS_SIZE) {
 		bhs = kmalloc_array(bh_count, sizeof(*bhs), GFP_NOFS);
 		if (!bhs)
 			return -ENOMEM;
@@ -3093,9 +3095,8 @@ ext4_xattr_cmp(struct ext4_xattr_header *header1,
 		entry1 = EXT4_XATTR_NEXT(entry1);
 		entry2 = EXT4_XATTR_NEXT(entry2);
 	}
-	if (!IS_LAST_ENTRY(entry2))
-		return 1;
-	return 0;
+
+	return (IS_LAST_ENTRY(entry2)) ? 0 : 1;
 }
 
 /*
-- 
2.42.0

