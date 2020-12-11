Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5552D7073
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Dec 2020 07:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436613AbgLKGzr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Dec 2020 01:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436526AbgLKGz0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Dec 2020 01:55:26 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF04AC0613CF;
        Thu, 10 Dec 2020 22:54:43 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id b5so1856433pjl.0;
        Thu, 10 Dec 2020 22:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Mk4Hj8uoE9+HWH4PG/7i9Q6Ep1F6cn02av09P/LOR0s=;
        b=nXCH68tTVbWmkoZR00lDYsABPJrG2BJyk2ZEZkimMS2klUiKQUCyVL2+xnAkFPZnIO
         l7v8XavwRF796V/6MB15o7d3GvklUtzLO84pdy3PDgyM2xVreukl0WHpjEkaBKdETpjb
         vYFSCK+dFqnyF+b5WcUo7rfd4rsTZHIrGOaq+UZGl83yUHXlZWH55C+XOdvpmhKnaDbf
         vxX4PiC5D8QB8+sivbP/x+WNInAz5N3rCSg48dS+eU8ZzShYz0zC4biqViYQWUrcyhDN
         y1cCKXTu6p4TPpUklPc+DOJlzBsBwkD7MWU3UdVqLAtgRmDZwUBPj1loKWI9cYUQpPtF
         Kr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Mk4Hj8uoE9+HWH4PG/7i9Q6Ep1F6cn02av09P/LOR0s=;
        b=NnPmvl5yWcmloqYsmBFyJEBugrvyic/qMEHu+zXGGqGj5/gzyJzHqy1ZetcNBZ5JyH
         SioNz3laekUbzcsS6ltaJ7Sg1ZaVkLShkwij3RFUlz8e7QaFddJRBErxg+kS9ce6oDt1
         RYx0B3npcZDJNbm4lY6WYTQsO/5euEfhK5/8m7QWureMElkf/lUfwYyVzXyExqiG3znU
         fzZ3yVLa4TET1jdC9GGwLOmpozbB5jDJC3UfQaR4RJYDwX9y2qegJYL59dsnB4Uiao57
         BaaaVhyi3zr6PzZBslKQhReMNGSFSboZsOYiSdOAmDhyNiw3sWRqA3fEKHRqLWoLqqPH
         AG6Q==
X-Gm-Message-State: AOAM533nJsIbmf9QXni3Afw1cfhs4tsl/FVlFsAObTtek/+zzOQbcVFS
        Uq6PeaUwVpqjB5QXiJLdKxWY2IcgRCpDgA==
X-Google-Smtp-Source: ABdhPJxelgrbtUldeg1djEvtvOmdwrvVCwPhzPmUSMA9ZFTzjXEC/PCjN42L3L1AXMYnJJEEeA/1tA==
X-Received: by 2002:a17:902:9307:b029:d9:d097:fd6c with SMTP id bc7-20020a1709029307b02900d9d097fd6cmr9733889plb.10.1607669683454;
        Thu, 10 Dec 2020 22:54:43 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id h36sm8890067pgb.28.2020.12.10.22.54.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Dec 2020 22:54:42 -0800 (PST)
From:   chenlei0x@gmail.com
X-Google-Original-From: lennychen@tencent.com
To:     chenlei0x@gmail.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lei Chen <lennychen@tencent.com>
Subject: [PATCH] fs: ext4: remove unnecessary wbc parameter from ext4_bio_write_page
Date:   Fri, 11 Dec 2020 14:54:24 +0800
Message-Id: <1607669664-25656-1-git-send-email-lennychen@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Lei Chen <lennychen@tencent.com>

ext4_bio_write_page does not need wbc parameter, since its parameter
io contains the io_wbc field. The io::io_wbc is initialized by
ext4_io_submit_init which is called in ext4_writepages and
ext4_writepage functions prior to ext4_bio_write_page.
Therefor, when ext4_bio_write_page is called, wbc info
has already been included in io parameter.

Signed-off-by: Lei Chen <lennychen@tencent.com>
---
 fs/ext4/ext4.h    | 1 -
 fs/ext4/inode.c   | 4 ++--
 fs/ext4/page-io.c | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index cd95965..1385898 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3638,7 +3638,6 @@ extern void ext4_io_submit_init(struct ext4_io_submit *io,
 extern int ext4_bio_write_page(struct ext4_io_submit *io,
 			       struct page *page,
 			       int len,
-			       struct writeback_control *wbc,
 			       bool keep_towrite);
 extern struct ext4_io_end_vec *ext4_alloc_io_end_vec(ext4_io_end_t *io_end);
 extern struct ext4_io_end_vec *ext4_last_io_end_vec(ext4_io_end_t *io_end);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index b147c2e..7360e7a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2055,7 +2055,7 @@ static int ext4_writepage(struct page *page,
 		unlock_page(page);
 		return -ENOMEM;
 	}
-	ret = ext4_bio_write_page(&io_submit, page, len, wbc, keep_towrite);
+	ret = ext4_bio_write_page(&io_submit, page, len, keep_towrite);
 	ext4_io_submit(&io_submit);
 	/* Drop io_end reference we got from init */
 	ext4_put_io_end_defer(io_submit.io_end);
@@ -2089,7 +2089,7 @@ static int mpage_submit_page(struct mpage_da_data *mpd, struct page *page)
 		len = size & ~PAGE_MASK;
 	else
 		len = PAGE_SIZE;
-	err = ext4_bio_write_page(&mpd->io_submit, page, len, mpd->wbc, false);
+	err = ext4_bio_write_page(&mpd->io_submit, page, len, false);
 	if (!err)
 		mpd->wbc->nr_to_write--;
 	mpd->first_page++;
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index cb135a9..03a44a0 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -435,7 +435,6 @@ static void io_submit_add_bh(struct ext4_io_submit *io,
 int ext4_bio_write_page(struct ext4_io_submit *io,
 			struct page *page,
 			int len,
-			struct writeback_control *wbc,
 			bool keep_towrite)
 {
 	struct page *bounce_page = NULL;
@@ -445,6 +444,7 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 	int ret = 0;
 	int nr_submitted = 0;
 	int nr_to_submit = 0;
+	struct writeback_control *wbc = io->io_wbc;
 
 	BUG_ON(!PageLocked(page));
 	BUG_ON(PageWriteback(page));
-- 
1.8.3.1

