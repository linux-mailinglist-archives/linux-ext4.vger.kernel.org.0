Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE672237C1
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jul 2020 11:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgGQJGP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jul 2020 05:06:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20758 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726013AbgGQJGP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jul 2020 05:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594976772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TjxpuaIEZReOuQMNVBCdBiPFrhT0NH3edqfceZd5+wA=;
        b=FIle/UoewTZR04oEGdAbXGpu0hYAay+6a/yj9sDG8k4n+FJANMFapUmlh9jsWxo+5NLR0q
        HZAaBdXSyWWJfWUj4ENIb1WgCHcbeYBbtPdryma6SgSAqYXWXjkidgAA2RS4c1nSPJuG1+
        FhQ58jg4w4qGe39i0Y4CzZYZ47/PAxY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-v6BI9ha9MEGYjUK2kW6g9A-1; Fri, 17 Jul 2020 05:06:08 -0400
X-MC-Unique: v6BI9ha9MEGYjUK2kW6g9A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C301C80046A;
        Fri, 17 Jul 2020 09:06:07 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C5E478467;
        Fri, 17 Jul 2020 09:06:06 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu
Subject: [PATCH v2] ext4: handle read only external journal device
Date:   Fri, 17 Jul 2020 11:06:05 +0200
Message-Id: <20200717090605.2612-1-lczerner@redhat.com>
In-Reply-To: <20200716183901.5016-1-lczerner@redhat.com>
References: <20200716183901.5016-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

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
---
v2: some stylistic and error message changes

 fs/ext4/super.c | 51 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 330957ed1f05..d925a1b16206 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5077,6 +5077,7 @@ static int ext4_load_journal(struct super_block *sb,
 	dev_t journal_dev;
 	int err = 0;
 	int really_read_only;
+	int journal_dev_ro;
 
 	BUG_ON(!ext4_has_feature_journal(sb));
 
@@ -5088,7 +5089,31 @@ static int ext4_load_journal(struct super_block *sb,
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
@@ -5103,27 +5128,14 @@ static int ext4_load_journal(struct super_block *sb,
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
 
@@ -5143,8 +5155,7 @@ static int ext4_load_journal(struct super_block *sb,
 
 	if (err) {
 		ext4_msg(sb, KERN_ERR, "error loading journal");
-		jbd2_journal_destroy(journal);
-		return err;
+		goto err_out;
 	}
 
 	EXT4_SB(sb)->s_journal = journal;
@@ -5159,6 +5170,10 @@ static int ext4_load_journal(struct super_block *sb,
 	}
 
 	return 0;
+
+err_out:
+	jbd2_journal_destroy(journal);
+	return err;
 }
 
 static int ext4_commit_super(struct super_block *sb, int sync)
-- 
2.21.3

