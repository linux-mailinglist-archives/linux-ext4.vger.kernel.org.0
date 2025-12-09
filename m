Return-Path: <linux-ext4+bounces-12244-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D08CB01E5
	for <lists+linux-ext4@lfdr.de>; Tue, 09 Dec 2025 14:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 198D730FBB58
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Dec 2025 13:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BFD33123E;
	Tue,  9 Dec 2025 13:41:55 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6561A33120D;
	Tue,  9 Dec 2025 13:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765287715; cv=none; b=RIgE9G8WRoxGjnuJOwEHta+ooUyt16gtnI3Z6fMMFSXTjLCADK+iZFYKkkRKOId4ySViQFq1BWq1fUM787pE60Sj4PEsHGTT9LFLWJFXMW5ErsWBuMuJvlPeWZF0BISjtFjd4iD+sxPuQM4mf5TFYDuhoRecyv6xfAWWiNreaGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765287715; c=relaxed/simple;
	bh=1zdXNva9dOJxzxwXhR1hoz5GU41IyGN6TKYJz1amZ/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cFLHn+RWDmeInMOI7a1yn8f6hdkaXZWAgDJqXigvN9AgOFB7Q6zVJsMoHwhACCWRBKwcOgyUgexQ6OyRXPtlY8/DGlsWYKWSZgMW+tYqxhpJUOEONIv8Cox9Pa0F8CeJ67vOPtMbd9nxeboVTAAgWhBNcj6m31DYjA2S4BZ18Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dQg3P2kQvzKHLyR;
	Tue,  9 Dec 2025 21:40:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id EEB801A175D;
	Tue,  9 Dec 2025 21:41:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgC3lU8aJzhpjT2aBA--.58217S4;
	Tue, 09 Dec 2025 21:41:47 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun1@huawei.com,
	libaokun@huaweicloud.com
Subject: [PATCH] ext4: move ext4_percpu_param_init() before ext4_mb_init()
Date: Tue,  9 Dec 2025 21:31:16 +0800
Message-Id: <20251209133116.731350-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgC3lU8aJzhpjT2aBA--.58217S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXFWkCrW5Jr4UKFWrWry7trb_yoWrXr1rpr
	1DAa4xKry8C34DCa13JFyYqF18X3W8Cay8W34fur15A3sFq3WkZF97tF15AFWj9rs5A3ZY
	qF1rGry7Gr17uaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0
	F24lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjfUoPEfDUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgARBWk4EuMIOwAAsF

From: Baokun Li <libaokun1@huawei.com>

When running `kvm-xfstests -c ext4/1k -C 1 generic/383` with the
`DOUBLE_CHECK` macro defined, the following panic is triggered:

==================================================================
EXT4-fs error (device vdc): ext4_validate_block_bitmap:423:
                        comm mount: bg 0: bad block bitmap checksum
BUG: unable to handle page fault for address: ff110000fa2cc000
PGD 3e01067 P4D 3e02067 PUD 0
Oops: Oops: 0000 [#1] SMP NOPTI
CPU: 0 UID: 0 PID: 2386 Comm: mount Tainted: G W
                        6.18.0-gba65a4e7120a-dirty #1152 PREEMPT(none)
RIP: 0010:percpu_counter_add_batch+0x13/0xa0
Call Trace:
 <TASK>
 ext4_mark_group_bitmap_corrupted+0xcb/0xe0
 ext4_validate_block_bitmap+0x2a1/0x2f0
 ext4_read_block_bitmap+0x33/0x50
 mb_group_bb_bitmap_alloc+0x33/0x80
 ext4_mb_add_groupinfo+0x190/0x250
 ext4_mb_init_backend+0x87/0x290
 ext4_mb_init+0x456/0x640
 __ext4_fill_super+0x1072/0x1680
 ext4_fill_super+0xd3/0x280
 get_tree_bdev_flags+0x132/0x1d0
 vfs_get_tree+0x29/0xd0
 vfs_cmd_create+0x59/0xe0
 __do_sys_fsconfig+0x4f6/0x6b0
 do_syscall_64+0x50/0x1f0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
==================================================================

This issue can be reproduced using the following commands:
        mkfs.ext4 -F -q -b 1024 /dev/sda 5G
        tune2fs -O quota,project /dev/sda
        mount /dev/sda /tmp/test

With DOUBLE_CHECK defined, mb_group_bb_bitmap_alloc() reads
and validates the block bitmap. When the validation fails,
ext4_mark_group_bitmap_corrupted() attempts to update
sbi->s_freeclusters_counter. However, this percpu_counter has not been
initialized yet at this point, which leads to the panic described above.

Fix this by moving the execution of ext4_percpu_param_init() to occur
before ext4_mb_init(), ensuring the per-CPU counters are initialized
before they are used.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/super.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 87205660c5d0..5c2e931d8a53 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5599,35 +5599,35 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	 */
 	if (!(ctx->spec & EXT4_SPEC_mb_optimize_scan)) {
 		if (sbi->s_groups_count >= MB_DEFAULT_LINEAR_SCAN_THRESHOLD)
 			set_opt2(sb, MB_OPTIMIZE_SCAN);
 		else
 			clear_opt2(sb, MB_OPTIMIZE_SCAN);
 	}
 
+	err = ext4_percpu_param_init(sbi);
+	if (err)
+		goto failed_mount5;
+
 	err = ext4_mb_init(sb);
 	if (err) {
 		ext4_msg(sb, KERN_ERR, "failed to initialize mballoc (%d)",
 			 err);
 		goto failed_mount5;
 	}
 
 	/*
 	 * We can only set up the journal commit callback once
 	 * mballoc is initialized
 	 */
 	if (sbi->s_journal)
 		sbi->s_journal->j_commit_callback =
 			ext4_journal_commit_callback;
 
-	err = ext4_percpu_param_init(sbi);
-	if (err)
-		goto failed_mount6;
-
 	if (ext4_has_feature_flex_bg(sb))
 		if (!ext4_fill_flex_info(sb)) {
 			ext4_msg(sb, KERN_ERR,
 			       "unable to initialize "
 			       "flex_bg meta info!");
 			err = -ENOMEM;
 			goto failed_mount6;
 		}
@@ -5699,18 +5699,18 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	ext4_quotas_off(sb, EXT4_MAXQUOTAS);
 failed_mount8: __maybe_unused
 	ext4_release_orphan_info(sb);
 failed_mount7:
 	ext4_unregister_li_request(sb);
 failed_mount6:
 	ext4_mb_release(sb);
 	ext4_flex_groups_free(sbi);
-	ext4_percpu_param_destroy(sbi);
 failed_mount5:
+	ext4_percpu_param_destroy(sbi);
 	ext4_ext_release(sb);
 	ext4_release_system_zone(sb);
 failed_mount4a:
 	dput(sb->s_root);
 	sb->s_root = NULL;
 failed_mount4:
 	ext4_msg(sb, KERN_ERR, "mount failed");
 	if (EXT4_SB(sb)->rsv_conversion_wq)
-- 
2.39.2


