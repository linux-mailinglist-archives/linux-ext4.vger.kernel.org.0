Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3152915AD34
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Feb 2020 17:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgBLQV4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Feb 2020 11:21:56 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33813 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgBLQV4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Feb 2020 11:21:56 -0500
Received: by mail-qt1-f196.google.com with SMTP id h12so2027921qtu.1
        for <linux-ext4@vger.kernel.org>; Wed, 12 Feb 2020 08:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ozJZHSV6KiYsP4IHkB8VNSvd1dPBz5qFfTZnA2gZ0Jc=;
        b=SVfYeJSZjkgPgUgUTzJaLOpz59yWTG3j+52teEjGSYWyDnivdhirQ1xRfBVC2ranF2
         sE/4G28Gmw4d6iDFkcGM5Yud2Xk6sMOrl4VpI/pLCqiTgKa1JhwAJGbMCVIE5iSRPqh6
         u5M+UUIKl4yLT0r+3PEXF2v2dLGs+NP3MCkbpRe2hxYCH20cFwt0jkzJKh8be+CCZXsZ
         QZMC7AHFgZXfEHCQWFVm/6/2FjMFnu05ru+BXVURUPL/x3zerRjvL7+82vC4GC5lcnPH
         PREMKnAaHPhyKKQZFU9KRVeZgW7ls+K+XYCVmoz/2sBS1AdL9XsgOX/5T9I3NnRkionG
         zxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ozJZHSV6KiYsP4IHkB8VNSvd1dPBz5qFfTZnA2gZ0Jc=;
        b=nxm9dL/p+b+Jr63Z8/4qinWz8i6fgJd6gbwJxS03qJfFSSOpVJmsbBTUHs6VBlt61z
         eBlB6nIf1t9mYWaBINncZ1uk5zXEAk5L6cfggScfKQLnWMd5XPSmLs1Jkwh4H1uK+1Dc
         iUN2rKTtCwbZ0arWCaPy3AL/pY9VFd9fK3xZcUwolvulVCXO2oWn6UpuiI3UFGhIVT9e
         wtwcTwcMch7mRxNDXYSyObLCXtCB3LYztcHd2rHyJdnriPf2ef6F8fjzM+k6vgKJqz1P
         FoPvAWDXVEyFjLzZirjX7jdZKQ6zGfTRIx/q/rFK3h3WJUzISkr0xG2xdCAr3hcKkJB7
         Qo7g==
X-Gm-Message-State: APjAAAUZeSWbFAo407V0T7HHCZAsUU87MnHErElK8EnZtxe2gD1YUS8z
        K+oQROSKq6ayAoV9x2F7Rd+23XkL
X-Google-Smtp-Source: APXvYqzj/l4+61X59qziYOUkLIPvYYhymHePHDFgooSg2WzHsldQEFrta4R0NTTNJAWfI7otY2rdMQ==
X-Received: by 2002:ac8:6999:: with SMTP id o25mr19778766qtq.342.1581524514821;
        Wed, 12 Feb 2020 08:21:54 -0800 (PST)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id n4sm422675qti.55.2020.02.12.08.21.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Feb 2020 08:21:53 -0800 (PST)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH] ext4:  delete declaration for ext4_split_extent()
Date:   Wed, 12 Feb 2020 11:21:41 -0500
Message-Id: <20200212162141.22381-1-enwlinux@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There are no forward references for ext4_split_extent() in extents.c,
so delete its unnecessary declaration.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 fs/ext4/extents.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 89aa9c7ae293..a5338a8da2ab 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -83,13 +83,6 @@ static void ext4_extent_block_csum_set(struct inode *inode,
 	et->et_checksum = ext4_extent_block_csum(inode, eh);
 }
 
-static int ext4_split_extent(handle_t *handle,
-				struct inode *inode,
-				struct ext4_ext_path **ppath,
-				struct ext4_map_blocks *map,
-				int split_flag,
-				int flags);
-
 static int ext4_split_extent_at(handle_t *handle,
 			     struct inode *inode,
 			     struct ext4_ext_path **ppath,
-- 
2.11.0

