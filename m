Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC4C5AEFDE
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Sep 2022 18:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbiIFQGR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Sep 2022 12:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbiIFQFu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Sep 2022 12:05:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F843FC1
        for <linux-ext4@vger.kernel.org>; Tue,  6 Sep 2022 08:29:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4AA0433906;
        Tue,  6 Sep 2022 15:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662478161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sHfiS/b/jr0z+nZX9qn+yA+fZvMUIZsYHb/HlwCGYjo=;
        b=jYVy4+zx52xttmLZL6K1ReSJTivUpSODPhEL5mJd6FTd6KBg7dnTvtu/eTHHO/rZIEQ9/b
        SCgnKFZlHvUgGH+GxcRO7AYExkNTY8fLz8AH2htSaa94Q9gGM/U4LUGkGzz91c0cv6GNNr
        83Vxk9Eo09/kwF+SXW7gYr9Ep2bLFwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662478161;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sHfiS/b/jr0z+nZX9qn+yA+fZvMUIZsYHb/HlwCGYjo=;
        b=lHf7B6/xPTAwgUvn6CC+87Qy3nHORD8/QDkT7nJM4gqL1H8JacjXkxkXMwK+NNfnVnfayB
        e+kEKSaiAhkdZhCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A34613B2C;
        Tue,  6 Sep 2022 15:29:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5DYXDlFnF2NUHAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 06 Sep 2022 15:29:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7F179A0682; Tue,  6 Sep 2022 17:29:20 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 2/5] ext4: Avoid unnecessary spreading of allocations among groups
Date:   Tue,  6 Sep 2022 17:29:08 +0200
Message-Id: <20220906152920.25584-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220906150803.375-1-jack@suse.cz>
References: <20220906150803.375-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2237; h=from:subject; bh=A+cK0EozPU0BdTnQ78Cn9BdsS9WnVEc8rshrdjI8jdM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjF2dD3Ju0FE1b6l1/Rs2jKV/urmQzOkBya05HI1UP wqktssSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYxdnQwAKCRCcnaoHP2RA2cnIB/ 9Vdhs9tEvnA1YNXIoJp1gFuQuxJvkVIeyh2NqL5Ex/CHY1240ZLAz9hutPEeokh13QS6zNqnOb00rk 0HCpJ+pQcXv0R2O8zjd5EKLqecKNQTCEqyjyPpIDkDnjEpRZIkmJTlJEg2f7UmmgazX8iZCSD2NDnL PSLKcC8Q2n2myx5gi4cxYEUIXADgFatgKppF7lnZjAb2lUvbW40WURrDCXBJrLYmnMttXr6q+mqEo8 Etfvzx8KZcdXl4ymRpmtR1HjPSPPoOOf6vPes3mqzGt3weGmvP8A1xVRl2nvevImovKmzn8ZHuFMju t/jqclEDq6JLSajy8kNE0nY8La6xkC
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

mb_set_largest_free_order() updates lists containing groups with largest
chunk of free space of given order. The way it updates it leads to
always moving the group to the tail of the list. Thus allocations
looking for free space of given order effectively end up cycling through
all groups (and due to initialization in last to first order). This
spreads allocations among block groups which reduces performance for
rotating disks or low-end flash media. Change
mb_set_largest_free_order() to only update lists if the order of the
largest free chunk in the group changed.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 41e1cfecac3b..6251b4a6cc63 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1077,23 +1077,25 @@ mb_set_largest_free_order(struct super_block *sb, struct ext4_group_info *grp)
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	int i;
 
-	if (test_opt2(sb, MB_OPTIMIZE_SCAN) && grp->bb_largest_free_order >= 0) {
+	for (i = MB_NUM_ORDERS(sb) - 1; i >= 0; i--)
+		if (grp->bb_counters[i] > 0)
+			break;
+	/* No need to move between order lists? */
+	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) ||
+	    i == grp->bb_largest_free_order) {
+		grp->bb_largest_free_order = i;
+		return;
+	}
+
+	if (grp->bb_largest_free_order >= 0) {
 		write_lock(&sbi->s_mb_largest_free_orders_locks[
 					      grp->bb_largest_free_order]);
 		list_del_init(&grp->bb_largest_free_order_node);
 		write_unlock(&sbi->s_mb_largest_free_orders_locks[
 					      grp->bb_largest_free_order]);
 	}
-	grp->bb_largest_free_order = -1; /* uninit */
-
-	for (i = MB_NUM_ORDERS(sb) - 1; i >= 0; i--) {
-		if (grp->bb_counters[i] > 0) {
-			grp->bb_largest_free_order = i;
-			break;
-		}
-	}
-	if (test_opt2(sb, MB_OPTIMIZE_SCAN) &&
-	    grp->bb_largest_free_order >= 0 && grp->bb_free) {
+	grp->bb_largest_free_order = i;
+	if (grp->bb_largest_free_order >= 0 && grp->bb_free) {
 		write_lock(&sbi->s_mb_largest_free_orders_locks[
 					      grp->bb_largest_free_order]);
 		list_add_tail(&grp->bb_largest_free_order_node,
-- 
2.35.3

