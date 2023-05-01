Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEB96F3182
	for <lists+linux-ext4@lfdr.de>; Mon,  1 May 2023 15:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjEAN0Z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 May 2023 09:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjEAN0Y (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 May 2023 09:26:24 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C73218E
        for <linux-ext4@vger.kernel.org>; Mon,  1 May 2023 06:26:23 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-958bb7731a9so516580766b.0
        for <linux-ext4@vger.kernel.org>; Mon, 01 May 2023 06:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1682947581; x=1685539581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f9cyg065wfP6TddaAwGYXK4uibrlWAL6qKdFTwcry6o=;
        b=gH2RedCByLlEpfX84KOzVmptYqV1qj09T1N+Mt5/QmRQyzNvfAZyWlYlVDHZ7DHbRe
         yhngUYfb/Dc472mGvpihQH7X1MKAMAArlY3rmpXeNiGgkQnWSEeVnDPJ6/Gk9/F4tBXC
         3IkSACUyB0p94ZdLwZbShWyXE4Kbep2AYfP/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682947581; x=1685539581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9cyg065wfP6TddaAwGYXK4uibrlWAL6qKdFTwcry6o=;
        b=CcLtC6gx4fRWPhCe0on1tgwRylBT42shixhlwXozXiSJfDvNSuPNyw2eX5goV8DzxK
         ackRewxeknGDS3HH9PX1j01kJKTKJ5VppLWQCGx2zaE25LwRUF+2+vlyozVPvLveO7Kp
         YFCQq2iVmLFDRyZUh1ng3yC5ilqrP2ypg4fqbONxxLM2HVQu2eWjzUNaYkpBke+qEFfo
         sYL7pATIcfnMPlNmvB+JzUbsCptav7RXKZxWNvjNvL3TRnj7AqW80XRchmbBPWH7zgMh
         B5or5hpKePjloVs2K4525xl+Wi+y0UpBWu5Gcru2W0VYZOrZH9OJTsEsHZeo7K7C8XUN
         6Vzg==
X-Gm-Message-State: AC+VfDzkVJMhtNOGqsPTfBkc0u1svB5WhiQ3tQy0YRRtRKk61hGS8YhJ
        LUWw9kud0RW0/LlwnAlu3OJkzg==
X-Google-Smtp-Source: ACHHUZ4KfMpS92cFeoS88pft9NxrUges95GqscIkKaXM0aJe3FGT4ol/Gok4hZSMi1fA2xGjzwRI4g==
X-Received: by 2002:a17:907:844:b0:961:8d21:a471 with SMTP id ww4-20020a170907084400b009618d21a471mr3970021ejb.58.1682947581367;
        Mon, 01 May 2023 06:26:21 -0700 (PDT)
Received: from cloudflare.com (apn-31-0-39-53.dynamic.gprs.plus.pl. [31.0.39.53])
        by smtp.gmail.com with ESMTPSA id ho17-20020a1709070e9100b0094edfbd475csm14514115ejc.127.2023.05.01.06.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 06:26:20 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     adilger.kernel@dilger.ca, jack@suse.cz, lczerner@redhat.com,
        linux-ext4@vger.kernel.org, ritesh.list@gmail.com, tytso@mit.edu
Cc:     yanaijie@huawei.com, kernel-team@cloudflare.com,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] ext4: unbreak build with CONFIG_QUOTA=n
Date:   Mon,  1 May 2023 15:26:19 +0200
Message-Id: <20230501132619.161735-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Commit dcbf87589d90 ("ext4: factor out ext4_flex_groups_free()") made some
loop count variables unused when CONFIG_QUOTA is unset.

Make the unused counters local to the loop scope to fix the build.

Fixes: dcbf87589d90 ("ext4: factor out ext4_flex_groups_free()")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202303240449.6Cg6YXJO-lkp@intel.com/
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
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
2.40.0

