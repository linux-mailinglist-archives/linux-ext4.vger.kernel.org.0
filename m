Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22522B80D9
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgKRPlL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbgKRPlL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:41:11 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EBFC0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:11 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id z130so1501275pgz.19
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=5raDp+nOWma+/5kc4saNDNxM5weU8Iq0IzEpPV0rCbU=;
        b=n+ZwreDcDf1fEeDc7RNipvoTbH22hJ6ILsCqG75zc01N6R0LVo+2kbr+wshEgw+rTm
         2LZKwE5lgoYKGgyIGw3JxyRCwqyZs42b/xew4e9odl4Bn8LZhH8tmacrMREMz9hYhbDi
         9PrsKd2WznCb/0sCB+s9fgGz5uw7b+VOtJCTrOgQ95EYE4CudbrgzstvmA2z1G4vRdUN
         4rSiD1VSgid0wMcK1FGr2lgdCKTuj+odoevd7reFGu5bCUHoeQ94raVV1Y5Ej7IHJt5Y
         OKd/NcLqtwhCXJdjvUNqVfBqOktqircZuzr/v6yuRrSflfg/H8fRRjKZgdTWAGq3zjox
         cH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5raDp+nOWma+/5kc4saNDNxM5weU8Iq0IzEpPV0rCbU=;
        b=nPzXCjoWo3sAOtei+yGre0I5QBsR6jvWi9+1mQ1QSggi+X/YUt8SrRLbXxyd7YcBVy
         UZ56NquxdwYEyn/nPjJKtAn6U/riMMnJ2NQ5XFMWkMzMMy012/HB4lfnEtUTRwOINIM8
         spiVOsrf3DHZYf9wFjF5kW6Tf/94X9k96HxSmQxWdvwahpQyQ1AhR9A5Nl4okDW6T1ul
         Q8xSi5dph/YBWzM7WrQ42DPS62xh25W2EytPmYBpozbse1926CkbMF5FLN9FaspeGKXT
         sr6HN91IiVK490tK8ryM1pInjhNC9ESnl4vtX+wsyQYCxlX0WkMCwR2hkAa3kCrdtGM+
         +Siw==
X-Gm-Message-State: AOAM5331Cz3lTSfNVpmiFBv+RVTTnhJrKsCgEfTyys/6AYzTBHijFUjA
        u4B56HN4oe2loE3GF8EVxZ2n2o+/l/65ECf6Ef5qwzH3Zu75UJNiK0+Rr766dOngZrXOfay+jeZ
        AVPlOXJt+2p4U1JDORLPSh5GeH9mLEFgRvFkZDkD951R8wbpnWzaorgfTjUSmFTOMZNYDLvGeXo
        8M6xQPEWg=
X-Google-Smtp-Source: ABdhPJxKXwfwxzbSPiUNHZyQN8+KGkmkA8oTVTFnmWJ8Ahw7mwTfjg+WU2OXb11H9dcz0NZan1eFdQ9S7wiHNnscn4k=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a63:e24:: with SMTP id
 d36mr8570498pgl.373.1605714070479; Wed, 18 Nov 2020 07:41:10 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:10 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-25-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 24/61] e2fsck: merge fs flags when threads finish
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Li Xi <lixi@ddn.com>,
        Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Xi <lixi@ddn.com>

merge fs flags properly.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/pass1.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index af0ff724..783e14f0 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2245,6 +2245,7 @@ static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 	ext2fs_block_bitmap block_map;
 	ext2_badblocks_list badblocks;
 	ext2_dblist dblist;
+	int flags;
 
 	dest_io = dest->io;
 	dest_image_io = dest->image_io;
@@ -2252,6 +2253,7 @@ static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 	block_map = dest->block_map;
 	badblocks = dest->badblocks;
 	dblist = dest->dblist;
+	flags = dest->flags;
 
 	memcpy(dest, src, sizeof(struct struct_ext2_filsys));
 	dest->io = dest_io;
@@ -2263,6 +2265,9 @@ static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 	dest->dblist = dblist;
 	if (dest->dblist)
 		dest->dblist->fs = dest;
+	dest->flags = src->flags | flags;
+	if (!(src->flags & EXT2_FLAG_VALID) || !(flags & EXT2_FLAG_VALID))
+		ext2fs_unmark_valid(dest);
 
 	if (src->icache) {
 		ext2fs_free_inode_cache(src->icache);
-- 
2.29.2.299.gdc1121823c-goog

