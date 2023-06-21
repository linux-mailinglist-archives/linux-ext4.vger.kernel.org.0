Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83044738797
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jun 2023 16:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjFUOsD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Jun 2023 10:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjFUOr4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Jun 2023 10:47:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81E31BC1;
        Wed, 21 Jun 2023 07:47:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5E7C91FECC;
        Wed, 21 Jun 2023 14:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687358865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kv6ExZernbSJWI88DpmmcJXjCzsmSh4Zm3LClIhZLBs=;
        b=uTLSKksY0r8UEg+1g8Guk7dqOeyat14cg0OjNpwTLUzr8cEyCNgHRveIDX2qfxuX9I5a8O
        hLscMNKvZGF/uIL6xgU2cLqH1V5eM8liwOYtuT/q/o1ITefV0RUCSCkprNILo3KG1pYwKG
        rM1DNpMVsmBPvigqeeqK8DazC1qf9ls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687358865;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kv6ExZernbSJWI88DpmmcJXjCzsmSh4Zm3LClIhZLBs=;
        b=Mo3w+XS3XfnQSCTYCM6KqnWgFu06AKVmYTKTVxpl0bzwm37SQBq1vn6jyYs5ey/cxTif5R
        FEKYjbEj/bGSOBDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 475C213A66;
        Wed, 21 Jun 2023 14:47:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4lvSEJENk2T+EAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 21 Jun 2023 14:47:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CF439A0762; Wed, 21 Jun 2023 16:47:44 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        <linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] xfs: Fix crash in ext4_bdev_mark_dead()
Date:   Wed, 21 Jun 2023 16:47:43 +0200
Message-Id: <20230621144744.1580-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230621144354.10915-1-jack@suse.cz>
References: <20230621144354.10915-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=792; i=jack@suse.cz; h=from:subject; bh=9mvZHv1nuxOrQ7jy+yO1dpp1vobf8ZfRCOPCzoekEhM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkkw2O58FKvXZCqoY+XMY4g6hDtZPOPFl/GfUiC1Bg KHkItYSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZJMNjgAKCRCcnaoHP2RA2UbvCA C4w8+U/GaomQgaxClF8hYFoz8gIrFJ9yEcmsR4jiuyhD8T1JyS9wX7+KlS3HjsLO0yMpq6Tiu1TLIu rMuFXsEWoTFmzawnh9j8Ym6ryHLu2PnnguqcLul2M7IKrfJuakK7/LrwnKa9BMgIjQebAbI1oUfd97 JOKBnJj2uumSdcan5RnELbs9OPtD643xFk2Wkcq3y5ZMwDO2tRObLNOCAmifbaNcTYLE9PVHV2Szkr KPUtLZFf6f4u++NPZTNoMqwJBANNEQfNBM2rogqGpDPbLFoNsTlpluDjAbns/DW6mnVpVBVOLXrwve XDW/WoZFXW7i3uyCpEXCE3fmJXkuAY
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

xfs_bdev_mark_dead() passes bdev->bd_holder to ext4_force_shutdown()
instead of bdev->bd_super leading to crashes. Fix it.

Fixes: 8067ca1dcdfc ("xfs: wire up the ->mark_dead holder operation for log and RT devices")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/xfs/xfs_super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index d910b141d52e..3ab188a6fba1 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -381,7 +381,7 @@ static void
 xfs_bdev_mark_dead(
 	struct block_device	*bdev)
 {
-	xfs_force_shutdown(bdev->bd_holder, SHUTDOWN_DEVICE_REMOVED);
+	xfs_force_shutdown(XFS_M(bdev->bd_super), SHUTDOWN_DEVICE_REMOVED);
 }
 
 static const struct blk_holder_ops xfs_holder_ops = {
-- 
2.35.3

