Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C271575390
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Jul 2022 18:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiGNQ7S (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Jul 2022 12:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238276AbiGNQ7K (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Jul 2022 12:59:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8A18167D1
        for <linux-ext4@vger.kernel.org>; Thu, 14 Jul 2022 09:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657817948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vs6UIGAf91uYImEDyyAG8SuOq8RXPR0WF7qRqQbJV/Q=;
        b=bzTe5dgrqca+BPC3nNzlv33UxdoLNJjcijSbc/aVmRGpE2Mv3Tcpff+SMzwUg42fg5M9le
        AYMMUKHK2MonUkJmOFSMabD2DT7OsGEwsPRtuiyJSYEd/SZmF5tQRqWP5Y/YC5nY9z1pFY
        4375yVi7aVzvA4NTu6/QltI35dLk4FQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-6gsdm_u9OVKD29ylfNwMEQ-1; Thu, 14 Jul 2022 12:59:05 -0400
X-MC-Unique: 6gsdm_u9OVKD29ylfNwMEQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C78AA38217ED;
        Thu, 14 Jul 2022 16:59:04 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.193.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06A5C1121315;
        Thu, 14 Jul 2022 16:59:03 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu,
        syzbot+15cd994e273307bf5cfa@syzkaller.appspotmail.com,
        Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: [PATCH] ext4: block range must be validated before use in ext4_mb_clear_bb()
Date:   Thu, 14 Jul 2022 18:59:03 +0200
Message-Id: <20220714165903.58260-1-lczerner@redhat.com>
In-Reply-To: <20220714095300.ffij7re6l5n6ixlg@fedora>
References: <20220714095300.ffij7re6l5n6ixlg@fedora>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Block range to free is validated in ext4_free_blocks() using
ext4_inode_block_valid() and then it's passed to ext4_mb_clear_bb().
However in some situations on bigalloc file system the range might be
adjusted after the validation in ext4_free_blocks() which can lead to
troubles on corrupted file systems such as one found by syzkaller that
resulted in the following BUG

kernel BUG at fs/ext4/ext4.h:3319!
PREEMPT SMP NOPTI
CPU: 28 PID: 4243 Comm: repro Kdump: loaded Not tainted 5.19.0-rc6+ #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1.fc35 04/01/2014
RIP: 0010:ext4_free_blocks+0x95e/0xa90
Call Trace:
 <TASK>
 ? lock_timer_base+0x61/0x80
 ? __es_remove_extent+0x5a/0x760
 ? __mod_timer+0x256/0x380
 ? ext4_ind_truncate_ensure_credits+0x90/0x220
 ext4_clear_blocks+0x107/0x1b0
 ext4_free_data+0x15b/0x170
 ext4_ind_truncate+0x214/0x2c0
 ? _raw_spin_unlock+0x15/0x30
 ? ext4_discard_preallocations+0x15a/0x410
 ? ext4_journal_check_start+0xe/0x90
 ? __ext4_journal_start_sb+0x2f/0x110
 ext4_truncate+0x1b5/0x460
 ? __ext4_journal_start_sb+0x2f/0x110
 ext4_evict_inode+0x2b4/0x6f0
 evict+0xd0/0x1d0
 ext4_enable_quotas+0x11f/0x1f0
 ext4_orphan_cleanup+0x3de/0x430
 ? proc_create_seq_private+0x43/0x50
 ext4_fill_super+0x295f/0x3ae0
 ? snprintf+0x39/0x40
 ? sget_fc+0x19c/0x330
 ? ext4_reconfigure+0x850/0x850
 get_tree_bdev+0x16d/0x260
 vfs_get_tree+0x25/0xb0
 path_mount+0x431/0xa70
 __x64_sys_mount+0xe2/0x120
 do_syscall_64+0x5b/0x80
 ? do_user_addr_fault+0x1e2/0x670
 ? exc_page_fault+0x70/0x170
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7fdf4e512ace

Fix it by making sure that the block range is properly validated before
used every time it changes in ext4_free_blocks() or ext4_mb_clear_bb().

Link: https://syzkaller.appspot.com/bug?id=5266d464285a03cee9dbfda7d2452a72c3c2ae7c
Reported-by: syzbot+15cd994e273307bf5cfa@syzkaller.appspotmail.com
Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Cc: Tadeusz Struk <tadeusz.struk@linaro.org>
---
 fs/ext4/mballoc.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 9e06334771a3..38e7dc2531b1 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5928,6 +5928,15 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 
 	sbi = EXT4_SB(sb);
 
+	if (!(flags & EXT4_FREE_BLOCKS_VALIDATED) &&
+	    !ext4_inode_block_valid(inode, block, count)) {
+		ext4_error(sb, "Freeing blocks in system zone - "
+			   "Block = %llu, count = %lu", block, count);
+		/* err = 0. ext4_std_error should be a no op */
+		goto error_return;
+	}
+	flags |= EXT4_FREE_BLOCKS_VALIDATED;
+
 do_more:
 	overflow = 0;
 	ext4_get_group_no_and_offset(sb, block, &block_group, &bit);
@@ -5944,6 +5953,8 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 		overflow = EXT4_C2B(sbi, bit) + count -
 			EXT4_BLOCKS_PER_GROUP(sb);
 		count -= overflow;
+		/* The range changed so it's no longer validated */
+		flags &= ~EXT4_FREE_BLOCKS_VALIDATED;
 	}
 	count_clusters = EXT4_NUM_B2C(sbi, count);
 	bitmap_bh = ext4_read_block_bitmap(sb, block_group);
@@ -5958,7 +5969,8 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 		goto error_return;
 	}
 
-	if (!ext4_inode_block_valid(inode, block, count)) {
+	if (!(flags & EXT4_FREE_BLOCKS_VALIDATED) &&
+	    !ext4_inode_block_valid(inode, block, count)) {
 		ext4_error(sb, "Freeing blocks in system zone - "
 			   "Block = %llu, count = %lu", block, count);
 		/* err = 0. ext4_std_error should be a no op */
@@ -6081,6 +6093,8 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 		block += count;
 		count = overflow;
 		put_bh(bitmap_bh);
+		/* The range changed so it's no longer validated */
+		flags &= ~EXT4_FREE_BLOCKS_VALIDATED;
 		goto do_more;
 	}
 error_return:
@@ -6127,6 +6141,7 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 			   "block = %llu, count = %lu", block, count);
 		return;
 	}
+	flags |= EXT4_FREE_BLOCKS_VALIDATED;
 
 	ext4_debug("freeing block %llu\n", block);
 	trace_ext4_free_blocks(inode, block, count, flags);
@@ -6158,6 +6173,8 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 			block -= overflow;
 			count += overflow;
 		}
+		/* The range changed so it's no longer validated */
+		flags &= ~EXT4_FREE_BLOCKS_VALIDATED;
 	}
 	overflow = EXT4_LBLK_COFF(sbi, count);
 	if (overflow) {
@@ -6168,6 +6185,8 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 				return;
 		} else
 			count += sbi->s_cluster_ratio - overflow;
+		/* The range changed so it's no longer validated */
+		flags &= ~EXT4_FREE_BLOCKS_VALIDATED;
 	}
 
 	if (!bh && (flags & EXT4_FREE_BLOCKS_FORGET)) {
-- 
2.35.3

