Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A6A292435
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Oct 2020 11:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbgJSJCv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Oct 2020 05:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729819AbgJSJCu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Oct 2020 05:02:50 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D419C0613CE
        for <linux-ext4@vger.kernel.org>; Mon, 19 Oct 2020 02:02:50 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id b23so5649384pgb.3
        for <linux-ext4@vger.kernel.org>; Mon, 19 Oct 2020 02:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SrEv0QX1jveOnz0dw1eCJkac0+vhIFQKGu76aPey5uY=;
        b=gBb9/nqKcBdzVBRem2muKT8H4EuT7xrBT8lY7+KMzPor5SUHD5GDbGN6RyeqDJkaWL
         xzVKTH1XU9jIEN/4OQyj9tR4HC4d+JWOZkFIom+C7d8MM0iDiAwHsPWGRqg0FrDuifU+
         SduOCFgETeoeSFhS73PDUo4vpjFPaQUE7VQLZV1g/Y/QohVMPnrQ4mCzXrVbGGnXASGv
         GifW9N5OuOutFHH+rcK9+XTGWTW5h2zHUGepsoiqU8NnHu/x0CQLunCxS8SeakaZ+1wZ
         eF+FRj0eGQtabDUGbvoKsDRaTbCRDXMcol3Dqz3NkV1+eezJk/a9OzcJCQQqoVN/4N8k
         cQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SrEv0QX1jveOnz0dw1eCJkac0+vhIFQKGu76aPey5uY=;
        b=TLgAGyIGe7fpyBJGhb+qIR74bZg5EU37oB8x6yAer+VITDbokQeSjaHn7M7cErzTFc
         2wFV3u5Mu4QHltTYBxHx7kOSuQHIIigiUmTyMITf6cktdXe+GuwkAJWy2naN5BhKsbkb
         j8OCW46tKls6xQugUoakdgapT5v3crIMhgX5ZMaWeP4zzCYylq+dyx00q5ckXGIYX1mq
         5BGSrJ5vdDZb3yCMX1CGQztS98IsKJDJEcDAC5bawxJaTdZDOhMax19d8Sntfhnjz4up
         UhrCAtOo3qaIEpbrSkAZrpy9dvhs9CBUobk7Nj9hcXkP5ZP0ulElpWEqmbAzcEMzwJuQ
         eHhQ==
X-Gm-Message-State: AOAM531XfkQNrvOGy8wpvF+VfyDZfDIALBF4EoUbkF05bXknh3hw8y/j
        7qss+YAJwPO/XWQT9Nflz2k=
X-Google-Smtp-Source: ABdhPJxy3Uqcju9mYOqHEbFwuC6LP6OY5oackRm55hlqHREHFJsx2e//WsLXxXtdncsBHR6VzZDoEA==
X-Received: by 2002:aa7:9811:0:b029:15d:2c0e:e947 with SMTP id e17-20020aa798110000b029015d2c0ee947mr3432414pfl.76.1603098170201;
        Mon, 19 Oct 2020 02:02:50 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id 14sm11422880pjn.48.2020.10.19.02.02.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Oct 2020 02:02:49 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH v2 7/8] ext4: delete invalid code inside ext4_xattr_block_set()
Date:   Mon, 19 Oct 2020 17:02:37 +0800
Message-Id: <1603098158-30406-7-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603098158-30406-1-git-send-email-brookxu@tencent.com>
References: <1603098158-30406-1-git-send-email-brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Delete invalid code inside ext4_xattr_block_set().

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/ext4/xattr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index cba4b87..56728f3 100644
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

