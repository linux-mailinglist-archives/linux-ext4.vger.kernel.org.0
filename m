Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0006A51539E
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Apr 2022 20:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380001AbiD2SbJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 Apr 2022 14:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379999AbiD2SbI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 29 Apr 2022 14:31:08 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864C5D0A9A
        for <linux-ext4@vger.kernel.org>; Fri, 29 Apr 2022 11:27:49 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 34B121F4690E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651256868;
        bh=vyo85rNwnnFuylcqfkeboay433CDn2ax39QHFWTvwF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RCO+2/FxtCBYHu2qhWtiVijJUlzxz/TWeSsMvp75eB/bjEvtQBsqXHtBCpGTXF4Qn
         +yjh2228/DQAdAWqhStXBZrI1QryIL1Ww+NviYYyloUURGneyypXTdtYA/66pRKuj8
         YXkcgZhdILFdXIFcuJE4BYINPZYtdiCN70NlZbg3n7f8+DSO4bIDSjyK8ghMhPZP1F
         2/ZB5y7x0er6kUqKrbWvf3gbt7hGgn0gXYq4Taex3m5je5O/DaoMDq/cCvN6sTQYUr
         LG4MrQrmnK8nSfZ/6vlCpEAJO84/OhLq/pKpR0i5UNRgfbsqUQqsBpcEtkLFVqij6J
         1viXzoquRIqoQ==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        ebiggers@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 4/7] ext4: Simplify hash check on ext4_match
Date:   Fri, 29 Apr 2022 14:27:25 -0400
Message-Id: <20220429182728.14008-5-krisman@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429182728.14008-1-krisman@collabora.com>
References: <20220429182728.14008-1-krisman@collabora.com>
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

The existence of fname->cf_name.name requires s_encoding & IS_CASEFOLDED,
therefore this can be simplified.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/ext4/namei.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 5102652b5af4..e450e52eef48 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1440,19 +1440,13 @@ static bool ext4_match(struct inode *parent,
 #endif
 
 #if IS_ENABLED(CONFIG_UNICODE)
-	if (parent->i_sb->s_encoding && IS_CASEFOLDED(parent) &&
-	    (!IS_ENCRYPTED(parent) || fscrypt_has_encryption_key(parent))) {
-		if (fname->cf_name.name) {
-			if (IS_ENCRYPTED(parent)) {
-				if (fname->hinfo.hash != EXT4_DIRENT_HASH(de) ||
-					fname->hinfo.minor_hash !=
-						EXT4_DIRENT_MINOR_HASH(de)) {
-
-					return false;
-				}
-			}
-		}
+	if (IS_ENCRYPTED(parent) && fname->cf_name.name) {
+		if (fname->hinfo.hash != EXT4_DIRENT_HASH(de) ||
+		    fname->hinfo.minor_hash != EXT4_DIRENT_MINOR_HASH(de))
+			return false;
+	}
 
+	if (parent->i_sb->s_encoding && IS_CASEFOLDED(parent)) {
 		u.folded_name = &fname->cf_name;
 		u.usr_name = fname->usr_fname;
 
-- 
2.35.1

