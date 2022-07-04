Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B13564E4E
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Jul 2022 09:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbiGDHI4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Jul 2022 03:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbiGDHIY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Jul 2022 03:08:24 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FE8764A
        for <linux-ext4@vger.kernel.org>; Mon,  4 Jul 2022 00:08:05 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d17so8140962pfq.9
        for <linux-ext4@vger.kernel.org>; Mon, 04 Jul 2022 00:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zMrOHCrGDXxXx4NXrcEuArp+ayo87mwIW1zD8gmhVr4=;
        b=B7h7eERjREtbWs+Uc1tB0yD35B3KdfmH3hs+lRpaOG2BO43lxf5d9gDvEqoVrwO79x
         xVEgI8mIU293+OEZhs2bc8lRbZ330fpsMpdojKMzsWIHlI3jlaaRQ7YsMZjdB/1WbRYV
         1eyD22OpuS8Zd90Zc1QVUWoP4xsiRf0ZGpZLk2xuT5v8dfl2yrjDl9OcloBO/TdvAH6+
         rOET2/b3yz3/YB8Cx/C5bRaqWG8VGBRewNiKRhfP7msWEDX8are5jOFmRB0n425dDaLV
         eQYfylMc9lZqVfdrwK4P+3rlAB30g63J2TOInE/sIDJwXIVHiakeiRmH57FZuIssHXuJ
         ciOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zMrOHCrGDXxXx4NXrcEuArp+ayo87mwIW1zD8gmhVr4=;
        b=RqskcaQUIeO1jnD9FnFZAiZApd3RPU92cly16jKvMHpCfOOtLstF2lPVz7G2S5jprL
         y4JGQ9tf0+C52Z/Sp5p0fYq6ZecN0GJSakle5SPGAu34Vq1bS0yznLE+qG1Ua8xyyNLO
         ZhH2EyRKp7Kd+w8VqxchLBfSzdeK4HlirtelHtaryZy2n4azmGC3TYiMx61Fd7K3QfUT
         1MOiFiXbVlhLlLfU3XDZv1lOEZaV55pyDiYGX4PmakXKFykxcOxDeC50sXZ185oMyTIG
         hMZ3zfHz0w4FYcM3CFKowC2/74JoxkCdVgeLgPyNe1rNRXm3cAhT5Ky6YuP1k+KsCH3L
         NnKA==
X-Gm-Message-State: AJIora+7VFByxNrpSqt+2MMYKTVtyfdwd28LnryUPhcM99ZNaQgQG+tQ
        1uq2DGBHCe3aE2rdTO3TP/s=
X-Google-Smtp-Source: AGRyM1sp4DGXDtWRV1HG7nHaunpgNyp5vVbmo+1omdkKeCFfelHNaGNwb8Urdt5VfqYCYZ03p1cB4A==
X-Received: by 2002:a63:6f01:0:b0:412:35fa:62dc with SMTP id k1-20020a636f01000000b0041235fa62dcmr4790432pgc.490.1656918485303;
        Mon, 04 Jul 2022 00:08:05 -0700 (PDT)
Received: from localhost ([2406:7400:63:cb1d:811:33e9:9bc2:d40])
        by smtp.gmail.com with ESMTPSA id z2-20020a170903018200b0016bea74d11esm255596plg.267.2022.07.04.00.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 00:08:05 -0700 (PDT)
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC 10/13] tst_badblocks: Add unit test to verify badblocks list merge api
Date:   Mon,  4 Jul 2022 12:36:59 +0530
Message-Id: <f5e545bf51e2b971904d84daad39f4541de7a0dc.1656912918.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1656912918.git.ritesh.list@gmail.com>
References: <cover.1656912918.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add unit test to verify badblocks list merge api i.e.
ext2fs_badblocks_merge()

Signed-off-by: Ritesh Harjani <ritesh.list@gmail.com>
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
2.35.3

