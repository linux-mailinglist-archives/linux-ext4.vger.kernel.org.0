Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FADF2DCC63
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Dec 2020 07:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgLQGOz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Dec 2020 01:14:55 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40120 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725828AbgLQGOz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Dec 2020 01:14:55 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BH6E1Qe028930
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 01:14:02 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 94D4B420280; Thu, 17 Dec 2020 01:14:01 -0500 (EST)
Date:   Thu, 17 Dec 2020 01:14:01 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Chunguang Xu <brookxu.cn@gmail.com>
Cc:     adilger.kernel@dilger.ca, bzzz@whamcloud.com,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] ext4: avoid s_mb_prefetch to be zero in individual
 scenarios
Message-ID: <X9r3KU5XdOHSthup@mit.edu>
References: <1607051143-24508-1-git-send-email-brookxu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607051143-24508-1-git-send-email-brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I cleaned up the commit description and the code slightly; it doesn't
change the generated object but makes the code a bit more concise and
easier to read:

commit 8333bd298d915a2d1c01cbed9287d284aaa04bb1
Author: Chunguang Xu <brookxu@tencent.com>
Date:   Fri Dec 4 11:05:43 2020 +0800

    ext4: avoid s_mb_prefetch to be zero in individual scenarios
    
    Commit cfd732377221 ("ext4: add prefetching for block allocation
    bitmaps") introduced block bitmap prefetch, and expects to read block
    bitmaps of flex_bg through an IO.  However, it seems to ignore the
    value range of s_log_groups_per_flex.  In the scenario where the value
    of s_log_groups_per_flex is greater than 27, s_mb_prefetch or
    s_mb_prefetch_limit will overflow, cause a divide zero exception.
    
    In addition, the logic of calculating nr is also flawed, because the
    size of flexbg is fixed during a single mount, but s_mb_prefetch can
    be modified, which causes nr to fail to meet the value condition of
    [1, flexbg_size].
    
    To solve this problem, we need to set the upper limit of
    s_mb_prefetch.  Since we expect to load block bitmaps of a flex_bg
    through an IO, we can consider determining a reasonable upper limit
    among the IO limit parameters.  After consideration, we chose
    BLK_MAX_SEGMENT_SIZE.  This is a good choice to solve divide zero
    problem and avoiding performance degradation.
    
    [ Some minor code simplifications to make the changes easy to follow -- TYT ]
    
    Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
    Signed-off-by: Chunguang Xu <brookxu@tencent.com>
    Reviewed-by: Samuel Liao <samuelliao@tencent.com>
    Reviewed-by: Andreas Dilger <adilger@dilger.ca>
    Link: https://lore.kernel.org/r/1607051143-24508-1-git-send-email-brookxu@tencent.com
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 77815cd110b2..99bf091fee10 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2372,9 +2372,9 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 
 				nr = sbi->s_mb_prefetch;
 				if (ext4_has_feature_flex_bg(sb)) {
-					nr = (group / sbi->s_mb_prefetch) *
-						sbi->s_mb_prefetch;
-					nr = nr + sbi->s_mb_prefetch - group;
+					nr = 1 << sbi->s_log_groups_per_flex;
+					nr -= group & (nr - 1);
+					nr = min(nr, sbi->s_mb_prefetch);
 				}
 				prefetch_grp = ext4_mb_prefetch(sb, group,
 							nr, &prefetch_ios);
@@ -2710,7 +2710,8 @@ static int ext4_mb_init_backend(struct super_block *sb)
 
 	if (ext4_has_feature_flex_bg(sb)) {
 		/* a single flex group is supposed to be read by a single IO */
-		sbi->s_mb_prefetch = 1 << sbi->s_es->s_log_groups_per_flex;
+		sbi->s_mb_prefetch = min(1 << sbi->s_es->s_log_groups_per_flex,
+			BLK_MAX_SEGMENT_SIZE >> (sb->s_blocksize_bits - 9));
 		sbi->s_mb_prefetch *= 8; /* 8 prefetch IOs in flight at most */
 	} else {
 		sbi->s_mb_prefetch = 32;
