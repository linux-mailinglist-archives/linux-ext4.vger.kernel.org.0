Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 180BC14F65D
	for <lists+linux-ext4@lfdr.de>; Sat,  1 Feb 2020 05:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgBAEAr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 31 Jan 2020 23:00:47 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39706 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbgBAEAr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 31 Jan 2020 23:00:47 -0500
Received: by mail-pj1-f65.google.com with SMTP id e9so3895926pjr.4
        for <linux-ext4@vger.kernel.org>; Fri, 31 Jan 2020 20:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=x2qpOMOi+cyHAu3y6Rms+urppcnzp8wr+dIctZb9LkI=;
        b=C4bMpzShmAEsr9nY3jDG3PAC0rmJuL7wywxY0IDV1LGBo1RQM9PoxwLZtYl6KIgzlv
         +KGdy1C0aPmi78pMgsDqDnY7IhqIG3ZwSXIyJSQO07bo5pAa2mWkrvZP9c/y6bBL3iVM
         r6u2Rck8M1bLsF0zs2dFfjXxdZCAQJRUkhDQ8Iy0AtE/rAIDitX0yzexUbYQXuMi4SEn
         GVVFtn6WPit3OKmqr+o66x0iyB0rjM7anV8el16qj32NCNEfzVc1rWPvqZMEsmK8OqqZ
         Eaamb37//T2Yye142dzF87RrXqRqcmBNci+U7gavHcv71pKLqI6QGPj1mBbywPDNBd8i
         L8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x2qpOMOi+cyHAu3y6Rms+urppcnzp8wr+dIctZb9LkI=;
        b=bvlcweNeKDgW6XEncPEnvqHThfVXPAj6mTaSnisvM8Gxi3qjHLHS0zSpSrHH5MQdel
         7WbsEC3pNvQEneCJwE+fHPEf199d5xodQUQTcHjBR+PIVfjJ7oEDPCkR4XsB0Vyai5fW
         VpKhxNqvkjBFYfbfHNOd1H+hbPVd6Ksx5C+j1CMFPNxn/uF1l/4tP4X9fSwGxNg91k5O
         y0ZkYa1qGeGPu1GdEt4LRi6ceqv+ePvpAhh6KZVZ0bvpAcgw3AwQqQSoFnOL9bIF/Lvr
         rrdM34OJEpukB2B7hPBP/KU8AcDoeuWRoFT182T8JSEhJi/sfsyHUkdSSexWwnVFl+x7
         Hg3Q==
X-Gm-Message-State: APjAAAVy14VO1XOEurIdSnWRp25zQz1FLtU2rh0K2jxrsDnjURqIIa2k
        R22OWKblJXq0VMOCMb5f6W2hGWfGyEI=
X-Google-Smtp-Source: APXvYqw/h4CvYaN9aqsVCsGkyeQFNZ8uJg0gXNrvPwRJXwiwJQ3vtZZiR343iOilYuynnblIBL3gLA==
X-Received: by 2002:a17:90a:608:: with SMTP id j8mr10242150pjj.85.1580529646513;
        Fri, 31 Jan 2020 20:00:46 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id f127sm12062957pfa.112.2020.01.31.20.00.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 31 Jan 2020 20:00:46 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     tytso@mit.edu, adilger.kernel@dilger.ca, trivial@kernel.org
Cc:     linux-ext4@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH] ext4: remove trivial nowait check for buffered write
Date:   Sat,  1 Feb 2020 12:00:39 +0800
Message-Id: <1580529639-26328-1-git-send-email-qiwuchen55@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

Remove trivial nowait check for ext4_buffered_write_iter(),
since buffered writes will return -EINVAL if IOCB_NOWAIT
passed in the follow-up function ext4_write_checks()->
ext4_generic_write_checks()->generic_write_checks().

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
 fs/ext4/file.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 5f22588..18ae435 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -258,9 +258,6 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
 	ssize_t ret;
 	struct inode *inode = file_inode(iocb->ki_filp);
 
-	if (iocb->ki_flags & IOCB_NOWAIT)
-		return -EOPNOTSUPP;
-
 	inode_lock(inode);
 	ret = ext4_write_checks(iocb, from);
 	if (ret <= 0)
-- 
1.9.1

