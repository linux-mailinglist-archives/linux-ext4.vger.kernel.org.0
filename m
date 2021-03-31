Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F6D34FFD9
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Mar 2021 14:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbhCaMBa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 Mar 2021 08:01:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14654 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbhCaMBT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 Mar 2021 08:01:19 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F9PwZ1gv1znWwc;
        Wed, 31 Mar 2021 19:58:38 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Wed, 31 Mar 2021
 20:01:10 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>
Subject: [PATCH v2] ext4: do not set SB_ACTIVE in ext4_orphan_cleanup()
Date:   Wed, 31 Mar 2021 20:09:10 +0800
Message-ID: <20210331120910.2223493-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When CONFIG_QUOTA is enabled and if we later fail to finish mounting the
filesystem due to some error after ext4_orphan_cleanup(), we may hit use
after free issues. The problem is that ext4_orphan_cleanup() sets
SB_ACTIVE flag and so inodes processed during the orphan cleanup are put
to the superblock's LRU list instead of being immediately destroyed.
However the path handling error recovery after failed ->fill_super()
call does not destroy inodes attached to the superblock and so they are
left active in memory while the superblock is freed.

Originally, SB_ACTIVE setting was added so that updated quota
information is not destroyed when we drop quota inode references after
orphan cleanup. However VFS does not purge dirty inode pages without
SB_ACTIVE flag for many years already. So just remove the hack with
setting SB_ACTIVE flag from ext4_orphan_cleanup().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Tested-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
---
Changes since v1:
 - Rephrase the changelog as Jan suggested.

 fs/ext4/super.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b9693680463a..2a33c53b57d8 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3023,9 +3023,6 @@ static void ext4_orphan_cleanup(struct super_block *sb,
 		sb->s_flags &= ~SB_RDONLY;
 	}
 #ifdef CONFIG_QUOTA
-	/* Needed for iput() to work correctly and not trash data */
-	sb->s_flags |= SB_ACTIVE;
-
 	/*
 	 * Turn on quotas which were not enabled for read-only mounts if
 	 * filesystem has quota feature, so that they are updated correctly.
-- 
2.25.4

