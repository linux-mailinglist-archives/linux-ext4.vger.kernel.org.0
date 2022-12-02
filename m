Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B37640DA0
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Dec 2022 19:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbiLBSmv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Dec 2022 13:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbiLBSmE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Dec 2022 13:42:04 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DBAD9693
        for <linux-ext4@vger.kernel.org>; Fri,  2 Dec 2022 10:40:07 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 69B0721C6F;
        Fri,  2 Dec 2022 18:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670006384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WHcFcLndfYFLzCMgwjJR71Z8DBi9JPKL6Gf7+EeHCTw=;
        b=uNC9rzzCrLwwXeBJDirMH5cuCWzxoEQ0Ka9S/5UOT3y8AHCljTC1tlS6f/o12vTRfme2uD
        yWtwbcimTIoh1rCtMMZmPwVEd89ftnbw8or0Ke/H1nU5OtzKd+iSEALbvdMp2aALYbJFBk
        zBnyLT0IZ+Yv2eYAQl1cjIvj1/EY93A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670006384;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WHcFcLndfYFLzCMgwjJR71Z8DBi9JPKL6Gf7+EeHCTw=;
        b=LkcTfbykr4iyMb9IAcyi/+cvYXgzMJvUaTR9Che0W1Q6AzaxV1bzV4KHC+Qiydc/TGzHOv
        ntwkCBr3FjlSq/Dw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5D39E13644;
        Fri,  2 Dec 2022 18:39:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id hQvJFnBGimPFZAAAGKfGzw
        (envelope-from <jack@suse.cz>); Fri, 02 Dec 2022 18:39:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7CD55A0724; Fri,  2 Dec 2022 19:39:43 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v2 9/11] ext4: Switch to using write_cache_pages() for data=journal writeout
Date:   Fri,  2 Dec 2022 19:39:34 +0100
Message-Id: <20221202183943.22640-9-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221202163815.22928-1-jack@suse.cz>
References: <20221202163815.22928-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1282; i=jack@suse.cz; h=from:subject; bh=ps25XuAdDipCISvNV70g1pB5pT2cYCVPHEVGJyuXA3o=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjikZl/qZ1PciUUyhGBrw7r1+P8dhRpDhs4JYXYJVC ftQpdUKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY4pGZQAKCRCcnaoHP2RA2ZoGCA DRMFvJ8CGzWDKb/6vEmmtn28N7ShQ65ise+2IVa+R4jb1OnbuYJH9+K+LPL6WjwOQvy6IyP/hhg5xu 3BBQjZ3Mze5pEOEtZbZvCjexwpZJux454AItxC/3JsC44iLjakwinSFOr0Dvx9ERp43a0spaB9OQZB zkDWkH1Mtxz8NK7AncP0lzxAFIAOqrBIW5K3ln+DY3twI5NsqvpBbRgWHgyGyaWCbCpICN2/TPouxH GhHP58J8QIV+DKYQQYHWm4WI5TaIwzvOBtobAkUDnwuPaqa54pd4TU71mxhwLGm+WbCuMJSkgYGWLD ciKlRI3vqXheNp6y0we+jBs1sBbcku
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

Instead of using generic_writepages(), let's use write_cache_pages() for
writeout of journalled data. It will allow us to stop providing
.writepage callback. Our data=journal writeback path would benefit from
a larger cleanup and refactoring but that's for a separate cleanup
series.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 88772e1ddd3b..d14c6d44bdf1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2705,6 +2705,12 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 	return err;
 }
 
+static int __writepage(struct page *page, struct writeback_control *wbc,
+		       void *data)
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
+		ret = write_cache_pages(mapping, wbc, __writepage, mapping);
+		blk_finish_plug(&plug);
 		goto out_writepages;
 	}
 
-- 
2.35.3

