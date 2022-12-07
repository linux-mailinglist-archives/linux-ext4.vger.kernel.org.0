Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7473C64598A
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 13:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiLGMAN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 07:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiLGL7z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 06:59:55 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E67C209
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 03:59:39 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3147F21C86;
        Wed,  7 Dec 2022 11:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670414378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OuymbYdwq//0yU4AGQtq1yLnLj4i8i2axD4bH6iP/Yg=;
        b=KRdodYGenx0ZGzran/cTIgty5c4c/plzJxWyKXr3UuUzxWiIV0N/w7e8qU++mDFoHVRfP0
        AeYt3iXj/TkO24y6qBl16tSTtDR8IsjboK0yGWn+SbcNa9JJyMhk3oDZbGZp0SokVaiKGL
        DHaPlm9VuQhjVCgEOfDCBPfwhx/VTrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670414378;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OuymbYdwq//0yU4AGQtq1yLnLj4i8i2axD4bH6iP/Yg=;
        b=wDTKgCydKKfHxaT49DfDTpMgLEu/Cf7odCkqAHesRxJzJJMiaT/g7UZYYcLr9hZrewWFCw
        24lawn3AuWjJSxBQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 2591113732;
        Wed,  7 Dec 2022 11:59:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id EZkoCSqAkGNrPQAAGKfGzw
        (envelope-from <jack@suse.cz>); Wed, 07 Dec 2022 11:59:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5B615A0728; Wed,  7 Dec 2022 12:59:37 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Pengfei Xu <pengfei.xu@intel.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] ext4: Avoid unaccounted block allocation when expanding inode
Date:   Wed,  7 Dec 2022 12:59:28 +0100
Message-Id: <20221207115937.26601-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221207115122.29033-1-jack@suse.cz>
References: <20221207115122.29033-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1181; i=jack@suse.cz; h=from:subject; bh=XHMqNmXUvIh74E0JeoIXJXEtWcAU/IhNo21BLzJMlG8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjkIAfosqfAPr1Zemt9l7C9l3BprWmqxhNJyf0upwz KOyD2vCJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY5CAHwAKCRCcnaoHP2RA2b7uCA CfpQgh7yVuX5T3Q5cbn8Uli+nFp/UKj7xVTv/wpBnj5g/0gCALHN6t01GLHheC/67Q5ZOvEZGD3vgl coTByEhiX871R/FD72AX9LQLUQ/JjopNVQBSq4ZmNqw6yUSTOKKc80PjQLzCXCbouCWlfIQLD9p9GT aPyuNDIWPhpTpeYzmnHeXL+04yBD6OILLrL3syMn8tqUS/8JN78uxo7X4TapTHHWzME93R0Oxel49I tDI9J46+BE7EFCbE1JO0x2i6ePzfAxIigVeSII8d/M+N3w0mPKFwNOLsANiwUXYowpxTsH5t/08LNH WoixBAFQvSvCSjocdPAUM2fr+kJgvT
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

When expanding inode space in ext4_expand_extra_isize_ea() we may need
to allocate external xattr block. If quota is not initialized for the
inode, the block allocation will not be accounted into quota usage. Make
sure the quota is initialized before we try to expand inode space.

Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Link: https://lore.kernel.org/all/Y5BT+k6xWqthZc1P@xpf.sh.intel.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2b5ef1b64249..62c81af57bb0 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5853,6 +5853,14 @@ static int __ext4_expand_extra_isize(struct inode *inode,
 		return 0;
 	}
 
+	/*
+	 * We may need to allocate external xattr block so we need quotas
+	 * initialized. Here we can be called with various locks held so we
+	 * cannot affort to initialize quotas ourselves. So just bail.
+	 */
+	if (dquot_initialize_needed(inode))
+		return -EAGAIN;
+
 	/* try to expand with EAs present */
 	error = ext4_expand_extra_isize_ea(inode, new_extra_isize,
 					   raw_inode, handle);
-- 
2.35.3

