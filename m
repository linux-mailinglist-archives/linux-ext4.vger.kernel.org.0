Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E1B7720E1
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Aug 2023 13:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjHGLRw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Aug 2023 07:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbjHGLRd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Aug 2023 07:17:33 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B821BEA
        for <linux-ext4@vger.kernel.org>; Mon,  7 Aug 2023 04:15:44 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1bc76cdf0cbso595355ad.1
        for <linux-ext4@vger.kernel.org>; Mon, 07 Aug 2023 04:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691406816; x=1692011616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=et7oKjMo2RpAm9eGe6PO8KzXkO6yMET8jj6KuxhxE1o=;
        b=LikGQLIJYBMaIhLRv2oXwUZ1S5/lUocFnmTR+FYR6Ek9DrdoATbLs4CDlynPte0jm9
         +o4McGrgBARlkb75OrdIWJKTn+TAsEnotraDhrP3rtl6y6q5edkiQAwqNgCpWHEQGLxu
         GHvaWLUFDnTHEHQY8B66ZCvfeUOtDRooCdq2e8FvhkYGE0+2kW031xfZ/1GeTTnnyACe
         erVR01yoMD1wcFa+90Rr7nUgrj+jHy2UHL/0KieWzuXqT/QJWuskjH4/gIAZtbTfNj8h
         rLHAUVp+wWaVi0Nz3/+zkqLaFK0QZUGbmHkke0Mu+daDajI/xmbze4i5ZAJyYAfaC1ge
         umJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691406816; x=1692011616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=et7oKjMo2RpAm9eGe6PO8KzXkO6yMET8jj6KuxhxE1o=;
        b=SPUINP6jQTyA+LkEjo7ByKrgjI3s+nN1aexIU8nd2KDpcGZ+GC4NQuBf/UBX5al7fI
         ty0WhNjPa4kWQazcTQKnssFLf5qcbgdqKmSo0Uq1XNOiyggbA/5VXMKQTWuEkyzk+bTx
         qK1VWGV1ASrwUcZtxhmayPrDhgMVc2V5oZ3iYaZEq8UdqQmnR/tSN9dWkTb0txPbgBvr
         bpYK+UPI8sYGu/+5oBzrT1ZXNSZMsl2af/hyROvq4nkeVytZJrjmeD1FqjXrY2NHi0/Z
         5IdEBzS0W+IWisCSGs1P7A8jC40m6QTduXtCNAaPiL2FHSRX9puY68Dk1rz3MMp4Jg6C
         9IaA==
X-Gm-Message-State: ABy/qLYc68pJft7nhdOV7pnGHFBT1M6ixFhymAbZMpySStKpMPjhENvK
        D8qR3m79CRGrBx1GDxmRaemFog==
X-Google-Smtp-Source: APBJJlF9QaWRkA2HFZAXDPGIksSZq6NqNIS7MDluuBXjMUyGz8OacRKwa0/I1dCKrdRRT8VidP2X/g==
X-Received: by 2002:a17:902:ea04:b0:1b8:a27d:f591 with SMTP id s4-20020a170902ea0400b001b8a27df591mr32781910plg.5.1691406816716;
        Mon, 07 Aug 2023 04:13:36 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090aca8d00b0025be7b69d73sm5861191pjt.12.2023.08.07.04.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:13:36 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev, simon.horman@corigine.com,
        dlemoal@kernel.org
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
Subject: [PATCH v4 17/48] ubifs: dynamically allocate the ubifs-slab shrinker
Date:   Mon,  7 Aug 2023 19:09:05 +0800
Message-Id: <20230807110936.21819-18-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
References: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Use new APIs to dynamically allocate the ubifs-slab shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/ubifs/super.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index b08fb28d16b5..c690782388a8 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -54,11 +54,7 @@ module_param_cb(default_version, &ubifs_default_version_ops, &ubifs_default_vers
 static struct kmem_cache *ubifs_inode_slab;
 
 /* UBIFS TNC shrinker description */
-static struct shrinker ubifs_shrinker_info = {
-	.scan_objects = ubifs_shrink_scan,
-	.count_objects = ubifs_shrink_count,
-	.seeks = DEFAULT_SEEKS,
-};
+static struct shrinker *ubifs_shrinker_info;
 
 /**
  * validate_inode - validate inode.
@@ -2373,7 +2369,7 @@ static void inode_slab_ctor(void *obj)
 
 static int __init ubifs_init(void)
 {
-	int err;
+	int err = -ENOMEM;
 
 	BUILD_BUG_ON(sizeof(struct ubifs_ch) != 24);
 
@@ -2439,10 +2435,16 @@ static int __init ubifs_init(void)
 	if (!ubifs_inode_slab)
 		return -ENOMEM;
 
-	err = register_shrinker(&ubifs_shrinker_info, "ubifs-slab");
-	if (err)
+	ubifs_shrinker_info = shrinker_alloc(0, "ubifs-slab");
+	if (!ubifs_shrinker_info)
 		goto out_slab;
 
+	ubifs_shrinker_info->count_objects = ubifs_shrink_count;
+	ubifs_shrinker_info->scan_objects = ubifs_shrink_scan;
+	ubifs_shrinker_info->seeks = DEFAULT_SEEKS;
+
+	shrinker_register(ubifs_shrinker_info);
+
 	err = ubifs_compressors_init();
 	if (err)
 		goto out_shrinker;
@@ -2467,7 +2469,7 @@ static int __init ubifs_init(void)
 	dbg_debugfs_exit();
 	ubifs_compressors_exit();
 out_shrinker:
-	unregister_shrinker(&ubifs_shrinker_info);
+	shrinker_free(ubifs_shrinker_info);
 out_slab:
 	kmem_cache_destroy(ubifs_inode_slab);
 	return err;
@@ -2483,7 +2485,7 @@ static void __exit ubifs_exit(void)
 	dbg_debugfs_exit();
 	ubifs_sysfs_exit();
 	ubifs_compressors_exit();
-	unregister_shrinker(&ubifs_shrinker_info);
+	shrinker_free(ubifs_shrinker_info);
 
 	/*
 	 * Make sure all delayed rcu free inodes are flushed before we
-- 
2.30.2

