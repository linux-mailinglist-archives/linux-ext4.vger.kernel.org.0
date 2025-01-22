Return-Path: <linux-ext4+bounces-6212-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEB9A190E8
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 12:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3EF188B723
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 11:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5BA211A3C;
	Wed, 22 Jan 2025 11:47:32 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4101213259;
	Wed, 22 Jan 2025 11:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737546452; cv=none; b=uJD466oIlgtmyaH2TQVI63/Y/4EBrVde/FBASoDoiXRjAyp4Il7tJ++ZOKeYwSUK++SRszDXjzaikhEsA/0AChVAjn53xFjwUcPOwc8b/YLRJ/NsK5lwk+vmKAuaHIEL+PyMIB38B+VIgLO3jYabFZcDxtgTapdeZfCQ8MQcrJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737546452; c=relaxed/simple;
	bh=Y5SLBH7WRj6oFXP6VqSS0YJXbX94IIpfq+HcBcgSuqY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GXpILEbOVScsVfyrR/kNFIQgr+W8OqdwWKhvwBmboP4uE648ODVneWM9RqahLBjssGXTsVmaVdU28FtbFvjj64xv3QPHevE6/EWgHgrBuq81x4LbhHu2unHCJEv9oKgN74ym0oOqlg1gW4+i1BAk+WF24hSXQ3kgXP6YUwUxqKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YdMkL2pm4z4f3jqr;
	Wed, 22 Jan 2025 19:47:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D280D1A0DF0;
	Wed, 22 Jan 2025 19:47:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgD3Wl_F2pBn0KiuBg--.48765S8;
	Wed, 22 Jan 2025 19:47:21 +0800 (CST)
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
Subject: [PATCH v2 4/7] ext4: add more ext4_emergency_state() checks around sb_rdonly()
Date: Wed, 22 Jan 2025 19:41:27 +0800
Message-Id: <20250122114130.229709-5-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250122114130.229709-1-libaokun@huaweicloud.com>
References: <20250122114130.229709-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3Wl_F2pBn0KiuBg--.48765S8
X-Coremail-Antispam: 1UD129KBjvJXoWxXr4UAw47uryfWryftryUtrb_yoWrXw1Dpr
	nYkFykZFWj9w1DuanrGF15XryFgw4IyFyUurW3ur1rXFyDtrn5AFsrtF1FvF17ZrW5Wr1x
	WF4jyrZrur47CrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPC14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI
	43ZEXa7VUbT7KDUUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAQBWeQpvMO7AAAsU

From: Baokun Li <libaokun1@huawei.com>

Some functions check sb_rdonly() to make sure the file system isn't
modified after it's read-only. Since we also don't want the file system
modified if it's in an emergency state (shutdown or emergency_ro),
we're adding additional ext4_emergency_state() checks where sb_rdonly()
is checked.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/file.c  |  3 ++-
 fs/ext4/ioctl.c |  2 +-
 fs/ext4/super.c | 26 +++++++++++++++-----------
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index d0c21e6503c6..45fc6586d41b 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -844,7 +844,8 @@ static int ext4_sample_last_mounted(struct super_block *sb,
 	if (likely(ext4_test_mount_flag(sb, EXT4_MF_MNTDIR_SAMPLED)))
 		return 0;
 
-	if (sb_rdonly(sb) || !sb_start_intwrite_trylock(sb))
+	if (ext4_emergency_state(sb) || sb_rdonly(sb) ||
+	    !sb_start_intwrite_trylock(sb))
 		return 0;
 
 	ext4_set_mount_flag(sb, EXT4_MF_MNTDIR_SAMPLED);
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 7b9ce71c1c81..0c5ce9c2cdfc 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1705,7 +1705,7 @@ int ext4_update_overhead(struct super_block *sb, bool force)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 
-	if (sb_rdonly(sb))
+	if (ext4_emergency_state(sb) || sb_rdonly(sb))
 		return 0;
 	if (!force &&
 	    (sbi->s_overhead == 0 ||
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 4b089a5b760a..d8116c9c2bd0 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -473,8 +473,9 @@ static void ext4_maybe_update_superblock(struct super_block *sb)
 	__u64 lifetime_write_kbytes;
 	__u64 diff_size;
 
-	if (sb_rdonly(sb) || !(sb->s_flags & SB_ACTIVE) ||
-	    !journal || (journal->j_flags & JBD2_UNMOUNT))
+	if (ext4_emergency_state(sb) || sb_rdonly(sb) ||
+	    !(sb->s_flags & SB_ACTIVE) || !journal ||
+	    journal->j_flags & JBD2_UNMOUNT)
 		return;
 
 	now = ktime_get_real_seconds();
@@ -765,7 +766,8 @@ static void update_super_work(struct work_struct *work)
 	 * We use directly jbd2 functions here to avoid recursing back into
 	 * ext4 error handling code during handling of previous errors.
 	 */
-	if (!sb_rdonly(sbi->s_sb) && journal) {
+	if (!ext4_emergency_state(sbi->s_sb) &&
+	    !sb_rdonly(sbi->s_sb) && journal) {
 		struct buffer_head *sbh = sbi->s_sbh;
 		bool call_notify_err = false;
 
@@ -1325,13 +1327,14 @@ static void ext4_put_super(struct super_block *sb)
 	ext4_mb_release(sb);
 	ext4_ext_release(sb);
 
-	if (!sb_rdonly(sb) && !aborted) {
-		ext4_clear_feature_journal_needs_recovery(sb);
-		ext4_clear_feature_orphan_present(sb);
-		es->s_state = cpu_to_le16(sbi->s_mount_state);
-	}
-	if (!sb_rdonly(sb))
+	if (!ext4_emergency_state(sb) && !sb_rdonly(sb)) {
+		if (!aborted) {
+			ext4_clear_feature_journal_needs_recovery(sb);
+			ext4_clear_feature_orphan_present(sb);
+			es->s_state = cpu_to_le16(sbi->s_mount_state);
+		}
 		ext4_commit_super(sb);
+	}
 
 	ext4_group_desc_free(sbi);
 	ext4_flex_groups_free(sbi);
@@ -3699,7 +3702,8 @@ static int ext4_run_li_request(struct ext4_li_request *elr)
 		if (group >= elr->lr_next_group) {
 			ret = 1;
 			if (elr->lr_first_not_zeroed != ngroups &&
-			    !sb_rdonly(sb) && test_opt(sb, INIT_INODE_TABLE)) {
+			    !ext4_emergency_state(sb) && !sb_rdonly(sb) &&
+			    test_opt(sb, INIT_INODE_TABLE)) {
 				elr->lr_next_group = elr->lr_first_not_zeroed;
 				elr->lr_mode = EXT4_LI_MODE_ITABLE;
 				ret = 0;
@@ -4004,7 +4008,7 @@ int ext4_register_li_request(struct super_block *sb,
 		goto out;
 	}
 
-	if (sb_rdonly(sb) ||
+	if (ext4_emergency_state(sb) || sb_rdonly(sb) ||
 	    (test_opt(sb, NO_PREFETCH_BLOCK_BITMAPS) &&
 	     (first_not_zeroed == ngroups || !test_opt(sb, INIT_INODE_TABLE))))
 		goto out;
-- 
2.39.2


