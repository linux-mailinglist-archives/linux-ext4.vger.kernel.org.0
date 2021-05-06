Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C2C375559
	for <lists+linux-ext4@lfdr.de>; Thu,  6 May 2021 16:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbhEFOEF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 May 2021 10:04:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17136 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbhEFOEE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 May 2021 10:04:04 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FbZvl24N7zqSgq;
        Thu,  6 May 2021 21:59:47 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Thu, 6 May 2021
 22:02:56 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.cz>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ye Bin <yebin10@huawei.com>
Subject: [PATCH v4] ext4: Fix bug on in ext4_es_cache_extent as ext4_split_extent_at failed
Date:   Thu, 6 May 2021 22:10:42 +0800
Message-ID: <20210506141042.3298679-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We got follow bug_on when run fsstress with injecting IO fault:
[130747.323114] kernel BUG at fs/ext4/extents_status.c:762!
[130747.323117] Internal error: Oops - BUG: 0 [#1] SMP
......
[130747.334329] Call trace:
[130747.334553]  ext4_es_cache_extent+0x150/0x168 [ext4]
[130747.334975]  ext4_cache_extents+0x64/0xe8 [ext4]
[130747.335368]  ext4_find_extent+0x300/0x330 [ext4]
[130747.335759]  ext4_ext_map_blocks+0x74/0x1178 [ext4]
[130747.336179]  ext4_map_blocks+0x2f4/0x5f0 [ext4]
[130747.336567]  ext4_mpage_readpages+0x4a8/0x7a8 [ext4]
[130747.336995]  ext4_readpage+0x54/0x100 [ext4]
[130747.337359]  generic_file_buffered_read+0x410/0xae8
[130747.337767]  generic_file_read_iter+0x114/0x190
[130747.338152]  ext4_file_read_iter+0x5c/0x140 [ext4]
[130747.338556]  __vfs_read+0x11c/0x188
[130747.338851]  vfs_read+0x94/0x150
[130747.339110]  ksys_read+0x74/0xf0

If call ext4_ext_insert_extent failed but new extent already inserted, we just
update "ex->ee_len = orig_ex.ee_len", this will lead to extent overlap, then
cause bug on when cache extent.
If call ext4_ext_insert_extent failed don't update ex->ee_len with old value.
Maybe there will lead to block leak, but it can be fixed by fsck later.

After we fixed above issue with v2 patch, but we got the same issue.
ext4_split_extent_at:
{
        ......
        err = ext4_ext_insert_extent(handle, inode, ppath, &newex, flags);
        if (err == -ENOSPC && (EXT4_EXT_MAY_ZEROOUT & split_flag)) {
            ......
            ext4_ext_try_to_merge(handle, inode, path, ex); ->step(1)
            err = ext4_ext_dirty(handle, inode, path + path->p_depth); ->step(2)
            if (err)
                goto fix_extent_len;
        ......
        }
        ......
fix_extent_len:
        ex->ee_len = orig_ex.ee_len; ->step(3)
        ......
}
If step(1) have been merged, but step(2) dirty extent failed, then go to
fix_extent_len label to fix ex->ee_len with orig_ex.ee_len. But "ex" may not be
old one, will cause overwritten. Then will trigger the same issue as previous.
If step(2) failed, just return error, don't fix ex->ee_len with old value.

This patch's modification is according to Jan Kara's suggestion in V3 patch:
("https://patchwork.ozlabs.org/project/linux-ext4/patch/20210428085158.3728201-1-yebin10@huawei.com/")
"I see. Now I understand your patch. Honestly, seeing how fragile is trying
to fix extent tree after split has failed in the middle, I would probably
go even further and make sure we fix the tree properly in case of ENOSPC
and EDQUOT (those are easily user triggerable).  Anything else indicates a
HW problem or fs corruption so I'd rather leave the extent tree as is and
don't try to fix it (which also means we will not create overlapping
extents)."

Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/extents.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 77c84d6f1af6..cbf37b2cf871 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3206,7 +3206,10 @@ static int ext4_split_extent_at(handle_t *handle,
 		ext4_ext_mark_unwritten(ex2);
 
 	err = ext4_ext_insert_extent(handle, inode, ppath, &newex, flags);
-	if (err == -ENOSPC && (EXT4_EXT_MAY_ZEROOUT & split_flag)) {
+	if (err != -ENOSPC && err != -EDQUOT)
+		goto out;
+
+	if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
 		if (split_flag & (EXT4_EXT_DATA_VALID1|EXT4_EXT_DATA_VALID2)) {
 			if (split_flag & EXT4_EXT_DATA_VALID1) {
 				err = ext4_ext_zeroout(inode, ex2);
@@ -3232,25 +3235,22 @@ static int ext4_split_extent_at(handle_t *handle,
 					      ext4_ext_pblock(&orig_ex));
 		}
 
-		if (err)
-			goto fix_extent_len;
-		/* update the extent length and mark as initialized */
-		ex->ee_len = cpu_to_le16(ee_len);
-		ext4_ext_try_to_merge(handle, inode, path, ex);
-		err = ext4_ext_dirty(handle, inode, path + path->p_depth);
-		if (err)
-			goto fix_extent_len;
-
-		/* update extent status tree */
-		err = ext4_zeroout_es(inode, &zero_ex);
-
-		goto out;
-	} else if (err)
-		goto fix_extent_len;
-
-out:
-	ext4_ext_show_leaf(inode, path);
-	return err;
+		if (!err) {
+			/* update the extent length and mark as initialized */
+			ex->ee_len = cpu_to_le16(ee_len);
+			ext4_ext_try_to_merge(handle, inode, path, ex);
+			err = ext4_ext_dirty(handle, inode, path + path->p_depth);
+			if (!err)
+				/* update extent status tree */
+				err = ext4_zeroout_es(inode, &zero_ex);
+			/* If we failed at this point, we don't know in which
+			 * state the extent tree exactly is so don't try to fix
+			 * length of the original extent as it may do even more
+			 * damage.
+			 */
+			goto out;
+		}
+	}
 
 fix_extent_len:
 	ex->ee_len = orig_ex.ee_len;
@@ -3260,6 +3260,9 @@ static int ext4_split_extent_at(handle_t *handle,
 	 */
 	ext4_ext_dirty(handle, inode, path + path->p_depth);
 	return err;
+out:
+	ext4_ext_show_leaf(inode, path);
+	return err;
 }
 
 /*
-- 
2.25.4

