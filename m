Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDB87336AE
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jun 2023 18:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345513AbjFPQw7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Jun 2023 12:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345683AbjFPQwM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Jun 2023 12:52:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1843C2F
        for <linux-ext4@vger.kernel.org>; Fri, 16 Jun 2023 09:51:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D1FD21F8C3;
        Fri, 16 Jun 2023 16:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686934270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vuTmGfoi3mKFD5wOdTZrM80Dc4Krp1XdZGQoTkSsjYY=;
        b=P5B37LRcWcv5/fjHyGXAiLxBv1ULAu1/rmFtYU4+op2Puly5ynByEZvWMfqpTJ8OEXHgY0
        rdwlTKz2AGtC5uerQqaRWsJ3ih10p5GXTkHRPHD/iALQsUDNjeCuQuSOa6Hfk8pW9wDpCu
        FSd5/frKFguCO7dvbZHWEKM9N8r+DuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686934270;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vuTmGfoi3mKFD5wOdTZrM80Dc4Krp1XdZGQoTkSsjYY=;
        b=Pq/1RN9dwIUOQ7MOTEYxfBUlVC1rMlkOP4VkFi/t3RCSWnQhTj1jIDzKSLgxL/E59ddBT3
        LAgooCs7DKSVlSCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BEFD61391E;
        Fri, 16 Jun 2023 16:51:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cd+iLv6SjGRWIwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Jun 2023 16:51:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9A88CA075D; Fri, 16 Jun 2023 18:51:09 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 09/11] ext4: Drop read-only check in ext4_write_inode()
Date:   Fri, 16 Jun 2023 18:50:55 +0200
Message-Id: <20230616165109.21695-9-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230616164553.1090-1-jack@suse.cz>
References: <20230616164553.1090-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=819; i=jack@suse.cz; h=from:subject; bh=eqrV7jBTWshf1imJI8I3RTb4DFoE3Px/Xk8d82Lf3bY=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkjJLu5n0Pq2s1b5mjfnxliXnJtsSz8d65hXcdbwSs 81oUJGOJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZIyS7gAKCRCcnaoHP2RA2fDEB/ 9KAUIwoQ+sOI1rnqcbnIFzv6npIXmrCbKonFXKETm9OJBudC6p1G3m5bxq9gWssz6xKVwHOKH6xuyt 0m7hQrax+wOjcjvCO2EbxwiM++NuKYi+3MHEvC5V7lb5H6FK9zjkWOWdQd8JyuHXqCquiTGT/lnlXl yfeNmKo1jNa9XnW31afwQ/wT3E+C+8OC2qMHyYc3Ygzhhh3MP75rZfO1KB/rpmxlnDRHz7yk02ttN7 RbgcLq8ERLdXbchOfU15xyvVS35CSplsmu3qtHdBIEGIB3VxidCiTltAknGoKuRPPmr8Cn2i+qD7Qb 2JKtnmvQpKtQX8hNZQg7XsRrxam8e1
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We should not have dirty inodes on read-only filesystem. Also silently
bailing without writing anything would be a problem when we enable
quotas during remount while the filesystem is read-only. So drop the
read-only check.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index fc6abafcc3fc..e0fe1895a20f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5155,8 +5155,7 @@ int ext4_write_inode(struct inode *inode, struct writeback_control *wbc)
 {
 	int err;
 
-	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC) ||
-	    sb_rdonly(inode->i_sb))
+	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC))
 		return 0;
 
 	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
-- 
2.35.3

