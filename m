Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B3A6FBC60
	for <lists+linux-ext4@lfdr.de>; Tue,  9 May 2023 03:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjEIBKt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 May 2023 21:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEIBKs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 May 2023 21:10:48 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2722F19BB
        for <linux-ext4@vger.kernel.org>; Mon,  8 May 2023 18:10:47 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-517bdd9957dso3523238a12.1
        for <linux-ext4@vger.kernel.org>; Mon, 08 May 2023 18:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683594646; x=1686186646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6ji+0rpoi3mfWjWeGc3NEAxASQDsQjp5l8wG2ymw3WU=;
        b=eoBjNmvKuRjQL8wfhxG2TYlfoQOVY+mA/ywpx4cy8i6dPpgtRw/j5MLLh9slCOr2pC
         xJouxkBRNuNcE/xx0dObVldeQK9ihkGN4+IF2M/RZhpNeagOVxPHM9iPmD2RD/oJMbc2
         HuK3sEowwYJtWzYo4aFRl9KN1Ut/Vn37aj6uVNGRP3g9aBmWbcnTexaO6ppoBgChZ9LD
         A6/imD+kBGEHPgbE1Q0cV6Kco6yf1QPqjy3imWMFQvWf3SwKqqaed8jBUGX1OotwnlaX
         4PayoM/ND5kRZCzOTYV1gKnPVHe/ijpOWucH0+5pQcArKHyvRZWCVn125kMw6cYhDzDZ
         oVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683594646; x=1686186646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ji+0rpoi3mfWjWeGc3NEAxASQDsQjp5l8wG2ymw3WU=;
        b=l369u/IL/4wlQypnPT8HV0lf8YlYWJ2qyHzDxh8/a89uV9xl2BVwZWBAUZsZ/idKVr
         7XfAVuiu+58HlSzzo8RBRrJ04INcCcEN4X7NO8THqIUpsyDGDE7JmsqhNidAo+88cI1c
         6TpbNYi8VoQe54QJ06X5qUDA828QpVPbB1dRBy8hZolxLfiogP/X1LMRtSTAcRaiSUPg
         APWH+GlQ/sF1DEh5lRC3q/Lsbg+QSy0shxpyEn5GfcBUtLDA/K88FAbfeDWLQfbs1YXI
         UliJYNg6Omdvl0KHMvzppNkAvuXJ9WFI7l4HTsomvt+YByVjyQ6c4LS1vUEVac6f6pmv
         /+FA==
X-Gm-Message-State: AC+VfDwppiaHdZNkxvnQ6edkwVrQyoMLGtEse5aoN48MUlU+Pmdjkesv
        o0grk1s7VTdec8BV3nTgm9o=
X-Google-Smtp-Source: ACHHUZ42nXCO/SikPNBolkZZ5CdZro1x9nPiGN0CxrWUOvhKN73CTRnM4mlfcGLXKkKaxkAAUTdXRg==
X-Received: by 2002:a17:90b:1c8a:b0:24e:f03:6b8f with SMTP id oo10-20020a17090b1c8a00b0024e0f036b8fmr10984350pjb.48.1683594646485;
        Mon, 08 May 2023 18:10:46 -0700 (PDT)
Received: from localhost ([101.224.161.147])
        by smtp.gmail.com with ESMTPSA id k4-20020a632404000000b00502e7115cbdsm109931pgk.51.2023.05.08.18.10.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 May 2023 18:10:45 -0700 (PDT)
From:   JunChao Sun <sunjunchao2870@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     jack@suse.cz, tahsin@google.com, linux-ext4@vger.kernel.org,
        JunChao Sun <sunjunchao2870@gmail.com>
Subject: [PATCH] ext4: Reduce time overhead for replacing xattr values.
Date:   Mon,  8 May 2023 18:10:42 -0700
Message-Id: <20230509011042.11781-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

When replace the value of xattr which found in an ea_inode, currently
ext4 will evict ea_inode which stores the old value, recreate an
ea_inode and then write the new value into new ea_inode. This can
be optimized by writing the new value into old ea_inode directly.

The logic for replacing the value of xattr without this patch
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

This patch reduces the time it takes to replace xattr in ext4.
Without this patch, replacing the value of xattr two million times takes
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

[1]: https://gist.github.com/sjc2870/c923d7fa627d10ab65d6c305afb02cdb

Signed-off-by: JunChao Sun <sunjunchao2870@gmail.com>
---
 fs/ext4/xattr.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index d57408cbe903..37f79594ac70 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1713,6 +1713,39 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
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
+		if (size_diff > 0)
+			ret = ext4_xattr_inode_alloc_quota(inode, size_diff);
+		else if (size_diff < 0)
+			ext4_xattr_inode_free_quota(inode, NULL, -size_diff);
+		if (ret)
+			goto out;
+
+		ret = ext4_xattr_inode_write(handle, old_ea_inode, i->value, i->value_len);
+		if (ret) {
+			if (size_diff > 0)
+				ext4_xattr_inode_free_quota(inode, NULL, size_diff);
+			else if (size_diff < 0)
+				ret = ext4_xattr_inode_alloc_quota(inode, -size_diff);
+			goto out;
+		}
+		here->e_value_size = cpu_to_le32(i->value_len);
+		new_ea_inode = old_ea_inode;
+		old_ea_inode = NULL;
+		goto update_hash;
+	}
+
 	/*
 	 * Getting access to old and new ea inodes is subject to failures.
 	 * Finish that work before doing any modifications to the xattr data.
-- 
1.8.3.1

