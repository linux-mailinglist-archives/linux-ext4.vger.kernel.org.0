Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FABE234B74
	for <lists+linux-ext4@lfdr.de>; Fri, 31 Jul 2020 21:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbgGaTId (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 31 Jul 2020 15:08:33 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59743 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728713AbgGaTId (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 31 Jul 2020 15:08:33 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 06VJ8SdU009106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 15:08:29 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5C343420478; Fri, 31 Jul 2020 15:08:28 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Alex Zhuravlev <azhuravlev@whamcloud.com>,
        Andreas Dilger <adilger@whamcloud.com>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>
Subject: [PATCH 2/4] ext4: skip non-loaded groups at cr=0/1 when scanning for good groups
Date:   Fri, 31 Jul 2020 15:08:03 -0400
Message-Id: <20200731190805.181253-3-tytso@mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200731190805.181253-1-tytso@mit.edu>
References: <20200731190805.181253-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Alex Zhuravlev <azhuravlev@whamcloud.com>

cr=0 is supposed to be an optimization to save CPU cycles, but if
buddy data (in memory) is not initialized then all this makes no sense
as we have to do sync IO taking a lot of cycles.  Also, at cr=0
mballoc doesn't choose any avaibale chunk.  cr=1 also skips groups
using heuristic based on avg. fragment size.  It's more useful to skip
such groups and switch to cr=2 where groups will be scanned for
available chunks.  However, we always read the first block group in a
flex_bg so metadata blocks will get read into the first flex_bg if
possible.

Using sparse image and dm-slow virtual device of 120TB was
simulated, then the image was formatted and filled using debugfs to
mark ~85% of available space as busy.  mount process w/o the patch
couldn't complete in half an hour (according to vmstat it would take
~10-11 hours).  With the patch applied mount took ~20 seconds.

Lustre-bug-id: https://jira.whamcloud.com/browse/LU-12988
Signed-off-by: Alex Zhuravlev <azhuravlev@whamcloud.com>
Reviewed-by: Andreas Dilger <adilger@whamcloud.com>
Reviewed-by: Artem Blagodarenko <artem.blagodarenko@gmail.com>
---
 fs/ext4/mballoc.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index fcc702f1ff15..b1ef35a9e9f1 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2177,6 +2177,7 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 {
 	struct ext4_group_info *grp = ext4_get_group_info(ac->ac_sb, group);
 	struct super_block *sb = ac->ac_sb;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	bool should_lock = ac->ac_flags & EXT4_MB_STRICT_CHECK;
 	ext4_grpblk_t free;
 	int ret = 0;
@@ -2195,7 +2196,26 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 
 	/* We only do this if the grp has never been initialized */
 	if (unlikely(EXT4_MB_GRP_NEED_INIT(grp))) {
-		ret = ext4_mb_init_group(ac->ac_sb, group, GFP_NOFS);
+		struct ext4_group_desc *gdp =
+			ext4_get_group_desc(sb, group, NULL);
+		int ret;
+
+		/* cr=0/1 is a very optimistic search to find large
+		 * good chunks almost for free.  If buddy data is not
+		 * ready, then this optimization makes no sense.  But
+		 * we never skip the first block group in a flex_bg,
+		 * since this gets used for metadata block allocation,
+		 * and we want to make sure we locate metadata blocks
+		 * in the first block group in the flex_bg if
+		 * possible.
+		 */
+		if (cr < 2 &&
+		    (!sbi->s_log_groups_per_flex ||
+		     ((group & ((1 << sbi->s_log_groups_per_flex) - 1)) != 0)) &&
+		    !(ext4_has_group_desc_csum(sb) &&
+		      (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))))
+			return 0;
+		ret = ext4_mb_init_group(sb, group, GFP_NOFS);
 		if (ret)
 			return ret;
 	}
-- 
2.24.1

