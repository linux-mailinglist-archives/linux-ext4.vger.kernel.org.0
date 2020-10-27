Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF4729AD49
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Oct 2020 14:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900685AbgJ0N15 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Oct 2020 09:27:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:58620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2900681AbgJ0N15 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 27 Oct 2020 09:27:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E3AB0ACAC;
        Tue, 27 Oct 2020 13:27:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9D51D1E10F5; Tue, 27 Oct 2020 14:27:55 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Mauricio Faria de Oliveira <mfo@canonical.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] ext4: Fix mmap write protection for data=journal mode
Date:   Tue, 27 Oct 2020 14:27:51 +0100
Message-Id: <20201027132751.29858-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Commit afb585a97f81 "ext4: data=journal: write-protect pages on
j_submit_inode_data_buffers()") added calls ext4_jbd2_inode_add_write()
to track inode ranges whose mappings need to get write-protected during
transaction commits. However the added calls use wrong start of a range
(0 instead of page offset) and so write protection is not necessarily
effective. Use correct range start to fix the problem.

Fixes: afb585a97f81 ("ext4: data=journal: write-protect pages on j_submit_inode_data_buffers()")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Mauricio, I think this could be the reason for occasional test failures you
were still seeing. Can you try whether this patch fixes those for you? Thanks!

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 03c2253005f0..f4a599c6dcde 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1918,7 +1918,7 @@ static int __ext4_journalled_writepage(struct page *page,
 	}
 	if (ret == 0)
 		ret = err;
-	err = ext4_jbd2_inode_add_write(handle, inode, 0, len);
+	err = ext4_jbd2_inode_add_write(handle, inode, page_offset(page), len);
 	if (ret == 0)
 		ret = err;
 	EXT4_I(inode)->i_datasync_tid = handle->h_transaction->t_tid;
@@ -6157,7 +6157,8 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 			if (ext4_walk_page_buffers(handle, page_buffers(page),
 					0, len, NULL, write_end_fn))
 				goto out_error;
-			if (ext4_jbd2_inode_add_write(handle, inode, 0, len))
+			if (ext4_jbd2_inode_add_write(handle, inode,
+						      page_offset(page), len))
 				goto out_error;
 			ext4_set_inode_state(inode, EXT4_STATE_JDATA);
 		} else {
-- 
2.16.4

