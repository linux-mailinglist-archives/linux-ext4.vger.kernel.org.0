Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF09265EEE
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Sep 2020 13:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgIKLnj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Sep 2020 07:43:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11820 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725808AbgIKLnb (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 11 Sep 2020 07:43:31 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BFDE4D7AD17869E56064;
        Fri, 11 Sep 2020 19:43:24 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Fri, 11 Sep 2020
 19:43:21 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <jack@suse.com>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] ext2: Fix some kernel-doc warnings in balloc.c
Date:   Fri, 11 Sep 2020 19:40:36 +0800
Message-ID: <20200911114036.60616-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

fs/ext2/balloc.c:203: warning: Excess function parameter 'rb_root' description in '__rsv_window_dump'
fs/ext2/balloc.c:294: warning: Excess function parameter 'rb_root' description in 'search_reserve_window'
fs/ext2/balloc.c:878: warning: Excess function parameter 'rsv' description in 'alloc_new_reservation'

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 fs/ext2/balloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index fa9c951d3471..1f3f4326bf3c 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -189,7 +189,7 @@ static void group_adjust_blocks(struct super_block *sb, int group_no,
 
 /**
  * __rsv_window_dump() -- Dump the filesystem block allocation reservation map
- * @rb_root:		root of per-filesystem reservation rb tree
+ * @root:		root of per-filesystem reservation rb tree
  * @verbose:		verbose mode
  * @fn:			function which wishes to dump the reservation map
  *
@@ -282,7 +282,7 @@ goal_in_my_reservation(struct ext2_reserve_window *rsv, ext2_grpblk_t grp_goal,
 
 /**
  * search_reserve_window()
- * @rb_root:		root of reservation tree
+ * @root:		root of reservation tree
  * @goal:		target allocation block
  *
  * Find the reserved window which includes the goal, or the previous one
@@ -859,7 +859,7 @@ static int find_next_reservable_window(
  *
  *	failed: we failed to find a reservation window in this group
  *
- *	@rsv: the reservation
+ *	@my_rsv: the reservation
  *
  *	@grp_goal: The goal (group-relative).  It is where the search for a
  *		free reservable space should start from.
-- 
2.17.1

