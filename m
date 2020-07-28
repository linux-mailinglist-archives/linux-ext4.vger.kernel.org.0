Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BE5230C83
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jul 2020 16:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbgG1OfV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Jul 2020 10:35:21 -0400
Received: from m15114.mail.126.com ([220.181.15.114]:36171 "EHLO
        m15114.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730392AbgG1OfV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Jul 2020 10:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=UqT1ceSRxaZJpNsBkd
        +RC5H0ROXAaLpgilicqUTfRaM=; b=evCfYUgeWgC3RVeFPzhHpZDhXANReEV1za
        hI2iklNb7FLu98w0F4tSWIpnOLivzwhweDtblIbY5LvBGrhuKyIMmTLrfErsI9fi
        g5toOOdwpVetx/QJ718cegsb9PENR9mvJ6z7fQuaP/UO/RlxL/bh5foC0013TRaZ
        cM/RMPzyU=
Received: from 192.168.137.249 (unknown [112.10.84.202])
        by smtp7 (Coremail) with SMTP id DsmowAAHhXZQNyBfrooqHw--.29196S3;
        Tue, 28 Jul 2020 22:33:53 +0800 (CST)
From:   Xianting Tian <xianting_tian@126.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: check superblock mapped prior to get write access
Date:   Tue, 28 Jul 2020 10:33:53 -0400
Message-Id: <1595946833-13011-1-git-send-email-xianting_tian@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DsmowAAHhXZQNyBfrooqHw--.29196S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gw1kCFyrCw17uw4kKFW7Arb_yoW7Gw4xpF
        y5CryjkFW09F4YvF4UAF4UJrW7GrsrAFW7GryfCryYqa15Gwn5ta4xta1Uuay5JrZ5Xa47
        JF1UGw10934UtaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jC7KsUUUUU=
X-Originating-IP: [112.10.84.202]
X-CM-SenderInfo: h0ld03plqjs3xldqqiyswou0bp/1tbiwRFvpFpD+4nFaQAAsc
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

One crash issue happened when directly down the network interface,
which nbd device is connected to. The kernel version is kernel
4.14.0-115.
According to the debug log and call trace, the buffer of ext4
superblock already unmapped after the network of nbd device down.
But the code continue to run until crash.
I checked latest kernel code of 5.8-rc7 based on the call trace,
no function checked if buffer of ext4 superblock unmapped.
The patch is similar to commit 742b06b, aim to check superblock
mapped prior to get write access.

The crash reason described as below:
struct journal_head *jbd2_journal_add_journal_head(struct buffer_head *bh)
{
        ... ...
	jbd_lock_bh_journal_head(bh);
	if (buffer_jbd(bh)) {
		jh = bh2jh(bh); <<== jh is null!!!
	} else {
                ... ...
	}
	jh->b_jcount++; <<==crash here!!!!
	jbd_unlock_bh_journal_head(bh);
        ... ...
}

Debug code added to __ext4_journal_get_write_access:
int __ext4_journal_get_write_access(const char *where, unsigned int line,
                                handle_t *handle, struct buffer_head *bh)
{
        int err = 0;

        might_sleep();

        if (ext4_handle_valid(handle)) {
                struct super_block *sb;
                struct buffer_head *sbh;

                sb = handle->h_transaction->t_journal->j_private;
                if (unlikely(ext4_forced_shutdown(EXT4_SB(sb)))) {
                        jbd2_journal_abort_handle(handle);
                        return -EIO;
                }

                sbh = EXT4_SB(sb)->s_sbh;
                if (!buffer_mapped(sbh)) {
                        ext4 sb bh not mapped\n");  <<==debug code
                }

                err = jbd2_journal_get_write_access(handle, bh);
                if (err)
                        ext4_journal_abort_handle(where, line, __func__, bh,
                                                  handle, err);
        }
        return err;
}

Call trace of crash:
[ 1715.669527] print_req_error: I/O error, dev nbd3, sector 42211904

[ 1715.674940] ext4 sb bh not mapped   <<== debug log, which is added and printed by the
                                            function "__ext4_journal_get_write_access"

[ 1715.674946] BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
[ 1715.674955] IP: jbd2_journal_add_journal_head+0x9d/0x110 [jbd2]
[ 1715.674956] PGD 2010004067 P4D 2010004067 PUD 201000b067 PMD 0
[ 1715.674961] Oops: 0002 [#1] SMP
[ 1715.675020] task: ffff8808a4d3dac0 task.stack: ffffc9002e78c000
[ 1715.675024] RIP: 0010:jbd2_journal_add_journal_head+0x9d/0x110 [jbd2] <== the crash is caused
[ 1715.675025] RSP: 0018:ffffc9002e78fb50 EFLAGS: 00010206
[ 1715.675026] RAX: 0000000000000000 RBX: ffff8816b71cad00 RCX: 0000000000000000
[ 1715.675026] RDX: 0000000000000000 RSI: ffff8816b71cad00 RDI: ffff8816b71cad00
[ 1715.675027] RBP: ffffc9002e78fb58 R08: 000000000000001b R09: ffff88207f82fe07
[ 1715.675028] R10: 000000000000113d R11: 0000000000000000 R12: ffff8820223a5ab0
[ 1715.675028] R13: 0000000000000000 R14: ffff8816b71cad00 R15: ffff88196053d930
[ 1715.675029] FS:  00007fc2ce9e9700(0000) GS:ffff88203d740000(0000) knlGS:0000000000000000
[ 1715.675030] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1715.675031] CR2: 0000000000000008 CR3: 0000002016d2c004 CR4: 00000000007606e0
[ 1715.675033] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1715.675034] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1715.675034] PKRU: 55555554
[ 1715.675035] Call Trace:
[ 1715.675041]  jbd2_journal_get_write_access+0x6c/0xc0 [jbd2]
[ 1715.675057]  __ext4_journal_get_write_access+0x8f/0x120 [ext4]
[ 1715.675069]  ext4_reserve_inode_write+0x7b/0xb0 [ext4]
[ 1715.675079]  ? ext4_dirty_inode+0x48/0x70 [ext4]
[ 1715.675088]  ext4_mark_inode_dirty+0x53/0x1e0 [ext4]
[ 1715.675096]  ? __ext4_journal_start_sb+0x6d/0xf0 [ext4]
[ 1715.675104]  ext4_dirty_inode+0x48/0x70 [ext4]
[ 1715.675111]  __mark_inode_dirty+0x17f/0x350
[ 1715.675116]  generic_update_time+0x87/0xd0
[ 1715.675119]  file_update_time+0xbc/0x110
[ 1715.675122]  ? try_to_wake_up+0x59/0x470
[ 1715.675125]  __generic_file_write_iter+0x9d/0x1e0
[ 1715.675134]  ext4_file_write_iter+0xca/0x420 [ext4]
[ 1715.675136]  __vfs_write+0xf3/0x170
[ 1715.675138]  vfs_write+0xb2/0x1b0
[ 1715.675141]  ? syscall_trace_enter+0x1d0/0x2b0
[ 1715.675142]  SyS_write+0x55/0xc0
[ 1715.675144]  do_syscall_64+0x67/0x1b0
[ 1715.675147]  entry_SYSCALL64_slow_path+0x25/0x25

Signed-off-by: Xianting Tian <xianting_tian@126.com>
---
 fs/ext4/ext4_jbd2.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 0c76cdd..9a60ca7 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -203,6 +203,15 @@ int __ext4_journal_get_write_access(const char *where, unsigned int line,
 	might_sleep();
 
 	if (ext4_handle_valid(handle)) {
+		struct super_block *sb;
+		struct buffer_head *sbh;
+
+		sb = handle->h_transaction->t_journal->j_private;
+		sbh = EXT4_SB(sb)->s_sbh;
+		if (unlikely(!buffer_mapped(sbh))) {
+			return -EIO;
+		}
+
 		err = jbd2_journal_get_write_access(handle, bh);
 		if (err)
 			ext4_journal_abort_handle(where, line, __func__, bh,
-- 
1.8.3.1

