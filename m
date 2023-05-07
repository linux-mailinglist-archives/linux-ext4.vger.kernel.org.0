Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2F76F968E
	for <lists+linux-ext4@lfdr.de>; Sun,  7 May 2023 04:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjEGCQ0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 6 May 2023 22:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEGCQZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 6 May 2023 22:16:25 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E69F1A136
        for <linux-ext4@vger.kernel.org>; Sat,  6 May 2023 19:16:23 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3472GKWe016200
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 6 May 2023 22:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1683425781; bh=pNNJoXNkf6DMfl+2oc0eFkLjwMZryyrMAayvetz2MLs=;
        h=From:To:Cc:Subject:Date;
        b=Pi4skScuggnvdy0rBlVjLAGi39vi7sgaDVDTS3hspVyOwVrCbbMmXTZ2eOCOJNwhk
         bIAKFa4T1e8dglA2P5apV4L+03X/WYzasZhH5q4pNNN7IGpzt4inw+SV9rPy1qkdTi
         T3czTgfODx9udhYaKqgENgN7PmkOC1dxeEig7EtXIJcApnTvOw5jB04KOaWeakgj80
         AJC9C20AFuHwFhY4X0uZpQnzy2WLUy4RUAVm5Sc37dg5gHuReuO6yQ6TMM7i6L50lk
         TKeOCJtgC8aSMbW2tygG1v0wWAv0kIW66cfB0oYxM8WPfXct+P1aoITFdfNenLHwYc
         bd+LE+FKmlIIw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E674215C02F0; Sat,  6 May 2023 22:16:19 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        syzbot+91dccab7c64e2850a4e5@syzkaller.appspotmail.com
Subject: [PATCH] ext4: fix deadlock when converting an inline directory in nojournal mode
Date:   Sat,  6 May 2023 22:16:08 -0400
Message-Id: <20230507021608.1290720-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In no journal mode, ext4_finish_convert_inline_dir() can self-deadlock
by calling ext4_handle_dirty_dirblock() when it already has taken the
directory lock.  There is a similar self-deadlock in
ext4_incvert_inline_data_nolock() for data files which we'll fix at
the same time.

A simple reproducer demonstrating the problem:

    mke2fs -Fq -t ext2 -O inline_data -b 4k /dev/vdc 64
    mount -t ext4 -o dirsync /dev/vdc /vdc
    cd /vdc
    mkdir file0
    cd file0
    touch file0
    touch file1
    attr -s BurnSpaceInEA -V abcde .
    touch supercalifragilisticexpialidocious

Reported-by: syzbot+91dccab7c64e2850a4e5@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=ba84cc80a9491d65416bc7877e1650c87530fe8a
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/inline.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 859bc4e2c9b0..d3dfc51a43c5 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1175,6 +1175,7 @@ static int ext4_finish_convert_inline_dir(handle_t *handle,
 		ext4_initialize_dirent_tail(dir_block,
 					    inode->i_sb->s_blocksize);
 	set_buffer_uptodate(dir_block);
+	unlock_buffer(dir_block);
 	err = ext4_handle_dirty_dirblock(handle, inode, dir_block);
 	if (err)
 		return err;
@@ -1249,6 +1250,7 @@ static int ext4_convert_inline_data_nolock(handle_t *handle,
 	if (!S_ISDIR(inode->i_mode)) {
 		memcpy(data_bh->b_data, buf, inline_size);
 		set_buffer_uptodate(data_bh);
+		unlock_buffer(data_bh);
 		error = ext4_handle_dirty_metadata(handle,
 						   inode, data_bh);
 	} else {
@@ -1256,7 +1258,6 @@ static int ext4_convert_inline_data_nolock(handle_t *handle,
 						       buf, inline_size);
 	}
 
-	unlock_buffer(data_bh);
 out_restore:
 	if (error)
 		ext4_restore_inline_data(handle, inode, iloc, buf, inline_size);
-- 
2.31.0

