Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3B3748FB4
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jul 2023 23:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjGEV3L (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Jul 2023 17:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbjGEV3K (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Jul 2023 17:29:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814E81980;
        Wed,  5 Jul 2023 14:29:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00FA66176E;
        Wed,  5 Jul 2023 21:29:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486A1C433C9;
        Wed,  5 Jul 2023 21:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688592546;
        bh=KcNEa0zEiaEU6adJH2JZRqZUV1g2aY4t4BXK14QkSmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rs6e5/ndV1WaPwfswIkjuHGZxkg5AVKmKpXjLnwXxXibLnuHHJEhP1lX0FWTpn9HB
         Hq1GyTvdKLiXXCLsBW8oHJLz/ufssuniOOad3yvjnkre0e8v6X/mRKGN4SgMCeM4kR
         4RkmA2kjsip5GEeN1sdYhXtD/DLl83n8dt9jrQsGIFTqqkHh1fgSDkzYUoUdz6LXfg
         NWwlkAKgodqMpO0oW0cUfiMiXpIl4Mlud0zxy+0EwFPpnrBjfJTRRGP0rZVD6AzRBQ
         hSqLswU0tITxTNlv4bVlwjrMUbBL50XwtDDRTf3iaYvcJPFHpeesbkqu8RHeQeK1bS
         TqIhNxqR27m5g==
From:   Eric Biggers <ebiggers@kernel.org>
To:     fsverity@lists.linux.dev
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] fsverity: move sysctl registration out of signature.c
Date:   Wed,  5 Jul 2023 14:27:43 -0700
Message-ID: <20230705212743.42180-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705212743.42180-1-ebiggers@kernel.org>
References: <20230705212743.42180-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Currently the registration of the fsverity sysctls happens in
signature.c, which couples it to CONFIG_FS_VERITY_BUILTIN_SIGNATURES.

This makes it hard to add new sysctls unrelated to builtin signatures.

Also, some users have started checking whether the directory
/proc/sys/fs/verity exists as a way to tell whether fsverity is
supported.  This isn't the intended method; instead, the existence of
/sys/fs/$fstype/features/verity should be checked, or users should just
try to use the fsverity ioctls.  Regardlesss, it should be made to work
as expected without a dependency on CONFIG_FS_VERITY_BUILTIN_SIGNATURES.

Therefore, move the sysctl registration into init.c.  With
CONFIG_FS_VERITY_BUILTIN_SIGNATURES, nothing changes.  Without it, but
with CONFIG_FS_VERITY, an empty list of sysctls is now registered.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/verity/fsverity_private.h |  1 +
 fs/verity/init.c             | 32 ++++++++++++++++++++++++++++++++
 fs/verity/signature.c        | 33 +--------------------------------
 3 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index c5ab9023dd2d3..d071a6e32581e 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -123,6 +123,7 @@ void __init fsverity_init_info_cache(void);
 /* signature.c */
 
 #ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
+extern int fsverity_require_signatures;
 int fsverity_verify_signature(const struct fsverity_info *vi,
 			      const u8 *signature, size_t sig_size);
 
diff --git a/fs/verity/init.c b/fs/verity/init.c
index bcd11d63eb1ca..a29f062f6047b 100644
--- a/fs/verity/init.c
+++ b/fs/verity/init.c
@@ -9,6 +9,37 @@
 
 #include <linux/ratelimit.h>
 
+#ifdef CONFIG_SYSCTL
+static struct ctl_table_header *fsverity_sysctl_header;
+
+static struct ctl_table fsverity_sysctl_table[] = {
+#ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
+	{
+		.procname       = "require_signatures",
+		.data           = &fsverity_require_signatures,
+		.maxlen         = sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec_minmax,
+		.extra1         = SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE,
+	},
+#endif
+	{ }
+};
+
+static void __init fsverity_init_sysctl(void)
+{
+	fsverity_sysctl_header = register_sysctl("fs/verity",
+						 fsverity_sysctl_table);
+	if (!fsverity_sysctl_header)
+		panic("fsverity sysctl registration failed");
+}
+#else /* CONFIG_SYSCTL */
+static inline void fsverity_init_sysctl(void)
+{
+}
+#endif /* !CONFIG_SYSCTL */
+
 void fsverity_msg(const struct inode *inode, const char *level,
 		  const char *fmt, ...)
 {
@@ -36,6 +67,7 @@ static int __init fsverity_init(void)
 	fsverity_check_hash_algs();
 	fsverity_init_info_cache();
 	fsverity_init_workqueue();
+	fsverity_init_sysctl();
 	fsverity_init_signature();
 	return 0;
 }
diff --git a/fs/verity/signature.c b/fs/verity/signature.c
index ec75ffec069ed..b95acae64eac6 100644
--- a/fs/verity/signature.c
+++ b/fs/verity/signature.c
@@ -24,7 +24,7 @@
  * /proc/sys/fs/verity/require_signatures
  * If 1, all verity files must have a valid builtin signature.
  */
-static int fsverity_require_signatures;
+int fsverity_require_signatures;
 
 /*
  * Keyring that contains the trusted X.509 certificates.
@@ -93,35 +93,6 @@ int fsverity_verify_signature(const struct fsverity_info *vi,
 	return 0;
 }
 
-#ifdef CONFIG_SYSCTL
-static struct ctl_table_header *fsverity_sysctl_header;
-
-static struct ctl_table fsverity_sysctl_table[] = {
-	{
-		.procname       = "require_signatures",
-		.data           = &fsverity_require_signatures,
-		.maxlen         = sizeof(int),
-		.mode           = 0644,
-		.proc_handler   = proc_dointvec_minmax,
-		.extra1         = SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE,
-	},
-	{ }
-};
-
-static void __init fsverity_sysctl_init(void)
-{
-	fsverity_sysctl_header = register_sysctl("fs/verity",
-						 fsverity_sysctl_table);
-	if (!fsverity_sysctl_header)
-		panic("fsverity sysctl registration failed");
-}
-#else /* !CONFIG_SYSCTL */
-static inline void fsverity_sysctl_init(void)
-{
-}
-#endif /* !CONFIG_SYSCTL */
-
 void __init fsverity_init_signature(void)
 {
 	fsverity_keyring =
@@ -132,6 +103,4 @@ void __init fsverity_init_signature(void)
 			      KEY_ALLOC_NOT_IN_QUOTA, NULL, NULL);
 	if (IS_ERR(fsverity_keyring))
 		panic("failed to allocate \".fs-verity\" keyring");
-
-	fsverity_sysctl_init();
 }
-- 
2.41.0

