Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208315706DF
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Jul 2022 17:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiGKPWM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Jul 2022 11:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGKPWL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 11 Jul 2022 11:22:11 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344274B0E0
        for <linux-ext4@vger.kernel.org>; Mon, 11 Jul 2022 08:22:09 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id y11so2731555lfs.6
        for <linux-ext4@vger.kernel.org>; Mon, 11 Jul 2022 08:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Bt8jumSWe9TfQTMj7wxw5mwJ87yJC9tuFDbXi50Ehs=;
        b=ZPUP6GUC7phDz22vzE6DOtG7uUyHpkBUdUzJoR1Y+IP4W8bkKmDe+J/TdcBqwk8G64
         /IAgSeGznA7SHPiHdDBv5tiUm09PiTe074HS8QfaHtJDU8TJlYoc4SLtjFzdNocdkiZj
         huUk3wYYvwnW6WvDEkSfoMpQzldR96NjYo9OAIxgomMo7ukGr+RmAyig3JudRuKv5989
         PTholZH8gSUd+rB39arKGbl+QhTbgfOTlChAc+N+Y5Txb8Zuf+q243O+35vbQTxTNJYN
         Uqc6RH6HGFvgJFmLdfQ1pARaAuPt2OsloMOR/jVah69i93S3V2GKBwXG2vIpA5YAwnIS
         qeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Bt8jumSWe9TfQTMj7wxw5mwJ87yJC9tuFDbXi50Ehs=;
        b=DK3Qi1fFVg/66jVK7Tyx3l9osREKp4BoxbmyGvnIdwbse88GG2q58/ZcfxB+d1pD1F
         oypRS4FTP36S8KYxMJWuvUTnuobmOqtIQ1z5UR1OcUfPvu5ePRBYWcVChhdoYSNJkGcr
         JG/vbUSoegCoePLSgpIu4Rgd8mYUF2s3vYOwgpl8DYs3PDCqguGwhmS/xDh24SqlsZ8m
         1pHvcz3zXoG3x0/pWu5ymkGbr4jZIke7MS9ssvwAtakJ4c5r2fiHHFeT1hJBo9Gs4ZCO
         Lo5kdPqyk2i0jqoh5yUzyreqLJhFPNWMSUhBMHnT5uZqvt1h8HssquN6E94T+Wn7M53s
         8Hpw==
X-Gm-Message-State: AJIora+zTirLbf5Eo6uUILw9qlY7GuIxM+MadDzxAgL5kbKLSZk+VZZa
        00rTR5ql/Dm2W0cL74519/gOMB7ZW5U8beyPzOo=
X-Google-Smtp-Source: AGRyM1vKTcbLB6JLOqEBAq/WeQfgcX8ZoNsI2EeHjF5jlQiMycJMDrxNwVC8eBD5097hW7+K2XB//A==
X-Received: by 2002:a05:6512:3b08:b0:481:1b90:bf55 with SMTP id f8-20020a0565123b0800b004811b90bf55mr12247811lfv.153.1657552927037;
        Mon, 11 Jul 2022 08:22:07 -0700 (PDT)
Received: from localhost.localdomain ([83.234.50.195])
        by smtp.gmail.com with ESMTPSA id t14-20020a05651c204e00b0025bf6099cdbsm1815682ljo.78.2022.07.11.08.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 08:22:06 -0700 (PDT)
From:   Artem Blagodarenko <artem.blagodarenko@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger.kernel@dilger.ca, andrew.perepechko@hpe.com,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>,
        Artem Blagodarenko <ablagodarenko@ddn.com>
Subject: [PATCH v4] ext4: truncate during setxattr leads to kernel panic
Date:   Mon, 11 Jul 2022 10:57:34 -0400
Message-Id: <20220711145735.53676-1-artem.blagodarenko@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When changing a large xattr value to a different large xattr
value, the old xattr inode is freed. Truncate during the final iput causes
current transaction restart. Eventually, parent inode bh is marked dirty and
kernel panic happens when jbd2 figures out that this bh belongs to the
committed transaction.

Here is a reporoducer:

dd if=/dev/zero of=/tmp/ldiskfs bs=1M count=100
mkfs.ext4 -O ea_inode /tmp/ldiskfs -J size=16 -I 512
mkdir -p /tmp/ldiskfs_m
mount -t ext4 /tmp/ldiskfs /tmp/ldiskfs_m -o loop,commit=600,no_mbcache
touch /tmp/ldiskfs_m/file{1..1024}
V=$(for i in `seq 60000`; do echo -n x ; done)
V1="1$V"
V2="2$V"
for k in 1 2 3 4 5 6 7 8 9; do
        setfattr -n user.xattr -v $V /tmp/ldiskfs_m/file{1..1024}
        setfattr -n user.xattr -v $V1 /tmp/ldiskfs_m/file{1..1024} &
        setfattr -n user.xattr -v $V2 /tmp/ldiskfs_m/file{1024..1} &
        wait
done
umount /tmp/ldiskfs_m

The above reproducer triggers the following oops (using a build from a
recent linux.git commit):

[  181.269541] ------------[ cut here ]------------
[  181.269733] kernel BUG at fs/jbd2/transaction.c:1511!
[  181.269951] invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
[  181.270169] CPU: 0 PID: 940 Comm: setfattr Not tainted
5.17.0-13430-g787af64d05cd #9
[  181.270243] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
VirtualBox 12/01/2006
[  181.270243] RIP: 0010:jbd2_journal_dirty_metadata+0x400/0x420
[  181.270243] Code: 24 4c 4c 8b 0c 24 41 83 f8 01 0f 84 3c ff ff ff e9
24 94 0b 01 48 8b 7c 24 08 e8 cb f6 df ff 4d 39 6c 24 70 0f 84 e6 fc ff
ff <0f> 0b 0f 0b c7 4
4 24 18 e4 ff ff ff e9 9f fe ff ff 0f 0b c7 44 24
[  181.270243] RSP: 0018:ffff88802632f698 EFLAGS: 00010207
[  181.270243] RAX: 0000000000000000 RBX: ffff88800044fcc8 RCX:
ffffffffa73a03b5
[  181.270243] RDX: dffffc0000000000 RSI: 0000000000000004 RDI:
ffff888032ff6f58
[  181.270243] RBP: ffff88802eb04418 R08: ffffffffa6f502bf R09:
ffffed1004c65ec6
[  181.270243] R10: 0000000000000003 R11: ffffed1004c65ec5 R12:
ffff888032ff6ee8
[  181.270243] R13: ffff888024af8300 R14: ffff88800044fcec R15:
ffff888032ff6f50
[  181.270243] FS:  00007ffb5f6e3740(0000) GS:ffff888034800000(0000)
knlGS:0000000000000000
[  181.270243] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  181.270243] CR2: 00007f9ca09dc024 CR3: 0000000032244000 CR4:
00000000000506f0
[  181.270243] Call Trace:
[  181.270243]  <TASK>
[  181.270243]  __ext4_handle_dirty_metadata+0xb1/0x330
[  181.270243]  ext4_mark_iloc_dirty+0x2b7/0xcd0
[  181.270243]  ext4_xattr_set_handle+0x694/0xaf0
[  181.270243]  ext4_xattr_set+0x164/0x260
[  181.270243]  __vfs_setxattr+0xcb/0x110
[  181.270243]  __vfs_setxattr_noperm+0x8c/0x300
[  181.270243]  vfs_setxattr+0xff/0x250
[  181.270243]  setxattr+0x14a/0x260
[  181.270243]  path_setxattr+0x132/0x150
[  181.270243]  __x64_sys_setxattr+0x63/0x70
[  181.270243]  do_syscall_64+0x3b/0x90
[  181.270243]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  181.270243] RIP: 0033:0x7ffb5efebbee

A possible fix is to call this final iput in a separate thread.
This way, setxattr transactions will never be split into two.
Since the setxattr code adds xattr inodes with nlink=0 into the
orphan list, old xattr inodes will be properly cleaned up in
any case.

Signed-off-by: Andrew Perepechko <andrew.perepechko@hpe.com>
Signed-off-by: Artem Blagodarenko <ablagodarenko@ddn.com>

Changes since v3:
- execute delayed_iput() only then recount is 0
  and iput() in all another cases
Changes since v1:
- fixed a bug added during the porting
- fixed a workqueue related deadlock reported by Tetsuo Handa
---
 fs/ext4/ext4.h    |  6 ++++
 fs/ext4/page-io.c |  2 +-
 fs/ext4/super.c   | 15 +++++-----
 fs/ext4/xattr.c   | 72 ++++++++++++++++++++++++++++++++++++++---------
 4 files changed, 74 insertions(+), 21 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 75b8d81b2469..1eed86d0d37f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1649,6 +1649,12 @@ struct ext4_sb_info {
 	/* workqueue for reserved extent conversions (buffered io) */
 	struct workqueue_struct *rsv_conversion_wq;
 
+	/*
+	 * workqueue for reserved extent conversions (buffered io)
+	 * and large ea inodes reclaim
+	 */
+	struct workqueue_struct *s_misc_wq;
+
 	/* timer for periodic error stats printing */
 	struct timer_list s_err_report;
 
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 97fa7b4c645f..e42ac5f54b12 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -230,7 +230,7 @@ static void ext4_add_complete_io(ext4_io_end_t *io_end)
 	WARN_ON(!(io_end->flag & EXT4_IO_END_UNWRITTEN));
 	WARN_ON(!io_end->handle && sbi->s_journal);
 	spin_lock_irqsave(&ei->i_completed_io_lock, flags);
-	wq = sbi->rsv_conversion_wq;
+	wq = sbi->s_misc_wq;
 	if (list_empty(&ei->i_rsv_conversion_list))
 		queue_work(wq, &ei->i_rsv_conversion_work);
 	list_add_tail(&io_end->list, &ei->i_rsv_conversion_list);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 845f2f8aee5f..5b93fc2dd0a1 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1215,10 +1215,11 @@ static void ext4_put_super(struct super_block *sb)
 		ext4_msg(sb, KERN_INFO, "unmounting filesystem.");
 
 	ext4_unregister_li_request(sb);
+	flush_workqueue(sbi->s_misc_wq);
 	ext4_quota_off_umount(sb);
 
 	flush_work(&sbi->s_error_work);
-	destroy_workqueue(sbi->rsv_conversion_wq);
+	destroy_workqueue(sbi->s_misc_wq);
 	ext4_release_orphan_info(sb);
 
 	if (sbi->s_journal) {
@@ -5218,9 +5219,9 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	 * The maximum number of concurrent works can be high and
 	 * concurrency isn't really necessary.  Limit it to 1.
 	 */
-	EXT4_SB(sb)->rsv_conversion_wq =
-		alloc_workqueue("ext4-rsv-conversion", WQ_MEM_RECLAIM | WQ_UNBOUND, 1);
-	if (!EXT4_SB(sb)->rsv_conversion_wq) {
+	EXT4_SB(sb)->s_misc_wq =
+		alloc_workqueue("ext4-misc", WQ_MEM_RECLAIM | WQ_UNBOUND, 1);
+	if (!EXT4_SB(sb)->s_misc_wq) {
 		printk(KERN_ERR "EXT4-fs: failed to create workqueue\n");
 		ret = -ENOMEM;
 		goto failed_mount4;
@@ -5434,8 +5435,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	sb->s_root = NULL;
 failed_mount4:
 	ext4_msg(sb, KERN_ERR, "mount failed");
-	if (EXT4_SB(sb)->rsv_conversion_wq)
-		destroy_workqueue(EXT4_SB(sb)->rsv_conversion_wq);
+	if (EXT4_SB(sb)->s_misc_wq)
+		destroy_workqueue(EXT4_SB(sb)->s_misc_wq);
 failed_mount_wq:
 	ext4_xattr_destroy_cache(sbi->s_ea_inode_cache);
 	sbi->s_ea_inode_cache = NULL;
@@ -6061,7 +6062,7 @@ static int ext4_sync_fs(struct super_block *sb, int wait)
 		return 0;
 
 	trace_ext4_sync_fs(sb, wait);
-	flush_workqueue(sbi->rsv_conversion_wq);
+	flush_workqueue(sbi->s_misc_wq);
 	/*
 	 * Writeback quota in non-journalled quota case - journalled quota has
 	 * no dirty dquots
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 564e28a1aa94..d67035c9223a 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -974,7 +974,7 @@ int __ext4_xattr_set_credits(struct super_block *sb, struct inode *inode,
 }
 
 static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
-				       int ref_change)
+				       int ref_change, s64 *ret_ref_count)
 {
 	struct mb_cache *ea_inode_cache = EA_INODE_CACHE(ea_inode);
 	struct ext4_iloc iloc;
@@ -1035,6 +1035,8 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
 	if (ret)
 		ext4_warning_inode(ea_inode,
 				   "ext4_mark_iloc_dirty() failed ret=%d", ret);
+	if (ret_ref_count)
+		*ret_ref_count = ref_count;
 out:
 	inode_unlock(ea_inode);
 	return ret;
@@ -1042,12 +1044,12 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
 
 static int ext4_xattr_inode_inc_ref(handle_t *handle, struct inode *ea_inode)
 {
-	return ext4_xattr_inode_update_ref(handle, ea_inode, 1);
+	return ext4_xattr_inode_update_ref(handle, ea_inode, 1, NULL);
 }
 
-static int ext4_xattr_inode_dec_ref(handle_t *handle, struct inode *ea_inode)
+static int ext4_xattr_inode_dec_ref(handle_t *handle, struct inode *ea_inode, s64 *ret_ref_count)
 {
-	return ext4_xattr_inode_update_ref(handle, ea_inode, -1);
+	return ext4_xattr_inode_update_ref(handle, ea_inode, -1, ret_ref_count);
 }
 
 static int ext4_xattr_inode_inc_ref_all(handle_t *handle, struct inode *parent,
@@ -1097,7 +1099,7 @@ static int ext4_xattr_inode_inc_ref_all(handle_t *handle, struct inode *parent,
 				     err);
 			continue;
 		}
-		err = ext4_xattr_inode_dec_ref(handle, ea_inode);
+		err = ext4_xattr_inode_dec_ref(handle, ea_inode, NULL);
 		if (err)
 			ext4_warning_inode(ea_inode, "cleanup dec ref error %d",
 					   err);
@@ -1180,7 +1182,7 @@ ext4_xattr_inode_dec_ref_all(handle_t *handle, struct inode *parent,
 			}
 		}
 
-		err = ext4_xattr_inode_dec_ref(handle, ea_inode);
+		err = ext4_xattr_inode_dec_ref(handle, ea_inode, NULL);
 		if (err) {
 			ext4_warning_inode(ea_inode, "ea_inode dec ref err=%d",
 					   err);
@@ -1531,7 +1533,7 @@ static int ext4_xattr_inode_lookup_create(handle_t *handle, struct inode *inode,
 
 	err = ext4_xattr_inode_write(handle, ea_inode, value, value_len);
 	if (err) {
-		ext4_xattr_inode_dec_ref(handle, ea_inode);
+		ext4_xattr_inode_dec_ref(handle, ea_inode, NULL);
 		iput(ea_inode);
 		return err;
 	}
@@ -1544,6 +1546,36 @@ static int ext4_xattr_inode_lookup_create(handle_t *handle, struct inode *inode,
 	return 0;
 }
 
+struct delayed_iput_work {
+	struct work_struct work;
+	struct inode *inode;
+};
+
+static void delayed_iput_fn(struct work_struct *work)
+{
+	struct delayed_iput_work *diwork;
+
+	diwork = container_of(work, struct delayed_iput_work, work);
+	iput(diwork->inode);
+	kfree(diwork);
+}
+
+noinline void delayed_iput(struct inode *inode, struct delayed_iput_work *work)
+{
+	if (!inode) {
+		kfree(work);
+		return;
+	}
+
+	if (!work) {
+		iput(inode);
+	} else {
+		INIT_WORK(&work->work, delayed_iput_fn);
+		work->inode = inode;
+		queue_work(EXT4_SB(inode->i_sb)->s_misc_wq, &work->work);
+	}
+}
+
 /*
  * Reserve min(block_size/8, 1024) bytes for xattr entries/names if ea_inode
  * feature is enabled.
@@ -1561,8 +1593,10 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 	int in_inode = i->in_inode;
 	struct inode *old_ea_inode = NULL;
 	struct inode *new_ea_inode = NULL;
+	struct delayed_iput_work *diwork = NULL;
 	size_t old_size, new_size;
 	int ret;
+	s64 ret_ref_count = -1;
 
 	/* Space used by old and new values. */
 	old_size = (!s->not_found && !here->e_value_inum) ?
@@ -1637,7 +1671,11 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 	 * Finish that work before doing any modifications to the xattr data.
 	 */
 	if (!s->not_found && here->e_value_inum) {
-		ret = ext4_xattr_inode_iget(inode,
+		diwork = kmalloc(sizeof(*diwork), GFP_NOFS);
+		if (!diwork)
+			ret = -ENOMEM;
+		else
+			ret = ext4_xattr_inode_iget(inode,
 					    le32_to_cpu(here->e_value_inum),
 					    le32_to_cpu(here->e_hash),
 					    &old_ea_inode);
@@ -1665,14 +1703,16 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 
 	if (old_ea_inode) {
 		/* We are ready to release ref count on the old_ea_inode. */
-		ret = ext4_xattr_inode_dec_ref(handle, old_ea_inode);
+		ret = ext4_xattr_inode_dec_ref(handle, old_ea_inode,
+					       &ret_ref_count);
 		if (ret) {
 			/* Release newly required ref count on new_ea_inode. */
 			if (new_ea_inode) {
 				int err;
 
 				err = ext4_xattr_inode_dec_ref(handle,
-							       new_ea_inode);
+							       new_ea_inode,
+							       NULL);
 				if (err)
 					ext4_warning_inode(new_ea_inode,
 						  "dec ref new_ea_inode err=%d",
@@ -1790,7 +1830,12 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 
 	ret = 0;
 out:
-	iput(old_ea_inode);
+	if (ret_ref_count == 0)
+		delayed_iput(old_ea_inode, diwork);
+	else {
+		kfree(diwork);
+		iput(old_ea_inode);
+	}
 	iput(new_ea_inode);
 	return ret;
 }
@@ -2087,7 +2132,8 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 			if (ea_inode) {
 				/* Drop the extra ref on ea_inode. */
 				error = ext4_xattr_inode_dec_ref(handle,
-								 ea_inode);
+								 ea_inode,
+								 NULL);
 				if (error)
 					ext4_warning_inode(ea_inode,
 							   "dec ref error=%d",
@@ -2137,7 +2183,7 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 	if (ea_inode) {
 		int error2;
 
-		error2 = ext4_xattr_inode_dec_ref(handle, ea_inode);
+		error2 = ext4_xattr_inode_dec_ref(handle, ea_inode, NULL);
 		if (error2)
 			ext4_warning_inode(ea_inode, "dec ref error=%d",
 					   error2);
-- 
2.31.1

