Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07F04425BE
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Nov 2021 03:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhKBCyR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Nov 2021 22:54:17 -0400
Received: from smtp181.sjtu.edu.cn ([202.120.2.181]:43122 "EHLO
        smtp181.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhKBCyQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Nov 2021 22:54:16 -0400
X-Greylist: delayed 505 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Nov 2021 22:54:16 EDT
Received: from proxy02.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
        by smtp181.sjtu.edu.cn (Postfix) with ESMTPS id 32FBA1008BE1D;
        Tue,  2 Nov 2021 10:43:15 +0800 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by proxy02.sjtu.edu.cn (Postfix) with ESMTP id 2213E200BFDAC;
        Tue,  2 Nov 2021 10:43:15 +0800 (CST)
X-Virus-Scanned: amavisd-new at 
Received: from proxy02.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy02.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id er17avYt62LX; Tue,  2 Nov 2021 10:43:15 +0800 (CST)
Received: from r742.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
        (Authenticated sender: sunrise_l)
        by proxy02.sjtu.edu.cn (Postfix) with ESMTPSA id A9D3E200BFDA6;
        Tue,  2 Nov 2021 10:43:00 +0800 (CST)
From:   Zhongwei Cai <sunrise_l@sjtu.edu.cn>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, mingkaidong@gmail.com,
        Zhongwei Cai <sunrise_l@sjtu.edu.cn>
Subject: [PATCH] ext4: remove unnecessary ext4_inode_datasync_dirty in read path
Date:   Tue,  2 Nov 2021 10:42:58 +0800
Message-Id: <20211102024258.210439-1-sunrise_l@sjtu.edu.cn>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4_inode_datasync_dirty will call read_lock(&journal->j_state_lock) in
journal mode, which is unnecessary in read path (As far as I know, the
IOMAP_F_DIRTY flag set in the if branch is only used in write path,
making it unnecessary in read path. Please correct me if I'm wrong).
and will cause cache contention overhead under high concurrency
especially in DAX mode. The unnecessary ext4_inode_datasync_dirty can be
eliminated by passing flags into ext4_set_iomap and checking it.

Performance tests are shown below. Workloads include simply reading files,
fileserver in filebench and readrandom/readsequence in RocksDB under
nosync mode.

Sixteen thread performance under ext4-DAX:
 Throughput (Kop/s) | original |  +patch  | improvement
 -------------------+----------+----------+--------------
 Read 4KB block     |   11456  |   27651  |  +141.37%
 fileserver         |     339  |     343  |  +1.18%
 readrandom         |    1807  |    1837  |  +1.66%
 readsequence       |   29724  |   30102  |  +1.27%

Signed-off-by: Zhongwei Cai <sunrise_l@sjtu.edu.cn>
---
 fs/ext4/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0f06305167d5..72ec2074ef54 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3274,7 +3274,7 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
 
 static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
 			   struct ext4_map_blocks *map, loff_t offset,
-			   loff_t length)
+			   loff_t length, int flags)
 {
 	u8 blkbits = inode->i_blkbits;
 
@@ -3284,8 +3284,8 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
 	 * there is no other metadata changes being made or are pending.
 	 */
 	iomap->flags = 0;
-	if (ext4_inode_datasync_dirty(inode) ||
-	    offset + length > i_size_read(inode))
+	if ((flags & IOMAP_WRITE) && (ext4_inode_datasync_dirty(inode) ||
+	    offset + length > i_size_read(inode)))
 		iomap->flags |= IOMAP_F_DIRTY;
 
 	if (map->m_flags & EXT4_MAP_NEW)
@@ -3423,7 +3423,7 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	if (ret < 0)
 		return ret;
 out:
-	ext4_set_iomap(inode, iomap, &map, offset, length);
+	ext4_set_iomap(inode, iomap, &map, offset, length, flags);
 
 	return 0;
 }
@@ -3543,7 +3543,7 @@ static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
 		delalloc = ext4_iomap_is_delalloc(inode, &map);
 
 set_iomap:
-	ext4_set_iomap(inode, iomap, &map, offset, length);
+	ext4_set_iomap(inode, iomap, &map, offset, length, flags);
 	if (delalloc && iomap->type == IOMAP_HOLE)
 		iomap->type = IOMAP_DELALLOC;
 
-- 
2.26.0

