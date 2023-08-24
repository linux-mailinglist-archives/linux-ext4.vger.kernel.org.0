Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9038D786BEC
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Aug 2023 11:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240351AbjHXJbA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Aug 2023 05:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240785AbjHXJas (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Aug 2023 05:30:48 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B433199E
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 02:30:45 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RWd9Y6l9Rz4f3prH
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 17:30:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHl6kzI+dkL1rbBQ--.46575S9;
        Thu, 24 Aug 2023 17:30:42 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: [RFC PATCH 05/16] ext4: pass real delayed status into ext4_es_insert_extent()
Date:   Thu, 24 Aug 2023 17:26:08 +0800
Message-Id: <20230824092619.1327976-6-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
References: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHl6kzI+dkL1rbBQ--.46575S9
X-Coremail-Antispam: 1UD129KBjvJXoWxWr15Jry8Kr4Dur1rWrykXwb_yoW5GF13p3
        sxAw1rWF4UWw4j934S9r40gr15KayqkrWDCrs5JryrtayfGr1SkF1DtFW8ZFyqgrW8Aa1Y
        qFWru3srCay5CFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9G14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
        xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMx
        C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
        vE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
        0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxV
        W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmZX7UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

Commit 'd2dc317d564a ("ext4: fix data corruption caused by unwritten and
delayed extents")' fix a data corruption issue by stop passing delayed
status into ext4_es_insert_extent() if the mapping range has been
written. This patch change it to still pass the real delayed status and
deal with the 'delayed && written' case in ext4_es_insert_extent(). If
the status have delayed bit is set, it means that the path of delayed
allocation is still running, and this insert process is not allocating
delayed allocated blocks.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents_status.c | 13 +++++++------
 fs/ext4/inode.c          |  2 --
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 3a004ed04570..62191c772b82 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -873,13 +873,14 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 
 	BUG_ON(end < lblk);
 
+	/*
+	 * Insert extent as delayed and written which can potentially cause
+	 * data lose, and the extent has been written, it's safe to remove
+	 * the delayed flag even it's still delayed.
+	 */
 	if ((status & EXTENT_STATUS_DELAYED) &&
-	    (status & EXTENT_STATUS_WRITTEN)) {
-		ext4_warning(inode->i_sb, "Inserting extent [%u/%u] as "
-				" delayed and written which can potentially "
-				" cause data loss.", lblk, len);
-		WARN_ON(1);
-	}
+	    (status & EXTENT_STATUS_WRITTEN))
+		status &= ~EXTENT_STATUS_DELAYED;
 
 	newes.es_lblk = lblk;
 	newes.es_len = len;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 6c490f05e2ba..82115d6656d3 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -563,7 +563,6 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		status = map->m_flags & EXT4_MAP_UNWRITTEN ?
 				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
 		if (!(flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE) &&
-		    !(status & EXTENT_STATUS_WRITTEN) &&
 		    ext4_es_scan_range(inode, &ext4_es_is_delayed, map->m_lblk,
 				       map->m_lblk + map->m_len - 1))
 			status |= EXTENT_STATUS_DELAYED;
@@ -673,7 +672,6 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		status = map->m_flags & EXT4_MAP_UNWRITTEN ?
 				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
 		if (!(flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE) &&
-		    !(status & EXTENT_STATUS_WRITTEN) &&
 		    ext4_es_scan_range(inode, &ext4_es_is_delayed, map->m_lblk,
 				       map->m_lblk + map->m_len - 1))
 			status |= EXTENT_STATUS_DELAYED;
-- 
2.39.2

