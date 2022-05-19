Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2F752C95B
	for <lists+linux-ext4@lfdr.de>; Thu, 19 May 2022 03:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiESBlo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 May 2022 21:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiESBlY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 May 2022 21:41:24 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FD96C0C6
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 18:41:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 3E05C1F45360
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652924482;
        bh=j8df1m1ueLIlcWV9hGb6El2JjRXuC81I9Nolg4K+vGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S4f3LpbjQilmM/4gPEAXf//62irWB+u+G4oJcb7xk0RELrFoaNa5wfnZny7cgGUBW
         dD8k36a5HJxHKdeic6ZFNrKApaoB5lsvhyejXH9aeIWZdk+So1FoPt3Juo+Q3/NFpn
         WjpPVOsjGh+H1AfgsetAw2g7TVxSe6Iin6D0X6Eel5BUL71OjoddbpwRQp+b099z1A
         AQGBkBKRbQmBzPMUdEH9m6yQm1nnrWX1NUo6xu/WYeIjnJ+tDYgSA+Aj14e9Fi/qz7
         4/y6StMqgSXKC2J55sdyRJgW6ZGSo5WkTbPbR1vQO39XiBl7vQ0v7PExAwxtB4ODUg
         jcY5Ha5cviYjw==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        ebiggers@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Eric Biggers <ebiggers@google.com>
Subject: [PATCH v6 6/8] ext4: Log error when lookup of encoded dentry fails
Date:   Wed, 18 May 2022 21:40:42 -0400
Message-Id: <20220519014044.508099-7-krisman@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220519014044.508099-1-krisman@collabora.com>
References: <20220519014044.508099-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If the volume is in strict mode, ext4_ci_compare can report a broken
encoding name.  This will not trigger on a bad lookup, which is caught
earlier, only if the actual disk name is bad.

Reviewed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---

changes since v4:
  - Reword error message (Eric)

Changes since v1:
  - reword error message "file in directory" -> "filename" (Eric)
---
 fs/ext4/namei.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 98295b03a57c..8fbb35187f72 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1396,6 +1396,9 @@ static bool ext4_match(struct inode *parent,
 			 * only case where it happens is on a disk
 			 * corruption or ENOMEM.
 			 */
+			if (ret == -EINVAL)
+				EXT4_ERROR_INODE(parent,
+					"Directory contains filename that is invalid UTF-8");
 			return false;
 		}
 		return ret;
-- 
2.36.1

