Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E70476CEE
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Dec 2021 10:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbhLPJK3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Dec 2021 04:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbhLPJK3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Dec 2021 04:10:29 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CFEC061574;
        Thu, 16 Dec 2021 01:10:29 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id 193so22678220qkh.10;
        Thu, 16 Dec 2021 01:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aGt13vD1itn5sjXw+H86cmDVBqoGT4H1e/3JbiAwhwo=;
        b=KGgdeC09Ut/4WVGRjUouF1X1fmV294IJcLMVJr6i7JbPH3Yz27oN21IEoQDk30t4aQ
         8iRpXgQfQVRDjvvG5BveyRPbaADJJkOXB/Rz/EyN+oEFD8TEuX1s8P6/oH/HK7f+KEd8
         Gh2nPCaUUPMXy2ofQ2F88tqnycdkaoA9aI8lDzPW9hqKz1EQS+whtWtBoRwkCxbulhns
         M8Nw+Z9I3x/LwVw6LTAbqHSj6phAtAhByjW2rX1bmU0QMJtcKqhdWys9wIqW700C6FxG
         MJsynPx2CbIuNG5i39yUx4ViGsnjY8fRHD4ObxQXG0Pl1aEShOiWVECa6AEmwtiKRhrd
         i3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aGt13vD1itn5sjXw+H86cmDVBqoGT4H1e/3JbiAwhwo=;
        b=DwnC+2viKH0Dr34Fh4mbFkgBSFxHMifNuzce7Q5z3s6TK5kqG8BmwnAzT1gdGcHXpc
         B80U3FATSMu82fpQThro4XU9chsr/jwnihaBWiS1s/tCp8Vx+3h+k2qr5kRbL0OOsWYV
         MUSh39U+bKufARMCI+X/sBcK5NuBfbXPK45lHZF5mIRwdZnHHi3IPf0l0hAzq4OsEbrL
         HcVLrRPugKlDEhWW9uPkiHI4v0pd3tuI/PrS37zLmnnZL9n+vxsgCiBpA/9e0CY4/jrF
         U4zhsILxk93sEc3COzSDOz5WXFKwDEYC4q9uxiKt8wnFw2ukbakWHDwlehvstMV43c/Y
         gNNg==
X-Gm-Message-State: AOAM533Y3KlkJ2AosCXKazdzGRXNvlI+xajYMpRV7uFgVnod4DX5Qnyn
        /ewNgt2zF3kBS1J5z0XM4Z3Zu6HLxuw=
X-Google-Smtp-Source: ABdhPJz/amnbn14+QmT0cNiOb8u0k7LTCAe+7BpnQEh1bZGJs5Uiw3zEm3Apu9g3WU3ev4XszLfz9w==
X-Received: by 2002:a05:620a:2589:: with SMTP id x9mr11050764qko.325.1639645828233;
        Thu, 16 Dec 2021 01:10:28 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id o4sm2411924qkh.107.2021.12.16.01.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 01:10:27 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ext4: use min() to make code cleaner
Date:   Thu, 16 Dec 2021 09:10:22 +0000
Message-Id: <20211216091022.449364-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Use min() in order to make code cleaner.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 fs/ext4/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 5ec5a1c3b364..d0c50e0e787d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6922,8 +6922,7 @@ static ssize_t ext4_quota_read(struct super_block *sb, int type, char *data,
 		len = i_size-off;
 	toread = len;
 	while (toread > 0) {
-		tocopy = sb->s_blocksize - offset < toread ?
-				sb->s_blocksize - offset : toread;
+		tocopy = min(sb->s_blocksize - offset, toread);
 		bh = ext4_bread(NULL, inode, blk, 0);
 		if (IS_ERR(bh))
 			return PTR_ERR(bh);
-- 
2.25.1

