Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504916458F5
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 12:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiLGL1c (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 06:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiLGL10 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 06:27:26 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56A3FAF3
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 03:27:24 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 618D721C9B;
        Wed,  7 Dec 2022 11:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670412443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bAJrgBIBpossRMfpq+QaMKNctdr+3ByQ3w/XZCgqD48=;
        b=R1FzHWzl80cfmP2+u5cd8fPwIT3Q/sDuGFtpxeSRDBm8lSbBC+dmaO8PMQP2i161ORbWcr
        eFl4mZiiD0EI8R96l/5BwNaU3AYxjJw++inpQdC4eIQt9Zutn4NWSq5Gv9SSpnHBDDxnb1
        9diC8P4IJM9cri0CtZK2/d6BoiVcuIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670412443;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bAJrgBIBpossRMfpq+QaMKNctdr+3ByQ3w/XZCgqD48=;
        b=g4jG+nx6k0Uzx+dr8L8tVqjZ8Yj9D1f6yW2FjtMwAfkqlNhg1kfO19sNlzeKomCjHcRVzA
        lj6HShBU4GV3EVAQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 54FE613732;
        Wed,  7 Dec 2022 11:27:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id CSmuFJt4kGMtLAAAGKfGzw
        (envelope-from <jack@suse.cz>); Wed, 07 Dec 2022 11:27:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DDDCAA072B; Wed,  7 Dec 2022 12:27:22 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v4 04/13] ext4: Drop pointless IO submission from ext4_bio_write_page()
Date:   Wed,  7 Dec 2022 12:27:07 +0100
Message-Id: <20221207112722.22220-4-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221207112259.8143-1-jack@suse.cz>
References: <20221207112259.8143-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=856; i=jack@suse.cz; h=from:subject; bh=4zrE8FuBvceix5JDITDiw9troAPfp1rf8G6PWkCP3ZQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjkHiLosVvJdxZNRlGA9S6hH7mwg4IjBC9PrQNYVyZ wzKG3+iJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY5B4iwAKCRCcnaoHP2RA2cuTB/ 46fvcNxB0xD695T6a6Ee1FTLtyDOMZJ3WvEaK47q5rp5MramhLeb3jVGXMt2RKQoERHupZWhuu6DOG xs0ELLYtQLtjxlV7nFvHqJg3fS0BycNUC7k4Bkdc9byzbXGphukNP89C58lWIocTpYe/U2g0fT7x30 2A5zfa8D1LQ6qZo7yD21w4/GpbnBSpXSKrqLAnh5MlPujxt9ycaePw+8A2K6guUPJAY4JpjUA/FCFl N/jAmEDnCbq9lSemw+6werMV70CwhTb2IJbqk0k4qaIxtB7KklGZuEH1bOwS9cVzJIrEp//kijdGps t5QLOVuq22x3w7uNqXxytpmZHAu1+F
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

