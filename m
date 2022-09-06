Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3275C5AEFDD
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Sep 2022 18:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbiIFQGP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Sep 2022 12:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbiIFQFu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Sep 2022 12:05:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEF033B
        for <linux-ext4@vger.kernel.org>; Tue,  6 Sep 2022 08:29:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 463DB33858;
        Tue,  6 Sep 2022 15:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662478161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z52/0koCgmnnFgyY21oQ1pJ0kuDgD73IAahqZ39D7Qs=;
        b=jQK77H8oMQ+efKzG3jru1qDI+OMSJe6NQ24Z38PPqFDs9BHAdx+yRb6I1lo0aLg88lo5RH
        zNmjvDGjwQQvXb5E/GhK3mtHczS0k618/1qWbMcTu/fcfbkmhA4ag7pW4lm6gpDNaAxdAJ
        MkxIStxRjFAIcpZCL5AXQA5KWz2/J0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662478161;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z52/0koCgmnnFgyY21oQ1pJ0kuDgD73IAahqZ39D7Qs=;
        b=4X0naBvrtiWxWZE24NXqm9VXH9/XERZvsea1/l63XBV52hytHFGZ0TY6Gbq2XUdjv9pA3h
        +GWAnLLI8jHFB7DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 37B1813A19;
        Tue,  6 Sep 2022 15:29:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mXlpDFFnF2NRHAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 06 Sep 2022 15:29:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8A77EA0685; Tue,  6 Sep 2022 17:29:20 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 4/5] ext4: Use locality group preallocation for small closed files
Date:   Tue,  6 Sep 2022 17:29:10 +0200
Message-Id: <20220906152920.25584-4-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220906150803.375-1-jack@suse.cz>
References: <20220906150803.375-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2446; h=from:subject; bh=DgowE6wl5K1sEm/d4x8F8CI+QF4uRL5Ja28OG5LxVnE=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjF2dFVtgvPHrqkKOlkiNVYhd7eg9adzhU7nimG61k CK/mrraJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYxdnRQAKCRCcnaoHP2RA2VQGB/ 9aLitR63/DiHEZqmcxM0xg/zpI4Gz1pQNXpkBWr4xinO2zgswTa/OcRVlcASlDr6eURus/ISvZ9q1R Yk//mNt91kd91Csg5aq9AsAwiNoI2HPERjhASpjxVNKcWzwDtaGBZ3pM6BWp0Z0Aa0EZfNadLnHCpy 0n8UzzqFcEXz4503VKCrfabNEiUPD47xOkcNBvovFC8KZQUlqBFRmWHXqoI8kqJInDjXRuM3LgeQBR RujY6tMVPAB9pYgot+6RHh8wOen5FXQEfp2yRWHz6/rk8drpjlc5qiCDg51AKxWg5YQJlyhqaW0bmA FN4cJvU8Gco47pzdUZN8T6UJJ5VMzT
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

Curently we don't use any preallocation when a file is already closed
when allocating blocks (from writeback code when converting delayed
allocation). However for small files, using locality group preallocation
is actually desirable as that is not specific to a particular file.
Rather it is a method to pack small files together to reduce
fragmentation and for that the fact the file is closed is actually even
stronger hint the file would benefit from packing. So change the logic
to allow locality group preallocation in this case.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 6251b4a6cc63..af1e49c3603f 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5195,6 +5195,7 @@ static void ext4_mb_group_or_file(struct ext4_allocation_context *ac)
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	int bsbits = ac->ac_sb->s_blocksize_bits;
 	loff_t size, isize;
+	bool inode_pa_eligible, group_pa_eligible;
 
 	if (!(ac->ac_flags & EXT4_MB_HINT_DATA))
 		return;
@@ -5202,25 +5203,27 @@ static void ext4_mb_group_or_file(struct ext4_allocation_context *ac)
 	if (unlikely(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY))
 		return;
 
+	group_pa_eligible = sbi->s_mb_group_prealloc > 0;
+	inode_pa_eligible = true;
 	size = ac->ac_o_ex.fe_logical + EXT4_C2B(sbi, ac->ac_o_ex.fe_len);
 	isize = (i_size_read(ac->ac_inode) + ac->ac_sb->s_blocksize - 1)
 		>> bsbits;
 
+	/* No point in using inode preallocation for closed files */
 	if ((size == isize) && !ext4_fs_is_busy(sbi) &&
-	    !inode_is_open_for_write(ac->ac_inode)) {
-		ac->ac_flags |= EXT4_MB_HINT_NOPREALLOC;
-		return;
-	}
+	    !inode_is_open_for_write(ac->ac_inode))
+		inode_pa_eligible = false;
 
-	if (sbi->s_mb_group_prealloc <= 0) {
-		ac->ac_flags |= EXT4_MB_STREAM_ALLOC;
-		return;
-	}
-
-	/* don't use group allocation for large files */
 	size = max(size, isize);
-	if (size > sbi->s_mb_stream_request) {
-		ac->ac_flags |= EXT4_MB_STREAM_ALLOC;
+	/* Don't use group allocation for large files */
+	if (size > sbi->s_mb_stream_request)
+		group_pa_eligible = false;
+
+	if (!group_pa_eligible) {
+		if (inode_pa_eligible)
+			ac->ac_flags |= EXT4_MB_STREAM_ALLOC;
+		else
+			ac->ac_flags |= EXT4_MB_HINT_NOPREALLOC;
 		return;
 	}
 
-- 
2.35.3

