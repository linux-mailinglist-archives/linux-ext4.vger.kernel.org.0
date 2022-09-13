Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154845B7DA0
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Sep 2022 01:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiIMXm0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Sep 2022 19:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiIMXmZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Sep 2022 19:42:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9642743606
        for <linux-ext4@vger.kernel.org>; Tue, 13 Sep 2022 16:42:24 -0700 (PDT)
Received: from localhost (modemcable141.102-20-96.mc.videotron.ca [96.20.102.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: krisman)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3046E6602024;
        Wed, 14 Sep 2022 00:42:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663112543;
        bh=gGSyEUDYeLCnC3+4gmoON9rz46oKzm7qQXXp3d6fhOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g40DmvHnSB/vv232nUN/wN2D4qLR3XHL8VLmDg17kXRG48tO0F4PmSZLU08cUCjIb
         u6qBIRiJqZsjn67sLC7Yne808Q5tl5w0gmt95duZM9v6QNXr7emsdh78lkrpviJ+cC
         LDwDSXRQgEZyexetcjY2puq71Sz+8LrCjp+BuCW9a2xhR87FAGjfWe8zgicPIecpyt
         QE08gwqdi+bVDFjmq028/4j65bFoOo6fjToWvP4j4YIAgEaEKGPyFEb02YQ4FhJEAF
         Mnas0AZb7iY7f0Iubka1SF7hqbwaSWlOUgw4Go5Kg5ZBCEmw9/xnOk40H1Gn0AtdM/
         QdiiMPYgb192g==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        ebiggers@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Eric Biggers <ebiggers@google.com>
Subject: [PATCH v9 6/8] ext4: Log error when lookup of encoded dentry fails
Date:   Tue, 13 Sep 2022 19:41:48 -0400
Message-Id: <20220913234150.513075-7-krisman@collabora.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220913234150.513075-1-krisman@collabora.com>
References: <20220913234150.513075-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 9c892c58abf2..959346950b3c 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1452,6 +1452,9 @@ static bool ext4_match(struct inode *parent,
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
2.37.3

