Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6712AA67F
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Nov 2020 16:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgKGP6v (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 7 Nov 2020 10:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgKGP6u (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 7 Nov 2020 10:58:50 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A238C0613D3
        for <linux-ext4@vger.kernel.org>; Sat,  7 Nov 2020 07:58:50 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id u2so2385327pls.10
        for <linux-ext4@vger.kernel.org>; Sat, 07 Nov 2020 07:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yyvd3jwAS4NyqEI8cpEn4CNVrLNCqfQyDPupxbVc788=;
        b=RUdgbl5BqUqNTnEU6AohlLmbirUbQ6dLdKkb02bTMuETpPWMNKgUfR9t/3aU3/f/KU
         Cj/XPhkriP3VgWS1Ku+lU2+ln/OxIGGQfvC2lZhSi+C8ZQ7kWhRZzxHZR8w3HTBuOY0P
         rTdrxIQXvFN8HEBtFp7Rc3nOFuKJGo97xqyrf4HiAKbN4osBRvho4QpJpPdt6cC3wSr5
         hacKEai8Gw5LaalNQJiqxtNpfqv7p1BRjk3ajH4RNthsCscwLuI9pQo/o5RzoTSXa9et
         79MpNkqwxqAGBlQGSlVKTRBY0ooGHuW7DGshnEbtobxIK3J2AHAQQQCg8VZKnNfrXg4b
         u/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yyvd3jwAS4NyqEI8cpEn4CNVrLNCqfQyDPupxbVc788=;
        b=fG/PGUy9fYlvKyKv2ceooFrQqnBV60Wcp67bwu54MTP9IrGi614RIgcsvXkdYmvKzo
         /vVzWjNtmfA0+ATD09hWWW8djEsJ2Z/rBX769Sglc3hdvBaEo+Q8aTHjjECHIFlV6j8v
         yZnChrYAPQW4dsYu8n0ZhVsjpUutmGdibU7iS5igtV/Kym8JhoWOUVAccY7jCHlF8OYe
         b3UWpwZoVdI99Du4nEl9QT2i9EpP0sIh1MNEeCtRt16X4qda7er7uClpMkiBCzsaXXfR
         0GYqWYKgfTMuBBYVzYGpAKQhbNjrCCf+asaK3YCIfskbOEQ98s5wHBJdxk5acSVT7wuN
         m90Q==
X-Gm-Message-State: AOAM531AqskEfNtNoADQG2qzlrKcBucY1oB8SpzwhvRwAqj/0XcKj2Wi
        VVKFDQLxqZODpSXRBz2zBpY=
X-Google-Smtp-Source: ABdhPJzw7sKie+oYcY+YfWIUxzCF1vh/GNPKXuqaPapcJ1oJbAp0Ecf6ABVIYgUk1ABBGEl70bD6/g==
X-Received: by 2002:a17:902:788e:b029:d6:9a57:ccab with SMTP id q14-20020a170902788eb02900d69a57ccabmr2897758pll.41.1604764729886;
        Sat, 07 Nov 2020 07:58:49 -0800 (PST)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id e81sm6049956pfh.104.2020.11.07.07.58.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Nov 2020 07:58:49 -0800 (PST)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH RESEND 7/8] ext4: delete invalid code inside ext4_xattr_block_set()
Date:   Sat,  7 Nov 2020 23:58:17 +0800
Message-Id: <1604764698-4269-7-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1604764698-4269-1-git-send-email-brookxu@tencent.com>
References: <1604764698-4269-1-git-send-email-brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Delete invalid code inside ext4_xattr_block_set().

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
---
 fs/ext4/xattr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 6127e94..4e3b1f8 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1927,7 +1927,6 @@ struct ext4_xattr_block_find {
 	} else {
 		/* Allocate a buffer where we construct the new block. */
 		s->base = kzalloc(sb->s_blocksize, GFP_NOFS);
-		/* assert(header == s->base) */
 		error = -ENOMEM;
 		if (s->base == NULL)
 			goto cleanup;
-- 
1.8.3.1

