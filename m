Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE80523D88
	for <lists+linux-ext4@lfdr.de>; Wed, 11 May 2022 21:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346906AbiEKTcS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 May 2022 15:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346890AbiEKTcQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 May 2022 15:32:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4627560D6
        for <linux-ext4@vger.kernel.org>; Wed, 11 May 2022 12:32:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id E7FDB1F42934
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652297535;
        bh=c75v2/ZUWH6IoljcFit0bLWBPzrmfaQjfZFWk4rflVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EBsuGOrJmRxDdIL3UVqqU1yAN4lBgbgq3f8FZQzAAkij6aNfupt4PWtsdjafYk+AL
         UAlPlzykOGpCkQS6d0KXu0g4zVJKXL5QvDli3p68k7QsMe+poeKeDe7fzHLc6VuER/
         fQS0cHMVZRKaIy9d1TCZ2eP/WmNLbWM1jtEWU3U5Q6YnGA46jJqxFwRnWB2FnF0ujv
         VzBvAKosu0i/B2aZY8KjbvKgrLhfRoKv7d2j4auiW6eaO7qySxbzywY3+XpUQBqcEH
         hYVzRf06Fo4NruE2WwNDsV8uFu08G65aiCJ3ikI2bOgLGCPt7le7ACMu6Lk5e2w2wA
         DL82qOXaPSZvA==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        ebiggers@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v4 06/10] ext4: Log error when lookup of encoded dentry fails
Date:   Wed, 11 May 2022 15:31:42 -0400
Message-Id: <20220511193146.27526-7-krisman@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220511193146.27526-1-krisman@collabora.com>
References: <20220511193146.27526-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If the volume is in strict mode, ext4_ci_compare can report a broken
encoding name.  This will not trigger on a bad lookup, which is caught
earlier, only if the actual disk name is bad.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---

Changes since v1:
  - reword error message "file in directory" -> "filename" (Eric)
---
 fs/ext4/namei.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index cebbcabf0ff0..708811525411 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1458,6 +1458,9 @@ static bool ext4_match(struct inode *parent,
 			 * only case where it happens is on a disk
 			 * corruption or ENOMEM.
 			 */
+			if (ret == -EINVAL)
+				EXT4_ERROR_INODE(parent,
+						 "Bad encoded filename");
 			return false;
 		}
 		return ret;
-- 
2.36.1

