Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B740297CB5
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Oct 2020 16:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761835AbgJXOBV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 24 Oct 2020 10:01:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34389 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761832AbgJXOBV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 24 Oct 2020 10:01:21 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1kWK6g-0002ND-Ph
        for linux-ext4@vger.kernel.org; Sat, 24 Oct 2020 14:01:18 +0000
Received: by mail-wr1-f72.google.com with SMTP id u15so2397462wrn.4
        for <linux-ext4@vger.kernel.org>; Sat, 24 Oct 2020 07:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=/4dnRbgtO5meSxIccl+sy9toA1tYJ9rK+hI6ilGPRo4=;
        b=iPJ+Gk01B8f3J7zdQ+jbiOJJPPMFUBRttq3PoT0x651X1C2+FP2/gQUGgJ7Qw2Y+Uw
         Xa0xuqxy82syw3suTPmF7M+XaMvKw4f6X8NnJSMV/bttnpehrz6iQf320+Xw7JMoEsku
         yYzBtxro+2BUB6lj7+rrmryEqt5CsV63fkvJQmXR+Sr/5NA6taTsGg/iShgtjKzgvG19
         BnEvseHaCUQIHZXc2QAr6pEJuQByO3h5cMrd7u3vfmgY0r2yqcSiu60liKlLz7tPLLRB
         c7xsq7O3JQ6STkHdKDM7o5FIPpPVOvjjwtB8/HagO5ujRgJLP54II46VapM0xsP3ESQx
         7nUw==
X-Gm-Message-State: AOAM5325wqcgPywouEuE55QGlaVNBMfVVFj2y9PrljLDKo1hmVDk2ak5
        FEJk2j/a6/KiJfII0I8puNKkszzRIILcoT4L6fWmzmpOu7RVGPFE8LugsWPC6ubDtipFB7OBKAc
        CiXvLJiJ8c3RCNPYoA3bImZMCtHwtdY3QAC8RYDo=
X-Received: by 2002:adf:8bd4:: with SMTP id w20mr7778112wra.391.1603548078078;
        Sat, 24 Oct 2020 07:01:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzl5aHCrBCmQWQvMRVyFFJyBfnEfh6V+Dl+qBJLj2fgLt4sE+1k4yNyDkYldshGsfPL7KrF5g==
X-Received: by 2002:adf:8bd4:: with SMTP id w20mr7778085wra.391.1603548077822;
        Sat, 24 Oct 2020 07:01:17 -0700 (PDT)
Received: from localhost (host-79-33-123-6.retail.telecomitalia.it. [79.33.123.6])
        by smtp.gmail.com with ESMTPSA id o4sm10476690wrv.8.2020.10.24.07.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 07:01:17 -0700 (PDT)
Date:   Sat, 24 Oct 2020 16:01:15 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: properly check for dirty state in
 ext4_inode_datasync_dirty()
Message-ID: <20201024140115.GA35973@xps-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4_inode_datasync_dirty() needs to return 'true' if the inode is
dirty, 'false' otherwise, but the logic seems to be incorrectly changed
by commit aa75f4d3daae ("ext4: main fast-commit commit path").

This introduces a problem with swap files that are always failing to be
activated, showing this error in dmesg:

 [   34.406479] swapon: file is not committed

Simple test case to reproduce the problem:

  # fallocate -l 8G swapfile
  # chmod 0600 swapfile
  # mkswap swapfile
  # swapon swapfile

Fix the logic to return the proper state of the inode.

Link: https://lore.kernel.org/lkml/20201024131333.GA32124@xps-13-7390
Fixes: aa75f4d3daae ("ext4: main fast-commit commit path")
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 fs/ext4/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 03c2253005f0..a890a17ab7e1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3308,8 +3308,8 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
 	if (journal) {
 		if (jbd2_transaction_committed(journal,
 					EXT4_I(inode)->i_datasync_tid))
-			return true;
-		return atomic_read(&EXT4_SB(inode->i_sb)->s_fc_subtid) >=
+			return false;
+		return atomic_read(&EXT4_SB(inode->i_sb)->s_fc_subtid) <
 			EXT4_I(inode)->i_fc_committed_subtid;
 	}
 
-- 
2.27.0

