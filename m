Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF4A6A6B77
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Mar 2023 12:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjCALMt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Mar 2023 06:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjCALMs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Mar 2023 06:12:48 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A2B3B860
        for <linux-ext4@vger.kernel.org>; Wed,  1 Mar 2023 03:12:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 50E0D1FE12;
        Wed,  1 Mar 2023 11:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677669159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G0AlmLfGiekbq2yaipJ0jfe7KDoKX8ZNdImobOAmth4=;
        b=fnNra/oubDt9rxddgmU7EcpjFnKT6OOT4IYufD9JA6vJQ5pXqhSWOTYIHRgUKJlm2kjFQi
        dze7RasAf6XxLWbZRWX4ieHai8qFCLZ3sdMmPGMoJBQGRFIXxTartdc+eSO+v7KeCSTyH8
        EkK0A1HiwHO71Uudyqa62Po4F6mzBqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677669159;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G0AlmLfGiekbq2yaipJ0jfe7KDoKX8ZNdImobOAmth4=;
        b=1GvwfIR9o0BC4oF5JsEihCab6d0hZNEyoa/zMFgx6A5qZ6wbnkGKr9lV5ge+DgpLpSQR1R
        hwad/QcB/DbJrVCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4633113A64;
        Wed,  1 Mar 2023 11:12:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gwgcEScz/2MBRQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 01 Mar 2023 11:12:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C29B4A06C6; Wed,  1 Mar 2023 12:12:38 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] ext2: Correct maximum ext2 filesystem block size
Date:   Wed,  1 Mar 2023 12:12:30 +0100
Message-Id: <20230301111238.22856-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230301111026.15102-1-jack@suse.cz>
References: <20230301111026.15102-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1003; i=jack@suse.cz; h=from:subject; bh=PgP57hZZyxmhshvWjcnY3d3TJ8st/Of9jYF9AyeSaOM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBj/zMdgBbfHPWvUR/gInxc3NRLP0Kw9sk9wihgEiIV UZmH8t6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY/8zHQAKCRCcnaoHP2RA2bFLCA DS9UpRfvP0yDt8NauIbZwjK1Ts/NOMIjFHEh56Fk2MHahSoInlIOBonZrRohGm8E6lRuzFYsg8zlWv HNpjdupy3/J2i1tTnlM0cspgKeaSqnZjtR20RFRgP4pJeIBf8SlIm9me3QVKZ1PGk4t5JCa/P5V+M8 oq8OP1OI0B1ER822veHPFfFaL1KmhoqIzaiWeRvsXiocFB8ayveQYD4v/AW7sGBRl8Jwctsf6G34lo cuDAAWDbqxtN+0RAYU69B/UmQdMRP1Ml2HnnFQQoy6l9vHHUhzZvYN+o5S9O6LfQVb8WNt9Fm7PYcz ux4A5GkP0/py5rnDZkWhnaTQ6VUuUT
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

Ext2 has traditionally supported filesystem block sizes upto page size
or upto 65536. Macro EXT2_MAX_BLOCK_SIZE is set to 4096, however that is
never used in ext2 so practically we always allowed whatever
sb_set_blocksize() accepted. Fix value of EXT2_MAX_BLOCK_SIZE because it
will be used in the next patch.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext2/ext2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index cb78d7dcfb95..6c8e838bb278 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -178,7 +178,7 @@ static inline struct ext2_sb_info *EXT2_SB(struct super_block *sb)
  * Macro-instructions used to manage several block sizes
  */
 #define EXT2_MIN_BLOCK_SIZE		1024
-#define	EXT2_MAX_BLOCK_SIZE		4096
+#define	EXT2_MAX_BLOCK_SIZE		65536
 #define EXT2_MIN_BLOCK_LOG_SIZE		  10
 #define EXT2_BLOCK_SIZE(s)		((s)->s_blocksize)
 #define	EXT2_ADDR_PER_BLOCK(s)		(EXT2_BLOCK_SIZE(s) / sizeof (__u32))
-- 
2.35.3

