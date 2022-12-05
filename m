Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E234164287E
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Dec 2022 13:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiLEM3r (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Dec 2022 07:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbiLEM3e (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Dec 2022 07:29:34 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EE612AEF
        for <linux-ext4@vger.kernel.org>; Mon,  5 Dec 2022 04:29:33 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 323DE1FF72;
        Mon,  5 Dec 2022 12:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670243370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vs7hmkx66Fp22yYnmDcVYVxpg8X0jWkoO4ST/ldwM1s=;
        b=rLvb+e2s2hXjKdETs/zCQAQT/Kj2+iEZxD5j26yWfnvSe4mGTF1kBg17zmqP6qbs1Dhd2I
        TLFuaybluiyEE7QWJ3XZomxM6h9ArMr/POQGC6h/FDt5q+uaWZ6NBobu48s67SMOljSh5c
        phMXLQyVFgawS5kFm/2w7UG6hx/rxNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670243370;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vs7hmkx66Fp22yYnmDcVYVxpg8X0jWkoO4ST/ldwM1s=;
        b=/iZicTs86ElTj/aRUoTwIuDFLDFNW32NnxtwLVjYyE2r9DD/XfdUBJF1zbe/wcceVhL32l
        PwcQQEos7Jc91BBg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1CC2E13990;
        Mon,  5 Dec 2022 12:29:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 6/TlBirkjWMhTgAAGKfGzw
        (envelope-from <jack@suse.cz>); Mon, 05 Dec 2022 12:29:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 77BF6A0739; Mon,  5 Dec 2022 13:29:28 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 10/12] ext4: Switch to using write_cache_pages() for data=journal writeout
Date:   Mon,  5 Dec 2022 13:29:24 +0100
Message-Id: <20221205122928.21959-10-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221205122604.25994-1-jack@suse.cz>
References: <20221205122604.25994-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1335; i=jack@suse.cz; h=from:subject; bh=23FIs73CR+dJuweXVsJE6NBdy/+rtnMaeWeeUjNcNEQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjjeQjoAynBFFpL2DjlyKvloiLtfeSQIv0y5PT8tMu bcDUS/GJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY43kIwAKCRCcnaoHP2RA2cI/B/ 9Ek/lQwZ0ArlB9DuRuL6/2U3+RUgAxVuYv4x6J1EZIc0FDWpHDjAg6bpF/2bc2Q0A7crlRECAkapcp mp3oVDkX6Z6AT5MZjNwDEvsQu4YLTGO9Fp7XVhzXS9rsd1WrBrupt+GMyIm+pNofyQvt3ylH2Eftm0 YJfMho0vT2wB/qLwUv4goIPv+eZw3tMCYQhlY2IrPXknpccHAqgT2+9cscIeFkbQz//AGdjroYgtse 9r45K7b8qD2w6flJOPGjEcgNcAAXnq1rgePiagyRDyun1vWT2Rc3Vjs7KBdltzblleR3m4p2HOTsDh X1Tel0ZKrrunCFJ6u1hBZoPeItrzEx
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

Instead of using generic_writepages(), let's use write_cache_pages() for
writeout of journalled data. It will allow us to stop providing
.writepage callback. Our data=journal writeback path would benefit from
a larger cleanup and refactoring but that's for a separate cleanup
series.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index b93a436bf5bc..f3b3792c1c96 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2705,6 +2705,12 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 	return err;
 }
 
+static int ext4_writepage_cb(struct page *page, struct writeback_control *wbc,
+			     void *data)
+{
+	return ext4_writepage(page, wbc);
+}
+
 static int ext4_do_writepages(struct mpage_da_data *mpd)
 {
 	struct writeback_control *wbc = mpd->wbc;
@@ -2731,7 +2737,9 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 		goto out_writepages;
 
 	if (ext4_should_journal_data(inode)) {
-		ret = generic_writepages(mapping, wbc);
+		blk_start_plug(&plug);
+		ret = write_cache_pages(mapping, wbc, ext4_writepage_cb, NULL);
+		blk_finish_plug(&plug);
 		goto out_writepages;
 	}
 
-- 
2.35.3

