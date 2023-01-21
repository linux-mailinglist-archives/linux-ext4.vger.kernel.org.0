Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04547676959
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjAUUhE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjAUUgt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE93C29169
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11CDB60B81
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDF6C433A8
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333403;
        bh=RnNP8QvLhZniSZKh7fzsGa9zTQXAgXo++gBVjqnTZ6w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mcP8bPJ3DHQCgFXNQmaAfRMCYoeCtsY7eQypIBh4vqaJx45NIYIKsVTprnSYL3wMb
         /jqZnm2y2R0aLeeTedPzCflLbbgy5aB6v1Mq9v/BqfsJ6zs2GuH5ieZ+1jrQlV3vnp
         yM3GV/HpkUucaGqEPJ5w3yfvn7RyJ+r3Y8g34sFeYjUrX9z2fJQ3ALjZiZWD4F9zce
         5sQICO6YSttL9+WtA0IGZ3YUJy10nnfiUCo/2u1SnKSocOuUSYtRjktry4GQiE06wQ
         JAN8WzBO0R7aBUWZAxtYSQz3uUQosXleR6nKTs0qw+X959EuHj0Je4DV3+iSA/Sczi
         ACE8pTpxPy0xg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 27/38] misc/create_inode: fix -Wunused-variable warnings in __populate_fs()
Date:   Sat, 21 Jan 2023 12:32:19 -0800
Message-Id: <20230121203230.27624-28-ebiggers@kernel.org>
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

These showed up when building for Windows.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 misc/create_inode.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/misc/create_inode.c b/misc/create_inode.c
index c00d54588..7ce69c2b0 100644
--- a/misc/create_inode.c
+++ b/misc/create_inode.c
@@ -813,11 +813,9 @@ static errcode_t __populate_fs(ext2_filsys fs, ext2_ino_t parent_ino,
 	const char	*name;
 	struct dirent	**dent;
 	struct stat	st;
-	char		*ln_target = NULL;
 	unsigned int	save_inode;
 	ext2_ino_t	ino;
 	errcode_t	retval = 0;
-	int		read_cnt;
 	int		hdlink;
 	size_t		cur_dir_path_len;
 	int		i, num_dents;
@@ -900,7 +898,10 @@ static errcode_t __populate_fs(ext2_filsys fs, ext2_ino_t parent_ino,
 				goto out;
 			}
 			break;
-		case S_IFLNK:
+		case S_IFLNK: {
+			char *ln_target;
+			int read_cnt;
+
 			ln_target = malloc(st.st_size + 1);
 			if (ln_target == NULL) {
 				com_err(__func__, retval,
@@ -935,7 +936,8 @@ static errcode_t __populate_fs(ext2_filsys fs, ext2_ino_t parent_ino,
 				goto out;
 			}
 			break;
-#endif
+		}
+#endif /* !_WIN32 */
 		case S_IFREG:
 			retval = do_write_internal(fs, parent_ino, name, name,
 						   root);
-- 
2.39.0

