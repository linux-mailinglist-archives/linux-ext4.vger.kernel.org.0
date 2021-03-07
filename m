Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B48330235
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Mar 2021 15:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhCGOuN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 7 Mar 2021 09:50:13 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46876 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231264AbhCGOuM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 7 Mar 2021 09:50:12 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 127Eo36g011825
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 7 Mar 2021 09:50:04 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D461D15C3A96; Sun,  7 Mar 2021 09:50:03 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     984472@bugs.debian.org, nabijaczleweli@nabijaczleweli.xyz,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/2] resize2fs: avoid allocating over the MMP block
Date:   Sun,  7 Mar 2021 09:49:49 -0500
Message-Id: <20210307144950.197569-1-tytso@mit.edu>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When resizing past the point where the reserve inode has reserved
space for the block group descriptors to expand, and resize2fs (in an
offline resize) needs to move the allocation bitmaps and/or inode
table around, it's possible for resize2fs to allocate over the MMP
block, which would be bad.

Prevent this from happening by reserving the MMP block as a file
system metadata block (which it is) in resize2fs's accounting.

Addresses-Debian-Bug: #984472
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 resize/resize2fs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/resize/resize2fs.c b/resize/resize2fs.c
index a0d08e5b..daaa3d49 100644
--- a/resize/resize2fs.c
+++ b/resize/resize2fs.c
@@ -1177,6 +1177,11 @@ static errcode_t mark_table_blocks(ext2_filsys fs,
 		if (blk)
 			ext2fs_mark_block_bitmap2(bmap, blk);
 	}
+	/* Reserve the MMP block */
+	if (ext2fs_has_feature_mmp(fs->super) &&
+	    fs->super->s_mmp_block > fs->super->s_first_data_block &&
+	    fs->super->s_mmp_block < ext2fs_blocks_count(fs->super))
+		ext2fs_mark_block_bitmap2(bmap, fs->super->s_mmp_block);
 	return 0;
 }
 
-- 
2.30.0

