Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0880F47DE10
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Dec 2021 04:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346176AbhLWDYR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Dec 2021 22:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346074AbhLWDYQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Dec 2021 22:24:16 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F98CC061574
        for <linux-ext4@vger.kernel.org>; Wed, 22 Dec 2021 19:24:16 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id z6so3302537plk.6
        for <linux-ext4@vger.kernel.org>; Wed, 22 Dec 2021 19:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YNW6lb4D68Pjevtpm3ZBWVUTAD4SEQ7ZKtiDMVWrDCI=;
        b=0nbdoVOPXc8d7yDEQMj31ca4y+VsD8Zr74dFkqt0tILPyobQuP/KPmuhGDeWzyoBs5
         iBv+vk9hkY4gMoTHOt9Z1cCVhAZtb4CtpNT9LyS6kpqb4TehecSGFsw/IEKoflTFYZ+j
         VIgPxb+UOq83Q6LIDh+ccanFztTNMwFF9TrFWIIGDYrR6m2GAAnyGvge1ltrkb2UlsX1
         hZL/tBXXmF7EBQ6+SKD1VGYB1orN1NreisdpgSC+faOhfLnPQFEStE7XBtNyQxGv01Hi
         VIJHLJHanMdL87S/A4xdHbWtB5zNIJ6jL2HZxY8JRrR0+TDhHRiKoyszvjGR/Hm/uoku
         CbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YNW6lb4D68Pjevtpm3ZBWVUTAD4SEQ7ZKtiDMVWrDCI=;
        b=G4YbqCFSwOGj+p//SKD9WQ2KsCYr6k2VSgiZEb8aIaxr3Fuh54WLl1sY7hQ2Z0X+xC
         gcNMqrzNx7jU0ZdtAjb6xf58UIdxq4GB8sq7RZvZYmyojI9lyPNt9qriB1IdJxB4MTgU
         zV8spTtoWNdaDiwlKv7IIBCxa2PN5cOluIeWer3yFK2D/EwGbjZFzdbmMcGxPuvlsyzn
         JH1XppRuUH3Mdm8WwfiKrFJtAIYKa0iyy1iDauP+0eDUPtLZnrQH/YTKsKkAjiN9w+Bb
         KbL0MCGrvuBFM5MmhPX21yVyWE7TTpBB18X2fPk+ns2hHAlqicBClkWBNEEGEOGqrAbE
         J4pw==
X-Gm-Message-State: AOAM533gwcpgKMkxIlVvfT52HocDHDVqZ6CMh+WHzGo4hwbUTFtL8/6a
        1arOuf6Nr9Jbq/GmDFYPBH10dQ==
X-Google-Smtp-Source: ABdhPJxMnqx4rKQLL0WdVz6bouEu/bw24Io/+zKRIxBd0P+OqOOHu0fBj/L5CBhjPoPTQ9Qptka/yA==
X-Received: by 2002:a17:903:1210:b0:143:a088:7932 with SMTP id l16-20020a170903121000b00143a0887932mr509343plh.11.1640229856148;
        Wed, 22 Dec 2021 19:24:16 -0800 (PST)
Received: from yinxin.bytedance.net ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id d3sm4348622pfv.192.2021.12.22.19.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 19:24:15 -0800 (PST)
From:   Xin Yin <yinxin.x@bytedance.com>
To:     harshadshirwadkar@gmail.com, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Yin <yinxin.x@bytedance.com>
Subject: [PATCH 1/2] ext4: use ext4_ext_remove_space() for fast commit replay delete range
Date:   Thu, 23 Dec 2021 11:23:36 +0800
Message-Id: <20211223032337.5198-2-yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223032337.5198-1-yinxin.x@bytedance.com>
References: <20211223032337.5198-1-yinxin.x@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

For now ,we use ext4_punch_hole() during fast commit replay delete range
procedure. But it will be affected by inode->i_size, which may not
correct during fast commit replay procedure. The following test will
failed.

-create & write foo (len 1000K)
-falloc FALLOC_FL_ZERO_RANGE foo (range 400K - 600K)
-create & fsync bar
-falloc FALLOC_FL_PUNCH_HOLE foo (range 300K-500K)
-fsync foo
-crash before a full commit

After the fast_commit reply procedure, the range 400K-500K will not be
removed. Because in this case, when calling ext4_punch_hole() the
inode->i_size is 0, and it just retruns with doing nothing.

Change to use ext4_ext_remove_space() instead of ext4_punch_hole()
to remove blocks of inode directly.

Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
---
 fs/ext4/fast_commit.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index aa05b23f9c14..3deb97b22ca4 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1708,11 +1708,14 @@ ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl,
 		}
 	}
 
-	ret = ext4_punch_hole(inode,
-		le32_to_cpu(lrange.fc_lblk) << sb->s_blocksize_bits,
-		le32_to_cpu(lrange.fc_len) <<  sb->s_blocksize_bits);
-	if (ret)
-		jbd_debug(1, "ext4_punch_hole returned %d", ret);
+	down_write(&EXT4_I(inode)->i_data_sem);
+	ret = ext4_ext_remove_space(inode, lrange.fc_lblk,
+				lrange.fc_lblk + lrange.fc_len - 1);
+	up_write(&EXT4_I(inode)->i_data_sem);
+	if (ret) {
+		iput(inode);
+		return 0;
+	}
 	ext4_ext_replay_shrink_inode(inode,
 		i_size_read(inode) >> sb->s_blocksize_bits);
 	ext4_mark_inode_dirty(NULL, inode);
-- 
2.20.1

