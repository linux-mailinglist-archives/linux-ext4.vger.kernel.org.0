Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A975252DF3E
	for <lists+linux-ext4@lfdr.de>; Thu, 19 May 2022 23:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241079AbiESVYe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 May 2022 17:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245175AbiESVY2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 May 2022 17:24:28 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B0EED8C5
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 14:24:27 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id E6A6A1F45F78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652995466;
        bh=4aprNls1SIrgCGEknan+1QCNSFzZMfaiFkY311lbaUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CdLJ3EH/R8kH5XGpI1nmoLA1vvT4Nnb5wGKg+awNGoFswzJVpWnNnKWaYYxl3N72D
         Xk2hwjVb+mjLFKxqCl7TirLD0AWI+prsAKYxojlOQCmz+E58wTRNVRs8cUaSGUMKKe
         e6yDA2bD2D5nvCCQQsefwILcSvnPdH9w5XhHWoQAtIJPf9zZzs040cx/aF1M9sGf4u
         0MUTVZVQUlpIJ/XZSTEap5dv6OMxMdQ6fzHs7M/Bbew1h11GRsItVKgYvduoPARt2W
         xL1A40DJjEcspoC6+nJhL4YC/RXCvFk0lgBfJSqWaD99S3R1m7V/1zUBCxPZu98T9S
         p07MczN/we8jw==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        ebiggers@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Eric Biggers <ebiggers@google.com>
Subject: [PATCH v8 6/8] ext4: Log error when lookup of encoded dentry fails
Date:   Thu, 19 May 2022 17:23:57 -0400
Message-Id: <20220519212359.19442-7-krisman@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220519212359.19442-1-krisman@collabora.com>
References: <20220519212359.19442-1-krisman@collabora.com>
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
index eaf383740965..708c241b23ec 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1406,6 +1406,9 @@ static bool ext4_match(struct inode *parent,
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

