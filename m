Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DC46F6C75
	for <lists+linux-ext4@lfdr.de>; Thu,  4 May 2023 14:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjEDMze (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 May 2023 08:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjEDMzc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 May 2023 08:55:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F44D72B9
        for <linux-ext4@vger.kernel.org>; Thu,  4 May 2023 05:55:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3E9FD338DB;
        Thu,  4 May 2023 12:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683204928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QQ17l+T2lt5mDZyNe6GZ7B0NIgRvDlTBB/vyOhUzvCA=;
        b=ndwm6JrHCDDQJIX2V1qqEMYtAbAhwKqf59AqC3FJg8LmeCrqKIY7yRlGAGJFSSLigLrzuF
        jlhe09nSbJwDlWSZi1O1qzrR7ez0o+uBi5GQ99UP3w0eS7+Qq00bkMf81v6IXqhRQwlwBR
        Xz2+HdwhLrukbTKB3vNiJb/f3VzryFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683204928;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QQ17l+T2lt5mDZyNe6GZ7B0NIgRvDlTBB/vyOhUzvCA=;
        b=Doug/qIsD2W9C+yix4TUu7EC474nuecF4XBZAXFJ5geUV23puiN+j7dSr6Swxi0Nutq6qr
        QfHK/YuMwYf6hNAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3169E133F7;
        Thu,  4 May 2023 12:55:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ikkLDECrU2SMTAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 04 May 2023 12:55:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A755AA0722; Thu,  4 May 2023 14:55:27 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        syzbot+4a03518df1e31b537066@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH v2] ext4: Fix data races when using cached status extents
Date:   Thu,  4 May 2023 14:55:24 +0200
Message-Id: <20230504125524.10802-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2609; i=jack@suse.cz; h=from:subject; bh=Q/3ndRfM66VVo7yXNP84XbZnaljFjXnuSnQBFgwV0hA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkU6s76rfbVu7zjWG3XM+Mm0I/RQX1jHQgpuqbVdse j1ucgVKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZFOrOwAKCRCcnaoHP2RA2R6XB/ 4+aIACdYe+ubtHw5lpjmCs9lN+oz0SmMS4y793A1qKgYyWsxN22ll1LRv3sZWc43RvvL4qZ0pfpFpq wzFTVMG3e3DZ5HLDKGPc5tPy0jkrprcMB1LHPdRfH5l7zbxRk85P1p/gUADyb6PRsHZyNwFC0W3n6N cuZuPpty56xvshrvWpRZSQAJRjkyHK+Mb1oVSmHAsDBT4Gs56JKvCbD+ojxX9uQCou/pjIAtOcRf1z TebTU9QdIBnwIjEHVwYOsHD/JG7WQ6ZQFIlbz/Ux9XkoMEEHyQOwM1UdeFUmv0YVS/gBpcixiGEpWy Ge5MlKJW0fpLCqd+/+S7pUURn8TdCe
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
 fs/ext4/extents_status.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 7bc221038c6c..595abb9e7d74 100644
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
@@ -293,7 +291,7 @@ static void __es_find_extent_range(struct inode *inode,
 	}
 
 	if (es1 && matching_fn(es1)) {
-		tree->cache_es = es1;
+		WRITE_ONCE(tree->cache_es, es1);
 		es->es_lblk = es1->es_lblk;
 		es->es_len = es1->es_len;
 		es->es_pblk = es1->es_pblk;
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

