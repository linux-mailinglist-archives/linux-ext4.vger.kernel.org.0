Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5216D711CE9
	for <lists+linux-ext4@lfdr.de>; Fri, 26 May 2023 03:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbjEZBnL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 May 2023 21:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjEZBnK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 25 May 2023 21:43:10 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4651D189
        for <linux-ext4@vger.kernel.org>; Thu, 25 May 2023 18:43:09 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5144a9c11c7so194108a12.2
        for <linux-ext4@vger.kernel.org>; Thu, 25 May 2023 18:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685065389; x=1687657389;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRZbi24sFJrRNj/lxW5h09BrGpwEFi7DTff/g3KQP4A=;
        b=N604WPr/aHBaWp4DEU4/UrNp5yaIIwFdEH5X1uDaQHhPd1W/MwlZvDLQm2HIgRnDaA
         1IyxD7Ne9IVZuQh57xfySRyVI1F7FNIQECp9xNqUqA7yBlvraFtTWTi1SRfBHOypQys3
         sEIRE1wSQd/HMtaPCSP4fMrqiOwk2R1VNOnqRiTCX77lLUEzutvM3z36C9D1E8GlksCh
         tNwFd5hCQ0DWqchA/+7AHOllix2H1A7EIxuRgjGYv6EbJNCr43CYmWTYYiXV0Ddi0JSy
         +f/J789H/X5Jr8Rt8b8w11lNqeSCCQyc1WgasK8Ee2AorGtsh0yFvR5YUKLzY2yR6Itr
         Ud1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685065389; x=1687657389;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRZbi24sFJrRNj/lxW5h09BrGpwEFi7DTff/g3KQP4A=;
        b=LhimoJURpUGUke9uV2lf2fga4B0cxs/KXYO7FqXCemZpWkN0EbN94xsnzkPVoC51eK
         nqabdqWbaeC4tpUZX0UYTpcJpPUwx0SsKc9KxW/15iOjxmc7+OxFdAP9dGkdlBfWvOLp
         7Gd3ts2crQUqvjuIS3RIT6JBcBSTnfyvCz4hwsHYuewBFczyDq/3RDqsEKkujgftspcU
         CUPAHfUHoRg1lmb3IegFqXr7CYMj1pJ4hp3KUJYVHXDSaEYan1XZL6a6E8hX7Qgjr/Vq
         BDE+v3g8eVWfg2RAN7DuLz9KZjEFXCw1oVpSgrzDjAV7IODOsjwxsDSyt1SGRE8MfIOg
         uVlg==
X-Gm-Message-State: AC+VfDyTjdHHQntVzU9PzlSkbgEQO5p8ZXdGOdv9S5IOSqveWXYvF4Ml
        58PM4sxGmiAw2eFCRJWePOuuLtirrAM=
X-Google-Smtp-Source: ACHHUZ452nd/wbzA2APadW647ehgu76OGZU+jKL2vjKSaX9+wzdnVSfVj3y/eDMzW1hXznMU4LIZ5Q==
X-Received: by 2002:a05:6a20:7d97:b0:100:607:b986 with SMTP id v23-20020a056a207d9700b001000607b986mr100807pzj.56.1685065388646;
        Thu, 25 May 2023 18:43:08 -0700 (PDT)
Received: from localhost ([101.224.163.9])
        by smtp.gmail.com with ESMTPSA id c6-20020aa78806000000b0064d2d0ff8d5sm1699619pfo.163.2023.05.25.18.43.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 May 2023 18:43:08 -0700 (PDT)
From:   JunChao Sun <sunjunchao2870@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     jack@suse.cz, linux-ext4@vger.kernel.org, tahsin@google.com,
        JunChao Sun <sunjunchao2870@gmail.com>
Subject: [RESEND PATCH v2] ext4: Replace the value of xattrs in place
Date:   Thu, 25 May 2023 18:43:04 -0700
Message-Id: <20230526014304.4294-1-sunjunchao2870@gmail.com>
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

