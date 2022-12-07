Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C28F6458F6
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 12:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiLGL1f (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 06:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiLGL10 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 06:27:26 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD7F233A0
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 03:27:25 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D2C951FE7C;
        Wed,  7 Dec 2022 11:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670412443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vUtytpX8nps/m5Do5292jMC9bIYC5TBKUi+9pwgcjsg=;
        b=RZlmvqSA/mEOm27bigM3Gamc3GuUTxMoIDxe/GpqBTTkMGuZmA7P/mU2/esuQQJ97MWpmO
        4dr9XBDvFtoDFGnJR8IJKdPwS8HS2g4mJkDkPugK6xJKG1SOwcgbrx7jF/+M9QiWy1dWDZ
        uBnHCEdP9RVk8wsESlu1IJH99V83a7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670412443;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vUtytpX8nps/m5Do5292jMC9bIYC5TBKUi+9pwgcjsg=;
        b=fypA9KWxjA7IyuvECq1z1zuGkl0TJ39AoegyqF0Fz+4YDQ6za84/8NN/UQdsIwJhy/8Z8d
        zzalGeX3OqO+t6CA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C6FD3136B4;
        Wed,  7 Dec 2022 11:27:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id yjKNMJt4kGNLLAAAGKfGzw
        (envelope-from <jack@suse.cz>); Wed, 07 Dec 2022 11:27:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1B3B9A073D; Wed,  7 Dec 2022 12:27:23 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 12/13] ext4: Stop providing .writepage hook
Date:   Wed,  7 Dec 2022 12:27:15 +0100
Message-Id: <20221207112722.22220-12-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221207112259.8143-1-jack@suse.cz>
References: <20221207112259.8143-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2558; i=jack@suse.cz; h=from:subject; bh=9G+139EKDfKxAXYNTQ3vkedoPk4/UkgAePP1eddQoKQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjkHiSrMFoGEMZQhXoVsH1++FHtlFiAOaHzk7AzjQ0 kfvBVnyJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY5B4kgAKCRCcnaoHP2RA2Z0eB/ sHDowcTDtP8mYm0IzGGuj8ptFEoo4eD5f0Bp3QYbM/JoZot0uxOGM/jtw6C8LUCTnURXzVMc3zWuiC b5lszcAG4xWHCDPZeVMMe54/jRxRHHEdw32OWgHgzM3EcdPG0lrgCoHGGBcjXCJQLGg+CroE5NU9hN sI6pbkIpyL5Bc866UwbMiSC+Bj//3n2m+J1iAJdQKqPh4oU005f/c6BZc/sOUTW2fk9vYtjBeF2oxu Rq+p5WRXeqvhxJit1fepeoIXb6rBt5QvyU5tWyPnwq9XA7y7ohIiRcWUy/jgB2PK9cxa0gU4ye70GE M92sO5e7CuGeonFVNhq1K3PQIZ8dVt
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

Now we don't need .writepage hook for anything anymore. Reclaim is fine
with relying on .writepages to clean pages and we often couldn't do much
from the .writepage callback anyway. We only need to provide
.migrate_folio callback for the ext4_journalled_aops - let's use
buffer_migrate_page_norefs() there so that buffers cannot be modified
under jdb2's hands as that can cause data corruption. For example when
commit code does writeout of transaction buffers in
jbd2_journal_write_metadata_buffer(), we don't hold page lock or have
page writeback bit set or have the buffer locked. So page migration code
would go and happily migrate the page elsewhere while the copy is
running thus corrupting data.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index f3b3792c1c96..acf9d23c1cfb 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3718,7 +3718,6 @@ static int ext4_iomap_swap_activate(struct swap_info_struct *sis,
 static const struct address_space_operations ext4_aops = {
 	.read_folio		= ext4_read_folio,
 	.readahead		= ext4_readahead,
-	.writepage		= ext4_writepage,
 	.writepages		= ext4_writepages,
 	.write_begin		= ext4_write_begin,
 	.write_end		= ext4_write_end,
@@ -3736,7 +3735,6 @@ static const struct address_space_operations ext4_aops = {
 static const struct address_space_operations ext4_journalled_aops = {
 	.read_folio		= ext4_read_folio,
 	.readahead		= ext4_readahead,
-	.writepage		= ext4_writepage,
 	.writepages		= ext4_writepages,
 	.write_begin		= ext4_write_begin,
 	.write_end		= ext4_journalled_write_end,
@@ -3745,6 +3743,7 @@ static const struct address_space_operations ext4_journalled_aops = {
 	.invalidate_folio	= ext4_journalled_invalidate_folio,
 	.release_folio		= ext4_release_folio,
 	.direct_IO		= noop_direct_IO,
+	.migrate_folio		= buffer_migrate_folio_norefs,
 	.is_partially_uptodate  = block_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
 	.swap_activate		= ext4_iomap_swap_activate,
@@ -3753,7 +3752,6 @@ static const struct address_space_operations ext4_journalled_aops = {
 static const struct address_space_operations ext4_da_aops = {
 	.read_folio		= ext4_read_folio,
 	.readahead		= ext4_readahead,
-	.writepage		= ext4_writepage,
 	.writepages		= ext4_writepages,
 	.write_begin		= ext4_da_write_begin,
 	.write_end		= ext4_da_write_end,
-- 
2.35.3

