Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCAD219777B
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Mar 2020 11:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbgC3JJh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Mar 2020 05:09:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:39834 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729684AbgC3JJh (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 30 Mar 2020 05:09:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 88994AD5D;
        Mon, 30 Mar 2020 09:09:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 073581E0E44; Mon, 30 Mar 2020 11:09:36 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] ext2fs: Fix off-by-one in dx_grow_tree()
Date:   Mon, 30 Mar 2020 11:09:32 +0200
Message-Id: <20200330090932.29445-3-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200330090932.29445-1-jack@suse.cz>
References: <20200330090932.29445-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There is an off-by-one error in dx_grow_tree() when checking whether we
can add another level to the tree. Thus we can grow tree too much
leading to possible crashes in the library or corrupted filesystem. Fix
the bug.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/ext2fs/link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ext2fs/link.c b/lib/ext2fs/link.c
index 7b5bb022117c..469eea8cd06d 100644
--- a/lib/ext2fs/link.c
+++ b/lib/ext2fs/link.c
@@ -473,7 +473,7 @@ static errcode_t dx_grow_tree(ext2_filsys fs, ext2_ino_t dir,
 		    ext2fs_le16_to_cpu(info->frames[i].head->limit))
 			break;
 	/* Need to grow tree depth? */
-	if (i < 0 && info->levels > ext2_dir_htree_level(fs))
+	if (i < 0 && info->levels >= ext2_dir_htree_level(fs))
 		return EXT2_ET_DIR_NO_SPACE;
 	lblk = size / fs->blocksize;
 	size += fs->blocksize;
-- 
2.16.4

