Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E210692482
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Feb 2023 18:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjBJRdN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Feb 2023 12:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjBJRc7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Feb 2023 12:32:59 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA4B79B38
        for <linux-ext4@vger.kernel.org>; Fri, 10 Feb 2023 09:32:58 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id nd22so1398528qvb.1
        for <linux-ext4@vger.kernel.org>; Fri, 10 Feb 2023 09:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C5zOq428H1D60CWAtSM7G1bZGl/KkudBslCQRrHWevk=;
        b=FI03MuCWEb3Qy6NejBd9fHvuCkRuBnLpUDcxhXIjTdmQvtIWdlABtqeniFtc2TkZxE
         uJ+j+ujBH/PMX5vYJ8fRvm0fGA8HFfTWX1tA8LBXf/+lRcNC8sdzleugyWn/rAjFEoW1
         Fo+E7V2BZGcMELbjAqHQ3mThdigiBxhFsA7zPNVBbVY4AU6YbMaMcuZl6zyLbzo4Q3by
         Tj7PiIUCHNG7f8g0W+9jGgZPuG9kpBILfLf5tNp+tv33Ke0qH5qIra57sfOl5Vj3soG4
         2tNmiXY5eFUQ03kJ82EWdLaEgCqKK+xZvI/edZcjTbnT1Ua5vVz7oAYiwT/AL0PxVY5d
         o3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5zOq428H1D60CWAtSM7G1bZGl/KkudBslCQRrHWevk=;
        b=4kJsIMk1MbsXC3+i6K8uAh3rK82tnEiEBU1NRyXpJKhGzj2VgGEQ03JCrYGC4kkLrx
         1Y6lcOWtWfTjloCLpyiAHq2FeXpKIAi6jz7AFqJ0224it/sTCH8hXRmZtf+yWd3oIQoz
         NS2xCqob1CGKtRpxzO8fmKw2WbuF5IjgL8ll8bGF91wW/KieyFX/ozds55XZa6mNjEsg
         xWvSqJpddMEO8wB/HeY07uL1Zp27OUgbCTviS9R7Of9hlsopYRrlzxcyZBfO5D9h5SBy
         1PzS39EjYdaCANhFWwoD0X5+LgReRkfDXdBALdc2dTwCUUYi4gNXOMosnWoP7ocnzBMi
         vAtQ==
X-Gm-Message-State: AO0yUKV+1Q8bUe44dc9aX3Z3Vjgia6Pr3wDydkZuBU3ahX1EE+9Q7gc5
        mnfyoEiadVVV1iXgdyS4IJKG1xNfIWc=
X-Google-Smtp-Source: AK7set+iunKS6+dRonXdJDA1C5hk0xABp43sRdgxIhn+nEhasMQigjlwTugwpNkJonhPs11qmqo7YA==
X-Received: by 2002:ad4:5d69:0:b0:56e:8f5e:d9a2 with SMTP id fn9-20020ad45d69000000b0056e8f5ed9a2mr8836814qvb.27.1676050376937;
        Fri, 10 Feb 2023 09:32:56 -0800 (PST)
Received: from localhost.localdomain (h64-35-202-119.cntcnh.broadband.dynamic.tds.net. [64.35.202.119])
        by smtp.gmail.com with ESMTPSA id h186-20020a376cc3000000b006fc3fa1f589sm3843982qkc.114.2023.02.10.09.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 09:32:56 -0800 (PST)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH] ext4: fix RENAME_WHITEOUT handling for inline directories
Date:   Fri, 10 Feb 2023 12:32:44 -0500
Message-Id: <20230210173244.679890-1-enwlinux@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

A significant number of xfstests can cause ext4 to log one or more
warning messages when they are run on a test file system where the
inline_data feature has been enabled.  An example:

"EXT4-fs warning (device vdc): ext4_dirblock_csum_set:425: inode
 #16385: comm fsstress: No space for directory leaf checksum. Please
run e2fsck -D."

The xfstests include: ext4/057, 058, and 307; generic/013, 051, 068,
070, 076, 078, 083, 232, 269, 270, 390, 461, 475, 476, 482, 579, 585,
589, 626, 631, and 650.

In this situation, the warning message indicates a bug in the code that
performs the RENAME_WHITEOUT operation on a directory entry that has
been stored inline.  It doesn't detect that the directory is stored
inline, and incorrectly attempts to compute a dirent block checksum on
the whiteout inode when creating it.  This attempt fails as a result
of the integrity checking in get_dirent_tail (usually due to a failure
to match the EXT4_FT_DIR_CSUM magic cookie), and the warning message
is then emitted.

Fix this by simply collecting the inlined data state at the time the
search for the source directory entry is performed.  Existing code
handles the rest, and this is sufficient to eliminate all spurious
warning messages produced by the tests above.  Go one step further
and do the same in the code that resets the source directory entry in
the event of failure.  The inlined state should be present in the
"old" struct, but given the possibility of a race there's no harm
in taking a conservative approach and getting that information again
since the directory entry is being reread anyway.

Fixes: b7ff91fd030d ("ext4: find old entry again if failed to rename whiteout")

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 fs/ext4/namei.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index dd28453d6ea3..924e16b239e0 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1595,11 +1595,10 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 		int has_inline_data = 1;
 		ret = ext4_find_inline_entry(dir, fname, res_dir,
 					     &has_inline_data);
-		if (has_inline_data) {
-			if (inlined)
-				*inlined = 1;
+		if (inlined)
+			*inlined = has_inline_data;
+		if (has_inline_data)
 			goto cleanup_and_exit;
-		}
 	}
 
 	if ((namelen <= 2) && (name[0] == '.') &&
@@ -3646,7 +3645,8 @@ static void ext4_resetent(handle_t *handle, struct ext4_renament *ent,
 	 * so the old->de may no longer valid and need to find it again
 	 * before reset old inode info.
 	 */
-	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de, NULL);
+	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de,
+				 &old.inlined);
 	if (IS_ERR(old.bh))
 		retval = PTR_ERR(old.bh);
 	if (!old.bh)
@@ -3813,7 +3813,8 @@ static int ext4_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 			return retval;
 	}
 
-	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de, NULL);
+	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de,
+				 &old.inlined);
 	if (IS_ERR(old.bh))
 		return PTR_ERR(old.bh);
 	/*
-- 
2.30.2

