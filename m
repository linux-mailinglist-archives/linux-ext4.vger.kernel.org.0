Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F9062321A
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Nov 2022 19:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiKISNt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Nov 2022 13:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKISNs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Nov 2022 13:13:48 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEC61005F;
        Wed,  9 Nov 2022 10:13:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7FD4621A0A;
        Wed,  9 Nov 2022 18:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668017626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rY7W3z7DqhCLcEiGD9R5jcYRT8wjZ5iw0Oyp7Ha8n98=;
        b=ea0Vp/PYeoE/mBbxngpWZ10yYt4E82F3m+2ZMQm8RS7oCm5mKTFa0qp7gR01SsjCOgQQSk
        ptnoQQa+RlrPM5II7eRY5j59hSph7nTNWa/fFzG5KV64YLaP2bkNCpQjLTwRGODH0usjaO
        Aae6LkEjajvbJKpdWyvs/ItmGbIMdX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668017626;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rY7W3z7DqhCLcEiGD9R5jcYRT8wjZ5iw0Oyp7Ha8n98=;
        b=UhSDuGSnSRRm53jENn+yRKiTW7xZrSDl1emZHpFVzdUKQwaIIIsGI6XbUM8MmIZ70sh9lg
        RJTeVvL6mnb/t0CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B0731331F;
        Wed,  9 Nov 2022 18:13:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EyS6B9rta2PbKgAAMHmgww
        (envelope-from <lhenriques@suse.de>); Wed, 09 Nov 2022 18:13:46 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id cc02a9da;
        Wed, 9 Nov 2022 18:14:46 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH] ext4: fix error code return to user-space in ext4_get_branch()
Date:   Wed,  9 Nov 2022 18:14:45 +0000
Message-Id: <20221109181445.17843-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If a block is out of range in ext4_get_branch(), -ENOMEM will be returned
to user-space.  Obviously, this error code isn't really useful.  This
patch fixes it by making sure the right error code (-EFSCORRUPTED) is
propagated to user-space.  EUCLEAN is more informative than ENOMEM.

Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
Hi Ted!

Just a note: this patch, as you suggested, is taken from the patch with
message-id 20221011155623.14840-1-lhenriques@suse.de .

Cheers,
--
Luís

 fs/ext4/indirect.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index 860fc5119009..c68bebe7ff4b 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -148,6 +148,7 @@ static Indirect *ext4_get_branch(struct inode *inode, int depth,
 	struct super_block *sb = inode->i_sb;
 	Indirect *p = chain;
 	struct buffer_head *bh;
+	unsigned int key;
 	int ret = -EIO;
 
 	*err = 0;
@@ -156,7 +157,13 @@ static Indirect *ext4_get_branch(struct inode *inode, int depth,
 	if (!p->key)
 		goto no_block;
 	while (--depth) {
-		bh = sb_getblk(sb, le32_to_cpu(p->key));
+		key = le32_to_cpu(p->key);
+		if (key > ext4_blocks_count(EXT4_SB(sb)->s_es)) {
+			/* the block was out of range */
+			ret = -EFSCORRUPTED;
+			goto failure;
+		}
+		bh = sb_getblk(sb, key);
 		if (unlikely(!bh)) {
 			ret = -ENOMEM;
 			goto failure;
