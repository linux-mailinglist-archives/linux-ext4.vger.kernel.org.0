Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA92D123DCE
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2019 04:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfLRDTl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Dec 2019 22:19:41 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43381 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfLRDTl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Dec 2019 22:19:41 -0500
Received: by mail-ot1-f65.google.com with SMTP id p8so540957oth.10;
        Tue, 17 Dec 2019 19:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0NidlF/CBLeinh3cp0FnzdKgnGEjo9SYU3o+e1k4btg=;
        b=O5ww+RZkp9XQNs3HYaNmhuzDqQOxlMJA1Agcmw2InBdajNPxibogVJItfBVHzRZFP2
         n6/kjHN+xhOxpKJaeFITaT6wHzrkwclLGcoihgQWmWLeB9JaFHu+nmSbvQ4XIsjY16VF
         xYzzl4+VJzEvbGRk6HdLSo79rD6rZRrnXnWTfPleolvj4zMtFMhN0YMFV/ea7baNLKFl
         Kny4DTJtmN9mYZ10IAILSpO5RaNbUkh77HlsKlOBdG61uSIN4xkWTIvMf22ukMwuNYOo
         HLnSkcum7BRtvWkBv/WkwFwGN/0PQuyj6SdHfLkEAIgm01VPSYV+m8UsVZA0S8Qw/86G
         thwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0NidlF/CBLeinh3cp0FnzdKgnGEjo9SYU3o+e1k4btg=;
        b=cUJehsBLFMsmgbvtR+jjSv/khNBFPOyTclbQcaXDcTlZ3MHFGQOpv1Q6v+9DIY+eRI
         ktvEGKsP8J/R/uA4vGjLi4oJnie1jRzKf2gPbVu8LTjTQZ24ntnnA+1KiES97KjYlW21
         aPH/ErhVmICEUd5XX923fXkTEHyW2cSB48uNLeR7fpcjpeuBpCHoCtTRlaheLlWLvUVf
         KL9KQuakmwVdLPgrwbzY72eBgQHR7ZIir2fG3+K96Zx/GrX+E/nD5CjIwmrXX+NviQ5h
         Wbij3FwnhqDcHCmKbJes2iBGXm8WfCQgFapEFvRW6NvqawEURnayBzm6YZCVlWG9BkHA
         lCsg==
X-Gm-Message-State: APjAAAWca9wYaux93f1ty3LVj2qgkm9YwJA9lYFsQuCNbsqHOB6igCdP
        NwYvb8tBc87P8n2n131b2szko11WsNM=
X-Google-Smtp-Source: APXvYqzOuPIVqI99LoLzsklmQrUzvd8WvaGDPjbrKWIiMnu6exYqqjG5nXh511jcQA9CcjGL4LTGvw==
X-Received: by 2002:a9d:73ca:: with SMTP id m10mr97183otk.289.1576639180067;
        Tue, 17 Dec 2019 19:19:40 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id t196sm111515oie.11.2019.12.17.19.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 19:19:39 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jan Kara <jack@suse.com>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] ext2: Adjust indentation in ext2_fill_super
Date:   Tue, 17 Dec 2019 20:19:31 -0700
Message-Id: <20191218031930.31393-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218031519.15450-1-natechancellor@gmail.com>
References: <20191218031519.15450-1-natechancellor@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Clang warns:

../fs/ext2/super.c:1076:3: warning: misleading indentation; statement is
not part of the previous 'if' [-Wmisleading-indentation]
        sbi->s_groups_count = ((le32_to_cpu(es->s_blocks_count) -
        ^
../fs/ext2/super.c:1074:2: note: previous statement is here
        if (EXT2_BLOCKS_PER_GROUP(sb) == 0)
        ^
1 warning generated.

This warning occurs because there is a space before the tab on this
line. Remove it so that the indentation is consistent with the Linux
kernel coding style and clang no longer warns.

Fixes: 41f04d852e35 ("[PATCH] ext2: fix mounts at 16T")
Link: https://github.com/ClangBuiltLinux/linux/issues/827
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Adjust link to point to the right issue.

 fs/ext2/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 8643f98e9578..4a4ab683250d 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -1073,9 +1073,9 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 
 	if (EXT2_BLOCKS_PER_GROUP(sb) == 0)
 		goto cantfind_ext2;
- 	sbi->s_groups_count = ((le32_to_cpu(es->s_blocks_count) -
- 				le32_to_cpu(es->s_first_data_block) - 1)
- 					/ EXT2_BLOCKS_PER_GROUP(sb)) + 1;
+	sbi->s_groups_count = ((le32_to_cpu(es->s_blocks_count) -
+				le32_to_cpu(es->s_first_data_block) - 1)
+					/ EXT2_BLOCKS_PER_GROUP(sb)) + 1;
 	db_count = (sbi->s_groups_count + EXT2_DESC_PER_BLOCK(sb) - 1) /
 		   EXT2_DESC_PER_BLOCK(sb);
 	sbi->s_group_desc = kmalloc_array (db_count,
-- 
2.24.1

