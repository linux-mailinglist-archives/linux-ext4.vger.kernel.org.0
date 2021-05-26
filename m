Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906E439128A
	for <lists+linux-ext4@lfdr.de>; Wed, 26 May 2021 10:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbhEZIo4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 May 2021 04:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbhEZIoz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 May 2021 04:44:55 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EEBC061574;
        Wed, 26 May 2021 01:43:24 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q15so340418pgg.12;
        Wed, 26 May 2021 01:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F9BawxCs/7ZIyDa37Le2Yvwu2P1I/URUI6MTJkKviLw=;
        b=kDPhnwVdxb5ddOeUc94E3Dv00TVTJkO1AcdyDcgSID6DIDCD7wUPRykSaHwBRlicck
         hzKXCDVqo6fNLBS3a6XWlzKLtPNEMV13USEbznBTPK8osgYCTarqEuzg3JiurA2ydX7b
         cVe+0C900liuDmb4I6cSjReBMMKPczvF8Hp0o9vIbmE1R2fV3DMRAl62NV43ne4l5iXD
         jTSA7q7BRh14N+7kGeBuMupEFMjgJswGBcTpLK8eI3nO0GMh02rt+b4qrWuNrg3OVoWE
         lWl5GJdAXutL/7ROjJ7nqBUkrCF3hnJnH8Cs3JWr0gKoxV2qA4tpilfmZxYw4BVlOR+L
         cWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F9BawxCs/7ZIyDa37Le2Yvwu2P1I/URUI6MTJkKviLw=;
        b=bkcZDZm5bl40jlr7smJzAPR+feZdo79HgJpHtrqw1m5DlRIiibGlny+/LaX5kgfL+W
         tFNWwejK2A1udAG97PnU3vA+t2r9Xlh9w7+WWm/QjiHR/IEH8q3Az2u8Zl9AshMhg5AZ
         MSMFJIjKdCR6VaJkRiUGKufs3fTJnlDEawIIjO3fxPiotnYZJ3zZ/sF/jj9iDd+kqZv+
         XU0HZgGBncSs1dT6DRO3simBeb/Ae5bD7h85tcuGHlpDTo0xrD07LZ0I6WTIkhqpBW8F
         +d2i/gb00TmM3yTsQiPKCtrIe3uy0k7aBzqYQDyeQYuM3s72S2Oml4p62BC2QBPf0VCS
         Y4FA==
X-Gm-Message-State: AOAM533ZUTAvEonH20OAenEtKIMgprcmrDY7DPCG5lTjcDcyzd2P08o/
        D/wsVIYJprjz+gFz4OWQHBA=
X-Google-Smtp-Source: ABdhPJzMH/lzv3MLi4CSFPwKUkhO3j3zh2Mjibq0SETkFvd6dgZ3bPHrRjf9hJoawM8N5C/NTVUbtA==
X-Received: by 2002:a63:1260:: with SMTP id 32mr4034907pgs.232.1622018604241;
        Wed, 26 May 2021 01:43:24 -0700 (PDT)
Received: from jianchwadeMacBook-Pro.local ([103.112.79.203])
        by smtp.gmail.com with ESMTPSA id 80sm16276183pgc.23.2021.05.26.01.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 01:43:23 -0700 (PDT)
From:   Wang Jianchao <jianchao.wan9@gmail.com>
Subject: [PATCH V2 3/7] ext4: remove the repeated comment of
 ext4_trim_all_free
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        lishujin@kuaishou.com
References: <164ffa3b-c4d5-6967-feba-b972995a6dfb@gmail.com>
 <a602a6ba-2073-8384-4c8f-d669ee25c065@gmail.com>
 <49382052-6238-f1fb-40d1-b6b801b39ff7@gmail.com>
Message-ID: <aeaa8757-b0f9-7e3e-278c-c8de77c1b6fc@gmail.com>
Date:   Wed, 26 May 2021 16:43:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <49382052-6238-f1fb-40d1-b6b801b39ff7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
---
 fs/ext4/mballoc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index f984f15..85418cf 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5741,15 +5741,10 @@ static int ext4_try_to_trim_range(struct super_block *sb,
  * @max:		last group block to examine
  * @minblocks:		minimum extent block count
  *
- * ext4_trim_all_free walks through group's buddy bitmap searching for free
- * extents. When the free block is found, ext4_trim_extent is called to TRIM
- * the extent.
- *
- *
  * ext4_trim_all_free walks through group's block bitmap searching for free
  * extents. When the free extent is found, mark it as used in group buddy
  * bitmap. Then issue a TRIM command on this extent and free the extent in
- * the group buddy bitmap. This is done until whole group is scanned.
+ * the group buddy bitmap.
  */
 static ext4_grpblk_t
 ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
-- 
1.8.3.1
