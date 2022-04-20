Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0CE509075
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Apr 2022 21:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236351AbiDTT3c (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Apr 2022 15:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbiDTT3b (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Apr 2022 15:29:31 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7C9E029;
        Wed, 20 Apr 2022 12:26:44 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id p3so1538665pfw.0;
        Wed, 20 Apr 2022 12:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IgqiBza+UCNF6Lg1MV20zNXZ6HKe5iB4r9YwaejwpyQ=;
        b=BKtnxZ8Q0H2mTQqEzdTvOtyalh4S0jtW3BHsw1A/6klutBp/9wMza50tDNE/vZvGOD
         RgQRyvoFz7W0Ly+gfGDAWt0FkHNFh0stcrRZ/S2332DH2R+5HfB7ClKiQf1fE2PS1mqh
         zIiKjNtT//z2xO/0AttEndZtCi3PX4ul50Yzel84Pw2j5CBP4TdyIcc1sYIjFXaZ+C4H
         9CtReabuexjlVgvmqrBk+5Fy35kNbmjjQSX/LntkwydIah8rffoDKOs1b+zMtbRQfcYB
         rNCYT+xiCr6/vO7WITkkkGKuKoQ82w7GunY7lSWRpA6xZ5FGA75/mHm81rWSa0Y7z+X/
         grbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IgqiBza+UCNF6Lg1MV20zNXZ6HKe5iB4r9YwaejwpyQ=;
        b=Fh0Dk6/PIODIEWpymbHrs8YjxbnjgLc/hK1fV7R+LblkLjjbPXmb7CGkH+z1o/2E2B
         ULiVso8llpy6t47ur4XJv5H7rtvaCtTYiq21V9OAoWHttT45rZKP7y3/evwhryOWNVJW
         LxIM8cVHIOuha1z+pDO9fRbbEq6/16cprAFr2JiR6FOTq/coG+OmPfJH8dL16VQuKhSX
         TJTIgPpk0G2Jq6PxF8nOKHlzNMTb2WPGIqeKnSjCoM+lJChwTU+bK0xhxBnmq9dl6VTn
         G6tRmcFnPTEKiQ05zHu3LQI9cxKgRDy4RP0PCHx0DeuB217N/rv051aL3N+2ymFIm9MM
         dpVw==
X-Gm-Message-State: AOAM533Zw9TXqlL7KNpEOmOT6fVCA6h3h+QFvjYTiuTCKJQUKLmrUcsK
        5bl6NRZIG/R0cSkDSvu7Z/xGLx32p2Q=
X-Google-Smtp-Source: ABdhPJyMpVZrz1ziI/qVGYw9vbpQp0nB/0zfLVsugmuDs4vuS6Adw4DlfreSic2erfGh6+wzvD3CuQ==
X-Received: by 2002:a05:6a00:15d4:b0:50a:665f:5072 with SMTP id o20-20020a056a0015d400b0050a665f5072mr20485784pfu.6.1650482804325;
        Wed, 20 Apr 2022 12:26:44 -0700 (PDT)
Received: from localhost.localdomain (bb42-60-144-185.singnet.com.sg. [42.60.144.185])
        by smtp.gmail.com with ESMTPSA id k4-20020a17090a3e8400b001cd37f6c0b7sm151460pjc.46.2022.04.20.12.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 12:26:43 -0700 (PDT)
From:   Nguyen Dinh Phi <phind.uet@gmail.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     Nguyen Dinh Phi <phind.uet@gmail.com>,
        syzbot+c7358a3cd05ee786eb31@syzkaller.appspotmail.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: Fix block validation on non-journal fs in __ext4_iget()
Date:   Thu, 21 Apr 2022 03:23:12 +0800
Message-Id: <20220420192312.1655305-1-phind.uet@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Syzbot report following KERNEL BUG:
	kernel BUG at fs/ext4/extents_status.c:899!
	....
	Call Trace:
	 <TASK>
	 ext4_cache_extents+0x13e/0x2d0 fs/ext4/extents.c:518
	 ext4_find_extent+0x8f6/0xd10 fs/ext4/extents.c:916
	 ext4_ext_map_blocks+0x1e2/0x5f30 fs/ext4/extents.c:4098
	 ext4_map_blocks+0x9ca/0x18a0 fs/ext4/inode.c:563
	 ext4_getblk+0x553/0x6b0 fs/ext4/inode.c:849
	 ext4_bread_batch+0x7c/0x550 fs/ext4/inode.c:923
	 __ext4_find_entry+0x482/0x1050 fs/ext4/namei.c:1600
	 ext4_lookup_entry fs/ext4/namei.c:1701 [inline]
	 ext4_lookup fs/ext4/namei.c:1769 [inline]
	 ext4_lookup+0x4fc/0x730 fs/ext4/namei.c:1760
	 __lookup_slow+0x24c/0x480 fs/namei.c:1707
	 lookup_slow fs/namei.c:1724 [inline]
	 walk_component+0x40f/0x6a0 fs/namei.c:2020
	 link_path_walk.part.0+0x7ef/0xf70 fs/namei.c:2347
	 link_path_walk fs/namei.c:2272 [inline]
	 path_openat+0x266/0x2940 fs/namei.c:3605
	 do_filp_open+0x1aa/0x400 fs/namei.c:3636
	 do_sys_openat2+0x16d/0x4d0 fs/open.c:1214
	 do_sys_open fs/open.c:1230 [inline]
	 __do_sys_openat fs/open.c:1246 [inline]
	 __se_sys_openat fs/open.c:1241 [inline]
	 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1241
	 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
	 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
	 entry_SYSCALL_64_after_hwframe+0x44/0xae
	 </TASK>

The reason is fast commit recovery path will skip block validation in
__ext4_iget(), it allows syzbot be able to mount a corrupted non-journal
filesystem and cause kernel BUG when accessing it.

Fix it by adding a condition checking.

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
Reported-by: syzbot+c7358a3cd05ee786eb31@syzkaller.appspotmail.com
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 560e56b42829..66c86d85081e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4951,7 +4951,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 		goto bad_inode;
 	} else if (!ext4_has_inline_data(inode)) {
 		/* validate the block references in the inode */
-		if (!(EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY) &&
+		if (!(journal && EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY) &&
 			(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
 			(S_ISLNK(inode->i_mode) &&
 			!ext4_inode_is_fast_symlink(inode)))) {
-- 
2.25.1

