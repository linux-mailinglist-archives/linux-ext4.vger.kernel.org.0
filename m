Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB4863DAC4
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Nov 2022 17:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiK3QgR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Nov 2022 11:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiK3QgL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Nov 2022 11:36:11 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACC0880EB
        for <linux-ext4@vger.kernel.org>; Wed, 30 Nov 2022 08:36:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 628851F45B;
        Wed, 30 Nov 2022 16:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669826169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yi3iYjfficMani0DB8DcTg/Hfupkks23yn5B9RYsXIo=;
        b=rf2Qa1IGgG1gdU46qPM5TQi8ClqO5KKAKFKLmBpDJ7jUtqVWw33C7euzvQvoOR8aneDdLL
        PJBXJDAPuhNIS8vhgKFv3+tn0vmZVyhPXFrcgOJ+kW1PWblAZDWh5PjplqNc5SQ3CfNA3c
        Zkpb3cT86dt9us64jzlYYKHzjq3sdK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669826169;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yi3iYjfficMani0DB8DcTg/Hfupkks23yn5B9RYsXIo=;
        b=OUH032FcREwwLzeD6858thcz/Lu6z0AysdPlLIP1J9oFZe4G3J2T/8uL5z/JGUbq1VHdso
        +OWM+b26H5x/8dBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55FAA13A70;
        Wed, 30 Nov 2022 16:36:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mMX7FHmGh2NVQgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 30 Nov 2022 16:36:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B8B30A0718; Wed, 30 Nov 2022 17:36:08 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 4/9] ext4: Drop pointless IO submission from ext4_bio_write_page()
Date:   Wed, 30 Nov 2022 17:35:55 +0100
Message-Id: <20221130163608.29034-4-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221130162435.2324-1-jack@suse.cz>
References: <20221130162435.2324-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=797; i=jack@suse.cz; h=from:subject; bh=SXWIF7GCG3JqXi8R/f4M+Ly6lggE4TvljS0LQU2XOQk=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjh4ZrIDGPRd0mzF1lfqe9aMuXZRcdsir/ea4zxWav Je7Po6GJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY4eGawAKCRCcnaoHP2RA2YgzB/ 9TzYQ2afn5VR6Q6U9yaFKZRNC+bR7DoY6cP/lERMz2EMILB5PJ84XZKZJrHHwtQf/bdPuoscBR4VeE H4/18GwVMJxZZhVLUljpuVMWpQualqWPXG19jIp955eBPiYxU5/GP6dOAaK2C1dTIPcJfUQb27zBRs piGQtgBKl4xsHQ6zlaVNowSG7RqKU7dATjOyqI3JjTmPVdCePM2qJbqKCAYlb9kzO0Z/vVtSccu38k edP1mj7IMV0327ya/NwaY0oGTIbaihulZZNyYPu6N2+kZj/0hnTu/so6H1ifwAdfTxIe0gQldbBIjt 0hqUKMn0mCkkY0Cx2eFaWippY6Uv68
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

We submit outstanding IO in ext4_bio_write_page() if we find a buffer we
are not going to write. This is however pointless because we already
handle submission of previous IO in case we detect newly added buffer
head is discontiguous. So just delete the pointless IO submission call.

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

