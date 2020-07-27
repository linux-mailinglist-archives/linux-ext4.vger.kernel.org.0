Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608A022E3C2
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Jul 2020 03:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgG0ByR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 26 Jul 2020 21:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgG0ByR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 26 Jul 2020 21:54:17 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6C4C0619D2;
        Sun, 26 Jul 2020 18:54:17 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id z5so8509691pgb.6;
        Sun, 26 Jul 2020 18:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=pU/UU8AOp1QLTy9B4XFXlftgUkYl03lBkuurw1t3dUw=;
        b=upbNmjKqiITvbt80uVdCAQ+IFdsRaT7iTzzbJXy0DE1wzjOmQ/k5OyppIysYsXoqTB
         QS4ise0k7eBVKfsYfwR9YUA3dMvZmQmJ/ME4M5ahHpMNpv8GLpgpFui9tn3Y76IBJ6Lj
         pQm946BigPStLigLjWdEhQGI7jC8fgbQDozDba4qs+chXrhPDjrWU56blVYU43/5ja9R
         jDelIus57jnmY9tkvwHS6VdZANEAzL1KXND9lI2SIYgX/R/Jt8qAWxh7reNiPdL3welf
         HhjK9aB0FSEuz3/u5coEEqdnQrfVgf0sXEaCNhOLXxRNGOqeliMOXeu+QRTk9JP6O8Sy
         tywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=pU/UU8AOp1QLTy9B4XFXlftgUkYl03lBkuurw1t3dUw=;
        b=adAVwQ477jG5JwZI77PxXqGIpUet/82DpaclNBSLmisGvu32Iiq8AtgsDk7NQN5IhC
         X+jWsFibKz3v6Ipff2yzeeZaZoMtDICebxGVpze4keXn71lU5jtyfde1rZ0X5J5IHsjo
         k+3aRw77mcTrPC5vXBQhz/KFl65kfy77Qwmbxg59XOesM9wFHom2AutlAYUAPLfBVzwf
         TNmnz2o8FcKcYebsDJ/rU3+ejtY5oe5fs1zF6ZmUpBUrqiTnemMpFuTSHleYYMkvORyn
         z1au5FATn3v0YfDxuDJDKKz2xE0QJg9KJzOQ0UNMA1iZXUHUqKrugmetKY9wopnp26aS
         Sk8g==
X-Gm-Message-State: AOAM530g8CtCaKeIvk2zlZxcohCsI9gX9mgXtrjovJrlCo9x8oo4Rcft
        u10fJexByuPTKsWTsZ6KH62fLCGM86w=
X-Google-Smtp-Source: ABdhPJwj1VtqxsoeuuFgonN3D/HINlVgZkGW5GZOis7sSgQ1xqG2tO1B0Ivqq59S6nl95T5MQr8cpA==
X-Received: by 2002:a63:5004:: with SMTP id e4mr18127350pgb.208.1595814856732;
        Sun, 26 Jul 2020 18:54:16 -0700 (PDT)
Received: from [10.8.0.10] ([203.205.141.54])
        by smtp.gmail.com with ESMTPSA id e5sm12218011pjy.26.2020.07.26.18.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2020 18:54:16 -0700 (PDT)
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
From:   brookxu <brookxu.cn@gmail.com>
Subject: ext4: delete the invalid BUGON in ext4_mb_load_buddy_gfp()
Message-ID: <ad68e8a2-5ec3-5beb-537f-f3e53f55367a@gmail.com>
Date:   Mon, 27 Jul 2020 09:54:14 +0800
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

Delete the invalid BUGON in ext4_mb_load_buddy_gfp(), the previous
code has already judged whether page is NULL.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/ext4/mballoc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 28a139f..9b1c3ad 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1279,9 +1279,6 @@ int ext4_mb_init_group(struct super_block *sb, ext4_group_t group, gfp_t gfp)
     e4b->bd_buddy_page = page;
     e4b->bd_buddy = page_address(page) + (poff * sb->s_blocksize);
 
-    BUG_ON(e4b->bd_bitmap_page == NULL);
-    BUG_ON(e4b->bd_buddy_page == NULL);
-
     return 0;
 
 err:
-- 
1.8.3.1

