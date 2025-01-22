Return-Path: <linux-ext4+bounces-6204-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF59CA19068
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 12:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F5477A58BC
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 11:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3761A2139DF;
	Wed, 22 Jan 2025 11:11:37 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF43D212D93;
	Wed, 22 Jan 2025 11:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737544297; cv=none; b=Nc/vN9kdobe3dAcbbjs8LKA2DOdn6J/RX7u8wY2AA3iGP8/UnMgK7A4nBWX9wKndEajJ/TcV5Xsmdo4n92ceulBl0g3kIo9d/EqFL7COpOmOGztRu4Vo8bFvGXiPGUuxyuTWfNQG8ReLQCcVrNIO2/o+nKh7v29MEk/8eHYbZWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737544297; c=relaxed/simple;
	bh=R1jCJ6y5Tv4MS7qx6LhEZuVE6xGSFDVZyrn94jDkQQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cEMH4RQ6bBEbwEA7p45CjxRP/fG1TVT5NkHMP9TCrzAMCwlA0rzRdM0kYpLB9ckwboYaSf3as3WbiyjljCOak4Ib0b1feN6yt27W2tc0XDdpeOCw5Jzph90ehw61yNwFOaaVkY1rLRhAMgbPJesFK1JxgT+n0WV88wCODr0QtmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YdLwn5yKrz4f3jd5;
	Wed, 22 Jan 2025 19:11:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 742361A1331;
	Wed, 22 Jan 2025 19:11:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAni19Z0pBnW0KsBg--.50502S8;
	Wed, 22 Jan 2025 19:11:26 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun@huaweicloud.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH v3 4/9] ext4: extract ext4_has_journal_option() from __ext4_fill_super()
Date: Wed, 22 Jan 2025 19:05:28 +0800
Message-Id: <20250122110533.4116662-5-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250122110533.4116662-1-libaokun@huaweicloud.com>
References: <20250122110533.4116662-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAni19Z0pBnW0KsBg--.50502S8
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4kXw17Xry7Zw4kKw48JFb_yoW5Ww17pF
	ZxZryIyrW8ZF1kurs7GFs5JrWrWw40ka48GrZ29F1kX39FyryIg348tFyYqFyaqFWxGw18
	XFy0k3W8u34jkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPG14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24lc7
	CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
	x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
	v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IY
	x2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
	Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIF
	yTuYvjfUYl19UUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAQBWeQpvkM+wAAsI

From: Baokun Li <libaokun1@huawei.com>

Extract the ext4_has_journal_option() helper function to reduce code
duplication. No functional changes.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 50 ++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 34a7b6523f8b..8bff0d3f807e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5020,6 +5020,24 @@ static int ext4_check_journal_data_mode(struct super_block *sb)
 	return 0;
 }
 
+static const char *ext4_has_journal_option(struct super_block *sb)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+
+	if (test_opt(sb, JOURNAL_ASYNC_COMMIT))
+		return "journal_async_commit";
+	if (test_opt2(sb, EXPLICIT_JOURNAL_CHECKSUM))
+		return "journal_checksum";
+	if (sbi->s_commit_interval != JBD2_DEFAULT_MAX_COMMIT_AGE*HZ)
+		return "commit=";
+	if (EXT4_MOUNT_DATA_FLAGS &
+	    (sbi->s_mount_opt ^ sbi->s_def_mount_opt))
+		return "data=";
+	if (test_opt(sb, DATA_ERR_ABORT))
+		return "data_err=abort";
+	return NULL;
+}
+
 static int ext4_load_super(struct super_block *sb, ext4_fsblk_t *lsb,
 			   int silent)
 {
@@ -5411,35 +5429,17 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		       "suppressed and not mounted read-only");
 		goto failed_mount3a;
 	} else {
-		/* Nojournal mode, all journal mount options are illegal */
-		if (test_opt(sb, JOURNAL_ASYNC_COMMIT)) {
-			ext4_msg(sb, KERN_ERR, "can't mount with "
-				 "journal_async_commit, fs mounted w/o journal");
-			goto failed_mount3a;
-		}
+		const char *journal_option;
 
-		if (test_opt2(sb, EXPLICIT_JOURNAL_CHECKSUM)) {
-			ext4_msg(sb, KERN_ERR, "can't mount with "
-				 "journal_checksum, fs mounted w/o journal");
-			goto failed_mount3a;
-		}
-		if (sbi->s_commit_interval != JBD2_DEFAULT_MAX_COMMIT_AGE*HZ) {
-			ext4_msg(sb, KERN_ERR, "can't mount with "
-				 "commit=%lu, fs mounted w/o journal",
-				 sbi->s_commit_interval / HZ);
-			goto failed_mount3a;
-		}
-		if (EXT4_MOUNT_DATA_FLAGS &
-		    (sbi->s_mount_opt ^ sbi->s_def_mount_opt)) {
-			ext4_msg(sb, KERN_ERR, "can't mount with "
-				 "data=, fs mounted w/o journal");
-			goto failed_mount3a;
-		}
-		if (test_opt(sb, DATA_ERR_ABORT)) {
+		/* Nojournal mode, all journal mount options are illegal */
+		journal_option = ext4_has_journal_option(sb);
+		if (journal_option != NULL) {
 			ext4_msg(sb, KERN_ERR,
-				 "can't mount with data_err=abort, fs mounted w/o journal");
+				 "can't mount with %s, fs mounted w/o journal",
+				 journal_option);
 			goto failed_mount3a;
 		}
+
 		sbi->s_def_mount_opt &= ~EXT4_MOUNT_JOURNAL_CHECKSUM;
 		clear_opt(sb, JOURNAL_CHECKSUM);
 		clear_opt(sb, DATA_FLAGS);
-- 
2.39.2


