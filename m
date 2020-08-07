Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F3123EE8A
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Aug 2020 16:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgHGODs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Aug 2020 10:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgHGOBs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Aug 2020 10:01:48 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AC5C061756
        for <linux-ext4@vger.kernel.org>; Fri,  7 Aug 2020 07:01:42 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k18so1041365pfp.7
        for <linux-ext4@vger.kernel.org>; Fri, 07 Aug 2020 07:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=RDZK4ePD0f/Jd2tccTa1htlhHUCJxtsS0PFYYGmt+7A=;
        b=Rw4JiFblk9B2SYat91tmzq8gnudaDz/EO0mPPMt52NHbMbihQxZ16S/XUEWHxex2cp
         Mxp7BCqYJtvfj2qxORBPFuLvdnvJUWJUhYiaX91YMqyEudS8F/dqbzB0br9kb0yj9yyy
         tcVyIEYOqkcHH4hjj649gZIE+IGY2d5Lz/ltrkEYTxPYa0ENUmGOsJ9F9KucF8e+6LLG
         avslblGrwXy0Xw8/gQMp9RyDxcwtew2B9xu2J+usNz48uY6B7fp3CPMYKAe/XCsImB7w
         PZKhW0Aivs4ZOUuS2jkaC7FO77S3RgFEHEmW+wzT1W0ADQARFeIn19RbGjWbfFD6mDjQ
         DTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=RDZK4ePD0f/Jd2tccTa1htlhHUCJxtsS0PFYYGmt+7A=;
        b=MmWMoksxs35uP15SUFcAf/9dxoUQplyK5El6YvZmWTlbxDSgyiJO0VUPCHPXkci1yo
         Zlwn4AECmJgKKZrOgPDmWsQNK77Y7Z/CpbCTThraqrWvKieHIbIlXiul494FJdIbPi7u
         g7NCLrys0+MD1SDh1jJxEWPFtcCtQ0zNzAcQuvaUb/n27HOcUVqfX/cRs/U0oallIaM7
         O9PuLLTX17N3CZF6Y1QhP3Orrj7VoplnKZ3ESUJUUtFVuANs395MihSlQmiWoK1PQeFA
         1k6NYCX0R5L0iymf0/NA2gmy2PRP30CzWWF+jyzDz539RCudSsiSNEvJvC2RSD4rIeiv
         LqEA==
X-Gm-Message-State: AOAM533UsiMFLoDC1Xhv3WqcKx8/d9h1wmg0TKFUDmSJAlu+8iqwnF5g
        c8c4KNzTxIfH7bvRhlvBj8Q4vwxh67o=
X-Google-Smtp-Source: ABdhPJxN2wSpP+d5PvvQbW88XX+IqWq2+u3g93XfK+4v4Yr4TYBEuRy+V6R0aOEiTcVvHN5KHohz0w==
X-Received: by 2002:aa7:8a0d:: with SMTP id m13mr13050401pfa.13.1596808901402;
        Fri, 07 Aug 2020 07:01:41 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.44])
        by smtp.gmail.com with ESMTPSA id b63sm12607403pfg.43.2020.08.07.07.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 07:01:41 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
Subject: [PATCH] ext4: optimize the implementation of ext4_mb_good_group()
To:     adilger.kernel@dilger.ca, tytso@mit.edu, linux-ext4@vger.kernel.org
Message-ID: <e20b2d8f-1154-adb7-3831-a9e11ba842e9@gmail.com>
Date:   Fri, 7 Aug 2020 22:01:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

It might be better to adjust the code in two places:
1. Determine whether grp is currupt or not should be placed first.
2. (cr<=2 && free <ac->ac_g_ex.fe_len)should may belong to the crx
   strategy, and it may be more appropriate to put it in the
   subsequent switch statement block. For cr1, cr2, the conditions
   in switch potentially realize the above judgment. For cr0, we
   should add (free <ac->ac_g_ex.fe_len) judgment, and then delete
   (free / fragments) >= ac->ac_g_ex.fe_len), because cr0 returns
   true by default.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/ext4/mballoc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 28a139f..4304113 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2119,13 +2119,11 @@ static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
 
 	BUG_ON(cr < 0 || cr >= 4);
 
-	free = grp->bb_free;
-	if (free == 0)
-		return false;
-	if (cr <= 2 && free < ac->ac_g_ex.fe_len)
+	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
 		return false;
 
-	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
+	free = grp->bb_free;
+	if (free == 0)
 		return false;
 
 	fragments = grp->bb_fragments;
@@ -2142,8 +2140,10 @@ static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
 		    ((group % flex_size) == 0))
 			return false;
 
-		if ((ac->ac_2order > ac->ac_sb->s_blocksize_bits+1) ||
-		    (free / fragments) >= ac->ac_g_ex.fe_len)
+		if (free < ac->ac_g_ex.fe_len)
+			return false;
+
+		if (ac->ac_2order > ac->ac_sb->s_blocksize_bits+1)
 			return true;
 
 		if (grp->bb_largest_free_order < ac->ac_2order)
-- 
1.8.3.1

