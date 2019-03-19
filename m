Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30F861967B7
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Mar 2020 17:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbgC1Qqj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 Mar 2020 12:46:39 -0400
Received: from mx.sdf.org ([205.166.94.20]:50263 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbgC1QnO (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:14 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGh9lk016292
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:09 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGh9vH007105;
        Sat, 28 Mar 2020 16:43:09 GMT
Message-Id: <202003281643.02SGh9vH007105@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Mon, 18 Mar 2019 21:32:20 -0400
Subject: [RFC PATCH v1 08/50] fs/ext4/ialloc.c: Replace % with reciprocal_scale() TO BE VERIFIED
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This came about as part of auditing prandom_u32() usage, but
this is a special case: sometimes the starting value comes
from prandom_u32, and sometimes it comes from a hash of a name.

Does the name hash algorithm have to be stable? In that case, this
change would alter it.  But it appears to use s_hash_seed which
is regenerated on "e2fsck -D", so maybe changing it isn't a big deal.

Feedback needed.

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org
---
 fs/ext4/ialloc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 7db0c8814f2ec..a4ea89b3ed368 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -457,9 +457,8 @@ static int find_group_orlov(struct super_block *sb, struct inode *parent,
 			grp = hinfo.hash;
 		} else
 			grp = prandom_u32();
-		parent_group = (unsigned)grp % ngroups;
-		for (i = 0; i < ngroups; i++) {
-			g = (parent_group + i) % ngroups;
+		g = parent_group = reciprocal_scale(grp, ngroups);
+		for (i = 0; i < ngroups; i++, ++g == ngroups && (g = 0)) {
 			get_orlov_stats(sb, g, flex_size, &stats);
 			if (!stats.free_inodes)
 				continue;
-- 
2.26.0

