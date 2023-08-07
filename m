Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773237722A3
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Aug 2023 13:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjHGLgU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Aug 2023 07:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbjHGLfw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Aug 2023 07:35:52 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8432D1FE4
        for <linux-ext4@vger.kernel.org>; Mon,  7 Aug 2023 04:32:50 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-4475d545cfbso503354137.0
        for <linux-ext4@vger.kernel.org>; Mon, 07 Aug 2023 04:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691407914; x=1692012714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1yZWn5jqhhXD5GlPCwn7Rqy/lqVgw4fKiPcfLbuAyw=;
        b=dX/hkg869uyzynSh9Rf+B6UukxH5yp22RnJx9caKIpdHnyUPxHN+LBGuLNIdvZ839h
         ylCcivvbPHtB5BzYIG9Q6Z7P5VcBQLqK5HHKzeWbW1jxrE8+kGBYCd/nuxpVnnnBAiRj
         H49UNDrG3BVnXMabk1tbtQiuviNTGktBecy/FIBV3wjUZAn73jqw4/k3zZzbpF9yJKgm
         L8MjYwmWCgEAvhC5PGoKt/caM84YzqtNMHyoc0T7oqm3qZuxMzWJM5Fpd1VrNTLJmxWm
         iXUknAaxGlG9dhGt6mWmyEMmN8CcAuhe6t7lDDiXgd3+BRnMqvkqm6baQ9LpoDdT3lbT
         hpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691407914; x=1692012714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1yZWn5jqhhXD5GlPCwn7Rqy/lqVgw4fKiPcfLbuAyw=;
        b=fSA5JOpuTNBe82dKuYEwd0OcSUPt0e/QRy3+egKbEG8ha9IZmLbovzgAjdhqziXyoZ
         OfXRBVWzxi9HMHuOGVVYA3tNUsCAJFU5VC7MYvzvrIJRMUsd/ISd0EmR525zeWiwhjPq
         MXc3rGczY+d3RSxxDGT+MNPN6Hq+ZjiHPlLsfecCjlmG8TqCplWA4QL9gunqYuRMlSe/
         XHfV8lotAQojCOxbj701fL25t97z2z8TcJgZ3FBOycIpCE6BMZ/4b0zv/QmYgZKVKB5z
         Q9xRbIhKlgA5ZcBLeF3QEG+rGcYb4fWd9ToUzIn5Cgn3ekU+hR3Sk5D2mdNY17J6012i
         bUfw==
X-Gm-Message-State: ABy/qLaNWh+YJLPB9zH8Ig3EirvEia1y5Eo7014jeL3FcXdfg2a06GdW
        KC2Ws80mGblOCWJSxjB0I/Fmck8Po2LZmYOeKBA=
X-Google-Smtp-Source: AGHT+IFmiFe8iRG7X1ND7nrFgfyiRFI3F00Omyk3P1Mi12alvC2oRACqfoDpuN1VIlTmyfJiX72rxw==
X-Received: by 2002:a17:90a:2909:b0:269:5bf7:d79c with SMTP id g9-20020a17090a290900b002695bf7d79cmr2218056pjd.1.1691406956537;
        Mon, 07 Aug 2023 04:15:56 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090aca8d00b0025be7b69d73sm5861191pjt.12.2023.08.07.04.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:15:55 -0700 (PDT)
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
Subject: [PATCH v4 28/48] md/raid5: dynamically allocate the md-raid5 shrinker
Date:   Mon,  7 Aug 2023 19:09:16 +0800
Message-Id: <20230807110936.21819-29-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
References: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the md-raid5 shrinker, so that it can be freed
asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
read-side critical section when releasing the struct r5conf.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/md/raid5.c | 26 +++++++++++++++-----------
 drivers/md/raid5.h |  2 +-
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 32a87193bad7..e284c2f7dbe4 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7401,7 +7401,7 @@ static void free_conf(struct r5conf *conf)
 
 	log_exit(conf);
 
-	unregister_shrinker(&conf->shrinker);
+	shrinker_free(conf->shrinker);
 	free_thread_groups(conf);
 	shrink_stripes(conf);
 	raid5_free_percpu(conf);
@@ -7449,7 +7449,7 @@ static int raid5_alloc_percpu(struct r5conf *conf)
 static unsigned long raid5_cache_scan(struct shrinker *shrink,
 				      struct shrink_control *sc)
 {
-	struct r5conf *conf = container_of(shrink, struct r5conf, shrinker);
+	struct r5conf *conf = shrink->private_data;
 	unsigned long ret = SHRINK_STOP;
 
 	if (mutex_trylock(&conf->cache_size_mutex)) {
@@ -7470,7 +7470,7 @@ static unsigned long raid5_cache_scan(struct shrinker *shrink,
 static unsigned long raid5_cache_count(struct shrinker *shrink,
 				       struct shrink_control *sc)
 {
-	struct r5conf *conf = container_of(shrink, struct r5conf, shrinker);
+	struct r5conf *conf = shrink->private_data;
 
 	if (conf->max_nr_stripes < conf->min_nr_stripes)
 		/* unlikely, but not impossible */
@@ -7705,18 +7705,22 @@ static struct r5conf *setup_conf(struct mddev *mddev)
 	 * it reduces the queue depth and so can hurt throughput.
 	 * So set it rather large, scaled by number of devices.
 	 */
-	conf->shrinker.seeks = DEFAULT_SEEKS * conf->raid_disks * 4;
-	conf->shrinker.scan_objects = raid5_cache_scan;
-	conf->shrinker.count_objects = raid5_cache_count;
-	conf->shrinker.batch = 128;
-	conf->shrinker.flags = 0;
-	ret = register_shrinker(&conf->shrinker, "md-raid5:%s", mdname(mddev));
-	if (ret) {
-		pr_warn("md/raid:%s: couldn't register shrinker.\n",
+	conf->shrinker = shrinker_alloc(0, "md-raid5:%s", mdname(mddev));
+	if (!conf->shrinker) {
+		ret = -ENOMEM;
+		pr_warn("md/raid:%s: couldn't allocate shrinker.\n",
 			mdname(mddev));
 		goto abort;
 	}
 
+	conf->shrinker->seeks = DEFAULT_SEEKS * conf->raid_disks * 4;
+	conf->shrinker->scan_objects = raid5_cache_scan;
+	conf->shrinker->count_objects = raid5_cache_count;
+	conf->shrinker->batch = 128;
+	conf->shrinker->private_data = conf;
+
+	shrinker_register(conf->shrinker);
+
 	sprintf(pers_name, "raid%d", mddev->new_level);
 	rcu_assign_pointer(conf->thread,
 			   md_register_thread(raid5d, mddev, pers_name));
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index 97a795979a35..22bea20eccbd 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -670,7 +670,7 @@ struct r5conf {
 	wait_queue_head_t	wait_for_stripe;
 	wait_queue_head_t	wait_for_overlap;
 	unsigned long		cache_state;
-	struct shrinker		shrinker;
+	struct shrinker		*shrinker;
 	int			pool_size; /* number of disks in stripeheads in pool */
 	spinlock_t		device_lock;
 	struct disk_info	*disks;
-- 
2.30.2

