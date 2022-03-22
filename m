Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7FD4E3718
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Mar 2022 04:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235756AbiCVDCC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Mar 2022 23:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235759AbiCVDB4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Mar 2022 23:01:56 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97363CCCC3
        for <linux-ext4@vger.kernel.org>; Mon, 21 Mar 2022 20:00:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 4FE281F413D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647918028;
        bh=kqkciCrqxPaGMYalJ3yGrHWLeiWSTcQ+ToF7JIySmPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WbonEwN4BS3rmF3IbyukzEHZv97o/vcmyOCI9J1lOz9QzDLuF67Rw44UzhTBoytFN
         xpdEIwoZy9qe+Nd1AsjdwNv3YemErR5E1Z98rp2Z5OPdjohMw4sMapG7wWcU1PP7aS
         AxwELfHdpCX3KSKTho6xTlY0CNkMIXoxsd9GDK+FSOWeG1bkaSNCwYYqGrPrgtnMiN
         375/wwPZo5XaBEr9wgns2pui15yMWg2q+VBZNd6+blmfT+w/0T1XbmbGlhH9MbBW1I
         5eFUJiyfaw9F6yve3ycFpsKbP6f9QERxnCWt/TfQcFmAFRDY7RaQEoCDYLJauCit8E
         oGnQXGUPaEUqg==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu
Cc:     ebiggers@kernel.org, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 4/5] ext4: Simplify hash check on ext4_match
Date:   Mon, 21 Mar 2022 23:00:03 -0400
Message-Id: <20220322030004.148560-5-krisman@collabora.com>
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

The existence of fname->cf_name.name requires s_encoding & IS_CASEFOLDED,
therefore this can be simplified.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/ext4/namei.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 71b4b05fae89..8520115cd5c2 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1442,19 +1442,13 @@ static bool ext4_match(struct inode *parent,
 #if IS_ENABLED(CONFIG_UNICODE)
 	f.cf_name = fname->cf_name;
 
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
 		ret = ext4_ci_compare(parent, &f, de->name, de->name_len);
 		if (ret < 0) {
 			/*
-- 
2.35.1

