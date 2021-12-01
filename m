Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3782A464B09
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Dec 2021 10:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236815AbhLAJ4d (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Dec 2021 04:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235434AbhLAJ4d (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Dec 2021 04:56:33 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17833C061748
        for <linux-ext4@vger.kernel.org>; Wed,  1 Dec 2021 01:53:13 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id v19so17243418plo.7
        for <linux-ext4@vger.kernel.org>; Wed, 01 Dec 2021 01:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SF1mD5SWLvbt+au3tQQLZWrYTDwiz/pttxfTol9Z/fI=;
        b=b/Mm9urqTRdhVGB6h0fWJ0QMjbyDSJdXQG26En4LCQRYoJ8jW6tO4ab2oPyeKooSEW
         88CAdIxf0SHDQ/DKEqFiT4JyWsbptsT0n69sWdmkD6ns/AmdnJfJRjNKBGMH1x/uvd94
         OrmSBry0lWUlIZa0ALj64izwXInFXOrcrn7Xyp8Acc8vTR/r0pbTn7gNsZc9krupKvyX
         nTtywYxiJD78N7pddL5zdSitF9r0HgF3yA+eDJeI2gYeq3tsLouIN6lFimllwNbU5dQf
         5UwtHHnAD7TbqzR02Q6hynRjI4vhPmpWp3C4gcWa6QaVhdBzGg9yWVlfxCVnTRpD5rkx
         9kHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SF1mD5SWLvbt+au3tQQLZWrYTDwiz/pttxfTol9Z/fI=;
        b=Y0bltWn/AGpruj0cbL+MUxXma3jLcjfniWWfOuOr+WoNabJs5kdn9S+MnBL8ya43Qu
         CAu4xIoc6rkhgwxAET4sVkMa50FmFAG/GrTST/AXN7M4mLlZ3NxGMOHYYi0xMip2TEXx
         ++lDxAXgTTsZ9taZIUV3YUo5huO7WhUyp6V/5eNDcTD7H9Xn5xqOyK9dvAaZyLyD/IH6
         gG2YKdEyD64ea57PiRkduinrkgctCmcCtlUckZYhyeVVDF9aX7jTlnpAmnx6ljXT4Tnr
         JqqZyJk4EI+qlvukuFcUfa0RSN8G2vqDL+mvEAyNFWiN8doyBNEOLqSf+DDoXSjX4Itt
         27bw==
X-Gm-Message-State: AOAM530/jx4ZJTi+tRzfeNUTpZZT2gZnQFMy8im7DqdHoO56pq5xru1g
        WBmHkGO/kXQB3UmObktDUXmDnpR3s+qLYQ==
X-Google-Smtp-Source: ABdhPJxxL9L4neI7W9JiWVsl5rNK0SWUzvcQV2lb8jnIYXrVdufA+dU8AdJUGKlQEPbWLzTCTGzxLA==
X-Received: by 2002:a17:902:f2c2:b0:141:9ce8:930f with SMTP id h2-20020a170902f2c200b001419ce8930fmr5918250plc.68.1638352392636;
        Wed, 01 Dec 2021 01:53:12 -0800 (PST)
Received: from yinxin.bytedance.net ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id s2sm28426494pfg.124.2021.12.01.01.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 01:53:11 -0800 (PST)
From:   Xin Yin <yinxin.x@bytedance.com>
To:     harshadshirwadkar@gmail.com, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Yin <yinxin.x@bytedance.com>
Subject: [PATCH] ext4: fix fast commit may miss tracking range for FALLOC_FL_ZERO_RANGE
Date:   Wed,  1 Dec 2021 17:52:58 +0800
Message-Id: <20211201095258.1966-1-yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

when call falloc with FALLOC_FL_ZERO_RANGE, to set an range to unwritten,
which has been already initialized. If the range is align to blocksize,
fast commit will not track range for this change.

change to track range during allocating blocks.

Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
---
 fs/ext4/extents.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 9229ab1f99c5..4108896d471b 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4433,6 +4433,8 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 			ret2 = ext4_journal_stop(handle);
 			break;
 		}
+		ext4_fc_track_range(handle, inode, map.m_lblk,
+					map.m_lblk + map.m_len - 1);
 		map.m_lblk += ret;
 		map.m_len = len = len - ret;
 		epos = (loff_t)map.m_lblk << inode->i_blkbits;
@@ -4599,8 +4601,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	ret = ext4_mark_inode_dirty(handle, inode);
 	if (unlikely(ret))
 		goto out_handle;
-	ext4_fc_track_range(handle, inode, offset >> inode->i_sb->s_blocksize_bits,
-			(offset + len - 1) >> inode->i_sb->s_blocksize_bits);
 	/* Zero out partial block at the edges of the range */
 	ret = ext4_zero_partial_blocks(handle, inode, offset, len);
 	if (ret >= 0)
-- 
2.20.1

