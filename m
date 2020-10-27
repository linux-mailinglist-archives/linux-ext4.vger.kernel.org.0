Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC21E29CA8E
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Oct 2020 21:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373163AbgJ0UoI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Oct 2020 16:44:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44576 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505096AbgJ0UoF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Oct 2020 16:44:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id 133so1603239pfx.11
        for <linux-ext4@vger.kernel.org>; Tue, 27 Oct 2020 13:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m7PGhnwmiNEUHnrZwoGZYSfpdcHmffqQQyDqVwh7p2g=;
        b=DbutXaYo0DqMFBwcf4GFyuti6pNYLI3oByQlUQ7y+G2wa31AlAC3c1lr6nGAMFXjSt
         PBBrR8rGgwLjlQO/7oQGoNocKULakDCgT/EqeR8HdMWBkYqVgrZcwq6W9aPJbUrK4WWW
         db0w04+vBJ9VScO68uPmnUhf53h2+ey5EYe6s22prpW+q91Ah+WjfssZwTVl24+tHHKA
         NBzx4YklI0TTdHFrgxKl8Esmu5S5fnAZjxlkjEZ1B6kB/kHPKJ1zJdvkiT/knQH6x/0Y
         mo2v8CFBxjuj2Bcdyg836KlfiW9FWQVwMn9EzTy7Mq8z+3VyHqnJCy8eysmPWbuZOa4D
         Ud3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m7PGhnwmiNEUHnrZwoGZYSfpdcHmffqQQyDqVwh7p2g=;
        b=hVNscMqFmUqSIybyNXj5OPFpItKV3K48xxdokXlgbFWhtyrRbiwFTirAvx7kE9xVQz
         t8ksqd+JzDfdUQwtw1Ik9+nSjIJ4h0zGCfz4KSEHWhB7Ge7ce5/VTaMJ4p7h1tPWkzE0
         6tQhmlJZxftItlUIO+ELiTsCJW88h2X/oKGYWSbMCIKgA/PUcFW3ttMgqiaVzCX421oa
         aLUC/DhaXGWDiCJMjM0aKibiUW7D4j9zU7WAwA+Z9GKbFEYvNyr2PVE1UuS9wj6N2MPf
         6zSPPL0pn92EmpmjSp17Xb7wirj3jiBP/MguAOdtiAlREnFoCScSkyN7945UA8mlQA4D
         895A==
X-Gm-Message-State: AOAM532HMBeITdbSq9ljSABLMVg9Gfh0HRAEriApOlNt3bhat2dFRfjd
        e2K7AFUjK775q0n8cCArG0ROMObcROPTLQ==
X-Google-Smtp-Source: ABdhPJwaOcFc57Ms5/Ig8z33vrpGiIyDcwX1JG33xphsBuescU7uxrHK2a/IOfSW+eIVQZe1quFuaw==
X-Received: by 2002:a62:6885:0:b029:164:51c0:b849 with SMTP id d127-20020a6268850000b029016451c0b849mr2035330pfc.58.1603831444183;
        Tue, 27 Oct 2020 13:44:04 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id f4sm3153017pfc.63.2020.10.27.13.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 13:44:03 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ext4: use IS_ERR() for error checking of path
Date:   Tue, 27 Oct 2020 13:43:42 -0700
Message-Id: <20201027204342.2794949-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

With this fix, fast commit recovery code uses IS_ERR() for path
returned by ext4_find_extent.

Fixes: 8016e29f4362 ("ext4: fast commit recovery path")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/fast_commit.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 3ee43fd6d5aa..8d43058386c3 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1616,8 +1616,10 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 		if (ret == 0) {
 			/* Range is not mapped */
 			path = ext4_find_extent(inode, cur, NULL, 0);
-			if (!path)
-				continue;
+			if (IS_ERR(path)) {
+				iput(inode);
+				return 0;
+			}
 			memset(&newex, 0, sizeof(newex));
 			newex.ee_block = cpu_to_le32(cur);
 			ext4_ext_store_pblock(
-- 
2.29.0.rc2.309.g374f81d7ae-goog

