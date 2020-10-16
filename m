Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D60B28FD06
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Oct 2020 05:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394328AbgJPD4N (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Oct 2020 23:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394326AbgJPD4L (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Oct 2020 23:56:11 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0614CC0613D2
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 20:56:11 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a17so635828pju.1
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 20:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NIVm2fb3WtUPffIkRf0LKhoamMpeX4bpI31tojmWPLY=;
        b=ho5zODX/RXUEcfleZfPzss17+VrHguHdjN8+HaRPoeCyWaIMSe2H+HhlCvYTOpM8a+
         j91JjQlmgvboyCxZ6QucEwfBkRv4zKVcE7OvOXO7iJuS9fi2jntUztcPXDL6NIvsv92z
         a7aOC9A2/hMZp72K13iDD4Zn8kbTGrQ6POialTQUdZMMt0yVSu7RvPxFqbC/cb1oyLCs
         7ELzfFg76obOTMmmbgZOKWDbocqzvuXnpWdFErZCKOLmZ+xOS+kV4M55FyLbgNX99Sh6
         ZgUtA6cVd14SM2x0/5wq0SM6CekmvklVWlHtRArCQMR0uqJ10+j2dGYfCZRwHh/zUHRl
         AdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NIVm2fb3WtUPffIkRf0LKhoamMpeX4bpI31tojmWPLY=;
        b=R1nqrykluVJ7g88PO9mH0ZH0uS16xofZXPbN3QXPibYFLaruXqCRAfmy66SUu7R8zQ
         GRsuiWH3gXXBMO4NVgLu+92M2TJKoAefUZ5D2vyvA/otYtC1EbJEyDhnDjToDB5IoSt0
         AZg+ErZWGxj/Qwl0s1G7q0q07unMinSQliEvs2TyNqkkLA5ABE/sV73icUmlptju7jZt
         FUnbJ10O0KnOSD7GTaiJLGTudAsQYEHZNv1u2ObvcVntoaXUEaU+6UkOCT8KHm8JcUch
         lxyPI2V2bGjG+Vm7pjP327NTDQ6JtyIcqcFtGs8D7hKt5C8UaTQumnzRphy6TISS53+6
         1v8Q==
X-Gm-Message-State: AOAM532LCOdI3Qh4gQMHc/zWlQx9VX5Bn5sQf8f8jkvxeiqpGu/woodm
        PvwGT6mYbw05RdbZ0Z536X46PulGqIA=
X-Google-Smtp-Source: ABdhPJzrsShb6p8Lu1wZJQppeRAA2+uW4CwtxISjOVewhugTNLWOqB9qDWBJoR+3Aw3tfRj4SBswjg==
X-Received: by 2002:a17:902:9a84:b029:d2:9390:5e6 with SMTP id w4-20020a1709029a84b02900d2939005e6mr2031714plp.37.1602820570637;
        Thu, 15 Oct 2020 20:56:10 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id v12sm861555pgr.4.2020.10.15.20.56.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2020 20:56:10 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH 8/8] ext4: delete invalid code inside ext4_xattr_block_set()
Date:   Fri, 16 Oct 2020 11:55:52 +0800
Message-Id: <1602820552-4082-8-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1602820552-4082-1-git-send-email-brookxu@tencent.com>
References: <1602820552-4082-1-git-send-email-brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

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

