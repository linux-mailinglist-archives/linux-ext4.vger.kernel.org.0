Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5383626F34E
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Sep 2020 05:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgIRDFh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Sep 2020 23:05:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727282AbgIRCEU (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 17 Sep 2020 22:04:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5B7A2376F;
        Fri, 18 Sep 2020 02:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600394659;
        bh=ibA8gcQYmlotP6cznryHZI/OdgfEaEgutrgQue529Fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XV8ggTH/odt6Ilz2lq8RLK1sk5PN4DGnWI4oHSGE5xYGtryOWstS7s+qKJv0Wj6n3
         nDQolbdO6oLP/qC6CrMLkxe18kdE20Rv4UfmKoR3cy7ORferIl7/TU8DwdutlpBdsI
         pUdPVjLaDU5dBTUuVE4xdAXYhhGi4frrO5YPSXEo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qiujun Huang <hqjagain@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>, linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 155/330] ext4: fix a data race at inode->i_disksize
Date:   Thu, 17 Sep 2020 21:58:15 -0400
Message-Id: <20200918020110.2063155-155-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918020110.2063155-1-sashal@kernel.org>
References: <20200918020110.2063155-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Qiujun Huang <hqjagain@gmail.com>

[ Upstream commit dce8e237100f60c28cc66effb526ba65a01d8cb3 ]

KCSAN find inode->i_disksize could be accessed concurrently.

BUG: KCSAN: data-race in ext4_mark_iloc_dirty / ext4_write_end

write (marked) to 0xffff8b8932f40090 of 8 bytes by task 66792 on cpu 0:
 ext4_write_end+0x53f/0x5b0
 ext4_da_write_end+0x237/0x510
 generic_perform_write+0x1c4/0x2a0
 ext4_buffered_write_iter+0x13a/0x210
 ext4_file_write_iter+0xe2/0x9b0
 new_sync_write+0x29c/0x3a0
 __vfs_write+0x92/0xa0
 vfs_write+0xfc/0x2a0
 ksys_write+0xe8/0x140
 __x64_sys_write+0x4c/0x60
 do_syscall_64+0x8a/0x2a0
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

read to 0xffff8b8932f40090 of 8 bytes by task 14414 on cpu 1:
 ext4_mark_iloc_dirty+0x716/0x1190
 ext4_mark_inode_dirty+0xc9/0x360
 ext4_convert_unwritten_extents+0x1bc/0x2a0
 ext4_convert_unwritten_io_end_vec+0xc5/0x150
 ext4_put_io_end+0x82/0x130
 ext4_writepages+0xae7/0x16f0
 do_writepages+0x64/0x120
 __writeback_single_inode+0x7d/0x650
 writeback_sb_inodes+0x3a4/0x860
 __writeback_inodes_wb+0xc4/0x150
 wb_writeback+0x43f/0x510
 wb_workfn+0x3b2/0x8a0
 process_one_work+0x39b/0x7e0
 worker_thread+0x88/0x650
 kthread+0x1d4/0x1f0
 ret_from_fork+0x35/0x40

The plain read is outside of inode->i_data_sem critical section
which results in a data race. Fix it by adding READ_ONCE().

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
Link: https://lore.kernel.org/r/1582556566-3909-1-git-send-email-hqjagain@gmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index a284d99a1ee57..95a8a04c77dd3 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5315,7 +5315,7 @@ static int ext4_do_update_inode(handle_t *handle,
 		raw_inode->i_file_acl_high =
 			cpu_to_le16(ei->i_file_acl >> 32);
 	raw_inode->i_file_acl_lo = cpu_to_le32(ei->i_file_acl);
-	if (ei->i_disksize != ext4_isize(inode->i_sb, raw_inode)) {
+	if (READ_ONCE(ei->i_disksize) != ext4_isize(inode->i_sb, raw_inode)) {
 		ext4_isize_set(raw_inode, ei->i_disksize);
 		need_datasync = 1;
 	}
-- 
2.25.1

