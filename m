Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6146F52C165
	for <lists+linux-ext4@lfdr.de>; Wed, 18 May 2022 19:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240982AbiERRX6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 May 2022 13:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240979AbiERRXy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 May 2022 13:23:54 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A2D1A4917
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 10:23:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id DE34A1F4549A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652894632;
        bh=wEtELicV/Q3JgBPpviNuE9QAVFCxhQ4MrH/zciZ2jSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JvDD9PqGqVe9idcKeP/5BPsrOm30CD3qFzcJrCRWAjz6XyTG5aTIpiQXcW0Rtq74H
         aQWcU7xpburVefpdH22KFhdKdYSoWfe97I4Xw37WDbzPRPLFLvTL0c40IIuDepAx1O
         gvIpzJoXEadbJVxKVd4AjPPHxcDG61CU88q+X/61DSEBi70F03KnRMoa5eeZCf3v3T
         Xk96TiP6hulALd447W9eaqF7EStmqe8rX2imRkCM8SP/sRSfTHVZyO9g20vribizso
         Bk5AZJ5vumlWhAHDkVLs5CRi38SxSpm4NvRIcwKDMT3sDXUs1nSQ937J3OGFA9weFG
         F/Lgp3l7t3h3Q==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        ebiggers@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v5 6/8] ext4: Log error when lookup of encoded dentry fails
Date:   Wed, 18 May 2022 13:23:18 -0400
Message-Id: <20220518172320.333617-7-krisman@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220518172320.333617-1-krisman@collabora.com>
References: <20220518172320.333617-1-krisman@collabora.com>
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

