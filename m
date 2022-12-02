Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC2C640DA2
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Dec 2022 19:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbiLBSm7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Dec 2022 13:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbiLBSme (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Dec 2022 13:42:34 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D58E3442
        for <linux-ext4@vger.kernel.org>; Fri,  2 Dec 2022 10:40:11 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 68EDC21C6D;
        Fri,  2 Dec 2022 18:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670006384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N0QD24xiIxX6knKcXwKNJ+ozLIvx95Guu21OI/SOtms=;
        b=D3CDualeL+9ssSCRz8C1pv3DeUrZCzK0TVtaI8hheScRM7E+r0/Su2JncHAXL+8PjFNp+S
        ZRPPdbGpfHoVCp27efTyqWNv5HG86GXlkCwhSjfA0h3XynZQOwpM0lgcn1ZWTYk5kCRAyu
        hipWh3AqecttdMe/4xLLaXA2mUzaQEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670006384;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N0QD24xiIxX6knKcXwKNJ+ozLIvx95Guu21OI/SOtms=;
        b=vMaiJtXxNlk/pbBMj1/g6/wFkES/b9JK5s+Ne9vgjF58PfWUQM2EtGkeLkAsTmkf8NssZk
        K3t/oZ9kCkxANSBA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5D659136ED;
        Fri,  2 Dec 2022 18:39:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id /WTPFnBGimPEZAAAGKfGzw
        (envelope-from <jack@suse.cz>); Fri, 02 Dec 2022 18:39:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 82D09A0725; Fri,  2 Dec 2022 19:39:43 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v2 0/11] ext4: Stop providing .writepage hook
Date:   Fri,  2 Dec 2022 19:39:35 +0100
Message-Id: <20221202183943.22640-10-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221202163815.22928-1-jack@suse.cz>
References: <20221202163815.22928-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2166; i=jack@suse.cz; h=from:subject; bh=BsCGjWRCdFXEvas2INa6yTNBIlrmzefUnzpzCcnTv4M=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjikZmfF6TZRvoDgxXlT79RQReTCBWbIOf2JOQgJ9D 9n87pWCJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY4pGZgAKCRCcnaoHP2RA2ckpCA DRjFqSbNvhGFx49LvuOFrm0LoBmSw7K2I1OXnoPvZ4egQCVW5yAEOT/oizGEf0OZROvo2qRPr6etXF /m69OnIqMD/A0cikotg+UCQB1QFkU2QGdgmhqs+h7YhARhSr3gcwpT2etKeKvcIhW5Qcr6qOZXeguI zl+3h7SSHQ+G5OCFYsOOKWgsdHDqmgxGBSHXdqTBRPVWl7PRb3PoevWVuz7UImGaUUmcEG9/Y3zfz6 TFoCXkMs37kzye9Jk2SDT9NWJN8UDciZIvPXvOxwMcuWAyzuUqSVMioMdAk06sLvvsXRGfloAE7454 /3+Mtsa3faEWHPy/KHtiCsJQxWZZ0Y
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

Now we don't need .writepage hook for anything anymore. Reclaim is fine
with relying on .writepages to clean pages and we often couldn't do much
from the .writepage callback anyway. We only need to provide
.migrate_folio callback for the ext4_journalled_aops - let's use
buffer_migrate_page_norefs() there so that buffers cannot be modified
under jdb2's hands.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d14c6d44bdf1..1c9dec0d5109 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3717,7 +3717,6 @@ static int ext4_iomap_swap_activate(struct swap_info_struct *sis,
 static const struct address_space_operations ext4_aops = {
 	.read_folio		= ext4_read_folio,
 	.readahead		= ext4_readahead,
-	.writepage		= ext4_writepage,
 	.writepages		= ext4_writepages,
 	.write_begin		= ext4_write_begin,
 	.write_end		= ext4_write_end,
@@ -3735,7 +3734,6 @@ static const struct address_space_operations ext4_aops = {
 static const struct address_space_operations ext4_journalled_aops = {
 	.read_folio		= ext4_read_folio,
 	.readahead		= ext4_readahead,
-	.writepage		= ext4_writepage,
 	.writepages		= ext4_writepages,
 	.write_begin		= ext4_write_begin,
 	.write_end		= ext4_journalled_write_end,
@@ -3744,6 +3742,7 @@ static const struct address_space_operations ext4_journalled_aops = {
 	.invalidate_folio	= ext4_journalled_invalidate_folio,
 	.release_folio		= ext4_release_folio,
 	.direct_IO		= noop_direct_IO,
+	.migrate_folio		= buffer_migrate_folio_norefs,
 	.is_partially_uptodate  = block_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
 	.swap_activate		= ext4_iomap_swap_activate,
@@ -3752,7 +3751,6 @@ static const struct address_space_operations ext4_journalled_aops = {
 static const struct address_space_operations ext4_da_aops = {
 	.read_folio		= ext4_read_folio,
 	.readahead		= ext4_readahead,
-	.writepage		= ext4_writepage,
 	.writepages		= ext4_writepages,
 	.write_begin		= ext4_da_write_begin,
 	.write_end		= ext4_da_write_end,
-- 
2.35.3

