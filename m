Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD6523C2D4
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Aug 2020 03:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgHEBB7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Aug 2020 21:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgHEBB6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Aug 2020 21:01:58 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F9AC06174A;
        Tue,  4 Aug 2020 18:01:58 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id s26so21713911pfm.4;
        Tue, 04 Aug 2020 18:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=779GA4ne4hG10vf7ILajmZMSldpFUYldREE8I8fw+1A=;
        b=MyfayZcjUINiLbATVxujs5llmwbJc8kaM1+B9KNX8iCoLU511ppU+6iVobwe5LZnUL
         brQtd+CZxgJTGmMnuiBTH+EYWUoK8ylNKmYKaKEnCYDuvOvs6WGJLfVD/gi3PUxlJrnh
         wla7xZGHgh8MQ8VPPsQhAXffrCamPOEbKnYs/1v3oGm49dtqTlPCwqsCSMJaMq0ZGZPD
         M4BuNOFVbNPW/aYsecJWQr2oRhmEB1053Vt3RZlkNsSr9BR5oDMaPuR0LaKQPF/crxpa
         M+SRKqrvVKDamRDA95kxLat6d8MlHULc0bsJ40sMbWYIWzEyZcLSJg6pDujGiTTcdI2M
         4GEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=779GA4ne4hG10vf7ILajmZMSldpFUYldREE8I8fw+1A=;
        b=hEJETjPjN7yMAqdvjjNwLYg9Qkl0EvuuARx/dVHDDHviyOWdWKllPgepZg8UtrwTj4
         k7Ixtw0zoWwuLDygcaBEngfs36Zhs85YltY9AdkWYhmKCo7uE7SorqfBewf4PTQLE0hB
         HwYIFkZDRFc8hvJAA+Q3bb7jeejwi42or9ZCMpz4rxK8OM2cdsfnbqSnYzHUsvdQikxx
         mNFc/p5kM4kF55fFWUp2R8azuTK1y2nUnpwLG6rn+O2Z+DbL1clPkTWQUz/XWKa+NmQT
         6ksCgeH9rQwO/WB6xsEpZfmLD3gmHtW0MFl7sYPn0q+HNTP5AeTxweH5jWadjiNkukH8
         GfXw==
X-Gm-Message-State: AOAM532VKaIH8ScJ30sbl3NiTLBnc+0hutWCud/+e3rpLJOi/tod8AY4
        rbvZLG4c1AqQm9v6eY+soHp6W/EIYB0=
X-Google-Smtp-Source: ABdhPJwopVXTyrxKr65BisMgIqUzDCAhDLiTJng9CCOc5zPvLdxx3zqy8SwQlTuxDoXM88PsQK0lFQ==
X-Received: by 2002:aa7:9a4c:: with SMTP id x12mr956350pfj.307.1596589317417;
        Tue, 04 Aug 2020 18:01:57 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.45])
        by smtp.gmail.com with ESMTPSA id r185sm489377pfr.8.2020.08.04.18.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 18:01:57 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
Subject: [PATCH v2 1/3] ext4: reorganize if statement of
 ext4_mb_release_context()
To:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-kernel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org
Message-ID: <ad1ac152-6d52-13cd-5786-7c888bf9370d@gmail.com>
Date:   Wed, 5 Aug 2020 09:01:55 +0800
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

