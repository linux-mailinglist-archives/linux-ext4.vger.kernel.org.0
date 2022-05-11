Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10241523D89
	for <lists+linux-ext4@lfdr.de>; Wed, 11 May 2022 21:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346901AbiEKTcR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 May 2022 15:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346906AbiEKTcP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 May 2022 15:32:15 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F5D275E9
        for <linux-ext4@vger.kernel.org>; Wed, 11 May 2022 12:32:13 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id A23651F42914
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652297531;
        bh=TjgXhAZ/MBxjUpu+HmWWAjpjE8dWN7hkqM2SLl+MDBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VvnzLQ74hbS+WXZ8pHwFFxiMw0z8L3tIEV0a8oPFrq/dlkcMT9D8372goZdjjIiL1
         U4Nd1VmivnTjUYHsQz6MOQ8gZg13qS5w+7EMeZmjC1obOQzoVroUZqfLP/n45isJk2
         I9CBQr9sUzcFNiAcVAjvy+t/2wavw/087SmnsbJ1O2SL9U/ViXomrHFsNDykUkUf3N
         e4kYN2nrO3Z1BXZmPNTWqYjX8Tn/ohS73l8HSFpKng0/2a48pcXTKyZYQTN0wcSvSk
         xrYfXD/T/dUbyZ+01yqCVH1ONS1KhWF8rbZg/i7ETUMb9oWGlGNbgFa3lA7JJMA2dJ
         o4i93sxDxfzEw==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        ebiggers@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v4 05/10] ext4: Simplify hash check on ext4_match
Date:   Wed, 11 May 2022 15:31:41 -0400
Message-Id: <20220511193146.27526-6-krisman@collabora.com>
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

The existence of fname->cf_name.name requires s_encoding & IS_CASEFOLDED,
therefore this can be simplified.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/ext4/namei.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 5296ced2e43e..cebbcabf0ff0 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1438,25 +1438,19 @@ static bool ext4_match(struct inode *parent,
 #endif
 
 #if IS_ENABLED(CONFIG_UNICODE)
-	if (parent->i_sb->s_encoding && IS_CASEFOLDED(parent) &&
-	    (!IS_ENCRYPTED(parent) || fscrypt_has_encryption_key(parent))) {
+	if (IS_ENCRYPTED(parent) && fname->cf_name.name) {
+		if (fname->hinfo.hash != EXT4_DIRENT_HASH(de) ||
+		    fname->hinfo.minor_hash != EXT4_DIRENT_MINOR_HASH(de))
+			return false;
+	}
+
+	if (parent->i_sb->s_encoding && IS_CASEFOLDED(parent)) {
 		struct unicode_name u = {
 			.folded_name = &fname->cf_name,
 			.usr_name = fname->usr_fname
 		};
 		int ret;
 
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
-
 		ret = ext4_match_ci(parent, &u, de->name, de->name_len);
 		if (ret < 0) {
 			/*
-- 
2.36.1

