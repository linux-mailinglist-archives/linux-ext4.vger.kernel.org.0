Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B4F3DBE7E
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Jul 2021 20:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhG3Srh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 30 Jul 2021 14:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhG3Srg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 30 Jul 2021 14:47:36 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65E1C06175F
        for <linux-ext4@vger.kernel.org>; Fri, 30 Jul 2021 11:47:30 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y34so19740466lfa.8
        for <linux-ext4@vger.kernel.org>; Fri, 30 Jul 2021 11:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=x5NVT8YFWCDgQ8roI3A7Za7B6QOMAcHjIVGvChEUK1c=;
        b=mhf8ucvWqHEBcPgvUvx/DyTPtztkD7RUwYxh1AJegGyW5of+mPi9a9SPHQFUIVE58D
         lokpDTME/tUkKqrcAA75inomXqzyl02GbKcUS3dFSxZfNGabM3F1YJ2oPOVrHAmFZQkA
         96+GMK6iV+z/+qegPHUPzYbR8rt6DmGHfcQR5wdj0BAsbu/glAKHk+3P2pkQ+BeH+lTs
         Zx96zs39WAUVRXtB8rKuY0Ol92RYxY3+lohDCC5Hfm5ZStJZ3N5/6azl9CEpzSrXK2X8
         kIZjHpcKwrVlNrEVkTzyxHEcqAwnCqmMrp8h9mpbwK4QhSwd9U+NfcQBSx1/Zh/5R7Jy
         mt6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x5NVT8YFWCDgQ8roI3A7Za7B6QOMAcHjIVGvChEUK1c=;
        b=gJkrHn6B2O6+LCMbtteaaUR+oRsTHyeV382hVhOKHXUqwBb5Qz8SBRT1MhoQauEPOY
         srAN8g6mYGsZ4mqojFKDjn04ncKzGcKZRoTBB5Epw+lB9/hMJB5fOgY+PwNTmEH7QnSq
         7L5B/9m88CoBsNCV8sC6AeRU8AwtGkbYJk3gx8bpmmxbQ0BrYpkT9EkW4umwxOYP02jE
         SzeSRFGxe/1T05wSv1gpYhko0cPhiPPjOBrvyBUpQuc6idZE7b/tPpyRWD13ixElPBr8
         /I6r12Lc4o+DztYtsgHyMWVGZKUCddDQjI4CbvcmP9h/OQ2xX6WndclmmyX1j1QZtmy2
         vX6g==
X-Gm-Message-State: AOAM5313jmzjKdJHD9lKoin2urP57cjn1lI7M39JqKNzdUqECLmPVNLE
        k3Dmmy/Y06Y5ZIyEmqD/wmjB7qgrMMxqVWJk
X-Google-Smtp-Source: ABdhPJwZ7Ub8qNd0vXfmd0QXXVSi6ESMGPWHX8qusEemvXe9C00BVm4+TtnACqGWO8Y/JdPzIQL1+g==
X-Received: by 2002:ac2:5684:: with SMTP id 4mr2853362lfr.386.1627670848866;
        Fri, 30 Jul 2021 11:47:28 -0700 (PDT)
Received: from localhost.localdomain ([62.33.81.195])
        by smtp.gmail.com with ESMTPSA id n8sm212944lfk.198.2021.07.30.11.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 11:47:28 -0700 (PDT)
From:   Artem Blagodarenko <artem.blagodarenko@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger.kernel@dilger.ca,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>,
        Denis Lukianov <denis@voxelsoft.com>
Subject: [PATCH] ext4: fix directory index node split corruption
Date:   Fri, 30 Jul 2021 14:24:03 -0400
Message-Id: <20210730182403.3254365-1-artem.blagodarenko@gmail.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I send patch whose author is Denis Lukianov <denis@voxelsoft.com>
His messages can't reach this list somehow.
I only rebased it ontop of master's HEAD and tested that it fixes
the problem and reviewed.

----

Following commit b5776e7, a trivial sequential write of empty files to
an empty ext4 file system (with large_dir enabled) fails after just
over 26 million files. Depending on luck, file creation will give error
EEXIST or EUCLEAN.

Commit b5776e7 fixed the no-restart condition so that
ext4_handle_dirty_dx_node is always called, but it also broke the
restart condition. This is because when restart=1, the original
implementation correctly skipped do_split() but b5776e7 clobbered the
"if(restart)goto journal_error;" logic.

This complementary change protects do_split() from restart condition,
making it safe from both current and future ordering of goto statements
in earlier sections of the code.

Tested on 5.11.20 with handy testing script:

i = 0
while i <= 32000000:
    print (i)
    with open('tmpmnt/%d' % i, 'wb') as fout:
        i += 1

Google-Bug-Id: 176345532
Fixes: b5776e7 ("ext4: fix potential htree index checksum corruption")
Signed-off-by: Denis Lukianov <denis@voxelsoft.com>
Signed-off-by: Artem Blagodarenko <artem.blagodarenko@gmail.com>
---
 fs/ext4/namei.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 5fd56f616cf0..0bbff03d4167 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2542,13 +2542,16 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 			goto journal_error;
 		}
 	}
-	de = do_split(handle, dir, &bh, frame, &fname->hinfo);
-	if (IS_ERR(de)) {
-		err = PTR_ERR(de);
+	if (!restart) {
+		de = do_split(handle, dir, &bh, frame, &fname->hinfo);
+		if (IS_ERR(de)) {
+			err = PTR_ERR(de);
+			goto cleanup;
+		}
+		err = add_dirent_to_buf(handle, fname, dir, inode, de,
+bh);
 		goto cleanup;
 	}
-	err = add_dirent_to_buf(handle, fname, dir, inode, de, bh);
-	goto cleanup;
 
 journal_error:
 	ext4_std_error(dir->i_sb, err); /* this is a no-op if err == 0 */
-- 
2.18.4

