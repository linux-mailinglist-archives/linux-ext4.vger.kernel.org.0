Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E28E7DBB17
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Oct 2023 14:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjJ3Nts (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Oct 2023 09:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjJ3Ntr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Oct 2023 09:49:47 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7909397
        for <linux-ext4@vger.kernel.org>; Mon, 30 Oct 2023 06:49:41 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6b1d1099a84so4403281b3a.1
        for <linux-ext4@vger.kernel.org>; Mon, 30 Oct 2023 06:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698673780; x=1699278580; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9srGe6y4XcL3Rfcyj6YjUCuEXJ6TrNfKp3GsXLyaxBU=;
        b=ZoH/GObAm97QFAJGv1FtLFyjWJWkGIP0VGG2LqKMshm53kjrjRNQuepcT+eWP45Nn1
         CAKcfXhDGk2FFWBLU8ac7vuTm3AkgYZJVJIO1npRAGVxTiu7NlDph/KKoBHpD/YeLXkQ
         2GPKiLKbgLjCVeR9ZeGTyDvNrx7kqVjruWCgaVQPBEc1ynyEYac1u7zhylb+2uaS8QE4
         vq35RWdCDhe18Ow9SnZ7oil4HpycZKocvaLLI439OURzmZEllvlCU8WCBTOZsNhY3gJa
         jzdzffHcK0dCycBIrXGomnE5JHRto6oKZW/T4ZWtpsUQEEZPMMN/0DTJVnXSo9RLII+E
         lCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698673780; x=1699278580;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9srGe6y4XcL3Rfcyj6YjUCuEXJ6TrNfKp3GsXLyaxBU=;
        b=l9F37wh66JrM4pL0VVcHSyThFl4ahKXamph2mOesKO0rOAHfkZ5t0/0bmdcORHLL3C
         kCRCVh5VQTqSxwQaawfnngS53qsh+vVVOO95Fg3j9x3Wyxd2QyWf8osGm3lbe5hrz9/B
         +C/CmI8+n176VcK9rhy7xNwWr6XBQGNuyp/VrBLcvVIN4BTJhO4SsF3MGX+LO9HUDie/
         v1LUwSC5C6b3+809N9lg8cr7wu5jsAJsPjUeLgJYdUCEB0kPRByLMqzYhzSi7qNIR0JV
         PSbPRKBYoeBemz0zRx1AZnqADooPgz3vY7MzjQh1ChjA5Mgu2xSXx2/ikNLJp84fH6MA
         0DbQ==
X-Gm-Message-State: AOJu0YzogD9O4V4Nx/hdI/rXYHveHqQoTLXgEduRALvlHv0IGI+Lrkoo
        Jw/MDrN/WsgLlIB6fFfSKZ/kc0zwKx46ag==
X-Google-Smtp-Source: AGHT+IH2HKHT0MbpKSywrgYDL6tRHffNLhGolMwmQeKN/nd8suLK5mWomhbhVW7gg/79xhRCtCDG2A==
X-Received: by 2002:a05:6a00:99e:b0:68a:59c6:c0a6 with SMTP id u30-20020a056a00099e00b0068a59c6c0a6mr12180721pfg.24.1698673780210;
        Mon, 30 Oct 2023 06:49:40 -0700 (PDT)
Received: from localhost ([124.77.22.109])
        by smtp.gmail.com with ESMTPSA id q20-20020a62ae14000000b006934a1c69f8sm5957112pff.24.2023.10.30.06.49.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Oct 2023 06:49:39 -0700 (PDT)
From:   JunChao Sun <sunjunchao2870@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger@dilger.ca,
        JunChao Sun <sunjunchao2870@gmail.com>
Subject: [PATCH v3] ext4: Replace value of xattrs in place
Date:   Mon, 30 Oct 2023 06:49:32 -0700
Message-Id: <20231030134932.3882-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
This patch passed the tests with xfstests 'check -g quick'.

[1] https://gist.github.com/sjc2870/c923d7fa627d10ab65d6c305afb02cdb

Signed-off-by: JunChao Sun <sunjunchao2870@gmail.com>
---

Change in v3:
  - Fix resources leakage when xattr size is shrinking
  - Link to v2: https://lore.kernel.org/linux-ext4/20230510001409.14522-1-sunjunchao2870@gmail.com/

Change in v2:
  - Fix a problem when ref of an ea_inode not equal to 1
  - Link to v1: https://lore.kernel.org/linux-ext4/20230509011042.11781-1-sunjunchao2870@gmail.com/

 fs/ext4/xattr.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 92ba28cebac6..ed5c34352e40 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1695,6 +1695,59 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 		}
 	}
 
+	if (!s->not_found && i->value && here->e_value_inum && i->in_inode) {
+		/* Replace xattr value in ea_inode in place */
+		int size_diff = i->value_len - le32_to_cpu(here->e_value_size);
+		u32 hash;
+		int err = 0;
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
+			hash = ext4_xattr_inode_hash(EXT4_SB(inode->i_sb), i->value, i->value_len);
+			ext4_xattr_inode_set_hash(new_ea_inode, hash);
+			if (size_diff < 0) {
+				inode_lock(new_ea_inode);
+				ext4_truncate(new_ea_inode);
+				inode_unlock(new_ea_inode);
+				/*
+				 * ext4_truncate() changed c_time, so ref_count which depends on c_time was changed also.
+				 * Let's restore it.
+				 */
+				ext4_xattr_inode_set_ref(new_ea_inode, 1);
+				err = ext4_mark_inode_dirty(handle, new_ea_inode);
+				if (err)
+					EXT4_ERROR_INODE(new_ea_inode, "mark ea inode dirty(error %d)", err);
+			}
+			goto update_hash;
+		} else
+			iput(old_ea_inode);
+	}
+
 	/*
 	 * Getting access to old and new ea inodes is subject to failures.
 	 * Finish that work before doing any modifications to the xattr data.
-- 
2.34.1

