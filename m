Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC73665F8D
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Jan 2023 16:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbjAKPqE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Jan 2023 10:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235186AbjAKPpe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Jan 2023 10:45:34 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8161BB43
        for <linux-ext4@vger.kernel.org>; Wed, 11 Jan 2023 07:43:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 344A08B8CF;
        Wed, 11 Jan 2023 15:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673451819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H9Y3Ug2d9PxV/z1Yd+PN2GAKUVsib+KNAWTAz2ds8Bc=;
        b=jM5omugWJM8fc8v2JVwu7HVfB+x/Q9zYYl+EkJrMq6+kpi2bHddAHK24xz4Imd3iNEJ1jI
        s0o5/gUIWKy1tKBOit776Bsj/jxn34CFe4I6HTf5fLy78TvSraldWj1YYMxrNPgCSHo3eF
        WBUcmeLGg63EaxHOArcAWauReUlKCmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673451819;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H9Y3Ug2d9PxV/z1Yd+PN2GAKUVsib+KNAWTAz2ds8Bc=;
        b=Wxkp2+bJ8oZvDOvVzyMGiubIymqMbC+872iuBmaJq7zNFhbR8AQRqSqDCnj97wAXNi3KbF
        wWkT5VPSv3YCQODA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F23B1358A;
        Wed, 11 Jan 2023 15:43:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YrymByvZvmOzOwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 11 Jan 2023 15:43:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 22C72A0749; Wed, 11 Jan 2023 16:43:38 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 3/7] ext4: Mark page for delayed dirtying only if it is pinned
Date:   Wed, 11 Jan 2023 16:43:27 +0100
Message-Id: <20230111154338.392-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230111152736.9608-1-jack@suse.cz>
References: <20230111152736.9608-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3033; i=jack@suse.cz; h=from:subject; bh=0gbqwrLZ82QItIKg9QqxNzvnP9BHqzEl1X5/Ky10LFQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjvtkfPwmMmwNe5QpgEUhINfTekEKiaCdIcWLLueSn acDWyOGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY77ZHwAKCRCcnaoHP2RA2QiiB/ 4mUTEYooyueI0NTiBJR4QAJ83bqBTaDfkSp5CuHEWFEJm8CzltXAEXJYwAnfXX19qjOs6pUWwk+Nve lzH8KV/tiFSH3/jdWJPJ9lvrWgldUEhcKfupJLUSL2jhp3smi1y2e2tPu+VPdxPTRZmu7XmZtiX8/G bHMC4IlksdlOEikuaXPiDNZLslCt6h+a2wXpgo3IbHpivcStgnAwJrqpKtkV9otkaKGokvMK8U1U12 2QDJN+PUZ8+MrPw/vKdCY8l0ebD0EvwTiCXs/vIU5efS3o4cHxrUVERt84QqTPiv2weffz5Gyc7lko KUA1s0DrQ6SLHMBPFqHoAdffNfcXkN
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In data=journal mode, page should be dirtied only when it has buffers
for checkpoint or it is writeably mapped. In the first case, we don't
need to do anything special. In the second case, page was already added
to the journal by ext4_page_mkwrite() and since transaction commit
writeprotects mapped pages again, page should be writeable (and thus
dirtied) only while it is part of the running transaction. So nothing
needs to be done either. The only special case is when someone pins the
page and uses this pin for modifying page data. So recognize this
special case and only then mark the page as having data that needs
adding to the journal.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 13cab2a47f99..4c14aa1b9152 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3670,24 +3670,26 @@ const struct iomap_ops ext4_iomap_report_ops = {
 };
 
 /*
- * Whenever the folio is being dirtied, corresponding buffers should already
- * be attached to the transaction (we take care of this in ext4_page_mkwrite()
- * and ext4_write_begin()). However we cannot move buffers to dirty transaction
- * lists here because ->dirty_folio is called under VFS locks and the folio
- * is not necessarily locked.
- *
- * We cannot just dirty the folio and leave attached buffers clean, because the
- * buffers' dirty state is "definitive".  We cannot just set the buffers dirty
- * or jbddirty because all the journalling code will explode.
- *
- * So what we do is to mark the folio "pending dirty" and next time writepage
- * is called, propagate that into the buffers appropriately.
+ * For data=journal mode, folio should be marked dirty only when it was
+ * writeably mapped. When that happens, it was already attached to the
+ * transaction and marked as jbddirty (we take care of this in
+ * ext4_page_mkwrite()). On transaction commit, we writeprotect page mappings
+ * so we should have nothing to do here, except for the case when someone
+ * had the page pinned and dirtied the page through this pin (e.g. by doing
+ * direct IO to it). In that case we'd need to attach buffers here to the
+ * transaction but we cannot due to lock ordering.  We cannot just dirty the
+ * folio and leave attached buffers clean, because the buffers' dirty state is
+ * "definitive".  We cannot just set the buffers dirty or jbddirty because all
+ * the journalling code will explode.  So what we do is to mark the folio
+ * "pending dirty" and next time ext4_writepages() is called, attach buffers
+ * to the transaction appropriately.
  */
 static bool ext4_journalled_dirty_folio(struct address_space *mapping,
 		struct folio *folio)
 {
 	WARN_ON_ONCE(!folio_buffers(folio));
-	folio_set_checked(folio);
+	if (folio_may_be_dma_pinned(folio))
+		folio_set_checked(folio);
 	return filemap_dirty_folio(mapping, folio);
 }
 
-- 
2.35.3

