Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F043EA4D9
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Aug 2021 14:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbhHLMsI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Aug 2021 08:48:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42750 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235864AbhHLMsI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Aug 2021 08:48:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 14BE41FF3E;
        Thu, 12 Aug 2021 12:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628772462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=A39j2co4sIqqC7Vxyvl//96WHcWa/7qEbNRag2kEL+c=;
        b=YOpaLSvVA5tjtTZyMGjlT2xPVrDD9P15kf0Gl0eGQX4yaMtlKJ4nEzxN0cUjbZkdwr52wc
        bnDFw+HGh556B2hi14j1enDLG+3rmUVpROvqnXolPt7Z8FcG3gxTkABRy6Jskw30S9n1qX
        l2YN4ZqfB4hWyjdR0GjgxzkiCzGguCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628772462;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=A39j2co4sIqqC7Vxyvl//96WHcWa/7qEbNRag2kEL+c=;
        b=CR5LxnaunnrTcmfDVmj8GmvYEWUjmm3h7wQQbazcHHL3VKT0VtI10ZYd7dcq28/C6jhUA3
        LF0BMRyQyDfUolAQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 0561FA3EF0;
        Thu, 12 Aug 2021 12:47:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CAAC21F2AC2; Thu, 12 Aug 2021 14:47:41 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     Boyang Xue <bxue@redhat.com>, <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] ext4: Fix tune2fs checksum failure for mounted filesystem
Date:   Thu, 12 Aug 2021 14:47:37 +0200
Message-Id: <20210812124737.21981-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1482; h=from:subject; bh=uKWbBc+a3E9TXFE5SbPvTNP8T/oUIFXIsO8xql8BSeA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhFRhI4IM7uxiUm1VJoaKEctIy5sB2soRb2AiovQUv u8Ai8j6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYRUYSAAKCRCcnaoHP2RA2eyUCA Cv5k3A0GD2Yw9kgFgvlR0SauJu6g9RgSVwMWz5u9964lx18Ked6Huls789AwafXvSaRE8OzTJAkxaw pqeCC4dzOcvMRrfP68uhuvaiIFJlTx4kf2WA/cES3gLEbfSnM5QhnqjdpkpE36q6LyTpJSF72X1SPC LbXsdaKjyo1hAUXx3UlazKpYhQk9ups0ZozARzaa6UKQSS9aUaqTVhtjMpERHMDY6vd1PFqObyt+ar DhE+o+5kEOuKYWDN/SwCmThSvuS4qNJMhMtkew0Tcjs1sZOVLvHFIjMYSirOiYSAupJ0VpMAFCZXg2 vvMYeQ2OMeYM3DezWxX/gOPN6c2mxP
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Commit 81414b4dd48 ("ext4: remove redundant sb checksum recomputation")
removed checksum recalculation after updating superblock free space /
inode counters in ext4_fill_super() based on the fact that we will
recalculate the checksum on superblock writeout. That is correct
assumption but until the writeout happens (which can take a long time)
the checksum is incorrect in the buffer cache and if tune2fs is called
in that time window it will complain. So return back the checksum
recalculation and add a comment explaining the tune2fs peculiarity.

Fixes: 81414b4dd48f ("ext4: remove redundant sb checksum recomputation")
Reported-by: Boyang Xue <bxue@redhat.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dfa09a277b56..8f2474618f7e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5032,6 +5032,12 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		err = percpu_counter_init(&sbi->s_freeinodes_counter, freei,
 					  GFP_KERNEL);
 	}
+	/*
+	 * Let's update the checksum after updating free space/inode counters.
+	 * Otherwise sb will have incorrect checksum in the buffer cache until
+	 * sb is written out and tune2fs can get confused.
+	 */
+	ext4_superblock_csum_set(sb);
 	if (!err)
 		err = percpu_counter_init(&sbi->s_dirs_counter,
 					  ext4_count_dirs(sb), GFP_KERNEL);
-- 
2.26.2

