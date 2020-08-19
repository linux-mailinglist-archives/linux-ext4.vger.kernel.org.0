Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1497A249777
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Aug 2020 09:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgHSHbV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Aug 2020 03:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgHSHbS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 19 Aug 2020 03:31:18 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7D5C061389
        for <linux-ext4@vger.kernel.org>; Wed, 19 Aug 2020 00:31:18 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id m8so11244579pfh.3
        for <linux-ext4@vger.kernel.org>; Wed, 19 Aug 2020 00:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w/d7QJcV9gi/9EvMULG8CbpAwI+clRLCRU3vnCYIn+M=;
        b=uDJzwRSH980vdb99NuzEHzFmym8BcL9SBwt/Q84olH0LJT7a8Vth3um97dddvCtNag
         4xGUxeoaPQiuqx2eEp4hax3taf4edKM/HzyJZD8iMdVuxudAeh0J+u67uLQOEh+FVUUf
         PhcBZBSkrlGCaMgULAbcjHOkNXpnNHLfynZ9grL4otiBWOVyvmTi/8+VA7R+XGQcYmc8
         mgsObHBVMb4H5m1/EcvhKLH3oSjeZ7qTfxQQ8psTKedT8p0PeOkq3j5h11Ipj6oOfjHu
         7Avl+VdOgbX0GZvQgCOF8W0VPrFMv4Kh1mKA5SQO3wHeEIPHds49QwOOceY+MMn3M6qO
         sNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w/d7QJcV9gi/9EvMULG8CbpAwI+clRLCRU3vnCYIn+M=;
        b=e2gTsiD3G3pEteM8Je+eFMCCdofPy0G+v5oa+rv9pEVI7CpKr83qcrBbS+9IqacGkc
         4eOtppWYqS2es3ZbURkjJ8uAb06gMVsZoGnEdQDmrzQXjHNqho146IgYBTYk4ojg3soJ
         wD17oYsd7gUD3fs4oOkmdXXaMJgJC+2364RGa/O6dst/ld4OfFeJFdzZ+3Oa0U/sgmB9
         6Qr7Yy+yJ4suit/JP2GKb80THYjhs+4/2N8w3V58QQyXXirzE3bq6XfN+Bco89X2lo4X
         +FlOylZSqAU78ToWfxDX6vPLJBLh95s3HlwgVsg4HfzMNml5v/a/oYoEwJ3xhBA9pMkn
         z8zQ==
X-Gm-Message-State: AOAM533x8JAl9aLzxAmz47HGrk7Nz2t3eBWAcd/8zz2gzzjyCwpHTVo5
        PiwAVWGa4mYwRpPdJ9hPN4TRruPiF2Y=
X-Google-Smtp-Source: ABdhPJxyKPHWYBeWEN1VakdD5Q1S13AiLZPxSU/WeSaRKD7vgSOEsMarmZ/grrM2XZzGalwntWA0PA==
X-Received: by 2002:aa7:8c42:: with SMTP id e2mr17656006pfd.181.1597822276852;
        Wed, 19 Aug 2020 00:31:16 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id q6sm2040019pjr.20.2020.08.19.00.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 00:31:16 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, lyx1209@gmail.com,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH 1/9] ext4: add handling for extended mount options
Date:   Wed, 19 Aug 2020 00:30:56 -0700
Message-Id: <20200819073104.1141705-2-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
In-Reply-To: <20200819073104.1141705-1-harshadshirwadkar@gmail.com>
References: <20200819073104.1141705-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We are running out of mount option bits. Add handling for using
s_mount_opt2. This patch was originally submitted as a part of fast
commit patch series. Resending it here with this patch series too.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
---
 fs/ext4/super.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 51e91a220ea9..98aa12602b68 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1733,6 +1733,7 @@ static int clear_qf_name(struct super_block *sb, int qtype)
 #define MOPT_EXT4_ONLY	(MOPT_NO_EXT2 | MOPT_NO_EXT3)
 #define MOPT_STRING	0x0400
 #define MOPT_SKIP	0x0800
+#define MOPT_2		0x1000
 
 static const struct mount_opts {
 	int	token;
@@ -2202,10 +2203,17 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
 			WARN_ON(1);
 			return -1;
 		}
-		if (arg != 0)
-			sbi->s_mount_opt |= m->mount_opt;
-		else
-			sbi->s_mount_opt &= ~m->mount_opt;
+		if (m->flags & MOPT_2) {
+			if (arg != 0)
+				sbi->s_mount_opt2 |= m->mount_opt;
+			else
+				sbi->s_mount_opt2 &= ~m->mount_opt;
+		} else {
+			if (arg != 0)
+				sbi->s_mount_opt |= m->mount_opt;
+			else
+				sbi->s_mount_opt &= ~m->mount_opt;
+		}
 	}
 	return 1;
 }
-- 
2.28.0.220.ged08abb693-goog

