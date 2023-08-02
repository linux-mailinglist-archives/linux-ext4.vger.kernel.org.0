Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9815F76D3A7
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Aug 2023 18:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjHBQ3w (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Aug 2023 12:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjHBQ3v (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Aug 2023 12:29:51 -0400
Received: from out203-205-251-60.mail.qq.com (out203-205-251-60.mail.qq.com [203.205.251.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFC11FFA
        for <linux-ext4@vger.kernel.org>; Wed,  2 Aug 2023 09:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1690993788;
        bh=CDRekWm6pd30PmXsiJ3YCcP2YoiZynmJooiM6qXd9ZQ=;
        h=From:To:Cc:Subject:Date;
        b=kCxmLk8x0dkMeXzq+NVfJxr3vJrPp82L7eREd2N8CBW5OLpG/xsTUR/kUikHs691s
         EdKv6L+AD5k3/LXI4wQk85/ASYhEUXfBG/JhzsCxG8DCpsg4ginUR0OWmSYYTTMbAP
         aM30CJpQPwzOZZ80IUEDV+VUop8ekwdb6zxrWCJ0=
Received: from fedora.. ([2409:8a00:2577:9740:9ca5:5f74:38db:4c67])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id 72B1AE0F; Thu, 03 Aug 2023 00:28:43 +0800
X-QQ-mid: xmsmtpt1690993723tmh2kf69l
Message-ID: <tencent_21AF0D446A9916ED5C51492CC6C9A0A77B05@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLO8hH8FyElRv9gO97SjxRlUY4JItgBYfGvblIkJbQHv9DqJFCId
         ci021TXSWY24vG9CvxYHLxKkgXaA4UCYwqYZV0wxEy0nG2LZ6Ngrt1zDtRXQXWnBCGaIN13SIy2s
         DJ6jsJBF1xSrparQCu/LIb5MfkkNrwLdbYNtn2HTnFd7b1cPw0eDEd0FX1bg2QgI+kwk4CK6/oU5
         HtlLBvHdcgdZrD8fgdiw0L6Pm8biJiQvRxHkRnTM4R3u5QpF4C0ocn/l7yiZHPDjZHhCm21/wOw8
         mD6/5ZMmReHxL/phdjZ5inm+Xo0cV/bhNZqTT3bNS4ukYBTi3lUc33GEEpHpeuE8FdNChnrW8afd
         P/RYOnNbg5IUUviFxOvG/V/E3k3gC86Wo6GZpujAax3GAx981/xSqo0yik67MUC5VD1dT70+KcW4
         zwSoDlHGscR6tADKw3kQuMVWtguljs5OW0xNz1mNcRBCdITLZG3NHJnTID4+51k11pv7vXcb5wZo
         5BMlydpcxzqkjXLupkO7l95T7abOEVFXjygShEVgJd1KgfHDz5PeOqr68QqtDBYyA9B2qAuMvmTL
         TlWEBkdUg2gfQj5NZmDR8n9JgWQPICG+mFgQ5Enpe1uqFZ1gM/90J041nyg64GN/Ce77i4RNGBez
         pQjOXqWLqeuSFBpi4knvB/EeMm6sqTfYXXipKo1GG00g8cGbJiL0RJSBTmkaEoqYsc3n3Fs9oK/t
         RdP01i0f960zc2B/j/+wzJVEApkhJPRAqbD2C4hEmMdn9dlp3+IhagF2pILGZvxP82ANs2Pqsvsp
         U8dKkuA6fDAjmn595WtWeQuOyJ4uK+7HxKuA7VYEs/beIrJU0TNIYv+BYV4ZVi0Ak/+TmBBX1mKP
         7uj6KEy1fnYhwzSV4FULy0YtujBF9afeFc2udzufHpzaF/qKLzJVQPiBxwba+zKczNjvBL2DGFV0
         v2R42r7eB81Q6AUNjWjT1yN/YstDSW4RLH5kriKyfmFKEjY2urF67JhfrXl0qB7RIV5AE5IgQEtJ
         q0vXBOwsUiVIDb2ke/6vvSrpdic9QaVEwwnAhQ/lyfb7wlY5vV
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From:   Wang Jianjian <wangjianjian0@foxmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Wang Jianjian <wangjianjian0@foxmail.com>
Subject: [PATCH 1/2] ext4: Ractor one helper ext4_num_base_meta_blocks
Date:   Thu,  3 Aug 2023 00:28:39 +0800
X-OQ-MSGID: <20230802162840.331385-1-wangjianjian0@foxmail.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Factor one helper ext4_num_base_meta_blocks and use it in next change.

Signed-off-by: Wang Jianjian <wangjianjian0@foxmail.com>
---
 fs/ext4/balloc.c | 15 +++++++++++----
 fs/ext4/ext4.h   |  2 ++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 1f72f977c6db..000056d05ce4 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -913,11 +913,11 @@ unsigned long ext4_bg_num_gdb(struct super_block *sb, ext4_group_t group)
 }
 
 /*
- * This function returns the number of file system metadata clusters at
+ * This function returns the number of file system metadata blocks at
  * the beginning of a block group, including the reserved gdt blocks.
  */
-static unsigned ext4_num_base_meta_clusters(struct super_block *sb,
-				     ext4_group_t block_group)
+unsigned ext4_num_base_meta_blocks(struct super_block *sb,
+				   ext4_group_t block_group)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	unsigned num;
@@ -935,8 +935,15 @@ static unsigned ext4_num_base_meta_clusters(struct super_block *sb,
 	} else { /* For META_BG_BLOCK_GROUPS */
 		num += ext4_bg_num_gdb_meta(sb, block_group);
 	}
-	return EXT4_NUM_B2C(sbi, num);
+	return num;
+}
+
+static unsigned ext4_num_base_meta_clusters(struct super_block *sb,
+					    ext4_group_t block_group)
+{
+	return EXT4_NUM_B2C(EXT4_SB(sb), ext4_num_base_meta_blocks(sb, block_group));
 }
+
 /**
  *	ext4_inode_to_goal_block - return a hint for block allocation
  *	@inode: inode for block allocation
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 0a2d55faa095..f9f329e1118e 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3084,6 +3084,8 @@ extern const char *ext4_decode_error(struct super_block *sb, int errno,
 extern void ext4_mark_group_bitmap_corrupted(struct super_block *sb,
 					     ext4_group_t block_group,
 					     unsigned int flags);
+unsigned ext4_num_base_meta_blocks(struct super_block *sb,
+				   ext4_group_t block_group);
 
 extern __printf(7, 8)
 void __ext4_error(struct super_block *, const char *, unsigned int, bool,
-- 
2.34.3

