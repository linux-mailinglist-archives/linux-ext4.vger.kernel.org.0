Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EC76EA454
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Apr 2023 09:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjDUHIl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Apr 2023 03:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjDUHIi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Apr 2023 03:08:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB9E7DBF;
        Fri, 21 Apr 2023 00:08:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27B0F61BD4;
        Fri, 21 Apr 2023 07:08:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF2FC433D2;
        Fri, 21 Apr 2023 07:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682060901;
        bh=bQzQaoashK/4PV029DbpZuuIfz5K69u3O9j4z8ufa1w=;
        h=From:To:Cc:Subject:Date:From;
        b=Sgyw3xUIbQ0riYIXVtTtryebT2IV79C2Dzffgn++x2nOcPdFgf0uy8AiHWsh9R/I8
         MxN+cYCzKwsO5w1H9vWHm87B0HQXXNFj2n90LKBusL7ViUDQCFyHcQ6l/OKGQblLef
         Z+Cmf+YjuD5FIGnZF+93/Jl0067BzmVh+gIiPJTQHVTOP9eVGCLozkvR8VPDRQcORE
         Mapq9etseBp9hqZbip30rMIja9qwF3dKrQ8zFA9dZeCepeyF7u08Tnk4U/SP+CUP67
         JfFejy8zqaN905Fynf0q3jxJNEgBo++0nSuW72UKMK+bYSWH4X9ndfhuFoZBYWF/vJ
         ltmYXZX7e0n8Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jason Yan <yanaijie@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Ye Bin <yebin10@huawei.com>, Baokun Li <libaokun1@huawei.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: avoid unused-variable warning with CONFIG_QUOTA=n
Date:   Fri, 21 Apr 2023 09:08:11 +0200
Message-Id: <20230421070815.2260326-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

From: Arnd Bergmann <arnd@arndb.de>

After some code reshuffling, the index variables in two functions
are only used in an #ifdef:

fs/ext4/super.c: In function 'ext4_put_super':
fs/ext4/super.c:1262:13: error: unused variable 'i' [-Werror=unused-variable]
fs/ext4/super.c: In function '__ext4_fill_super':
fs/ext4/super.c:5200:22: error: unused variable 'i' [-Werror=unused-variable]

Since all supported compilers now allow having variable declarations
inside of a for() loop, move them into the #ifdef block directly.

Fixes: dcbf87589d90 ("ext4: factor out ext4_flex_groups_free()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ext4/super.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d03bf0ecf505..9b331ef593ea 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1259,7 +1259,7 @@ static void ext4_put_super(struct super_block *sb)
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_super_block *es = sbi->s_es;
 	int aborted = 0;
-	int i, err;
+	int err;
 
 	/*
 	 * Unregister sysfs before destroying jbd2 journal.
@@ -1311,7 +1311,7 @@ static void ext4_put_super(struct super_block *sb)
 	ext4_flex_groups_free(sbi);
 	ext4_percpu_param_destroy(sbi);
 #ifdef CONFIG_QUOTA
-	for (i = 0; i < EXT4_MAXQUOTAS; i++)
+	for (int i = 0; i < EXT4_MAXQUOTAS; i++)
 		kfree(get_qf_name(sb, sbi, i));
 #endif
 
@@ -5197,7 +5197,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	ext4_fsblk_t logical_sb_block;
 	struct inode *root;
 	int ret = -ENOMEM;
-	unsigned int i;
 	int needs_recovery;
 	int err = 0;
 	ext4_group_t first_not_zeroed;
@@ -5628,7 +5627,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 #endif
 
 #ifdef CONFIG_QUOTA
-	for (i = 0; i < EXT4_MAXQUOTAS; i++)
+	for (int i = 0; i < EXT4_MAXQUOTAS; i++)
 		kfree(get_qf_name(sb, sbi, i));
 #endif
 	fscrypt_free_dummy_policy(&sbi->s_dummy_enc_policy);
-- 
2.39.2

