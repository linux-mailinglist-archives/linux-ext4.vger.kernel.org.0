Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687FC6FD347
	for <lists+linux-ext4@lfdr.de>; Wed, 10 May 2023 02:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbjEJAOS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 May 2023 20:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjEJAOP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 May 2023 20:14:15 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD1A3A9E
        for <linux-ext4@vger.kernel.org>; Tue,  9 May 2023 17:14:13 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1aaec6f189cso45584625ad.3
        for <linux-ext4@vger.kernel.org>; Tue, 09 May 2023 17:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683677653; x=1686269653;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRZbi24sFJrRNj/lxW5h09BrGpwEFi7DTff/g3KQP4A=;
        b=q4/rr/CbWC2cM+BUUGx/yqSEPkvMFp1XJrJCSYGc4uc51hGLsFfovEkl0evC2Y0N9k
         TPN9Dm6Yb7V4Ru4Gg2ctbwkIvJvmGcQtz4sBeLiIy0RInOQxxT4z45/oQSnszUtJWPZG
         g3RM9CBxlD9EB+rzThDWMg5RDqB3T3UHsk4pJja/uy+0wUP8LRlQ57To29CGkcbEZVjN
         LuWl/m0EVfEYkBvV7yOb/v9/PkFO7+rBG/E8qEYdM7flkvnEmixa+myEZCsLL1AkqaE0
         J+hPccIDn3G8cMbifL9Cz+odU6qgPuSKVRNYutE4U7a6KEdq9Us8TqCsIrFIGJnDTWg7
         p8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683677653; x=1686269653;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRZbi24sFJrRNj/lxW5h09BrGpwEFi7DTff/g3KQP4A=;
        b=bXXsC1ohy9g7RFFtU2PHZ+D5Ekr6Ldxh+zHvHacCi/czEkZ3nFqrTsvzkAI2tTH7f9
         STQZgauq6f4IJ6vwY7ZplcYa/a9zim4Ys85Ep/bjqRTBhJItJ7HI3F00kVbF6pmy3woG
         W3YREBpSUXocGj+NaG5My69XP09B4eV4dlulrTC4mfwucl3CkX0zbXdjlDrVXbfz6EPR
         o4CsrRH34hu1cRSWHqLlVltHPI1+nc0v0ArQoqXoT3IJ2d5IDWpGcm+oDoVStt2GhBmE
         R3kRaN8omCCrGbXOaZX9YqbXSPPgVYaLuAUOiSNgWHcHqZeoC7QsyjqQrVtxBMWTf9SX
         NgMw==
X-Gm-Message-State: AC+VfDx/cyUC8gU761zFJB+lKrbIuNwozbE5cl9YJjqK5+yreCXdfef2
        E8250p+5rrdfNIKBB2OpvIBNqolZ0VIsCQ==
X-Google-Smtp-Source: ACHHUZ53MgnKrkeOV4Pjlx6m0RH6CZ4Oh2KWDeUGpHCcM31ymdEgDXWZtFAB/GfPBFWH39gqMMjDTw==
X-Received: by 2002:a17:902:ec87:b0:19f:87b5:1873 with SMTP id x7-20020a170902ec8700b0019f87b51873mr20855486plg.62.1683677653227;
        Tue, 09 May 2023 17:14:13 -0700 (PDT)
Received: from localhost ([101.224.161.147])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902694a00b001a4fecf79e4sm2241575plt.49.2023.05.09.17.14.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 May 2023 17:14:12 -0700 (PDT)
From:   JunChao Sun <sunjunchao2870@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     jack@suse.cz, linux-ext4@vger.kernel.org,
        JunChao Sun <sunjunchao2870@gmail.com>
Subject: [PATCH v2] ext4: Replace value of xattrs in place
Date:   Tue,  9 May 2023 17:14:09 -0700
Message-Id: <20230510001409.14522-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When replacing the value of an xattr found in an ea_inode, currently
ext4 will evict the ea_inode that stores the old value, recreate an
ea_inode, and then write the new value into the new ea_inode.
This can be optimized by writing the new value into the old
ea_inode directly.

The logic for replacing value of xattrs without this patch
is as follows:
ext4_xattr_set_entry()
    ->ext4_xattr_inode_iget(&old_ea_inode)
    ->ext4_xattr_inode_lookup_create(&new_ea_inode)
    ->ext4_xattr_inode_dec_ref(old_ea_inode)
    ->iput(old_ea_inode)
        ->ext4_destroy_inode()
        ->ext4_evict_inode()
        ->ext4_free_inode()
    ->iput(new_ea_inode)

The logic with this patch is:
ext4_xattr_set_entry()
    ->ext4_xattr_inode_iget(&old_ea_inode)
    ->ext4_xattr_inode_write(old_ea_inode, new_value)
    ->iput(old_ea_inode)

This patch reduces the time it takes to replace xattrs in the ext4.
Without this patch, replacing the value of an xattr two million times takes
about 45 seconds on Intel(R) Xeon(R) CPU E5-2620 v3 platform.
With this patch, the same operation takes only 6 seconds.

  [root@client01 sjc]# ./mount.sh
  /dev/sdb1 contains a ext4 file system
      last mounted on /mnt/ext4 on Mon May  8 17:05:38 2023
  [root@client01 sjc]# touch /mnt/ext4/file1
  [root@client01 sjc]# gcc test.c
  [root@client01 sjc]# time ./a.out

  real    0m45.248s
  user    0m0.513s
  sys 0m39.231s

  [root@client01 sjc]# ./mount.sh
  /dev/sdb1 contains a ext4 file system
      last mounted on /mnt/ext4 on Mon May  8 17:08:20 2023
  [root@client01 sjc]# touch /mnt/ext4/file1
  [root@client01 sjc]# time ./a.out

  real    0m5.977s
  user    0m0.316s
  sys 0m5.659s

The test.c and mount.sh are in [1].
This patch passed the tests with xfstests using 'check -g quick'.

[1] https://gist.github.com/sjc2870/c923d7fa627d10ab65d6c305afb02cdb

Signed-off-by: JunChao Sun <sunjunchao2870@gmail.com>
---

Changes in v2:
  - Fix a problem when ref of an ea_inode not equal to 1
  - Link to v1: https://lore.kernel.org/linux-ext4/20230509011042.11781-1-sunjunchao2870@gmail.com/

 fs/ext4/xattr.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index d57408cbe903..8f03958bfcc6 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1713,6 +1713,42 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 		}
 	}
 
+	if (!s->not_found && i->value && here->e_value_inum && i->in_inode) {
+		/* Replace xattr value in ea_inode in place */
+		int size_diff = i->value_len - le32_to_cpu(here->e_value_size);
+
+		ret = ext4_xattr_inode_iget(inode,
+						le32_to_cpu(here->e_value_inum),
+						le32_to_cpu(here->e_hash),
+						&old_ea_inode);
+		if (ret) {
+			old_ea_inode = NULL;
+			goto out;
+		}
+		if (ext4_xattr_inode_get_ref(old_ea_inode) == 1) {
+			if (size_diff > 0)
+				ret = ext4_xattr_inode_alloc_quota(inode, size_diff);
+			else if (size_diff < 0)
+				ext4_xattr_inode_free_quota(inode, NULL, -size_diff);
+			if (ret)
+				goto out;
+
+			ret = ext4_xattr_inode_write(handle, old_ea_inode, i->value, i->value_len);
+			if (ret) {
+				if (size_diff > 0)
+					ext4_xattr_inode_free_quota(inode, NULL, size_diff);
+				else if (size_diff < 0)
+					ret = ext4_xattr_inode_alloc_quota(inode, -size_diff);
+				goto out;
+			}
+			here->e_value_size = cpu_to_le32(i->value_len);
+			new_ea_inode = old_ea_inode;
+			old_ea_inode = NULL;
+			goto update_hash;
+		} else
+			iput(old_ea_inode);
+	}
+
 	/*
 	 * Getting access to old and new ea inodes is subject to failures.
 	 * Finish that work before doing any modifications to the xattr data.
-- 
1.8.3.1

