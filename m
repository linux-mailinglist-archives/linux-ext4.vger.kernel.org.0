Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D1E513E5D
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Apr 2022 00:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352813AbiD1WOP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Apr 2022 18:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352823AbiD1WOO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Apr 2022 18:14:14 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D065F675
        for <linux-ext4@vger.kernel.org>; Thu, 28 Apr 2022 15:10:58 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id D8F511F45D0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651183857;
        bh=oEaF20C4aIC1tZklEgboa5zDbpP1I68FAiSAwW9buHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RCpa9jsKeh49uyWEV1DIo9vGHIb4/arIqLxlGcSCvU5xXADcs32JgWnHKTDZNE1At
         OSJekJE5+xrmM3ptcvT1oTvdk1nEm7GpZ8yJmbcdaFVXsigLjE7u1b3xIwwTud2ioK
         bz7X3VY1RLyodR0HCA+bNiIx4C2evT2KOCzbokNmaya8a6oHFaTk186GC0u1puaS/w
         qe+DiHU0ElUbYrKFsllyisSFJxC6So9I++jFTOuj/lRWVNHhiA/JIRH8NLZKO792tK
         CJNK80c9lPTXtjUUFdhTrslmQrlQ3Jdsc6t4WpKc62EI/CXOnDEnDRkFLQTor1kiNa
         F+Uhlz6b6SEPw==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        ebiggers@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v2 5/7] ext4: Log error when lookup of encoded dentry fails
Date:   Thu, 28 Apr 2022 18:10:25 -0400
Message-Id: <20220428221027.269084-6-krisman@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428221027.269084-1-krisman@collabora.com>
References: <20220428221027.269084-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
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
index e450e52eef48..d53c8d101099 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1457,6 +1457,9 @@ static bool ext4_match(struct inode *parent,
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
2.35.1

