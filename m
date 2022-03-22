Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7904E3725
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Mar 2022 04:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbiCVDCD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Mar 2022 23:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235761AbiCVDB7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Mar 2022 23:01:59 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C163CC079
        for <linux-ext4@vger.kernel.org>; Mon, 21 Mar 2022 20:00:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 25A7A1F41054
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647918032;
        bh=Tx1VCof8d5xVQ2X1dQ+CXCV8k1m84bsTT2v1ZSmYgKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mT3VhGo0OF5Oje5JSQDFh9aLAuaR2yow24oQk1pUUyMeXaHREW9HzYr+kVs7zyoRP
         m8r00JXv8/J+1RCZRKiZJWRoDigsCneKVf1U7tw+TGytGjoO8p7A3LM0AzOYcSv0Vl
         LCbdgAkP/qX1m0wfWrUbNL2RyffdICIBQZAKxUQfmwzRT336Q1DeiXPEqBf1wGFE3q
         bFXETyhE2DjhzfGeiYxkymX5hxXjGSQY2QVDDQjiRPmpBCwjZ/HIoT3hHg+YGHslMo
         JHTUsqXwPjqdU5RK9CynA9Gx73UTQiapgWTxNODulHDfelRc5Z/B2rZ5/UkKr/y1L5
         /aNt143Ng1yig==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu
Cc:     ebiggers@kernel.org, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 5/5] ext4: Log error when lookup of encoded dentry fails
Date:   Mon, 21 Mar 2022 23:00:04 -0400
Message-Id: <20220322030004.148560-6-krisman@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322030004.148560-1-krisman@collabora.com>
References: <20220322030004.148560-1-krisman@collabora.com>
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
 fs/ext4/namei.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 8520115cd5c2..c321c6fdb4ae 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1456,6 +1456,9 @@ static bool ext4_match(struct inode *parent,
 			 * only case where it happens is on a disk
 			 * corruption or ENOMEM.
 			 */
+			if (ret == -EINVAL)
+				EXT4_ERROR_INODE(parent,
+						 "Bad encoded file in directory");
 			return false;
 		}
 		return ret;
-- 
2.35.1

