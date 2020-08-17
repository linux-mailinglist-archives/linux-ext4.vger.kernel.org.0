Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFD2245E20
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Aug 2020 09:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgHQHgL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 Aug 2020 03:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgHQHgK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 17 Aug 2020 03:36:10 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795F9C061388
        for <linux-ext4@vger.kernel.org>; Mon, 17 Aug 2020 00:36:10 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id e4so7411352pjd.0
        for <linux-ext4@vger.kernel.org>; Mon, 17 Aug 2020 00:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mj4Fnp34XlwG/1YgIudDj9/KW0wKeHD0PBqpQFlH/o0=;
        b=LnCf88XjNU59LPzSD9vF0RceIyHcXL+qEwhSAgT7CUbMNcIZxUK5/6+gBK199clbfz
         LaZPrYUIcRrHOywUSTvzo8siuyfgEwhG5ZM49TxUr7LJfARz2TApWzUFILzUbGQRqOH3
         LwMt7/V8ACRf5vmPTDGN6LKSgKdTykPNvYH/53cCwbbsiLbURLXb4b/7Sch/RrJSz+vI
         1UXxO8PjlW2u1f4tFAmXtSSz/ePO4toS6cHx6fvk0ntRYrywi2s3PFCVh6MjQ7Oy3bqv
         Vo/XMSvLNWPf++h/zxhoIzkfCLnnwTbCEOwo1sf/uLxz4DsaKyE2oveZFQ0awMW4GyQW
         kkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mj4Fnp34XlwG/1YgIudDj9/KW0wKeHD0PBqpQFlH/o0=;
        b=V7OBqxdXhsPMGFTeoNeOxEIDMnwDFn+t0q7zxdB3nVqiBp4Dl/JiMe58aqE7SvFT6K
         bcX01f3yDUQz4FnzmQBZ6yrW2YXzgdCHuOx91ll4lnqBI7lToLYgnQX5fahZYWyO3kKq
         toyhGEK1vMAwDm2Kn+8xCAiIRVvYMQxa+67WuAcpVj7fLrM7UPGJ5AgpxMbeAIZyEu7m
         g9wGaBmYevm4Q1qgoPRy9FR6blrXln2BcCyoqdlfCAUDlwsLiJPXNug3jKa9dK/ZY31s
         PTcmfJ4yGYRsmT/LblnP4fDbE5E1+V8DGQX/fdmQunuLSkowfTpZ0/ZZKwi/4RyVbn/8
         k4Vg==
X-Gm-Message-State: AOAM533a7oKZAz5LYKfLryBDp+a7EQJbJuaiwoTDNYa4b5s9vLhdrV5Z
        X39hhFkI/yfwAI+monB8b77uQkjiz0o=
X-Google-Smtp-Source: ABdhPJydRKq9CSvIi8iOvg27e5ebMBi0q58VHyStEJlDW2VESOsA6VWfif2u4luIcAR47F3xNapF3A==
X-Received: by 2002:a17:902:54c:: with SMTP id 70mr10279459plf.233.1597649769728;
        Mon, 17 Aug 2020 00:36:09 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.50])
        by smtp.gmail.com with ESMTPSA id o17sm15990450pgn.73.2020.08.17.00.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 00:36:09 -0700 (PDT)
To:     adilger.kernel@dilger.ca, tytso@mit.edu
Cc:     riteshh@linux.ibm.com, jack@suse.cz, linux-ext4@vger.kernel.org
References: <530dadc7-7bee-6d90-38b8-3af56c428297@gmail.com>
 <20200815133212.8D164A4057@d06av23.portsmouth.uk.ibm.com>
From:   brookxu <brookxu.cn@gmail.com>
Subject: [PATCH v5 1/2] ext4: reorganize if statement of
 ext4_mb_release_context()
Message-ID: <5439ac6f-db79-ad68-76c1-a4dda9aa0cc3@gmail.com>
Date:   Mon, 17 Aug 2020 15:36:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200815133212.8D164A4057@d06av23.portsmouth.uk.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
index 70b110f..51f37f1 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4567,20 +4567,19 @@ static int ext4_mb_release_context(struct ext4_allocation_context *ac)
 			pa->pa_free -= ac->ac_b_ex.fe_len;
 			pa->pa_len -= ac->ac_b_ex.fe_len;
 			spin_unlock(&pa->pa_lock);
-		}
-	}
-	if (pa) {
-		/*
-		 * We want to add the pa to the right bucket.
-		 * Remove it from the list and while adding
-		 * make sure the list to which we are adding
-		 * doesn't grow big.
-		 */
-		if ((pa->pa_type == MB_GROUP_PA) && likely(pa->pa_free)) {
-			spin_lock(pa->pa_obj_lock);
-			list_del_rcu(&pa->pa_inode_list);
-			spin_unlock(pa->pa_obj_lock);
-			ext4_mb_add_n_trim(ac);
+
+			/*
+			 * We want to add the pa to the right bucket.
+			 * Remove it from the list and while adding
+			 * make sure the list to which we are adding
+			 * doesn't grow big.
+			 */
+			if (likely(pa->pa_free)) {
+				spin_lock(pa->pa_obj_lock);
+				list_del_rcu(&pa->pa_inode_list);
+				spin_unlock(pa->pa_obj_lock);
+				ext4_mb_add_n_trim(ac);
+			}
 		}
 		ext4_mb_put_pa(ac, ac->ac_sb, pa);
 	}
-- 
1.8.3.1


