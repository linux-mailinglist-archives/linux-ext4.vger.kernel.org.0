Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4380764B92
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jul 2023 10:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjG0IPo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Jul 2023 04:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbjG0IOi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 Jul 2023 04:14:38 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E010DE78
        for <linux-ext4@vger.kernel.org>; Thu, 27 Jul 2023 01:09:40 -0700 (PDT)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6748a616e17so182606b3a.1
        for <linux-ext4@vger.kernel.org>; Thu, 27 Jul 2023 01:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690445272; x=1691050072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubpyp4SIhGXjO6/VTKiZvWjlRzyN8ANvKHVN5xSGnIw=;
        b=JnEFWCJ0lfqLQ09KAhpDiGnRAmdtfYhke3aIyqMGyaI1u+7/j8X1g+ymABPYujVt+w
         cz28zAP40524HNhXDL9Q5SofaC1n/CPA+MmByiqiYd170BhvKkwUMWNTWGQlZaYnqgaR
         FBpKNnlG1vtBshrp2zrDJ2SvCtcPtO2Uoxi7Td9WriKIRN+9BBM1kAj+4w0IHie3PsAJ
         NEqh91Op9gs693bzhjwiJV1tmOiwkF+OnmYUm9c5BSiHcRPJXsNw4NR6JZLqvW90Jp1l
         wYlHCbMfcgp//O2TdulFnaEsdlVg5OO3iU4DnTCf9/O5RCqrJgKtWA6LRsXmBpSaFsGJ
         4ftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690445272; x=1691050072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubpyp4SIhGXjO6/VTKiZvWjlRzyN8ANvKHVN5xSGnIw=;
        b=R41/0u1U0tVyuK2csCr5OAR1T8DyCdvfaL0sWK7AR7qVJWDDGZXwINh4CYBmQNqg8N
         rEsSxWysGtVSRPNqxLJc0hsQtd3CnzX+9fbpLaR3Cx96h89kbQYUa4fv5CaYu/g3feHl
         fxDvxzrApKWoheH3wPbSpE17d6bxcHYL7i15cUkEjGxdX15BtvbBFnl3z9j5C0K2AQ4B
         oaXsBaL7MzoZHXalAGUWZWPDNH3CtP82RuAEvohVA70cDuFZV4mol4tRNeEeF/WZW1bW
         E+DqTE/C6B1Mu269SGJFYZC+vfcPQuqG/GG9EAUAtVCjY5j5vUxkXMVq5wFPeqKgVfcS
         PqmQ==
X-Gm-Message-State: ABy/qLakyfuCt4JgVkDKFAMvCyjKRlyYlDg9fT8uNjXXyt2++dNWuWIn
        wtMJFnBfM35YMzWaXuOCo8Z18A==
X-Google-Smtp-Source: APBJJlH8Hm//FCUnZvKJ1Fsda02AnYQWQqq2rUtStc8LnYU5/NdJ+w8F5lFLyohrr/NHLskzxbNOmQ==
X-Received: by 2002:a05:6a00:2d09:b0:682:59aa:178d with SMTP id fa9-20020a056a002d0900b0068259aa178dmr4647270pfb.1.1690445272018;
        Thu, 27 Jul 2023 01:07:52 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78d08000000b006828e49c04csm885872pfe.75.2023.07.27.01.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:07:51 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 10/49] erofs: dynamically allocate the erofs-shrinker
Date:   Thu, 27 Jul 2023 16:04:23 +0800
Message-Id: <20230727080502.77895-11-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Use new APIs to dynamically allocate the erofs-shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/erofs/utils.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index cc6fb9e98899..6e1a828e6ca3 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -270,19 +270,25 @@ static unsigned long erofs_shrink_scan(struct shrinker *shrink,
 	return freed;
 }
 
-static struct shrinker erofs_shrinker_info = {
-	.scan_objects = erofs_shrink_scan,
-	.count_objects = erofs_shrink_count,
-	.seeks = DEFAULT_SEEKS,
-};
+static struct shrinker *erofs_shrinker_info;
 
 int __init erofs_init_shrinker(void)
 {
-	return register_shrinker(&erofs_shrinker_info, "erofs-shrinker");
+	erofs_shrinker_info = shrinker_alloc(0, "erofs-shrinker");
+	if (!erofs_shrinker_info)
+		return -ENOMEM;
+
+	erofs_shrinker_info->count_objects = erofs_shrink_count;
+	erofs_shrinker_info->scan_objects = erofs_shrink_scan;
+	erofs_shrinker_info->seeks = DEFAULT_SEEKS;
+
+	shrinker_register(erofs_shrinker_info);
+
+	return 0;
 }
 
 void erofs_exit_shrinker(void)
 {
-	unregister_shrinker(&erofs_shrinker_info);
+	shrinker_free(erofs_shrinker_info);
 }
 #endif	/* !CONFIG_EROFS_FS_ZIP */
-- 
2.30.2

