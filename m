Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D7673879D
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jun 2023 16:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjFUOsG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Jun 2023 10:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjFUOr5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Jun 2023 10:47:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB70F1BCB;
        Wed, 21 Jun 2023 07:47:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 570DA1FECB;
        Wed, 21 Jun 2023 14:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687358865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QWUOtp0iwu/9Qa0OVnEO54KvtodKK3z2Yy7Kvf+nwDE=;
        b=spZwbLy7WTEzmCG4IMRKQcBb3oB/aSMNtEjvoswtRfWZzVDvghsD5pMwYwaZxYquv0jqYf
        YcAGwzQPCRk3PBncB9u2KOnsFAgy3rxJuwJydd5bw8pFRXy4lzQ+Wz3fp8hSCgE6RCXtAy
        34vS7wfHeG2WTI41bOoDyjVMQNkpESY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687358865;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QWUOtp0iwu/9Qa0OVnEO54KvtodKK3z2Yy7Kvf+nwDE=;
        b=YS9AuQ78ENZBIpT+YMAxs3pUdZCQBG02Y9BNmpyyomSr+5pEuDZlRnut4qwFav1kcoKNJg
        xrOBheTKgL0AAQCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3FF70133E6;
        Wed, 21 Jun 2023 14:47:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ISQRD5ENk2T7EAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 21 Jun 2023 14:47:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C88E1A0439; Wed, 21 Jun 2023 16:47:44 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        <linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] ext4: Fix crash in ext4_bdev_mark_dead()
Date:   Wed, 21 Jun 2023 16:47:42 +0200
Message-Id: <20230621144744.1580-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230621144354.10915-1-jack@suse.cz>
References: <20230621144354.10915-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=831; i=jack@suse.cz; h=from:subject; bh=fVkRZ23tC1duoGWpYIOUWQFn7i7gXQuatR9LkqpoylM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkkw2Nz9dPYRfxuj98FpO6uTFrTKYBBa85oPM//MLy caQyHJuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZJMNjQAKCRCcnaoHP2RA2XS/CA CUkx2kfMmw1VtFu0zZfSoq9OorFMl6+eWvqt5avVVd9qqI+jUKlzqcJOuJZkufV0dkWnfUN5XKXMha Hh55mhrpH+G5Hq9Pkwcqk4YCAoHCS9GdIMIe6z2RW6mZo5qfEFOFjr7SgaNk2iDikQTRyFYAVxQfft x37meRh8o2HaGqj1bIbRfeqpbMMYP4BacrIfKM0XHSEuYpDZbXdEiYR+IoYZftU6gOp/lr0V9/nBk2 R4C9TIwZcJK2IEYNvFBjZefwBLuriM90kWdeXwZI4BDZJtViF+UOoyhQhnUUgecMSPkUej5L3fcRu7 Zul/dHMFfegtba8HHutOXxoZlahwT8
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4_bdev_mark_dead() passes bdev->bd_holder to ext4_force_shutdown()
instead of bdev->bd_super leading to crashes. Fix it.

Fixes: dd2e31afba9e ("ext4: wire up the ->mark_dead holder operation for log devices")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 6f43a86ecf16..53d74144ee34 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1098,7 +1098,7 @@ void ext4_update_dynamic_rev(struct super_block *sb)
 
 static void ext4_bdev_mark_dead(struct block_device *bdev)
 {
-	ext4_force_shutdown(bdev->bd_holder, EXT4_GOING_FLAGS_NOLOGFLUSH);
+	ext4_force_shutdown(bdev->bd_super, EXT4_GOING_FLAGS_NOLOGFLUSH);
 }
 
 static const struct blk_holder_ops ext4_holder_ops = {
-- 
2.35.3

