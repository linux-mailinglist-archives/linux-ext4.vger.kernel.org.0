Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EC676C9D1
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Aug 2023 11:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjHBJti (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Aug 2023 05:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjHBJth (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Aug 2023 05:49:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF8FE57;
        Wed,  2 Aug 2023 02:49:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5F9C51F749;
        Wed,  2 Aug 2023 09:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690969775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oG99N9wn1Zwsv4UxpgLJDybTYUZ52WwqDECex34X2Ok=;
        b=1jYsc+Xy79TkLiVn8FyhO/kCudhhFlmkevXic8bQl4pI+sEVJzTa3j5QpCtwOF4vWXNci5
        ycr/pF6rZEggWoev1UZWk4lp8ZVcy7hRYujImA6kHsfHNkNMfUiGAiWdwMdtUiYjlW5374
        JWL1c+dngQvLpEOHaydpH+yOrfT03j0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690969775;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oG99N9wn1Zwsv4UxpgLJDybTYUZ52WwqDECex34X2Ok=;
        b=53er0okG6zAS0kRbBncgS1qtXng3Y93tUmR9bxJXqjXIilpziX+PEA5fSnqfQ/b+DnPjcS
        ckvf68sWHKpFBACw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E48FB13909;
        Wed,  2 Aug 2023 09:49:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fpPoNK4mymRycAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Wed, 02 Aug 2023 09:49:34 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id a355a2d3;
        Wed, 2 Aug 2023 09:49:34 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Daniel Rosenberg <drosen@google.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH v2] ext4: fix memory leaks in ext4_fname_{setup_filename,prepare_lookup}
Date:   Wed,  2 Aug 2023 10:49:31 +0100
Message-Id: <20230802094931.18215-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If casefolding the filename fails, we'll be leaking fscrypt_buf name.
Make sure we free it in the error paths of ext4_fname_setup_filename() and
ext4_fname_prepare_lookup() functions.

Fixes: 1ae98e295fa2 ("ext4: optimize match for casefolded encrypted dirs")
Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
Changes since v1:
- Include fix to ext4_fname_prepare_lookup() as well
- Add 'Fixes:' tag

 fs/ext4/crypto.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext4/crypto.c b/fs/ext4/crypto.c
index e20ac0654b3f..3c05c7f3415b 100644
--- a/fs/ext4/crypto.c
+++ b/fs/ext4/crypto.c
@@ -33,6 +33,8 @@ int ext4_fname_setup_filename(struct inode *dir, const struct qstr *iname,
 
 #if IS_ENABLED(CONFIG_UNICODE)
 	err = ext4_fname_setup_ci_filename(dir, iname, fname);
+	if (err)
+		fscrypt_free_filename(&name);
 #endif
 	return err;
 }
@@ -51,6 +53,8 @@ int ext4_fname_prepare_lookup(struct inode *dir, struct dentry *dentry,
 
 #if IS_ENABLED(CONFIG_UNICODE)
 	err = ext4_fname_setup_ci_filename(dir, &dentry->d_name, fname);
+	if (err)
+		fscrypt_free_filename(&name);
 #endif
 	return err;
 }
