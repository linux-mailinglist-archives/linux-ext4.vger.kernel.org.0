Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB1A6A6B79
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Mar 2023 12:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjCALMz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Mar 2023 06:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjCALMu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Mar 2023 06:12:50 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538D73B87C
        for <linux-ext4@vger.kernel.org>; Wed,  1 Mar 2023 03:12:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5A2131FE15;
        Wed,  1 Mar 2023 11:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677669159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hsiXxYWtWvmov5CXejO7JzhNMjMWT22ZYKaAedRDp78=;
        b=nnMwbZFVp+ghXoe7JWa3lRjzgug00FO7DoelhcdC1yR6rTD0m2OOgw75D3fpvZ4BR0GkOI
        poo435LF7oRwt4OhzgNqa0x32vshFEOe4uQ405rMhiVKk0B9zYeJZApi6cXzS+kLC2EvOH
        //z9whqFVq/nXvdiByCP+WYYdi4w5nw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677669159;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hsiXxYWtWvmov5CXejO7JzhNMjMWT22ZYKaAedRDp78=;
        b=8n6LwJtlIGONr2r/4rl4BbweiN3VpI8sfipDOD6BAwBlndr5w1sobDgIzbCAnqp2rgq/J0
        EqDjNpsUH/K6w4Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4F4C313A3E;
        Wed,  1 Mar 2023 11:12:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CaFWEycz/2MERQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 01 Mar 2023 11:12:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C97B8A06F3; Wed,  1 Mar 2023 12:12:38 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot+4fec412f59eba8c01b77@syzkaller.appspotmail.com
Subject: [PATCH 2/2] ext2: Check block size validity during mount
Date:   Wed,  1 Mar 2023 12:12:31 +0100
Message-Id: <20230301111238.22856-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230301111026.15102-1-jack@suse.cz>
References: <20230301111026.15102-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1532; i=jack@suse.cz; h=from:subject; bh=oQu+c6jEEuBIgghq0JkuMFE3JnwaE1eY7blemXFqnhI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBj/zMezuaQvUQa1zHePk2bDsa/Y7fhO8OL9zygUhbm qJpIdCCJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY/8zHgAKCRCcnaoHP2RA2SLNB/ 0epaD7h8+nk42myWXoR6tIj4AyRh2ytGW3BpN28I4vIT4HFy5ZD7hWkmMaWc2xdyF2xQe3j2axJ0eU NyNSAOocRkf+8VbJgN8KpNlv86OU0jx8l3sdqymYFRJuffsfqwWjvOPI7lbnkXEiP79UkezABC9TrL IAn+W7yl8qOvJ97Ml195vfP7gqCnxG3ELq1RodgGJad+uypvTtw/WJlRZ0BgZqzcQq7v7DDBGZ7JW7 C8UCkaBcIX5jZx00shDBye/dOFXGHYnLwShLWMHg6ubuMEbS3omxvV2+LLbC6kc729+qNEutvqJ+qO La2qwmsYoN5pqcmkC548GRcoeUZoYR
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Check that log of block size stored in the superblock has sensible
value. Otherwise the shift computing the block size can overflow leading
to undefined behavior.

Reported-by: syzbot+4fec412f59eba8c01b77@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext2/ext2.h  | 1 +
 fs/ext2/super.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index 6c8e838bb278..8244366862e4 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -180,6 +180,7 @@ static inline struct ext2_sb_info *EXT2_SB(struct super_block *sb)
 #define EXT2_MIN_BLOCK_SIZE		1024
 #define	EXT2_MAX_BLOCK_SIZE		65536
 #define EXT2_MIN_BLOCK_LOG_SIZE		  10
+#define EXT2_MAX_BLOCK_LOG_SIZE		  16
 #define EXT2_BLOCK_SIZE(s)		((s)->s_blocksize)
 #define	EXT2_ADDR_PER_BLOCK(s)		(EXT2_BLOCK_SIZE(s) / sizeof (__u32))
 #define EXT2_BLOCK_SIZE_BITS(s)		((s)->s_blocksize_bits)
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 69c88facfe90..f342f347a695 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -945,6 +945,13 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 		goto failed_mount;
 	}
 
+	if (le32_to_cpu(es->s_log_block_size) >
+	    (EXT2_MAX_BLOCK_LOG_SIZE - BLOCK_SIZE_BITS)) {
+		ext2_msg(sb, KERN_ERR,
+			 "Invalid log block size: %u",
+			 le32_to_cpu(es->s_log_block_size));
+		goto failed_mount;
+	}
 	blocksize = BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
 
 	if (test_opt(sb, DAX)) {
-- 
2.35.3

