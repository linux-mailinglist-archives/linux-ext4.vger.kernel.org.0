Return-Path: <linux-ext4+bounces-6150-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C79A14B2A
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jan 2025 09:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4201E3A7F80
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jan 2025 08:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0A11F91EB;
	Fri, 17 Jan 2025 08:28:52 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5BD1F8929;
	Fri, 17 Jan 2025 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737102532; cv=none; b=tEN7jLzEeBRWgb+B3fyJjwNNO9XFgTEBW6OvMC0Jo+i/lUrjjMhBHV4cL8EZpitOBcBqBNoCoMqTLzDEsLLALxCkA/18Hnh/T+scO4BYlsj5LA87na9Filxltbuq3/EUF2TkUjP6jUcu+NpTID2coUI61TJ6quncWcNjrCxum1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737102532; c=relaxed/simple;
	bh=BSUDrswNPQuPsEB6ImGQqdtp5+65EUxWIdLv13OWBNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IPgZJ4b0dhDWqdD2kvxgo2fB8fs/223O18qTDj2FX4HLQIIQ4dV04Kj73Z31cvIK2jxk+Ntz8NCuq8PCz7naCn4gEfZYM3JR4A+j/Y/uc2pSWDTDcNqnYP9pha7iZtIGoekGIHFw0BqJoGLR8X8/1cjL1NHcLqD3+nhnE+AIn4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YZCYW0v9pz4f3jqx;
	Fri, 17 Jan 2025 16:28:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 62B831A13C7;
	Fri, 17 Jan 2025 16:28:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDHKl+5FIpnZbnIBA--.46013S8;
	Fri, 17 Jan 2025 16:28:46 +0800 (CST)
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
Subject: [PATCH 4/7] ext4: add ext4_sb_rdonly() helper function
Date: Fri, 17 Jan 2025 16:23:12 +0800
Message-Id: <20250117082315.2869996-5-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250117082315.2869996-1-libaokun@huaweicloud.com>
References: <20250117082315.2869996-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHKl+5FIpnZbnIBA--.46013S8
X-Coremail-Antispam: 1UD129KBjvJXoWxurWfCw4xurWkCry8tw48tFb_yoWrtF1fpr
	s8CFy09F4j9F1DuwsrGFWUXw1agw40ya4jkrW5Cr1rXry5trn5AF4UtF1YvF17J398uF1f
	uF4jyrW7Wrs7CrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
	1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0wCY1x
	0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC2
	0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
	0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv2
	0xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
	IE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZF
	pf9x0JU9Aw3UUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgALBWeKD3kBggACsW

From: Baokun Li <libaokun1@huawei.com>

Because both SB_RDONLY and EXT4_FLAGS_EMERGENCY_RO indicate the file system
is read-only, the ext4_sb_rdonly() helper function is added. This function
returns true if either flag is set, signifying that the file system is
read-only.

Then replace some sb_rdonly() with ext4_sb_rdonly() to avoid unexpected
failures of some read-only operations or modification of the superblock
after setting EXT4_FLAGS_EMERGENCY_RO.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/ext4.h  |  5 +++++
 fs/ext4/file.c  |  2 +-
 fs/ext4/ioctl.c |  2 +-
 fs/ext4/super.c | 17 +++++++++--------
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index ca01b476e42b..610c18036dc8 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2258,6 +2258,11 @@ static inline int ext4_is_emergency(struct super_block *sb)
 	return 0;
 }
 
+static inline int ext4_sb_rdonly(struct super_block *sb)
+{
+	return sb_rdonly(sb) || ext4_emergency_ro(sb);
+}
+
 /*
  * Default values for user and/or group using reserved blocks
  */
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 6db052a87b9b..70b556c87b88 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -844,7 +844,7 @@ static int ext4_sample_last_mounted(struct super_block *sb,
 	if (likely(ext4_test_mount_flag(sb, EXT4_MF_MNTDIR_SAMPLED)))
 		return 0;
 
-	if (sb_rdonly(sb) || !sb_start_intwrite_trylock(sb))
+	if (ext4_sb_rdonly(sb) || !sb_start_intwrite_trylock(sb))
 		return 0;
 
 	ext4_set_mount_flag(sb, EXT4_MF_MNTDIR_SAMPLED);
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 7b9ce71c1c81..0807ee8cbcdc 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1705,7 +1705,7 @@ int ext4_update_overhead(struct super_block *sb, bool force)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 
-	if (sb_rdonly(sb))
+	if (ext4_sb_rdonly(sb))
 		return 0;
 	if (!force &&
 	    (sbi->s_overhead == 0 ||
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c12133628ee9..fc5d30123f22 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -473,7 +473,7 @@ static void ext4_maybe_update_superblock(struct super_block *sb)
 	__u64 lifetime_write_kbytes;
 	__u64 diff_size;
 
-	if (sb_rdonly(sb) || !(sb->s_flags & SB_ACTIVE) ||
+	if (ext4_sb_rdonly(sb) || !(sb->s_flags & SB_ACTIVE) ||
 	    !journal || (journal->j_flags & JBD2_UNMOUNT))
 		return;
 
@@ -707,7 +707,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
 	if (test_opt(sb, WARN_ON_ERROR))
 		WARN_ON_ONCE(1);
 
-	if (!continue_fs && !sb_rdonly(sb)) {
+	if (!continue_fs && !ext4_sb_rdonly(sb)) {
 		set_bit(EXT4_FLAGS_SHUTDOWN, &EXT4_SB(sb)->s_ext4_flags);
 		if (journal)
 			jbd2_journal_abort(journal, -EIO);
@@ -737,7 +737,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
 			sb->s_id);
 	}
 
-	if (sb_rdonly(sb) || continue_fs)
+	if (ext4_sb_rdonly(sb) || continue_fs)
 		return;
 
 	ext4_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
@@ -765,7 +765,7 @@ static void update_super_work(struct work_struct *work)
 	 * We use directly jbd2 functions here to avoid recursing back into
 	 * ext4 error handling code during handling of previous errors.
 	 */
-	if (!sb_rdonly(sbi->s_sb) && journal) {
+	if (!ext4_sb_rdonly(sbi->s_sb) && journal) {
 		struct buffer_head *sbh = sbi->s_sbh;
 		bool call_notify_err = false;
 
@@ -1325,12 +1325,12 @@ static void ext4_put_super(struct super_block *sb)
 	ext4_mb_release(sb);
 	ext4_ext_release(sb);
 
-	if (!sb_rdonly(sb) && !aborted) {
+	if (!ext4_sb_rdonly(sb) && !aborted) {
 		ext4_clear_feature_journal_needs_recovery(sb);
 		ext4_clear_feature_orphan_present(sb);
 		es->s_state = cpu_to_le16(sbi->s_mount_state);
 	}
-	if (!sb_rdonly(sb))
+	if (!ext4_sb_rdonly(sb))
 		ext4_commit_super(sb);
 
 	ext4_group_desc_free(sbi);
@@ -3693,7 +3693,8 @@ static int ext4_run_li_request(struct ext4_li_request *elr)
 		if (group >= elr->lr_next_group) {
 			ret = 1;
 			if (elr->lr_first_not_zeroed != ngroups &&
-			    !sb_rdonly(sb) && test_opt(sb, INIT_INODE_TABLE)) {
+			    !ext4_sb_rdonly(sb) &&
+			    test_opt(sb, INIT_INODE_TABLE)) {
 				elr->lr_next_group = elr->lr_first_not_zeroed;
 				elr->lr_mode = EXT4_LI_MODE_ITABLE;
 				ret = 0;
@@ -3998,7 +3999,7 @@ int ext4_register_li_request(struct super_block *sb,
 		goto out;
 	}
 
-	if (sb_rdonly(sb) ||
+	if (ext4_sb_rdonly(sb) ||
 	    (test_opt(sb, NO_PREFETCH_BLOCK_BITMAPS) &&
 	     (first_not_zeroed == ngroups || !test_opt(sb, INIT_INODE_TABLE))))
 		goto out;
-- 
2.39.2


