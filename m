Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6079661F2E9
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiKGMXs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbiKGMXn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:23:43 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D12262D
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:23:42 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id f63so10319692pgc.2
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cdp2EtBFym3wXOJtzcxo7hXulJYdnGAKwekrjG+zUb0=;
        b=ePuwIJfOiqNjLwnrs8fQXia1tSkKaWqHiYhh5rB4yQ12sIGpVnyt3zmvbyRgDsAdNf
         z0YBQL+b7ju2XA26nK5qoPPMu+184dsHxwI51AYPi53P8u+d+XR3cQnWmm4btU9DfSxs
         mc/lX+ORbQFAkT883VHP3oL9KzDOqj8FLwRSjOcxgkVba1+LBfAGU6dXQAFgQzsvtnlW
         +YR+nAonD1ZoNmAghRJuHuxUCVDMxZsloUPtVMO2t+51wnMetH/WN74QvjW+3X0m0E+t
         aaUWaOckzANtSBN3QPSptmGcXJJxSiKWE6KWi3gdsvur0hjlChT3A9Wwu3FoDsQLbXDE
         zW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cdp2EtBFym3wXOJtzcxo7hXulJYdnGAKwekrjG+zUb0=;
        b=nRjU2Geu5IEvK/p98yx2G1bqDUnG3jglWP/sSwJWMRcVVwSn0Ug6Dv6kO6iX/frvjC
         HD1iPvtkywW1OAIZaiUQg4I4+lHtNf1sMpQBcn7P1iWzcH9sINOuvTUkNby1wlRI7iPZ
         tblm+AE7MRA6mOe0VJ1fmW4a9PsleF915XZDtHgra0zhkd+vem2TJnO7U4TkZUGEr1DA
         cbu4qV+rZeNkhgLu7xbYUAEFb3g5Jny9KJqYUPBxwdb+DzxpUPADuZqeyQXLu7n4eO6M
         cKdq1ze++8El9JN7b35ipCdCpqZZiXyjIY+XAmr1m8YraR9boQJxj/ax/dfMacTJJqij
         Tjvw==
X-Gm-Message-State: ACrzQf2+3SnDyNbBci3WJru5FIEQqoXbv74o2WwP+PhjrkNRsqlnIoKm
        GFRz7kvnEChbKt9N0/eRHAs=
X-Google-Smtp-Source: AMsMyM7SiBE5gw5JRh8TXYttBoUlkk2cbbidTQZvuulWna9bPnulNpy9pSH+x1TLd4oxmj865c2LQg==
X-Received: by 2002:a63:f84c:0:b0:470:f04:5c81 with SMTP id v12-20020a63f84c000000b004700f045c81mr22790213pgj.143.1667823821654;
        Mon, 07 Nov 2022 04:23:41 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id ci11-20020a17090afc8b00b0020de216d0f7sm4223869pjb.18.2022.11.07.04.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:23:40 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv1 13/72] tst_badblocks: Add unit test to verify badblocks list merge api
Date:   Mon,  7 Nov 2022 17:51:01 +0530
Message-Id: <9442bf260312e78236353ce1976ea7edc519d1cf.1667822611.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667822611.git.ritesh.list@gmail.com>
References: <cover.1667822611.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add unit test to verify badblocks list merge api i.e.
ext2fs_badblocks_merge()

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 lib/ext2fs/tst_badblocks.c | 61 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 2 deletions(-)

diff --git a/lib/ext2fs/tst_badblocks.c b/lib/ext2fs/tst_badblocks.c
index b6e766ab..946de0ae 100644
--- a/lib/ext2fs/tst_badblocks.c
+++ b/lib/ext2fs/tst_badblocks.c
@@ -119,6 +119,40 @@ static void print_list(badblocks_list bb, int verify)
 	}
 }
 
+static void do_list_merge_verify(badblocks_list bb, badblocks_list bbm, int verify)
+{
+	errcode_t retval;
+	badblocks_iterate iter;
+	blk_t blk;
+	int i, ok;
+
+	retval = ext2fs_badblocks_merge(bb, bbm);
+	if (retval) {
+		com_err("do_list_merge_verify", retval, "while doing list merge");
+		return;
+	}
+
+	if (!verify)
+		return;
+
+	retval = ext2fs_badblocks_list_iterate_begin(bb, &iter);
+	if (retval) {
+		com_err("do_list_merge_verify", retval, "while setting up iterator");
+		return;
+	}
+
+	while (ext2fs_badblocks_list_iterate(iter, &blk)) {
+		retval = ext2fs_badblocks_list_test(bbm, blk);
+		if (retval == 0) {
+			printf(" --- NOT OK\n");
+			test_fail++;
+			return;
+		}
+	}
+	ext2fs_badblocks_list_iterate_end(iter);
+	printf(" --- OK\n");
+}
+
 static void validate_test_seq(badblocks_list bb, blk_t *vec)
 {
 	int	i, match, ok;
@@ -275,13 +309,13 @@ out:
 
 int main(int argc, char **argv)
 {
-	badblocks_list bb1, bb2, bb3, bb4, bb5;
+	badblocks_list bb1, bb2, bb3, bb4, bb5, bbm;
 	int	equal;
 	errcode_t	retval;
 
 	add_error_table(&et_ext2_error_table);
 
-	bb1 = bb2 = bb3 = bb4 = bb5 = 0;
+	bb1 = bb2 = bb3 = bb4 = bb5 = bbm = 0;
 
 	printf("test1: ");
 	retval = create_test_list(test1, &bb1);
@@ -346,6 +380,27 @@ int main(int argc, char **argv)
 		printf("\n");
 	}
 
+	printf("Create merge bb list\n");
+	retval = ext2fs_badblocks_list_create(&bbm, 5);
+	if (retval) {
+		com_err("ext2fs_badblocks_list_create", retval, "while creating list");
+		test_fail++;
+	}
+
+	printf("Merge & Verify all bb{1..5} into bbm\n");
+	if (bb1 && bb2 && bb3 && bb4 && bb5 && bbm) {
+		printf("Merge bb1 into bbm");
+		do_list_merge_verify(bb1, bbm, 1);
+		printf("Merge bb2 into bbm");
+		do_list_merge_verify(bb2, bbm, 1);
+		printf("Merge bb3 into bbm");
+		do_list_merge_verify(bb3, bbm, 1);
+		printf("Merge bb4 into bbm");
+		do_list_merge_verify(bb4, bbm, 1);
+		printf("Merge bb5 into bbm");
+		do_list_merge_verify(bb5, bbm, 1);
+	}
+
 	file_test(bb4);
 
 	file_test_invalid(bb4);
@@ -363,6 +418,8 @@ int main(int argc, char **argv)
 		ext2fs_badblocks_list_free(bb4);
 	if (bb5)
 		ext2fs_badblocks_list_free(bb5);
+	if (bbm)
+		ext2fs_badblocks_list_free(bbm);
 
 	return test_fail;
 
-- 
2.37.3

