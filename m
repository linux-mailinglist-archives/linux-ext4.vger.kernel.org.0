Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F77C642876
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Dec 2022 13:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiLEM3e (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Dec 2022 07:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiLEM3c (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Dec 2022 07:29:32 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A34112AEF
        for <linux-ext4@vger.kernel.org>; Mon,  5 Dec 2022 04:29:30 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 47BC91FF6A;
        Mon,  5 Dec 2022 12:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670243369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bAJrgBIBpossRMfpq+QaMKNctdr+3ByQ3w/XZCgqD48=;
        b=JclDH2GVvI+dTPxj8OtjN6V7EGi/dKP6ux3uaZjV05DkpSewzaY/HytvlWlxezZTjDKS4p
        IE92eZbwn89EcPcUA2TGykr/0kxTHaSYB8tZ/nxZc/ayi+ZH//+Hye0c3/GoUAxE9Wn3Ey
        OvkUmHurpKjy8dttd/3VtknYWsTCStw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670243369;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bAJrgBIBpossRMfpq+QaMKNctdr+3ByQ3w/XZCgqD48=;
        b=UzUYyE2F4YB/nzo6BS6+d5jsmTP2eg5SA0As2C99lNkmwFNKBCB9D26lCFwvwne1EBQdiO
        uuY0Atz2WeZPx7CQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 24ECB1369C;
        Mon,  5 Dec 2022 12:29:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 43KtCCnkjWP/TQAAGKfGzw
        (envelope-from <jack@suse.cz>); Mon, 05 Dec 2022 12:29:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 53DF1A072C; Mon,  5 Dec 2022 13:29:28 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v3 04/12] ext4: Drop pointless IO submission from ext4_bio_write_page()
Date:   Mon,  5 Dec 2022 13:29:18 +0100
Message-Id: <20221205122928.21959-4-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221205122604.25994-1-jack@suse.cz>
References: <20221205122604.25994-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=856; i=jack@suse.cz; h=from:subject; bh=4zrE8FuBvceix5JDITDiw9troAPfp1rf8G6PWkCP3ZQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjjeQeosVvJdxZNRlGA9S6hH7mwg4IjBC9PrQNYVyZ wzKG3+iJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY43kHgAKCRCcnaoHP2RA2W1vB/ 9utacmyQOmmcxtHtXxJMcKPCYdYyVJLWz/Vp+923ss8AoCBEHK3k39OqBGOhAsxV2K1/tqpXL5XYMH bGxpnGL7IZitWkISIwPjZKeLKZRfNMphT8gr1cRyHuPldUbHCwnsiY6LcB4RY4CL/VV3+VzRKusLSv 9p4LxaLg7OFKIH7OQ2b0JnLDrw/irIxLEkxEIqB4Ps8rSBM2jh0ep+H4eJGav5JY5D3MgUz5sZcy3P 7oLM5lYmS8WDq2d9WfzYsJnB061LhS6WcdRmPTs3tCy1nq1TBTkQpUSKZsYZWiIWzSDVIpv195fctv WgtHpw0AcuAaLEh2h7IGBGzZRs8eEn
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

