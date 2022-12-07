Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE036458FD
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 12:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiLGL1v (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 06:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiLGL12 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 06:27:28 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A505FB5
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 03:27:27 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C3E9F21CA4;
        Wed,  7 Dec 2022 11:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670412443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zpQ5pqECC7zfStAichmjNg9JJ5GpSKtsoF3bdTjzvm0=;
        b=Cdt+6O0Hq+Rv38q0B/zo6ODyKM9xdns5Z5PPlg7SA7erQtgXHK5bTlQZYZdG+nBubz0oV1
        RHorHwrDQO9+ipmlHG7Sr40PsrdHRk1bSryZwtzOT2mxDXjMmwTG83I3lddb/rZHJ7tOmd
        W45R+TwP4F1Qux62Ya7vOP+O+uvuPL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670412443;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zpQ5pqECC7zfStAichmjNg9JJ5GpSKtsoF3bdTjzvm0=;
        b=vkZ8NCwumUsmOPsCQX3OIlsc1f504akqUPrta8BmeLL3YzfnoCC5bOHeqVtRoqPbQ6ocIB
        OktGLCSxpcPgXdCg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B99B01373B;
        Wed,  7 Dec 2022 11:27:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id e2hILZt4kGNDLAAAGKfGzw
        (envelope-from <jack@suse.cz>); Wed, 07 Dec 2022 11:27:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F0F79A0732; Wed,  7 Dec 2022 12:27:22 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v4 07/13] ext4: Move percpu_rwsem protection into ext4_writepages()
Date:   Wed,  7 Dec 2022 12:27:10 +0100
Message-Id: <20221207112722.22220-7-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221207112259.8143-1-jack@suse.cz>
References: <20221207112259.8143-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1875; i=jack@suse.cz; h=from:subject; bh=j0DgcX6U83KV++ws+PacqXTcQBSes8Qh1QV7iXDVXAo=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjkHiONhTLkyK8IkojQ5z5FFbrI2FL9H0toOBh1kY2 W9R6a1mJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY5B4jgAKCRCcnaoHP2RA2bx3CA CQLOS8kVmkrm6rXpXZ+vbcs5uUZaar8yv9IYkvxJPoWByVUvkIzZTSffY/K8KhrC0FJoQ8PUqfcEvr uzYPSNWDCcDtGYZMpz6l1L3ct7tyUH+5ZmUb0yoKP1RaRf1rKnXiQp8kmPPaZhQOWQOmuNvlqMUJc8 d/57SSJUIC2Ijnik1C/1b7/Ei7Ngn5Iq624ywpPuoztsLwmWkxYNHBTfE0KRngMn3JoqIsRA9UQi9g F0JWCFRMJ2TWpGxnIWpAcDmOUltrub3A0Wbd8DwWJQv2qrGhjlRaBqyMpyHiEN+zLjumyPlEhILJXW HQE47dOp1I3J5lpuQ08uPKrAtfM7xB
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

Move protection by percpu_rwsem from ext4_do_writepages() to
ext4_writepages(). We will not want to grab this protection during
transaction commits as that would be prone to deadlocks and the
protection is not needed. Move the shutdown state checking as well since
we want to be able to complete commit while the shutdown is in progress.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 99c66c768cd0..4f8f4959524c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2720,10 +2720,6 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 	struct blk_plug plug;
 	bool give_up_on_write = false;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
-		return -EIO;
-
-	percpu_down_read(&sbi->s_writepages_rwsem);
 	trace_ext4_writepages(inode, wbc);
 
 	/*
@@ -2933,20 +2929,28 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 out_writepages:
 	trace_ext4_writepages_result(inode, wbc, ret,
 				     nr_to_write - wbc->nr_to_write);
-	percpu_up_read(&sbi->s_writepages_rwsem);
 	return ret;
 }
 
 static int ext4_writepages(struct address_space *mapping,
 			   struct writeback_control *wbc)
 {
+	struct super_block *sb = mapping->host->i_sb;
 	struct mpage_da_data mpd = {
 		.inode = mapping->host,
 		.wbc = wbc,
 		.can_map = 1,
 	};
+	int ret;
+
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(sb))))
+		return -EIO;
 
-	return ext4_do_writepages(&mpd);
+	percpu_down_read(&EXT4_SB(sb)->s_writepages_rwsem);
+	ret = ext4_do_writepages(&mpd);
+	percpu_up_read(&EXT4_SB(sb)->s_writepages_rwsem);
+
+	return ret;
 }
 
 static int ext4_dax_writepages(struct address_space *mapping,
-- 
2.35.3

