Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008B04C81F8
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Mar 2022 05:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiCAELU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Feb 2022 23:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbiCAELT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Feb 2022 23:11:19 -0500
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897E458E49
        for <linux-ext4@vger.kernel.org>; Mon, 28 Feb 2022 20:10:38 -0800 (PST)
Received: from shw-obgw-4004a.ext.cloudfilter.net ([10.228.9.227])
        by cmsmtp with ESMTP
        id OohUneddugTZYOtqPn7Pq4; Tue, 01 Mar 2022 04:10:37 +0000
Received: from webber.adilger.int ([70.77.221.9])
        by cmsmtp with ESMTP
        id OtqOnaCNOd7RfOtqOn6iX2; Tue, 01 Mar 2022 04:10:37 +0000
X-Authority-Analysis: v=2.4 cv=XrLphHJ9 c=1 sm=1 tr=0 ts=621d9cbd
 a=2Y6h5+ypAxmHcsumz2f7Og==:117 a=2Y6h5+ypAxmHcsumz2f7Og==:17 a=lB0dNpNiAAAA:8
 a=ySfo2T4IAAAA:8 a=bp1g5Iz1D7c7guLF1_8A:9 a=c-ZiYqmG3AbHTdtsH08C:22
 a=ZUkhVnNHqyo2at-WnAgH:22
From:   Andreas Dilger <adilger@whamcloud.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@whamcloud.com>,
        Li Dongyang <dongyangli@ddn.com>
Subject: [PATCH] debugfs: allow <inode> for ncheck
Date:   Mon, 28 Feb 2022 21:10:31 -0700
Message-Id: <20220301041031.74615-1-adilger@whamcloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfIrbhwfxFXViWRF3OTDlz/Rx8pW0SfMHfXlxYgc9EytuYmBni4/EdVcKN7FClityQ1h3bSmnxBH3NWx53hYa+sVPIgvXsmD1APxGm8t4IxF+0761BeC3
 GNvE22ehN7nR68XTMdRi6EqtmLSTadST44x50taVhd3xcaun8AzLS6dLv95HXE3mM5pN+jFMfmZ7guk+uEg1rCbDQdArJaG7QMBSkqK32L3Mold1rR0yX237
 Q13lrLdoX61IvqmAPmgZq3Y5eo1d0nP1hWEZvzN62i/HVC/UPsYMrvgAPiMtVTwz
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If the arg string is of the form <ino>, allow it for ncheck.
Improve the error message, use "Invalid inode number" instead
of "Bad inode", which implies the inode content being bad.

Signed-off-by: Li Dongyang <dongyangli@ddn.com>
Reviewed-by: Andreas Dilger <adilger@whamcloud.com>
---
 debugfs/ncheck.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/debugfs/ncheck.c b/debugfs/ncheck.c
index 011f26de..3be4be19 100644
--- a/debugfs/ncheck.c
+++ b/debugfs/ncheck.c
@@ -134,9 +134,21 @@ void do_ncheck(int argc, char **argv, int sci_idx EXT2FS_ATTR((unused)),
 
 	iw.names_left = 0;
 	for (i=0; i < argc; i++) {
-		iw.iarray[i] = strtol(argv[i], &tmp, 0);
+		char *str = argv[i];
+		int len = strlen(str);
+
+		if ((len > 2) && (str[0] == '<') && (str[len-1] == '>')) {
+			str[len-1] = '\0';
+			str++;
+		}
+		iw.iarray[i] = strtol(str, &tmp, 0);
 		if (*tmp) {
-			com_err("ncheck", 0, "Bad inode - %s", argv[i]);
+			if (str != argv[i]) {
+				str--;
+				str[len-1] = '>';
+			}
+			com_err("ncheck", 0, "Invalid inode number - '%s'",
+				argv[i]);
 			goto error_out;
 		}
 		if (debugfs_read_inode(iw.iarray[i], &inode, *argv))
-- 
2.25.1

