Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA0B25056E
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Aug 2020 19:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgHXRPi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Aug 2020 13:15:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728363AbgHXQg7 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 24 Aug 2020 12:36:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51F3F22DBF;
        Mon, 24 Aug 2020 16:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598287000;
        bh=Tktxt8SlTXZnCsn9kNnDFymjkSSC+oD6k9CmoHTDNAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tWG354frHKC4NnXh3xnXcSbpqCq0zqwuBM9lmjKnUDALfesDluvpUhXLdnT6Q17cH
         uAaFyuHparEuGIHUK5U0uWOp5pm6o+PSqOVO4rCrOfXv/tp0oJrUs6oBYlmxA/d54i
         oz/8W2E2tawgUxiPEKMJYeD0mPKpLucaF8gHxmqo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lukas Czerner <lczerner@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
        linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 04/54] ext4: handle read only external journal device
Date:   Mon, 24 Aug 2020 12:35:43 -0400
Message-Id: <20200824163634.606093-4-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163634.606093-1-sashal@kernel.org>
References: <20200824163634.606093-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Lukas Czerner <lczerner@redhat.com>

[ Upstream commit 273108fa5015eeffc4bacfa5ce272af3434b96e4 ]

Ext4 uses blkdev_get_by_dev() to get the block_device for journal device
which does check to see if the read-only block device was opened
read-only.

As a result ext4 will hapily proceed mounting the file system with
external journal on read-only device. This is bad as we would not be
able to use the journal leading to errors later on.

Instead of simply failing to mount file system in this case, treat it in
a similar way we treat internal journal on read-only device. Allow to
mount with -o noload in read-only mode.

This can be reproduced easily like this:

mke2fs -F -O journal_dev $JOURNAL_DEV 100M
mkfs.$FSTYPE -F -J device=$JOURNAL_DEV $FS_DEV
blockdev --setro $JOURNAL_DEV
mount $FS_DEV $MNT
touch $MNT/file
umount $MNT

leading to error like this

[ 1307.318713] ------------[ cut here ]------------
[ 1307.323362] generic_make_request: Trying to write to read-only block-device dm-2 (partno 0)
[ 1307.331741] WARNING: CPU: 36 PID: 3224 at block/blk-core.c:855 generic_make_request_checks+0x2c3/0x580
[ 1307.341041] Modules linked in: ext4 mbcache jbd2 rfkill intel_rapl_msr intel_rapl_common isst_if_commd
[ 1307.419445] CPU: 36 PID: 3224 Comm: jbd2/dm-2 Tainted: G        W I       5.8.0-rc5 #2
[ 1307.427359] Hardware name: Dell Inc. PowerEdge R740/01KPX8, BIOS 2.3.10 08/15/2019
[ 1307.434932] RIP: 0010:generic_make_request_checks+0x2c3/0x580
[ 1307.440676] Code: 94 03 00 00 48 89 df 48 8d 74 24 08 c6 05 cf 2b 18 01 01 e8 7f a4 ff ff 48 c7 c7 50e
[ 1307.459420] RSP: 0018:ffffc0d70eb5fb48 EFLAGS: 00010286
[ 1307.464646] RAX: 0000000000000000 RBX: ffff9b33b2978300 RCX: 0000000000000000
[ 1307.471780] RDX: ffff9b33e12a81e0 RSI: ffff9b33e1298000 RDI: ffff9b33e1298000
[ 1307.478913] RBP: ffff9b7b9679e0c0 R08: 0000000000000837 R09: 0000000000000024
[ 1307.486044] R10: 0000000000000000 R11: ffffc0d70eb5f9f0 R12: 0000000000000400
[ 1307.493177] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
[ 1307.500308] FS:  0000000000000000(0000) GS:ffff9b33e1280000(0000) knlGS:0000000000000000
[ 1307.508396] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1307.514142] CR2: 000055eaf4109000 CR3: 0000003dee40a006 CR4: 00000000007606e0
[ 1307.521273] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1307.528407] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1307.535538] PKRU: 55555554
[ 1307.538250] Call Trace:
[ 1307.540708]  generic_make_request+0x30/0x340
[ 1307.544985]  submit_bio+0x43/0x190
[ 1307.548393]  ? bio_add_page+0x62/0x90
[ 1307.552068]  submit_bh_wbc+0x16a/0x190
[ 1307.555833]  jbd2_write_superblock+0xec/0x200 [jbd2]
[ 1307.560803]  jbd2_journal_update_sb_log_tail+0x65/0xc0 [jbd2]
[ 1307.566557]  jbd2_journal_commit_transaction+0x2ae/0x1860 [jbd2]
[ 1307.572566]  ? check_preempt_curr+0x7a/0x90
[ 1307.576756]  ? update_curr+0xe1/0x1d0
[ 1307.580421]  ? account_entity_dequeue+0x7b/0xb0
[ 1307.584955]  ? newidle_balance+0x231/0x3d0
[ 1307.589056]  ? __switch_to_asm+0x42/0x70
[ 1307.592986]  ? __switch_to_asm+0x36/0x70
[ 1307.596918]  ? lock_timer_base+0x67/0x80
[ 1307.600851]  kjournald2+0xbd/0x270 [jbd2]
[ 1307.604873]  ? finish_wait+0x80/0x80
[ 1307.608460]  ? commit_timeout+0x10/0x10 [jbd2]
[ 1307.612915]  kthread+0x114/0x130
[ 1307.616152]  ? kthread_park+0x80/0x80
[ 1307.619816]  ret_from_fork+0x22/0x30
[ 1307.623400] ---[ end trace 27490236265b1630 ]---

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Link: https://lore.kernel.org/r/20200717090605.2612-1-lczerner@redhat.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 51 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index f1b975ff210c4..017aecc1393a8 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4983,6 +4983,7 @@ static int ext4_load_journal(struct super_block *sb,
 	dev_t journal_dev;
 	int err = 0;
 	int really_read_only;
+	int journal_dev_ro;
 
 	if (WARN_ON_ONCE(!ext4_has_feature_journal(sb)))
 		return -EFSCORRUPTED;
@@ -4995,7 +4996,31 @@ static int ext4_load_journal(struct super_block *sb,
 	} else
 		journal_dev = new_decode_dev(le32_to_cpu(es->s_journal_dev));
 
-	really_read_only = bdev_read_only(sb->s_bdev);
+	if (journal_inum && journal_dev) {
+		ext4_msg(sb, KERN_ERR,
+			 "filesystem has both journal inode and journal device!");
+		return -EINVAL;
+	}
+
+	if (journal_inum) {
+		journal = ext4_get_journal(sb, journal_inum);
+		if (!journal)
+			return -EINVAL;
+	} else {
+		journal = ext4_get_dev_journal(sb, journal_dev);
+		if (!journal)
+			return -EINVAL;
+	}
+
+	journal_dev_ro = bdev_read_only(journal->j_dev);
+	really_read_only = bdev_read_only(sb->s_bdev) | journal_dev_ro;
+
+	if (journal_dev_ro && !sb_rdonly(sb)) {
+		ext4_msg(sb, KERN_ERR,
+			 "journal device read-only, try mounting with '-o ro'");
+		err = -EROFS;
+		goto err_out;
+	}
 
 	/*
 	 * Are we loading a blank journal or performing recovery after a
@@ -5010,27 +5035,14 @@ static int ext4_load_journal(struct super_block *sb,
 				ext4_msg(sb, KERN_ERR, "write access "
 					"unavailable, cannot proceed "
 					"(try mounting with noload)");
-				return -EROFS;
+				err = -EROFS;
+				goto err_out;
 			}
 			ext4_msg(sb, KERN_INFO, "write access will "
 			       "be enabled during recovery");
 		}
 	}
 
-	if (journal_inum && journal_dev) {
-		ext4_msg(sb, KERN_ERR, "filesystem has both journal "
-		       "and inode journals!");
-		return -EINVAL;
-	}
-
-	if (journal_inum) {
-		if (!(journal = ext4_get_journal(sb, journal_inum)))
-			return -EINVAL;
-	} else {
-		if (!(journal = ext4_get_dev_journal(sb, journal_dev)))
-			return -EINVAL;
-	}
-
 	if (!(journal->j_flags & JBD2_BARRIER))
 		ext4_msg(sb, KERN_INFO, "barriers disabled");
 
@@ -5050,8 +5062,7 @@ static int ext4_load_journal(struct super_block *sb,
 
 	if (err) {
 		ext4_msg(sb, KERN_ERR, "error loading journal");
-		jbd2_journal_destroy(journal);
-		return err;
+		goto err_out;
 	}
 
 	EXT4_SB(sb)->s_journal = journal;
@@ -5071,6 +5082,10 @@ static int ext4_load_journal(struct super_block *sb,
 	}
 
 	return 0;
+
+err_out:
+	jbd2_journal_destroy(journal);
+	return err;
 }
 
 static int ext4_commit_super(struct super_block *sb, int sync)
-- 
2.25.1

