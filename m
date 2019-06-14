Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C78934612A
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Jun 2019 16:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbfFNOnC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 14 Jun 2019 10:43:02 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45097 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbfFNOnB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 14 Jun 2019 10:43:01 -0400
Received: by mail-io1-f66.google.com with SMTP id e3so6177652ioc.12
        for <linux-ext4@vger.kernel.org>; Fri, 14 Jun 2019 07:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/ksnpuaEL/WdDMRC2Xj4Vj7MJKw0QSdyiTPXZRpkEUw=;
        b=UJ3SB8WuMAhR9IzwD/gfEouFtC+3cZEC5QvuZJZT7aTTrY/0C+OFpvP1liwYWLdY1i
         YhnO72QpOZ/NuBFQFIHwV04F5V22KKBbLLncwx9zSIeY1FnKg9/oPygH/QNfm7A77OUb
         uJlZNlj1NhT+3dlnTRCTvPT2SMyH/9gGUKqIeDcqdQAAKSVb3wBJ/3CA+LaMPFYICpWU
         glpXGbotgydWPn6SKVaLajhnIJ4UXO8mUBHVSmrpzCTSFArkHgjLFICfZLTT9OU1OlfP
         O6sExFcKP6So+RwFXDJ7sclPK2ZhsG2qc3L+0+WHtLk6LjQZa+eHQ/KCjSkOkM2IQzm0
         40/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/ksnpuaEL/WdDMRC2Xj4Vj7MJKw0QSdyiTPXZRpkEUw=;
        b=WDINzE9U62rMhHshoD1rgX/e155iFM/XF4r2Roerp/i29jkw+g3cJlUTHuCOm1z2GC
         91qw2RmWjmB9uDmsNsrqOhAK9gqz7JIVKBJ8xaQz4Mbck3eiTXsGzCH/6DoeqR+JLkFb
         CObao7ixz1iNNZZ8FXcOPucyt99kc8x+7Uu5xR1xxNHjFRo95bY09qZSN3V9dbmnJ3zr
         TKLsYhKh2m+5rbcby6spk/xkUzdLDGlSbjxhehQX6vuFkX89r0xvsm1HTYZDj80bilwh
         BjxybToNd1rJXmuF1D2E92/eaLE5Uc/2wcrsUIJceuz0xd6Pa0fgmimGJ2fTuuN9PwTy
         Z7fw==
X-Gm-Message-State: APjAAAXEvbNkbfuSmwfC4C6v7zvgOnpOeGZ/a1wi1eFhW4kVvLZxW3k9
        z87eXTX/2kZg/+c23TKuFHg7diFEl50=
X-Google-Smtp-Source: APXvYqxHs+yt5yW/gN0s11krmPhUbXWtEInkvF1Ke79rfQBji/fiyZtLDuq+DoS32BKhe6nSoL6nnQ==
X-Received: by 2002:a05:6602:2181:: with SMTP id b1mr15881622iob.198.1560523380646;
        Fri, 14 Jun 2019 07:43:00 -0700 (PDT)
Received: from C02TN4C6HTD6.us.cray.com (chippewa-nat.cray.com. [136.162.34.1])
        by smtp.gmail.com with ESMTPSA id i23sm2115531ioj.24.2019.06.14.07.42.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 07:42:59 -0700 (PDT)
From:   Artem Blagodarenko <artem.blagodarenko@gmail.com>
X-Google-Original-From: Artem Blagodarenko <c17828@cray.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger.kernel@dilger.ca, linux@rasmusvillemoes.dk
Subject: [PATCH] e2fsck: process empty directory if large_dir and inline_data set
Date:   Fri, 14 Jun 2019 17:42:37 +0300
Message-Id: <20190614144237.6010-1-c17828@cray.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Doing a forced check on an ext4 file system with inline_data and
large_dir results in lots of fsck messages. To reproduce:

truncate -s 100000000 ext4.img
misc/mke2fs -t ext4 -I 512 -O 'inline_data,large_dir' ext4.img
mkdir m
sudo mount ext4.img m
mkdir m/aa
sudo umount m
e2fsck/e2fsck -f -n ext4.img

The last command gives this output:

[root@localhost e2fsprogs-kernel]# e2fsck/e2fsck -f -n ext4-2.img
e2fsck 1.45.2 (27-May-2019)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
'..' in /aa (12) is <The NULL inode> (0), should be / (2).
Fix? no

Pass 4: Checking reference counts
Inode 2 ref count is 4, should be 3.  Fix? no

Inode 12 ref count is 2, should be 1.  Fix? no

Pass 5: Checking group summary information

ext4-2.img: ********** WARNING: Filesystem still has errors **********

ext4-2.img: 12/24384 files (0.0% non-contiguous), 17874/97656 blocks

Rootcause of this issue is large_dir optimization that is not
appropriate for inline_data.

Let's not optimize it if inline_data is set.

Reported-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Artem Blagodarenko <c17828@cray.com>
---
 e2fsck/pass2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/e2fsck/pass2.c b/e2fsck/pass2.c
index a7d9c47d..8b40e93d 100644
--- a/e2fsck/pass2.c
+++ b/e2fsck/pass2.c
@@ -980,7 +980,8 @@ static int check_dir_block(ext2_filsys fs,
 	 * very large and then the files are deleted. For now, all that is
 	 * needed is to avoid e2fsck filling in these holes as part of
 	 * feature flag. */
-	if (db->blk == 0 && ext2fs_has_feature_largedir(fs->super))
+	if (db->blk == 0 && ext2fs_has_feature_largedir(fs->super) &&
+	    !ext2fs_has_feature_inline_data(fs->super))
 		return 0;
 
 	if (db->blk == 0 && !inline_data_size) {
-- 
2.14.3

