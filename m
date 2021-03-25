Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969093486E4
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Mar 2021 03:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbhCYCWE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 Mar 2021 22:22:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14579 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbhCYCVd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 Mar 2021 22:21:33 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F5TM30x5Hz19HM2;
        Thu, 25 Mar 2021 10:19:27 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Thu, 25 Mar 2021
 10:21:15 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ye Bin <yebin10@huawei.com>
Subject: [PATCH] ext4: Fix bug on in ext4_es_cache_extent as ext4_split_extent_at failed
Date:   Thu, 25 Mar 2021 10:29:25 +0800
Message-ID: <20210325022925.1769056-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We got follow bug_on:
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

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/extents.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 77c84d6f1af6..970eb2dfcc46 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3246,7 +3246,7 @@ static int ext4_split_extent_at(handle_t *handle,
 
 		goto out;
 	} else if (err)
-		goto fix_extent_len;
+		goto err;
 
 out:
 	ext4_ext_show_leaf(inode, path);
@@ -3254,6 +3254,7 @@ static int ext4_split_extent_at(handle_t *handle,
 
 fix_extent_len:
 	ex->ee_len = orig_ex.ee_len;
+err:
 	/*
 	 * Ignore ext4_ext_dirty return value since we are already in error path
 	 * and err is a non-zero error code.
-- 
2.25.4

