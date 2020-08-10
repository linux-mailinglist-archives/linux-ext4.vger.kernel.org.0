Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F96E240329
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Aug 2020 10:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgHJIHL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Aug 2020 04:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgHJIHK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 10 Aug 2020 04:07:10 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A882C061756
        for <linux-ext4@vger.kernel.org>; Mon, 10 Aug 2020 01:07:10 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id c10so8560279pjn.1
        for <linux-ext4@vger.kernel.org>; Mon, 10 Aug 2020 01:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=q5vQB4DddEL669odkV+UsQkEJ4iF2VTIBEkf5nzMUQs=;
        b=HUiPuP5+AR6gzrPETJQELYN5EE5/VXeLoOpD4aWjRFK/bIcKGVsNHOFPxS//mtxUu4
         zikyslq+M+TIP29r/M3kgf6JCyQAhanwbeWBuRvyNp/P2ygfsiJciPHS5b9KlCSdX8Tr
         wDlRBeNlS12x1WJkPIIfy8SiHVen1ggCPppIckJMhxNItErvBeJGdzFYX1o3eqnsahGy
         SVKwuRWlJGHr+h89LSIEjaKjZK1t+bSPS+cYguCtIEfWZGHNYAEakI4KPqU55Cff1YIU
         +DRYq1sxEYOkdR44bYWlbh9fcwWVLP1nt6PGU+aR6LkhB4z0ZzOuL2TAKC0vf6OEwreZ
         il1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=q5vQB4DddEL669odkV+UsQkEJ4iF2VTIBEkf5nzMUQs=;
        b=koaLAC1/qRXCC7YgjN0pAdZPnnPVEssrPXayi/4Fr8cf9eC4RTs+Fnd7v6/M6gNW2S
         DkCHFo1XPCo4j8IcXHTVSqWMiiXcMC0+cJdMO168ltZ1h1oblGmVfITW3nMyUWqfXxz8
         Imzhl/gsx53W8rBAo/D1ZmMlx8gqbzZfdQQ0Xbfu1iZGeed73rB4wJi7qBcXlrAgVQDh
         6O05wMfamz6M2Q67qj/NCS+lUoKore1SSTcUm/bkvmrD7bDIz3NTyr/Ly6FKVjNsifbN
         snUUcwL+wnBUuzTYdJ7u8dNOGIXCtxEIR4Vp8UHACmxXoqilQ3s9Zw8XOYE+zDu22+hO
         jBGQ==
X-Gm-Message-State: AOAM531Si/2zGedwvRty11CrHJ87mfwvtJ22RjYVY25rRsrmWr+MxXfP
        rlB3z28Z6XK55I8B6r0GspkODXDAPg0=
X-Google-Smtp-Source: ABdhPJwMkeWsUxIrR0w+S0vxA4gC9Szr4zqjpSpoGbye1wRI/kec9+oHQ5kotNArXzwQAszVANx5UA==
X-Received: by 2002:a17:90a:b78e:: with SMTP id m14mr24651922pjr.94.1597046829734;
        Mon, 10 Aug 2020 01:07:09 -0700 (PDT)
Received: from koo-Z370-HD3 ([143.248.230.14])
        by smtp.gmail.com with ESMTPSA id l63sm17543846pgl.24.2020.08.10.01.07.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Aug 2020 01:07:09 -0700 (PDT)
Date:   Mon, 10 Aug 2020 17:07:05 +0900
From:   Kyoungho Koo <rnrudgh@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH] ext4: remove unused parameter of ext4_generic_delete_entry
 function
Message-ID: <20200810080701.GA14160@koo-Z370-HD3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The ext4_generic_delete_entry function defines the handle_t type
variable, handle, as a parameter, but it is not used.

Signed-off-by: Kyoungho Koo <rnrudgh@gmail.com>
---
 fs/ext4/ext4.h   | 3 +--
 fs/ext4/inline.c | 2 +-
 fs/ext4/namei.c  | 6 ++----
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 5148cbb0b4b3..feda8b65924b 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2764,8 +2764,7 @@ extern int ext4_search_dir(struct buffer_head *bh,
 			   struct ext4_filename *fname,
 			   unsigned int offset,
 			   struct ext4_dir_entry_2 **res_dir);
-extern int ext4_generic_delete_entry(handle_t *handle,
-				     struct inode *dir,
+extern int ext4_generic_delete_entry(struct inode *dir,
 				     struct ext4_dir_entry_2 *de_del,
 				     struct buffer_head *bh,
 				     void *entry_buf,
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index c3a1ad2db122..13054653a06a 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1706,7 +1706,7 @@ int ext4_delete_inline_entry(handle_t *handle,
 	if (err)
 		goto out;
 
-	err = ext4_generic_delete_entry(handle, dir, de_del, bh,
+	err = ext4_generic_delete_entry(dir, de_del, bh,
 					inline_start, inline_size, 0);
 	if (err)
 		goto out;
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 56738b538ddf..f5e60c622ce2 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2455,8 +2455,7 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
  * ext4_generic_delete_entry deletes a directory entry by merging it
  * with the previous entry
  */
-int ext4_generic_delete_entry(handle_t *handle,
-			      struct inode *dir,
+int ext4_generic_delete_entry(struct inode *dir,
 			      struct ext4_dir_entry_2 *de_del,
 			      struct buffer_head *bh,
 			      void *entry_buf,
@@ -2517,8 +2516,7 @@ static int ext4_delete_entry(handle_t *handle,
 	if (unlikely(err))
 		goto out;
 
-	err = ext4_generic_delete_entry(handle, dir, de_del,
-					bh, bh->b_data,
+	err = ext4_generic_delete_entry(dir, de_del, bh, bh->b_data,
 					dir->i_sb->s_blocksize, csum_size);
 	if (err)
 		goto out;
-- 
2.17.1

