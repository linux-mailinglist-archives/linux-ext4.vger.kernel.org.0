Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240DD23E96F
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Aug 2020 10:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgHGIo1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Aug 2020 04:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgHGIo0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Aug 2020 04:44:26 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC000C061574
        for <linux-ext4@vger.kernel.org>; Fri,  7 Aug 2020 01:44:26 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id d4so573950pjx.5
        for <linux-ext4@vger.kernel.org>; Fri, 07 Aug 2020 01:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=3tYQih+V+ppeG2IQ/RtzaWDnprFZ6lzdIW/WjrGH4Ik=;
        b=FqzK8IRGVt7d90+Za+VgbGr72uTKhaSdegj+gQFFM2l7A/VmfJfohXDGUvqKy0ivOD
         dc2QgV6W4Pk+Q6U3Kyktgihf4YdIEXiac6GbAGDF2PNHwiL/lK9eaLIJCT/O/77Qe+B9
         rxyhOJiIWPlyntyH5RwXwOKAj1jZDgdT1IljHJ8n7d7jzq8O4YI6cXOUWc4fI8JlnBoX
         /K5jus8t0HPii/cz9ksXu9MTlcI+XaRZSJcSeRbBPfcZxwhqh7wiGhCCna8NrqrcGRJx
         c6cajIEPZni0B1tHCIEsOqeC/oWN3u/b7HBMs7KcX/i4YCn/mpnGuvVua4pF09gSXG1c
         FuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=3tYQih+V+ppeG2IQ/RtzaWDnprFZ6lzdIW/WjrGH4Ik=;
        b=eNzRxuqU2WiThjmpBDAcAT2Shh4BGvgvwB//HIj3sfiDgpcSW1sPvluy9jVu+m+GLL
         ODePBp7NebiXEjZmDs24h4yuqt1k+pJ6J371JwDP23jEKb1h2H8AfRu+uay20gmH/mWk
         QJMrxSHjEbZf9zueZl0Zv0FLLK+ktvYJ0kGWuHlv8VNp84iCqNjQp2m4Lk2bmVmSbpX2
         jyEmRHI8rnc7tB7KrBxn/Q497Ux9RgzsElhHaVzm0eOSjdlweI+1BK8G/Eu7L0RhRy8O
         iFge1DKDg222AYDLqK7UkpESmgZX4qxdqY55dKKCfUixbiam3F2LQUHGGahZ9sqXt+AY
         bo1Q==
X-Gm-Message-State: AOAM532f8SBtBvlHUJqewACwhGaZ/1NTNJwJLyr2pn90AQBRVie963z5
        0wF5X/H2mPLSdejvwQXjGRpfpWLkKXI=
X-Google-Smtp-Source: ABdhPJxlwKORzU3HNP04Ie0TXZmBaYw+aR3lHdEk8CaoSdX9qFpmEWnA+h7hlA7j6znQLzP6Gq5EHA==
X-Received: by 2002:a17:90a:1682:: with SMTP id o2mr12963888pja.227.1596789866009;
        Fri, 07 Aug 2020 01:44:26 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.44])
        by smtp.gmail.com with ESMTPSA id g15sm11813279pfh.70.2020.08.07.01.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 01:44:25 -0700 (PDT)
To:     adilger.kernel@dilger.ca, tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org
From:   brookxu <brookxu.cn@gmail.com>
Subject: [PATCH v4 1/2] ext4: reorganize if statement of
 ext4_mb_release_context()
Message-ID: <03e83854-e5b3-ef78-e004-4de4689e84da@gmail.com>
Date:   Fri, 7 Aug 2020 16:44:23 +0800
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
