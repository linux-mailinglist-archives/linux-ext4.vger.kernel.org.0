Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905473D70E5
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Jul 2021 10:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbhG0IJK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Jul 2021 04:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235920AbhG0IJH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Jul 2021 04:09:07 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237A8C061757
        for <linux-ext4@vger.kernel.org>; Tue, 27 Jul 2021 01:09:07 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1627373345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=76lFqIk0L/rqRGFiepD1eR8XhHM9TGiJAs6Dn11W9WU=;
        b=VwUr+Sac00+jHNgIqrOsnaTKOpw0bae4zQXmfy1ZBqIruO72wbV5TTWGotsgll2iYYWV6J
        nUQx6eRo6Qwq0OEM4or0ZVq34sgBdNxN8c1Hh22XYNenF/xHPHHpLP5w3Md0yNflIXsmbJ
        glCuRfDY4vvHaSrZnfupCQjMmpOpFJo=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH] ext4: reduce arguments of ext4_fc_add_dentry_tlv
Date:   Tue, 27 Jul 2021 16:07:08 +0800
Message-Id: <20210727080708.3708814-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: guoqing.jiang@linux.dev
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Guoqing Jiang <jiangguoqing@kylinos.cn>

Let's pass fc_dentry directly since those arguments (tag, parent_ino and
ino etc) can be deferenced from it.

Signed-off-by: Guoqing Jiang <jiangguoqing@kylinos.cn>
---
 fs/ext4/fast_commit.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 5106c9fe2e19..797105adcabf 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -775,28 +775,27 @@ static bool ext4_fc_add_tlv(struct super_block *sb, u16 tag, u16 len, u8 *val,
 }
 
 /* Same as above, but adds dentry tlv. */
-static  bool ext4_fc_add_dentry_tlv(struct super_block *sb, u16 tag,
-					int parent_ino, int ino, int dlen,
-					const unsigned char *dname,
-					u32 *crc)
+static bool ext4_fc_add_dentry_tlv(struct super_block *sb, u32 *crc,
+				   struct ext4_fc_dentry_update *fc_dentry)
 {
 	struct ext4_fc_dentry_info fcd;
 	struct ext4_fc_tl tl;
+	int dlen = fc_dentry->fcd_name.len;
 	u8 *dst = ext4_fc_reserve_space(sb, sizeof(tl) + sizeof(fcd) + dlen,
 					crc);
 
 	if (!dst)
 		return false;
 
-	fcd.fc_parent_ino = cpu_to_le32(parent_ino);
-	fcd.fc_ino = cpu_to_le32(ino);
-	tl.fc_tag = cpu_to_le16(tag);
+	fcd.fc_parent_ino = cpu_to_le32(fc_dentry->fcd_parent);
+	fcd.fc_ino = cpu_to_le32(fc_dentry->fcd_ino);
+	tl.fc_tag = cpu_to_le16(fc_dentry->fcd_op);
 	tl.fc_len = cpu_to_le16(sizeof(fcd) + dlen);
 	ext4_fc_memcpy(sb, dst, &tl, sizeof(tl), crc);
 	dst += sizeof(tl);
 	ext4_fc_memcpy(sb, dst, &fcd, sizeof(fcd), crc);
 	dst += sizeof(fcd);
-	ext4_fc_memcpy(sb, dst, dname, dlen, crc);
+	ext4_fc_memcpy(sb, dst, fc_dentry->fcd_name.name, dlen, crc);
 	dst += dlen;
 
 	return true;
@@ -991,11 +990,7 @@ __acquires(&sbi->s_fc_lock)
 				 &sbi->s_fc_dentry_q[FC_Q_MAIN], fcd_list) {
 		if (fc_dentry->fcd_op != EXT4_FC_TAG_CREAT) {
 			spin_unlock(&sbi->s_fc_lock);
-			if (!ext4_fc_add_dentry_tlv(
-				sb, fc_dentry->fcd_op,
-				fc_dentry->fcd_parent, fc_dentry->fcd_ino,
-				fc_dentry->fcd_name.len,
-				fc_dentry->fcd_name.name, crc)) {
+			if (!ext4_fc_add_dentry_tlv(sb, crc, fc_dentry)) {
 				ret = -ENOSPC;
 				goto lock_and_exit;
 			}
@@ -1034,11 +1029,7 @@ __acquires(&sbi->s_fc_lock)
 		if (ret)
 			goto lock_and_exit;
 
-		if (!ext4_fc_add_dentry_tlv(
-			sb, fc_dentry->fcd_op,
-			fc_dentry->fcd_parent, fc_dentry->fcd_ino,
-			fc_dentry->fcd_name.len,
-			fc_dentry->fcd_name.name, crc)) {
+		if (!ext4_fc_add_dentry_tlv(sb, crc, fc_dentry)) {
 			ret = -ENOSPC;
 			goto lock_and_exit;
 		}
-- 
2.25.1

