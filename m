Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0576645989
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 13:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiLGMAL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 07:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiLGL7z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 06:59:55 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64036200
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 03:59:39 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 24DC81FD7A;
        Wed,  7 Dec 2022 11:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670414378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=57ibS47N9BDwKOVUtoFj4WQ3lyGco6R17eMA/Blas+s=;
        b=XofTo8jCyGoTtKSwUsATbG+tW/4qJ1d1c9CeaIBLPLUEdLz5py7KisSf4w0sEWuVraeu2t
        PvSKd4l6sNhH7T/tSa3mbFqjyduojPnUY1EslzkAjaURQ276oGvOuRl9fEDNBKUFbvwJZn
        SJpZjyE3YmiRENjN2qNv8VhCO75azgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670414378;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=57ibS47N9BDwKOVUtoFj4WQ3lyGco6R17eMA/Blas+s=;
        b=Ty+W65bd1766jiZE6iNsHE9sTfoqqYyVxluvqxM0yDYnBEMeeKAkrAZCscEOrA34wSe7kO
        7PFTk0elthxhcKBw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 16B5E136B4;
        Wed,  7 Dec 2022 11:59:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 1Bx8BSqAkGNnPQAAGKfGzw
        (envelope-from <jack@suse.cz>); Wed, 07 Dec 2022 11:59:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 55A47A0504; Wed,  7 Dec 2022 12:59:37 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Pengfei Xu <pengfei.xu@intel.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] ext4: Initialize quota before expanding inode in setproject ioctl
Date:   Wed,  7 Dec 2022 12:59:27 +0100
Message-Id: <20221207115937.26601-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221207115122.29033-1-jack@suse.cz>
References: <20221207115122.29033-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1083; i=jack@suse.cz; h=from:subject; bh=nCm8Fs5Sy6P7076qczmFFHv6VAq9RRH3FSGW814wO94=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjkIAe3MKa+IqimEvQ3bNnAS50/lgsITfbw4qo562h Hj1wTC2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY5CAHgAKCRCcnaoHP2RA2eQqCA DPjnUoj2S+KfDvtI915xcYGpzer3HgIYbv8/YEKMje2CJ8N603EbQiWdacBa2D0Li6wWTIITfsrqVG 3i3JkoQ4sZeRHYGpYbt2n7vUmNx1dqmc7BrcBdh3+XIn7HWemRjW4RVB6bKHxPrZyxA4/jPaZEumRI szP3wWaF3GEACPwhtjNvtshuwFq4kps4hOfwqEh47t+3Nl/OAbMuvECQ1ASOOlhkauV90flDK+oFic Y6BuwsJMwW4eDerTzOsUvN7zLdCYwq9iDj8GCwqZUPNIpuTi0tOX74JUzFj/tjfXG8Mmpy7jhW1p7w F0bv0+SpcnWnVQvcC+eEsboSQgCCwV
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

Make sure we initialize quotas before possibly expanding inode space
(and thus maybe needing to allocate external xattr block) in
ext4_ioctl_setproject(). This prevents not accounting the necessary
block allocation.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ioctl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 95dfea28bf4e..082f65602cc1 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -731,6 +731,10 @@ static int ext4_ioctl_setproject(struct inode *inode, __u32 projid)
 	if (ext4_is_quota_file(inode))
 		return err;
 
+	err = dquot_initialize(inode);
+	if (err)
+		return err;
+
 	err = ext4_get_inode_loc(inode, &iloc);
 	if (err)
 		return err;
@@ -746,10 +750,6 @@ static int ext4_ioctl_setproject(struct inode *inode, __u32 projid)
 		brelse(iloc.bh);
 	}
 
-	err = dquot_initialize(inode);
-	if (err)
-		return err;
-
 	handle = ext4_journal_start(inode, EXT4_HT_QUOTA,
 		EXT4_QUOTA_INIT_BLOCKS(sb) +
 		EXT4_QUOTA_DEL_BLOCKS(sb) + 3);
-- 
2.35.3

