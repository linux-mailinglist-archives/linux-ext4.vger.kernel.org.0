Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22D964287C
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Dec 2022 13:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiLEM3o (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Dec 2022 07:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiLEM3c (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Dec 2022 07:29:32 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A9217405
        for <linux-ext4@vger.kernel.org>; Mon,  5 Dec 2022 04:29:31 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2E6E121ED4;
        Mon,  5 Dec 2022 12:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670243370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zkmm5tESiA9cgSppaoxoMWpVGNx7OwAEk4n220C6/Uo=;
        b=LwBuwQsaWjPgDh8QVHGqNvvSrkiQb9m10ZbScfHPGaba/oQeWvGH0a2BBzjlF/XmgVqU4t
        cFyTjwlokiZghkehREteB2yqk3TeA3MQD/lF2WOe6G9tqDq0FeMhpoiLxWhQwZOef2HwXe
        BLv7FDBglbv6Lz0zKT1BhHiF0imXN1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670243370;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zkmm5tESiA9cgSppaoxoMWpVGNx7OwAEk4n220C6/Uo=;
        b=KW1rGOCOlUM1PArydurjKQtnh6lKRIsQrIA2CwOzdf47xi+UlK6h6nPRQa2Nwco7OzYnh9
        yYE02lP5tibegbBw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 17B6A1397F;
        Mon,  5 Dec 2022 12:29:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id V07GBSrkjWMfTgAAGKfGzw
        (envelope-from <jack@suse.cz>); Mon, 05 Dec 2022 12:29:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7E6C8A073D; Mon,  5 Dec 2022 13:29:28 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 11/12] ext4: Stop providing .writepage hook
Date:   Mon,  5 Dec 2022 13:29:25 +0100
Message-Id: <20221205122928.21959-11-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221205122604.25994-1-jack@suse.cz>
References: <20221205122604.25994-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2211; i=jack@suse.cz; h=from:subject; bh=NtH5GC2/iN/qQvDpkUBZhCS3WR7zsPKKsSdgPhweRFI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjjeQkcwqiHIx90KR5UKvU6KxZC5zhtYbyaxLR7j7f zfOvYPWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY43kJAAKCRCcnaoHP2RA2U2bCA DdfrE/6wSXP6ejIg0rXa3faCanYX0E+Y9betD2PrUaP/7VDtI/eRB4aWum9KqzAX6CAhkyfbAQwqoH JQzjoP9rUxfREaUg6FujTQRt+6yMSqufAxjXmFIgvLjL+FVaC9HvGrVwA6zy29i99ePrIGVLesIBfk kVxy+oFb6W5GUQrB2JvAsSauGyl9otWySvG9GzhwJZucZHW5Bbdny0sEQFlCYURxyrMROZ/PORo4MD lPa+rvNX1yDwriCY/3XQJ/tHt4Epaba6GO6V94TZCI41eotaMCQ09gZ6jsO37fflRVyXXLNYrr4dbe gJ5ZIbKm5GMJiARUBW6WEAPHk6KWYv
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
under jdb2's hands.

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

