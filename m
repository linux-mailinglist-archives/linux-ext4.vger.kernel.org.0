Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66C945E52F
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jul 2019 15:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfGCNRq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Jul 2019 09:17:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:47033 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGCNRq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Jul 2019 09:17:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id e5so1225599pls.13;
        Wed, 03 Jul 2019 06:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ovgGl+jGowxGh/5LJKQzh3sNG9BCZNG/DBPIgm5xu5k=;
        b=j1orMTiJfi+4JeL0B+RB28+WkHswD5L1q8Lai4m7ymMXWb+sxdS2NAxmK36T+YjWMR
         wEb6vyHaoAPi7I0FugPkwVGncWQg42OQBcYWsjI0yHg3/N73KO/LtEjTQbJJu7Yeouoq
         DYl8vkoOScbEwl8vwZAjoWXGHYFPi0zzuUOu/oqSsg2d5NPZG8bFk+186PbSChKNwYV/
         yWOINDW95WEemSJeveBzMy5zY4fTQcbpkCjsLssXvoenyzS56iv96KIkINDpEOPC8Cas
         pjzqTrjOe4EK6t6vxptKq3mojuE2DFBN/Ndq8JNAb3ysDPMMwG2GgJJ+/P2B1F1CNJKG
         d6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ovgGl+jGowxGh/5LJKQzh3sNG9BCZNG/DBPIgm5xu5k=;
        b=k47AdMrBvLx/4euRGrMxFir3SvAzbEkxugk29Ri/Q1lSyPFFFqyRuWQhSYH8/OJlMz
         vGjmtTW4fKkKggCx+9cEEGjpas7u84497Osrdv94/XPT7v7iBx9btWirfgZW+/+gV8ly
         uAd7cYtEWGUSJCf4Ez9M3BKLxAfgLFR4KNGUWrVC5so+a7Z8xIzITeIsR747Zx+F5ctc
         iz/LY1T/R0EUOKtJHtJrLvtkwyKOT4fPVyU5ngMixLL3K5C0T35B+qOxnDcHx3fJWbJ2
         Bi8CKpeP2MQVIlyG6T9gY9LsxP+sLm1seAxrnpAvTs7vztAOhYHLncqAvrfT2RGXA5eN
         Ktsg==
X-Gm-Message-State: APjAAAUpGOKEQNS8eEnEyrbTR2wMFWSoRUISePZpX2kzeYZuxVFV4w8l
        AI7ZJJh/vpmAgKuNseVLSDE=
X-Google-Smtp-Source: APXvYqyR3nq9eHErOpO7QM45dzh/9Rzb7VaRo8EfRYr0NgWRIoMtDwcvnelQBys9vfnp7NTYe5wkhA==
X-Received: by 2002:a17:902:2baa:: with SMTP id l39mr2445988plb.280.1562159865770;
        Wed, 03 Jul 2019 06:17:45 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id w1sm2152938pjt.30.2019.07.03.06.17.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 06:17:45 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 24/30] ext4: Use kmemdup rather than duplicating its implementation
Date:   Wed,  3 Jul 2019 21:17:37 +0800
Message-Id: <20190703131737.25781-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memset, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memset.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 fs/ext4/xattr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 491f9ee4040e..d09040df7014 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1898,11 +1898,10 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 
 			unlock_buffer(bs->bh);
 			ea_bdebug(bs->bh, "cloning");
-			s->base = kmalloc(bs->bh->b_size, GFP_NOFS);
+			s->base = kmemdup(BHDR(bs->bh), bs->bh->b_size, GFP_NOFS);
 			error = -ENOMEM;
 			if (s->base == NULL)
 				goto cleanup;
-			memcpy(s->base, BHDR(bs->bh), bs->bh->b_size);
 			s->first = ENTRY(header(s->base)+1);
 			header(s->base)->h_refcount = cpu_to_le32(1);
 			s->here = ENTRY(s->base + offset);
-- 
2.11.0

