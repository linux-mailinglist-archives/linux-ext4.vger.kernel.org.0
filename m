Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD265AEFDC
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Sep 2022 18:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbiIFQGL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Sep 2022 12:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiIFQFt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Sep 2022 12:05:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC17327
        for <linux-ext4@vger.kernel.org>; Tue,  6 Sep 2022 08:29:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3E3051F922;
        Tue,  6 Sep 2022 15:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662478161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xeBX+aqh8dI+zZamf+hnFHxB1cAUoFVE79Cq3AcYAWw=;
        b=iYutOdHajKPdlycuKMrIVy/WoSKcBeO54HhMaQzR3WHqabELFXWfuZPSU9HERp3jXTGrSR
        PWApwsdeH5pnN6Jre3+oNB2FRLBlN9q4EUYHc8I3V3EqtEXaXDY83Z/UX2w/PDKyQH4c3G
        a3QAhh79LFF3NuSs4hFI3mrYcYEgmOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662478161;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xeBX+aqh8dI+zZamf+hnFHxB1cAUoFVE79Cq3AcYAWw=;
        b=oOs3fxKeJfydNYr0q/OmiKcFlKJm5GiQJkbO8aQDnpg+NZQgpARqi/8pONFn1es4fUUaNv
        INl1fedMXLX8XxBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E30D13A93;
        Tue,  6 Sep 2022 15:29:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9TIhDFFnF2NQHAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 06 Sep 2022 15:29:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 84282A0684; Tue,  6 Sep 2022 17:29:20 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 3/5] ext4: Make directory inode spreading reflect flexbg size
Date:   Tue,  6 Sep 2022 17:29:09 +0200
Message-Id: <20220906152920.25584-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220906150803.375-1-jack@suse.cz>
References: <20220906150803.375-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1030; h=from:subject; bh=0ydVeHAR/W/FHxkhDmZbYwUxUA0Pga+4UqySultdu+Y=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjF2dE6HEeTN6O5RgZu8VXC5YfOcB8GhMVoenSbiI7 SJMRxpOJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYxdnRAAKCRCcnaoHP2RA2Uf4B/ 4m4hipZEFyCfvBbnqRVY/vuHFPg9ZBMFSx1h9e4yAbCG50KHPNeu4fWGPXcYPZ2M+niz8Dd4VwIOhU d/f5xzFgy7qxzv0JB6u7ePKarDYyXuz9/e39FlpcmPWDeixkCAFXIwadwVoojN5c46iBd47Y5axVm/ rnypd0/f42N/yQio8aOS/uM2oWXCTBJpmaTA0nsFIjzaKxCXmPgXZdpC421zPrPskB8qwZxt3zB/4N sPO4dA/VQw6E/pV3G6YczupzGJQoftQR1zMUneAuOxH4RiDRdankjlaIXplTWv9y736cmy8N1GYMYy U04cQyfKfN63UDzgVplH2u9WNDf2zX
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

Currently the Orlov inode allocator searches for free inodes for a
directory only in flex block groups with at most inodes_per_group/16
more directory inodes than average per flex block group. However with
growing size of flex block group this becomes unnecessarily strict.
Scale allowed difference from average directory count per flex block
group with flex block group size as we do with other metrics.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ialloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index f73e5eb43eae..208b87ce8858 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -510,7 +510,7 @@ static int find_group_orlov(struct super_block *sb, struct inode *parent,
 		goto fallback;
 	}
 
-	max_dirs = ndirs / ngroups + inodes_per_group / 16;
+	max_dirs = ndirs / ngroups + inodes_per_group*flex_size / 16;
 	min_inodes = avefreei - inodes_per_group*flex_size / 4;
 	if (min_inodes < 1)
 		min_inodes = 1;
-- 
2.35.3

