Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016325B8C33
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Sep 2022 17:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiINPrh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Sep 2022 11:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiINPrd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Sep 2022 11:47:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8038F80480
        for <linux-ext4@vger.kernel.org>; Wed, 14 Sep 2022 08:47:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DD88C33ADA;
        Wed, 14 Sep 2022 15:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663170448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IVp10Y+VzuHkSxzzhwFGmp/mTQVsDBsgRUGOapcCE7Q=;
        b=dJY8MTTD0Y6IwH3W27yO78O+LT9Fg8oly2UcTVAyJAcMpoqIJNUIxcQQtzarKTjZXXZRak
        5vM5TJlyfp2ODcfTp+X/8v4BXzzDhDtEw/xDc3N10x6UDkfnurpwBhA3yKqN7Veh7VzDW7
        hhlWenLZ6RS/FyweoqtxdMVySCRkuNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663170448;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IVp10Y+VzuHkSxzzhwFGmp/mTQVsDBsgRUGOapcCE7Q=;
        b=9/8JqpcenIOogBOGIXfnQyNN7RtoDzwF2D5SGISqNbtfj3YMoLw1wq8eoijyEIppqon940
        3zJZ2e58UJquy0Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1F9613494;
        Wed, 14 Sep 2022 15:47:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eKmxMpD3IWOqVQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 14 Sep 2022 15:47:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 42625A0684; Wed, 14 Sep 2022 17:47:28 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot+0f2f7e65a3007d39539f@syzkaller.appspotmail.com
Subject: [PATCH 2/2] ext2: Use kvmalloc() for group descriptor array
Date:   Wed, 14 Sep 2022 17:47:23 +0200
Message-Id: <20220914154728.20280-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220914154450.26562-1-jack@suse.cz>
References: <20220914154450.26562-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1700; h=from:subject; bh=4GzXl3TDoRKEYUL5P9nXbrj+gM5AOBUbBe+30ALfq+E=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjIfeKzQ1WYwvnavTeq4ZCKXv7q4XxPYghSaRUmAyc j5idCG+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYyH3igAKCRCcnaoHP2RA2Qr+B/ 0fvtrmEs5DuuWEaLwCl1Jim+eJSM4rlYC9LNT+Sm3TWacNp90D1jYE6N0pox8TB8Ev8DWNK82omLBz JluMDDh3xmZtvEhjL+5K+KtIYFD7Bd3yS2mmgiG7uHXeszRV8OvQreKIBcqrWNCApoHsX0vlno4py2 EYAXPDbXYudBnVZheZYwkI25dK6oz9qmAvt+ix1DCKBo12bcypshJ37CVk3RAq15p3whZEm37xEZQe KSV/w1MXHR+2ng6vjQJCU6lw+RhtOARDos2v8KbDnLxrNIIJkEMRc51yJPJZAa8ZPzZJ5cVEFwSFtO gAdRvjt2ang3gufODVOR0dQuBoEidK
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

Array of group descriptor block buffers can get rather large. In theory
in can reach 1MB for perfectly valid filesystem and even more for
maliciously crafted ones. Use kvmalloc() to allocate the array to avoid
straining memory allocator with large order allocations unnecessarily.

Reported-by: syzbot+0f2f7e65a3007d39539f@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext2/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index c94955b6701c..8cdeaf70ac36 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -163,7 +163,7 @@ static void ext2_put_super (struct super_block * sb)
 	db_count = sbi->s_gdb_count;
 	for (i = 0; i < db_count; i++)
 		brelse(sbi->s_group_desc[i]);
-	kfree(sbi->s_group_desc);
+	kvfree(sbi->s_group_desc);
 	kfree(sbi->s_debts);
 	percpu_counter_destroy(&sbi->s_freeblocks_counter);
 	percpu_counter_destroy(&sbi->s_freeinodes_counter);
@@ -1092,7 +1092,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 	}
 	db_count = (sbi->s_groups_count + EXT2_DESC_PER_BLOCK(sb) - 1) /
 		   EXT2_DESC_PER_BLOCK(sb);
-	sbi->s_group_desc = kmalloc_array(db_count,
+	sbi->s_group_desc = kvmalloc_array(db_count,
 					   sizeof(struct buffer_head *),
 					   GFP_KERNEL);
 	if (sbi->s_group_desc == NULL) {
@@ -1218,7 +1218,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 	for (i = 0; i < db_count; i++)
 		brelse(sbi->s_group_desc[i]);
 failed_mount_group_desc:
-	kfree(sbi->s_group_desc);
+	kvfree(sbi->s_group_desc);
 	kfree(sbi->s_debts);
 failed_mount:
 	brelse(bh);
-- 
2.35.3

