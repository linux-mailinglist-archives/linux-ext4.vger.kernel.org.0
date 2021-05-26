Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B0739129C
	for <lists+linux-ext4@lfdr.de>; Wed, 26 May 2021 10:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbhEZIpS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 May 2021 04:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbhEZIpR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 May 2021 04:45:17 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329B1C061574;
        Wed, 26 May 2021 01:43:46 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x18so409001pfi.9;
        Wed, 26 May 2021 01:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TA9xJ9PtHz9pmM6zL8ig8SFoo1C9SL8VTQvVBosCszM=;
        b=jMNPGl5hZ2TsiFuoj5fApo2D75V2A9G6MsWKqnShLLkvlDCrV1E5tBiDCfKJ8Zc0LJ
         KWdswe46yHbXRTC6SmhS/VMQ64P+UTqF2fH3EbpdlHVn+xZD+Q/IetynJm9zft3RQpbA
         X/MrvWNVaZ+3juwoFve3LlA0xiyd4m0PJfFGi5z+pmowhCj8op/V9tz98kE7PDEi8W+A
         +am3qCB+gzBpzdbrJVJr3inEQG0Jt90JIWdRub5wk/2iIWygPUKN79apY2TQdVbe494U
         FTauRXZPIsZsgcVh+UWmU6bq3A87l6zSU66PsBC0sYEoDvFJDIi6UaxQTiT5lCxV1Omc
         VYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TA9xJ9PtHz9pmM6zL8ig8SFoo1C9SL8VTQvVBosCszM=;
        b=loFTjOu/tcY+zUIbemudhXPR3bEgYAJu0CyMW1GLFWZku60CVbhgDm5fv9Gs4O6QOG
         /G/XGec2pt1Qgqa1cFhH5HPIAYSyaSOGSWZ/iR/vR41KfYCqUj6kIVWKrNnkxZ935P57
         R/UxwvDaCoArHODOKdp45vNmGGaocd1cYiSmqBdpHZXr9XDQ+PSzLKG/cN95eib4i3XW
         WYETwCF57BKQpZfbTf/HSMZd0Cpv6Tmm9PNXAunYfr2t2Hfmq4wpwplS4KRfPDheDfsJ
         8HI8oSjwi4aHM9bNAPpAsOz+2evrLy99eoEBPHIQIm6tI+fM17ohF+aQJUmlJH6/kQ5U
         lsVw==
X-Gm-Message-State: AOAM531PzwfWi5cOEiS91Zhzviyu0+eJ39KpJE2xHMIlAsXeEVpk4KeM
        ghBKj8Y0TExx6zZm+nvInwKkUjPNWLA=
X-Google-Smtp-Source: ABdhPJzwQPbzmIHVR3qEb9ecRhlQ7RJF+UatmyYVFtmYGY58bPzu06Di7cFaze2FaBtzs25fHqqsfg==
X-Received: by 2002:a63:e104:: with SMTP id z4mr16040008pgh.249.1622018625839;
        Wed, 26 May 2021 01:43:45 -0700 (PDT)
Received: from jianchwadeMacBook-Pro.local ([154.48.252.66])
        by smtp.gmail.com with ESMTPSA id 66sm17008428pgj.9.2021.05.26.01.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 01:43:45 -0700 (PDT)
From:   Wang Jianchao <jianchao.wan9@gmail.com>
Subject: [PATCH V2 5/7] ext4: get buddy cache after insert successfully
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        lishujin@kuaishou.com
References: <164ffa3b-c4d5-6967-feba-b972995a6dfb@gmail.com>
 <a602a6ba-2073-8384-4c8f-d669ee25c065@gmail.com>
 <49382052-6238-f1fb-40d1-b6b801b39ff7@gmail.com>
 <48e33dea-d15e-f211-0191-e01bd3eb17b3@gmail.com>
 <67eeb65a-d413-c4f9-c06f-d5dcceca0e4f@gmail.com>
Message-ID: <93458049-0d43-617a-a5e7-c7e10325443a@gmail.com>
Date:   Wed, 26 May 2021 16:43:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <67eeb65a-d413-c4f9-c06f-d5dcceca0e4f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The getting of bd_bitmap_page and bd_buddy_page should be done
after insert the ext4_free_data successfully. Otherwise, nobody
can put them.

Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
---
 fs/ext4/mballoc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index b23010c..3e8ad43 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5116,21 +5116,12 @@ static int ext4_insert_free_data( struct ext4_sb_info *sbi,
 	struct ext4_group_info *db = e4b->bd_info;
 	struct super_block *sb = e4b->bd_sb;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	bool first = RB_EMPTY_ROOT(&db->bb_free_root);
 
 	BUG_ON(!ext4_handle_valid(handle));
 	BUG_ON(e4b->bd_bitmap_page == NULL);
 	BUG_ON(e4b->bd_buddy_page == NULL);
 
-	if (!db->bb_free_root.rb_node) {
-		/* first free block exent. We need to
-		   protect buddy cache from being freed,
-		 * otherwise we'll refresh it from
-		 * on-disk bitmap and lose not-yet-available
-		 * blocks */
-		get_page(e4b->bd_buddy_page);
-		get_page(e4b->bd_bitmap_page);
-	}
-
 	if (ext4_insert_free_data(sbi, &db->bb_free_root, nfd)) {
 		ext4_grp_locked_error(sb, e4b->bd_group, 0,
 				ext4_group_first_block_no(sb, e4b->bd_group) +
@@ -5140,6 +5131,15 @@ static int ext4_insert_free_data( struct ext4_sb_info *sbi,
 		return 0;
 	}
 
+	if (first) {
+		/* first free block exent. We need to protect buddy
+		 * cache from being freed, otherwise we'll refresh it
+		 * from on-disk bitmap and lose not-yet-available blocks
+		 */
+		get_page(e4b->bd_buddy_page);
+		get_page(e4b->bd_bitmap_page);
+	}
+
 	spin_lock(&sbi->s_md_lock);
 	list_add_tail(&nfd->efd_list, &sbi->s_freed_data_list);
 	sbi->s_mb_free_pending += nfd->efd_count;
-- 
1.8.3.1
