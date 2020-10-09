Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D74288595
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Oct 2020 10:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732953AbgJIIwK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Oct 2020 04:52:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57148 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732496AbgJIIwK (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 9 Oct 2020 04:52:10 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 59A21BE4E6B029381D37;
        Fri,  9 Oct 2020 16:52:08 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Fri, 9 Oct 2020
 16:51:58 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ye Bin <yebin10@huawei.com>
Subject: [PATCH] ext4: Fix WARN_ON_ONCE in __ext4_handle_dirty_metadata()
Date:   Fri, 9 Oct 2020 17:02:44 +0800
Message-ID: <20201009090244.111352-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When run fsstress with disk offline/online, I got follow warning:
[   47.395783] ------------[ cut here ]------------
[   47.400554] sd 1:0:0:0: rejecting I/O to offline device
[   47.403327] WARNING: CPU: 3 PID: 2420 at fs/buffer.c:1117 mark_buffer_dirty+0xcd/0xe0
[   47.406093] Modules linked in:
[   47.407322] CPU: 3 PID: 2420 Comm: fsstress Not tainted 3.10.0-862.14.0.6.x86_64 #136
[   47.409702] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),BIOS ?
-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc3104/01/2014
[   47.413142] Call Trace:
[   47.413473] sd 1:0:0:0: rejecting I/O to offline device
[   47.414805]  [<ffffffffa604697f>] dump_stack+0x19/0x1b
[   47.415866]  [<ffffffffa5895988>] __warn+0xd8/0x100
[   47.416970]  [<ffffffffa5895acd>] warn_slowpath_null+0x1d/0x20
[   47.418115]  [<ffffffffa5a5aecd>] mark_buffer_dirty+0xcd/0xe0
[   47.419247]  [<ffffffffa5af6a78>] __ext4_handle_dirty_metadata+0x1a8/0x220
[   47.420408]  [<ffffffffa5af65d3>] ? __ext4_journal_get_write_access+0x53/0x110
[   47.421430]  [<ffffffffa5abeec1>] __ext4_new_inode+0x921/0x1350
[   47.422276]  [<ffffffffa5ad22b9>] ext4_create+0xd9/0x1a0
[   47.423071]  [<ffffffffa5a31763>] vfs_create+0xd3/0x140
[   47.423820]  [<ffffffffa5a33870>] do_last+0x10f0/0x12c0
[   47.424627]  [<ffffffffa5bdc4fc>] ? selinux_file_alloc_security+0x3c/0x60
[   47.425571]  [<ffffffffa5a35877>] path_openat+0xd7/0x640
[   47.426389]  [<ffffffffa605885b>] ? system_call_fastpath+0x22/0x27
[   47.428099]  [<ffffffffa5a1c444>] ? create_object+0x234/0x310
[   47.428922]  [<ffffffffa5a3727d>] do_filp_open+0x4d/0xb0
[   47.429724]  [<ffffffffa5a90b69>] ? files_cgroup_alloc_fd+0x39/0x60
[   47.430623]  [<ffffffffa5a44c35>] ? __alloc_fd+0xe5/0x180
[   47.431361]  [<ffffffffa5a234a7>] do_sys_open+0x137/0x240
[   47.432275]  [<ffffffffa6058795>] ? system_call_after_swapgs+0xa2/0x146
[   47.433214]  [<ffffffffa5a235ce>] SyS_open+0x1e/0x20
[   47.433959]  [<ffffffffa5a23606>] SyS_creat+0x16/0x20
[   47.434675]  [<ffffffffa605885b>] system_call_fastpath+0x22/0x27
[   47.435555]  [<ffffffffa60587a1>] ? system_call_after_swapgs+0xae/0x146
[   47.436468] ---[ end trace f8ed64a9adfa868b ]---

In fact, I got a lot of call trace. All call trace trigger warning when call
__ext4_handle_dirty_metadate.
If there are racing calls to __ext4_handle_dirty_metadate. It's possible for
another writeback result in the buffer being marked with an error after we check
if the buffer is marked as having a write error and the buffer up-to-date flag
is cleared. If that happens mark_buffer_dirty() can end up throwing a WARN_ON_ONCE.
To Fix this warning, lock buffer when call mark_buffer_dirty in function
__ext4_handle_dirty_metadate.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/ext4_jbd2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 760b9ee49dc0..306ede92ee40 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -355,11 +355,13 @@ int __ext4_handle_dirty_metadata(const char *where, unsigned int line,
 					 err);
 		}
 	} else {
+		lock_buffer(bh);
 		set_buffer_uptodate(bh);
 		if (inode)
 			mark_buffer_dirty_inode(bh, inode);
 		else
 			mark_buffer_dirty(bh);
+		unlock_buffer(bh);
 		if (inode && inode_needs_sync(inode)) {
 			sync_dirty_buffer(bh);
 			if (buffer_req(bh) && !buffer_uptodate(bh)) {
-- 
2.16.2.dirty

