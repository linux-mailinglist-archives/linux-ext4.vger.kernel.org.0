Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51B2622B62
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2019 07:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbfETFpc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 20 May 2019 01:45:32 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25410 "EHLO
        sender1.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725681AbfETFpc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 May 2019 01:45:32 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1558331126; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=WLQ5srmI8/Af+bB24IXY/0C5eVtlqjUvHeT6kKIOE1rYwErE5dNIh3oAuyS2iN9FM5Iba5B0ZUpqJ3ujiubseh1tJVX58Qwo2Vd7MQUATs23rMEIlDa/oupgzCPs1ZF1EoRnZpdUNAk5Sxgv9vPS5H702r1vVKExKF0ljXO0HmY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1558331126; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=KrMYO6YNDC2g3wQ8oqrdjWM/VDlXG9Xy8YobYnuYwKU=; 
        b=dE0hAL+bfeR/d8orPiGVA9EfR5h3LWEoP7XPzsPzJKB2BN1feICyUHeKIfZI7j034LAiKGSkNIaQbFrferTYLWe+0YOXhHFADksx2nemi4r6jWy/5MPMUsRxrz/7bHtrl7uEQcT8WjLiwOCgRK8Rx01NCXW4gPfCmNKNG/9uAd0=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1558331122720431.2317736858864; Mon, 20 May 2019 13:45:22 +0800 (CST)
From:   Chengguang Xu <cgxu519@zoho.com.cn>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@zoho.com.cn>
Message-ID: <20190520054503.26411-1-cgxu519@zoho.com.cn>
Subject: [PATCH] ext2: code cleanup by using test_opt() and clear_opt()
Date:   Mon, 20 May 2019 13:45:03 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Using test_opt() and clear_opt() instead of directly
comparing flag bit of mount option.

Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
---
 fs/ext2/super.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 3988633789cb..ca7229c38fce 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -302,16 +302,16 @@ static int ext2_show_options(struct seq_file *seq, struct dentry *root)
 	if (test_opt(sb, NOBH))
 		seq_puts(seq, ",nobh");
 
-	if (sbi->s_mount_opt & EXT2_MOUNT_USRQUOTA)
+	if (test_opt(sb, USRQUOTA))
 		seq_puts(seq, ",usrquota");
 
-	if (sbi->s_mount_opt & EXT2_MOUNT_GRPQUOTA)
+	if (test_opt(sb, GRPQUOTA))
 		seq_puts(seq, ",grpquota");
 
-	if (sbi->s_mount_opt & EXT2_MOUNT_XIP)
+	if (test_opt(sb, XIP))
 		seq_puts(seq, ",xip");
 
-	if (sbi->s_mount_opt & EXT2_MOUNT_DAX)
+	if (test_opt(sb, DAX))
 		seq_puts(seq, ",dax");
 
 	if (!test_opt(sb, RESERVATION))
@@ -934,8 +934,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->s_resgid = opts.s_resgid;
 
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
-		((EXT2_SB(sb)->s_mount_opt & EXT2_MOUNT_POSIX_ACL) ?
-		 SB_POSIXACL : 0);
+		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
 	sb->s_iflags |= SB_I_CGROUPWB;
 
 	if (le32_to_cpu(es->s_rev_level) == EXT2_GOOD_OLD_REV &&
@@ -966,11 +965,11 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 
 	blocksize = BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
 
-	if (sbi->s_mount_opt & EXT2_MOUNT_DAX) {
+	if (test_opt(sb, DAX)) {
 		if (!bdev_dax_supported(sb->s_bdev, blocksize)) {
 			ext2_msg(sb, KERN_ERR,
 				"DAX unsupported by block device. Turning off DAX.");
-			sbi->s_mount_opt &= ~EXT2_MOUNT_DAX;
+			clear_opt(sbi->s_mount_opt, DAX);
 		}
 	}
 
@@ -1403,7 +1402,7 @@ static int ext2_remount (struct super_block * sb, int * flags, char * data)
 	sbi->s_resuid = new_opts.s_resuid;
 	sbi->s_resgid = new_opts.s_resgid;
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
-		((sbi->s_mount_opt & EXT2_MOUNT_POSIX_ACL) ? SB_POSIXACL : 0);
+		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
 	spin_unlock(&sbi->s_lock);
 
 	return 0;
-- 
2.20.1



