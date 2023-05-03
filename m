Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E236F5DCC
	for <lists+linux-ext4@lfdr.de>; Wed,  3 May 2023 20:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjECSVi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 May 2023 14:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjECSVh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 May 2023 14:21:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FDA2698
        for <linux-ext4@vger.kernel.org>; Wed,  3 May 2023 11:21:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7AE1D2062F;
        Wed,  3 May 2023 18:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683138095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=4nWShETjGYXZFdzqiA7AN/yqSqnYTxYJ+Kxc161i5cs=;
        b=W+H/N5AoHIvZ6U39A4C2gyWRoamW7ekVRNCSqZmJFonpSWe4on5UeJHAnGYhW6lWu9u+J8
        hOfcnQw3m4l7KTmMwPheEIC8bbN5fYND+GlKrKVMjShCMYnNAn5lejUXizR3wHXNBoiUnG
        ERfNEPBQqTPqeSZQmJfUSG42KrZjBsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683138095;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=4nWShETjGYXZFdzqiA7AN/yqSqnYTxYJ+Kxc161i5cs=;
        b=M7/FCQv5D5P4w1nt2uDH7GBlaNHI2UEGIrShe0PrYwCdY4/m4TEPqbAZUdGw7iLc7p+YTg
        dwrU5JQJBSEFftAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6D93513584;
        Wed,  3 May 2023 18:21:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2bi3Gi+mUmRFPgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 03 May 2023 18:21:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E6E8AA0744; Wed,  3 May 2023 20:21:34 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>,
        Jan Kara <jack@suse.cz>,
        syzbot+4a03518df1e31b537066@syzkaller.appspotmail.com
Subject: [PATCH] ext4: Fix data races when using cached status extents
Date:   Wed,  3 May 2023 20:21:28 +0200
Message-Id: <20230503182128.14115-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2331; i=jack@suse.cz; h=from:subject; bh=acO5L3eFCHxd8f3y7ZiahEDMnbhguiCquKLroLErBPE=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkUqYi2+MyI0UTA6/ZaHdVqI65iggxdEtqit7e+97x mO8sksmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZFKmIgAKCRCcnaoHP2RA2XzpB/ 9iQGJR/J7vSnJWDVpf7w27aCSonwutMKGe4D5A2fgj7NdivZfK6EUbzco9yegxSJKlrgECr9XGLJZE Z/Z2M91qb9HxuVDYjl2yMpldO4qdSrL488K056ThoAaDDInG9q5dnvV11zJOlZO/e6tX5wt4za+Oaa RNwFBYzEgGvEoV6iEAYNyAetkGalEu7gbp5kAPgzuyzawoE6FcaXD6TMpJ1UOdlA7BbRbUtfGyVC6A w/mZ8diNZ5MP2gywCpCvuU6yXj7i8iV60yU9nS4bgfxNV4ZShSepSUmx0gTFBy9uBnzmlLI0RLy2Xt Bs81CSop/uigoUqRaQi7DnogmFo1Dy
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

When using cached extent stored in extent status tree in tree->cache_es
another process holding ei->i_es_lock for reading can be racing with us
setting new value of tree->cache_es. If the compiler would decide to
refetch tree->cache_es at an unfortunate moment, it could result in a
bogus in_range() check. Fix the possible race by using READ_ONCE() when
using tree->cache_es only under ei->i_es_lock for reading.

Reported-by: syzbot+4a03518df1e31b537066@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/000000000000d3b33905fa0fd4a6@google.com
Suggested-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/extents_status.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 7bc221038c6c..ca2cb926894f 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -267,14 +267,12 @@ static void __es_find_extent_range(struct inode *inode,
 
 	/* see if the extent has been cached */
 	es->es_lblk = es->es_len = es->es_pblk = 0;
-	if (tree->cache_es) {
-		es1 = tree->cache_es;
-		if (in_range(lblk, es1->es_lblk, es1->es_len)) {
-			es_debug("%u cached by [%u/%u) %llu %x\n",
-				 lblk, es1->es_lblk, es1->es_len,
-				 ext4_es_pblock(es1), ext4_es_status(es1));
-			goto out;
-		}
+	es1 = READ_ONCE(tree->cache_es);
+	if (es1 && in_range(lblk, es1->es_lblk, es1->es_len)) {
+		es_debug("%u cached by [%u/%u) %llu %x\n",
+			 lblk, es1->es_lblk, es1->es_len,
+			 ext4_es_pblock(es1), ext4_es_status(es1));
+		goto out;
 	}
 
 	es1 = __es_tree_search(&tree->root, lblk);
@@ -931,14 +929,12 @@ int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
 
 	/* find extent in cache firstly */
 	es->es_lblk = es->es_len = es->es_pblk = 0;
-	if (tree->cache_es) {
-		es1 = tree->cache_es;
-		if (in_range(lblk, es1->es_lblk, es1->es_len)) {
-			es_debug("%u cached by [%u/%u)\n",
-				 lblk, es1->es_lblk, es1->es_len);
-			found = 1;
-			goto out;
-		}
+	es1 = READ_ONCE(tree->cache_es);
+	if (es1 && in_range(lblk, es1->es_lblk, es1->es_len)) {
+		es_debug("%u cached by [%u/%u)\n",
+			 lblk, es1->es_lblk, es1->es_len);
+		found = 1;
+		goto out;
 	}
 
 	node = tree->root.rb_node;
-- 
2.35.3

