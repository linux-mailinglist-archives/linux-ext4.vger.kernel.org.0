Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC04C67695A
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjAUUhI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjAUUgt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647A929164
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 453F060B6A
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B469C433A7
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333404;
        bh=k/zPJBS29Jxqgu03dWEGg+K+owm+W0mnZF+A3RqTr1w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DQo9lfAPKDj4fJnTkGP6VMNJwsmsJHVbGD2bu3T4YJfcEZIJ+Vj/XymJuoD3+waPq
         T6lkDmKfzf63vxJPQnC5i0utBzhXA1Qqv2eYFZp2eyTuE+G+67OEh/brhMnmXid1f3
         rFDKaMKeIJHQ5+1r+bZHbPJs1h9ZlSaPJ4+OfSmuLtzF5vXDIpCTlP7sA9Yv94/STu
         Ra/6oOSzjiE2+BCaHa5WLbcv3s6yfAekorO2bwQ+lsSO/3IKgeKtdon3KJbKbl6hu+
         3/wVUhy+WbhZfwfQts4axGlVtm128bKT5dwW9BFE6jMIJAUSxzxkq5Cz5T9SGW0iSF
         eA9aOHti9qFFw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 28/38] misc/create_inode: simplify logic in scandir()
Date:   Sat, 21 Jan 2023 12:32:20 -0800
Message-Id: <20230121203230.27624-29-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121203230.27624-1-ebiggers@kernel.org>
References: <20230121203230.27624-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The control flow in scandir() (only used on Windows) confuses gcc into
thinking that *name_list is not always set on success, which causes a
-Wmaybe-uninitialized warning in __populate_fs().  As far as I can tell
it's a false positive; however, avoid it by cleanly separating the
success and failure cases in scandir().

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 misc/create_inode.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/misc/create_inode.c b/misc/create_inode.c
index 7ce69c2b0..6e61d98e6 100644
--- a/misc/create_inode.c
+++ b/misc/create_inode.c
@@ -763,39 +763,33 @@ static int scandir(const char *dir_name, struct dirent ***name_list,
 			size_t new_list_size = temp_list_size + 32;
 			struct dirent **new_list = (struct dirent**)realloc(
 				temp_list, new_list_size * sizeof(struct dirent*));
-			if (new_list == NULL) {
-				goto out;
-			}
+			if (new_list == NULL)
+				goto out_err;
 			temp_list_size = new_list_size;
 			temp_list = new_list;
 		}
 		// add the copy of dirent to the list
 		temp_list[num_dent] = (struct dirent*)malloc((dent->d_reclen + 3) & ~3);
 		if (!temp_list[num_dent])
-			goto out;
+			goto out_err;
 		memcpy(temp_list[num_dent], dent, dent->d_reclen);
 		num_dent++;
 	}
+	closedir(dir);
 
 	if (compar != NULL) {
 		qsort(temp_list, num_dent, sizeof(struct dirent*),
 		      (int (*)(const void*, const void*))compar);
 	}
-
-        // release the temp list
 	*name_list = temp_list;
-	temp_list = NULL;
+	return num_dent;
 
-out:
-	if (temp_list != NULL) {
-		while (num_dent > 0) {
-			free(temp_list[--num_dent]);
-		}
-		free(temp_list);
-		num_dent = -1;
-	}
+out_err:
 	closedir(dir);
-	return num_dent;
+	while (num_dent > 0)
+		free(temp_list[--num_dent]);
+	free(temp_list);
+	return -1;
 }
 
 static int alphasort(const struct dirent **a, const struct dirent **b) {
-- 
2.39.0

