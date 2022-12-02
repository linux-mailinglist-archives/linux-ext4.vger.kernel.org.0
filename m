Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4B3640D99
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Dec 2022 19:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbiLBSmH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Dec 2022 13:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbiLBSl2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Dec 2022 13:41:28 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB7EF2895
        for <linux-ext4@vger.kernel.org>; Fri,  2 Dec 2022 10:39:46 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 01CCA1FDAC;
        Fri,  2 Dec 2022 18:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670006384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bAJrgBIBpossRMfpq+QaMKNctdr+3ByQ3w/XZCgqD48=;
        b=VkXHo2JJg4kXm9uFVwqoHPIURvJ6SfbsW7XErIOsT+8vEJO8Idr2BL8n2hL81UplPjK85T
        MW9fschoKJNg7WGBVpVjPpQ1D99Qp7cflhDEAUrYGt/hN1M8woe0naVtpJ79nGTGG+0nOm
        YKSn/xTw288sX5AK6E98TQWfT3V04mg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670006384;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bAJrgBIBpossRMfpq+QaMKNctdr+3ByQ3w/XZCgqD48=;
        b=g4oGSmaV8QPJQC7fFAcGikSDI8sZEHFulzgOfocS5BrT04qr0PAGP5k88+5f7aMvTIEDFV
        s0KpPXXJ726DaJBA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id E07E5136CF;
        Fri,  2 Dec 2022 18:39:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id HafKNm9GimOpZAAAGKfGzw
        (envelope-from <jack@suse.cz>); Fri, 02 Dec 2022 18:39:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5EFC5A071F; Fri,  2 Dec 2022 19:39:43 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v2 4/11] ext4: Drop pointless IO submission from ext4_bio_write_page()
Date:   Fri,  2 Dec 2022 19:39:29 +0100
Message-Id: <20221202183943.22640-4-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221202163815.22928-1-jack@suse.cz>
References: <20221202163815.22928-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=856; i=jack@suse.cz; h=from:subject; bh=4zrE8FuBvceix5JDITDiw9troAPfp1rf8G6PWkCP3ZQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjikZhosVvJdxZNRlGA9S6hH7mwg4IjBC9PrQNYVyZ wzKG3+iJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY4pGYQAKCRCcnaoHP2RA2YVuB/ 9XbHsnWWTlLLcaLgxaIFHtvHBrpoZ5Sp+Azs80kG5woeZAooG6n/Ox/2BD7XPCEK8ADMVDQKUFj7ix xylfcdMfmbk9uR4cuejkBaRK+faFZd9tzhZXolfN8fmso1NN/9T1LBEu9njfEbvW6GyYfr9z7xNbat CZT1bq7Nkjwo6MPm8WCRw3vuS1Epuou4FPrfHxUJEYYQaFkWMuB2ch/+2f4Ru7eWXRVSp8bmiGJ0tg 0KUgOc03lrScWv5NLB5hwJLetojnT3SRk1LA6FOZg4/9RhMmyyOdC+nO5fHja8/oTdR2jAyc/aKPLI xY90HQOz0uAJHeNaTRja8S9fkt46dJ
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

We submit outstanding IO in ext4_bio_write_page() if we find a buffer we
are not going to write. This is however pointless because we already
handle submission of previous IO in case we detect newly added buffer
head is discontiguous. So just delete the pointless IO submission call.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/page-io.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 2bdfb8a046d9..beaec6d81074 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -489,8 +489,6 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 					redirty_page_for_writepage(wbc, page);
 				keep_towrite = true;
 			}
-			if (io->io_bio)
-				ext4_io_submit(io);
 			continue;
 		}
 		if (buffer_new(bh))
-- 
2.35.3

