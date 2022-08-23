Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD63159ED5F
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Aug 2022 22:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiHWUfZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 Aug 2022 16:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiHWUfE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 Aug 2022 16:35:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CCC4AD50
        for <linux-ext4@vger.kernel.org>; Tue, 23 Aug 2022 13:15:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 91195336D9;
        Tue, 23 Aug 2022 20:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661285758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sHfiS/b/jr0z+nZX9qn+yA+fZvMUIZsYHb/HlwCGYjo=;
        b=vu11/JwrbZaqilf2BZBZ1uBghfSepKXgPoL0rqwbT4V1vf7t5XjmG3xxjx8Ql+QTCNSM+n
        ZYIgc1l+3uPNp1NPreQ60CjWXmJceGqtmU/jt/rqpucvs3yL2xhdMIM5YtJ0jb/Lx3MO1r
        08Zk3dH5b3Zk0XY0daLYgpGTHrWIPSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661285758;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sHfiS/b/jr0z+nZX9qn+yA+fZvMUIZsYHb/HlwCGYjo=;
        b=k73TsDZrNRVbfwmFQjiGZaI5/YN0CqOQkK6outuHpAgMIlchH9lPyXMgczF0GJyh+DAph+
        aISzq3dY1fcjstAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7BE5B13AE6;
        Tue, 23 Aug 2022 20:15:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qrcSHn41BWPJAQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 23 Aug 2022 20:15:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EA133A0680; Tue, 23 Aug 2022 22:15:57 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] ext4: Avoid unnecessary spreading of allocations among groups
Date:   Tue, 23 Aug 2022 22:15:54 +0200
Message-Id: <20220823201557.28818-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220823134508.27854-1-jack@suse.cz>
References: <20220823134508.27854-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2237; h=from:subject; bh=A+cK0EozPU0BdTnQ78Cn9BdsS9WnVEc8rshrdjI8jdM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjBTV53Ju0FE1b6l1/Rs2jKV/urmQzOkBya05HI1UP wqktssSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYwU1eQAKCRCcnaoHP2RA2cArCA CyyqkhayUbOnKjQmeNy6b+YITXLcgBKX+gA2ZnFDfDACRomIx8xAUTsvpS35tsw+ORe9n51PHqNyYm +gZrTMBI3xSQ65bYsSXbGtx17+d4u2VhACiLPTcw9+vFVgSp9hRvUCOlU6hMmCPxCmHhhRRAN2MrkU 4Vup+Ov/+ZCPsQSBfFNlz6pR1UojAM645VwT59c8wyKQhoxg4Q2/x81+B6+E8spYe4u15xIaI+zX4q 1A6rvwJ1urP6GzY1fk+0FPj08vyjhSiupY0laEhHp2tl4cCH1qHs83NC4+0O5Onkjj/eih1a6fTwpj fYtdXnTRUz04P/50LV9rpdiWo2CPBL
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

