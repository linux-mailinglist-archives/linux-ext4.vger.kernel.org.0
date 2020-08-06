Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679A323D70E
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Aug 2020 08:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgHFG45 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Aug 2020 02:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgHFG44 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Aug 2020 02:56:56 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3F6C061574
        for <linux-ext4@vger.kernel.org>; Wed,  5 Aug 2020 23:56:55 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id c10so4300873pjn.1
        for <linux-ext4@vger.kernel.org>; Wed, 05 Aug 2020 23:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=4t0GZUqaSa6aUwCTaIwAXrly6p8Czif4LGn3BgFT6TE=;
        b=KHFceP4qpWXW3z3v9kZGkponk/zeh4XHOdYcvaCeQVqTcLZfgAT8gmayGWtyhy+9dN
         tD8uXQ78/iCAdzLFHZUsrNpwOf8nqVfkv207NZQxF96qQ9jDZsVPv2ZTcI6b+EfRCppN
         vGFeKymzj2JukwxvhuGvwsQGIOwHfBzT0B1IDDC/dofXF2Weyhg4IIx7xNaIm8n7YUgC
         zm8XLoL3TZL75qkf2zSYW8dXLLD/EEwkV3fj8dKT6HV1ELOUhL1T8NGot046KYGTxclK
         NaVOmjlJ5WGNfDmgxWIYCwF6/dkl89a0ePDw8mkBimSeN9hu/ohZkONgJdWtuKEL7okT
         aKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=4t0GZUqaSa6aUwCTaIwAXrly6p8Czif4LGn3BgFT6TE=;
        b=HWCsrYSz/1nwTCDFv7+we0XznypB1gGadNGKdH65Tm+dCgnyiJcUDoGpBADVUu9SHj
         jfte0MxUxklct/KMAxPc9U65x/blyj/Ih2WfdW3haLEmnSoaDLdQ/GQGTYaNKFTFXckm
         BR8WBSVQ2LaE31WXIXZ1Kj5iv/FNzKu6cAZtzy9pdEdlSTvMeQpUfO9aPbM9ZSjwVVU3
         0gebjtYqZLULlM+O1cIBOHStQTTP/vjl7UhecyGMb0be0UQtcEJuD+70K4ybFysr7PGC
         4JzmizD6WKGfnRwH5dGyOMFpzpq8elx2psDilI7NG4b/pSbmgCPPuyOmd4itU5Fl/njI
         +zXA==
X-Gm-Message-State: AOAM531Y5CkLp+nxn0i7/ZuWVj9IM+/kSjVIzgoQLLcYZ3pRQovZTg3E
        TBUYQs9k5F/MEs4LnqmGs3BJ1wn4GZU=
X-Google-Smtp-Source: ABdhPJxqWumsJYVsZOd1ncruVXHSguSABtFUX4ecaLJPzH5htaJa2ny+epM+Z8cqHWkuKo+R2sYaAw==
X-Received: by 2002:a17:902:9883:: with SMTP id s3mr6252830plp.271.1596697015209;
        Wed, 05 Aug 2020 23:56:55 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.45])
        by smtp.gmail.com with ESMTPSA id b185sm6467549pfg.71.2020.08.05.23.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 23:56:54 -0700 (PDT)
To:     adilger.kernel@dilger.ca, tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org
From:   brookxu <brookxu.cn@gmail.com>
Subject: [PATCH v3 1/2] ext4: reorganize if statement of
 ext4_mb_release_context()
Message-ID: <60972aac-6f04-0945-3ef9-f5d0ecbf147c@gmail.com>
Date:   Thu, 6 Aug 2020 14:56:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Reorganize the if statement of ext4_mb_release_context(), make it
easier to read.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/ext4/mballoc.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index c0a331e..4f21f34 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4564,20 +4564,19 @@ static int ext4_mb_release_context(struct ext4_allocation_context *ac)
             pa->pa_free -= ac->ac_b_ex.fe_len;
             pa->pa_len -= ac->ac_b_ex.fe_len;
             spin_unlock(&pa->pa_lock);
-        }
-    }
-    if (pa) {
-        /*
-         * We want to add the pa to the right bucket.
-         * Remove it from the list and while adding
-         * make sure the list to which we are adding
-         * doesn't grow big.
-         */
-        if ((pa->pa_type == MB_GROUP_PA) && likely(pa->pa_free)) {
-            spin_lock(pa->pa_obj_lock);
-            list_del_rcu(&pa->pa_inode_list);
-            spin_unlock(pa->pa_obj_lock);
-            ext4_mb_add_n_trim(ac);
+
+            /*
+             * We want to add the pa to the right bucket.
+             * Remove it from the list and while adding
+             * make sure the list to which we are adding
+             * doesn't grow big.
+             */
+            if (likely(pa->pa_free)) {
+                spin_lock(pa->pa_obj_lock);
+                list_del_rcu(&pa->pa_inode_list);
+                spin_unlock(pa->pa_obj_lock);
+                ext4_mb_add_n_trim(ac);
+            }
         }
         ext4_mb_put_pa(ac, ac->ac_sb, pa);
     }
-- 
1.8.3.1

