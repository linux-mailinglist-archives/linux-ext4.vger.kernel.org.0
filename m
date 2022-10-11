Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8415FB7D4
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Oct 2022 17:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiJKP5M (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 11 Oct 2022 11:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiJKP5G (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 11 Oct 2022 11:57:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12FA3386A;
        Tue, 11 Oct 2022 08:57:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 31F5921CE7;
        Tue, 11 Oct 2022 15:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1665503824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Oe3uf25AYWfevc4VWeTIQ/nmsX2KXKvM05hFxfYN5OQ=;
        b=avEuPDsPps5iS5JDhk27pl2qhuo/E5/sBdSb11ciEFMxouA6ko0QieAf5wfwp3qow9lV2J
        pR0ghazPSlsHa9lnhfF2sss2OniNLaIq0zmJWsHEU/b38PuDK8zIvlg38VLcUxyvsXIg09
        Hem3zPFKrVGV/0/PSFaSRDimnZoByic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1665503824;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Oe3uf25AYWfevc4VWeTIQ/nmsX2KXKvM05hFxfYN5OQ=;
        b=k32d+WKmjpCdYsXKOQ/pCjbdzYqQlvSAwygbKvI4QCPKWBpQd1eyWktleSXiRH7CXGA5cP
        c8zxF+G5P75VGlAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B9AB613AAC;
        Tue, 11 Oct 2022 15:57:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +AdsKk+SRWPEYwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Tue, 11 Oct 2022 15:57:03 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 72d8e8ec;
        Tue, 11 Oct 2022 15:58:00 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH] ext4: remove trailing newline from ext4_msg() message
Date:   Tue, 11 Oct 2022 16:57:58 +0100
Message-Id: <20221011155758.15287-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The ext4_msg() function adds a new line to the message.  Remove extra '\n'
from call to ext4_msg() in ext4_orphan_cleanup().

Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 fs/ext4/orphan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
index 69a9cf9137a6..e5b47dda3317 100644
--- a/fs/ext4/orphan.c
+++ b/fs/ext4/orphan.c
@@ -412,7 +412,7 @@ void ext4_orphan_cleanup(struct super_block *sb, struct ext4_super_block *es)
 		/* don't clear list on RO mount w/ errors */
 		if (es->s_last_orphan && !(s_flags & SB_RDONLY)) {
 			ext4_msg(sb, KERN_INFO, "Errors on filesystem, "
-				  "clearing orphan list.\n");
+				  "clearing orphan list.");
 			es->s_last_orphan = 0;
 		}
 		ext4_debug("Skipping orphan recovery on fs with errors.\n");
