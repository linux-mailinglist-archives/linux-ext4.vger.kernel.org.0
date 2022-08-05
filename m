Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A77B58B169
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Aug 2022 23:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbiHEVwt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Aug 2022 17:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbiHEVwe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Aug 2022 17:52:34 -0400
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D33211
        for <linux-ext4@vger.kernel.org>; Fri,  5 Aug 2022 14:52:32 -0700 (PDT)
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
        by cmsmtp with ESMTP
        id JwWZo77tGS8WrK5FAoKVkJ; Fri, 05 Aug 2022 21:52:32 +0000
Received: from webber.adilger.int ([174.0.67.248])
        by cmsmtp with ESMTP
        id K5F9oox13uJwwK5F9oiiMa; Fri, 05 Aug 2022 21:52:32 +0000
X-Authority-Analysis: v=2.4 cv=F+BEy4tN c=1 sm=1 tr=0 ts=62ed9120
 a=5skvQWjG3xExD1Ft+FuDHA==:117 a=5skvQWjG3xExD1Ft+FuDHA==:17 a=lB0dNpNiAAAA:8
 a=RPJ6JBhKAAAA:8 a=6B9pKRKXe6hBbKI7uUAA:9 a=c-ZiYqmG3AbHTdtsH08C:22
 a=fa_un-3J20JGBB2Tu-mn:22
From:   Andreas Dilger <adilger@dilger.ca>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Li Dongyang <dongyangli@ddn.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH v2] debugfs: allow <inode> for ncheck
Date:   Fri,  5 Aug 2022 15:52:21 -0600
Message-Id: <20220805215221.11801-1-adilger@dilger.ca>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfPiuxU+rPkr1k5Di9ZjRsYkL2lhXqq6IT5hZb6lwcNGtENZGaPn73KHuvMubZMLD76inF4ux44mUe6OkBaOtRU04EWI3dgRdABAufWbK9vzFqxFykFaA
 Tr2t7XTFlKtURDZ80NZuTLvJOak6Ve+hwAouklHWBHxMUMnlVf7AmJ9CWHpeI9DSseF1Ytt+LgOGfChecZNwSD7hzFov9u01K+sNaB/8v+QzsdqdHXtgYMra
 S/Q7wbxcrj8Sj6XNNExpAcXpjzm6coNSi0SWCy5EICg=
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Dongyang <dongyangli@ddn.com>

If the ncheck argument is of the form "<ino>", allow it for ncheck
for consistency with other commands that accept an inode number.

Improve the error message, use "Invalid inode number" instead
of "Bad inode", which implies the inode content being bad.

Signed-off-by: Li Dongyang <dongyangli@ddn.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
---
 debugfs/ncheck.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

v2: don't modify argv[] during parsing

diff --git a/debugfs/ncheck.c b/debugfs/ncheck.c
index 011f26de..963b3a12 100644
--- a/debugfs/ncheck.c
+++ b/debugfs/ncheck.c
@@ -134,9 +134,15 @@ void do_ncheck(int argc, char **argv, int sci_idx EXT2FS_ATTR((unused)),
 
 	iw.names_left = 0;
 	for (i=0; i < argc; i++) {
-		iw.iarray[i] = strtol(argv[i], &tmp, 0);
-		if (*tmp) {
-			com_err("ncheck", 0, "Bad inode - %s", argv[i]);
+		char *str = argv[i];
+		int len = strlen(str);
+
+		if ((len > 2) && (str[0] == '<') && (str[len - 1] == '>'))
+			str++;
+		iw.iarray[i] = strtol(str, &tmp, 0);
+		if (*tmp && (str == argv[i] || *tmp != '>')) {
+			com_err("ncheck", 0, "Invalid inode number - '%s'",
+				argv[i]);
 			goto error_out;
 		}
 		if (debugfs_read_inode(iw.iarray[i], &inode, *argv))
-- 
2.25.1

