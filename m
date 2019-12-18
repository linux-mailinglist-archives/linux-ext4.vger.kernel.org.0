Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 204E1123DC1
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2019 04:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfLRDPZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Dec 2019 22:15:25 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:32842 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfLRDPY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Dec 2019 22:15:24 -0500
Received: by mail-ot1-f65.google.com with SMTP id b18so577592otp.0;
        Tue, 17 Dec 2019 19:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=czNP6LwPZnpp64axcSIR+6sFO5rvWfMnhX184ZSQgOY=;
        b=NX4eemyM8mAIvGccXgJOrjssc0/1t+Q47838F7o5vo5qOo8eoUEJNI2YtJ9QcH28pe
         /aPyYnBUJ9qK0Yn/P/BxOt+Dnzskdp/fuvsZ/3GeJAQvYlN1MYkgWU36MKlCsZLTOiLF
         pcidCJPdcIFRf5F5hFwLZcDOXpf5vGaYep+6ATNK6EWU7n4xIC6gF5dTNSgFlceFzyMB
         Z1Fzk6wD1R9+7itQJOdoL2tvcnEKHLz97VPE6A796DhVtYQBq6d+KHUPDyiv7b8OoXvM
         mfVPHchnnVQOlK1Ktgn4VUajokn/DmfRaWyWuYv+ERC5e60dRwlz/PmwaRaC95LOuqDP
         B9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=czNP6LwPZnpp64axcSIR+6sFO5rvWfMnhX184ZSQgOY=;
        b=ZSJRQnMiVcRzhpJLb+K3d3mg7wyZPF7JeRlWfz5lxOaq6KwI37lJW3vIqfsw1Ym7i6
         a8j+ZfuUYex1IbZB1FeLzFY+1Ujju1ZscmYxIdm0+9C7XYJZFK4jVENRXEjpKY9vMvBZ
         AjWtY+VSCEkTpHZE7xXAs5eO/em294d0O2gbT3QW08PVSqLDFVVXhmJGU2idr7cosCMB
         BGityXpsyxajC9NeVecR9N29/gi0bBUJSW8DUV23XI0IKSV920di3mA2dqR+7DRBP2En
         6W6n4TR/N8GD2GxStjjUe/Uyu1nIfbfpTwkZe8+rsSZHubHNnjWwOuITCEzfiXmgBlfH
         AXlg==
X-Gm-Message-State: APjAAAVfOmAwjlwriSGz8dCZue5kKwCSYcbn7WIL5aE3mWbwLVh+rFuN
        6GOuBO4+0NcMecUjkOAsjX0=
X-Google-Smtp-Source: APXvYqyjZg14MMTZxNXAFWEQjCxTro4b1w9dEs+q6ykIi0/tc95bdTMR202p1m2A/ouVDuIGc6d5fQ==
X-Received: by 2002:a05:6830:16c6:: with SMTP id l6mr141094otr.186.1576638923829;
        Tue, 17 Dec 2019 19:15:23 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id 97sm318300otx.29.2019.12.17.19.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 19:15:23 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jan Kara <jack@suse.com>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] ext2: Adjust indentation in ext2_fill_super
Date:   Tue, 17 Dec 2019 20:15:19 -0700
Message-Id: <20191218031519.15450-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.24.1
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
Link: https://github.com/ClangBuiltLinux/linux/issues/826
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
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

