Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12090572DB5
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Jul 2022 07:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbiGMFyZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Jul 2022 01:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbiGMFyA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Jul 2022 01:54:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F69C2FFE9;
        Tue, 12 Jul 2022 22:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Y3KJzRLrphaTDn8Wyop5u8huGV0HUKZAMu6CEtRR/Bk=; b=PEJVBI4x3qa0TuZ6BDxyNedRsC
        21lm58vzmdgB11esQizXAAiCWwrQFxyGkvNn7RMx/SkFDycJThb61cyZxAaAUGEDdojB4NaeNFknZ
        wtAhFYALKJ0dT0eAP3uu1+rPEDqqlcqanSiIilvM3eKi/enitEbOctOt05sWF3OrHoeWFiBBdk1Fp
        oodg1CyjzRY4AARCUaUliopVIt92TUDazeCdMCVgb7x79v0CcqnvoSTIMY1EyAnno/g3PUGExqWRg
        /AMS9ASCbiyBP8suooRN9mDl3MAHsl+BJZv1Zk09a9FJut6uwN2h9Ia1mrOYimv4J9imOrEocUUAT
        qXE9OFRA==;
Received: from ip4d15c27d.dynamic.kabel-deutschland.de ([77.21.194.125] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBVJc-000NVh-G0; Wed, 13 Jul 2022 05:53:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>, Song Liu <song@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
Subject: [PATCH 7/9] ocfs2/cluster: remove the hr_dev_name field from struct o2hb_region
Date:   Wed, 13 Jul 2022 07:53:15 +0200
Message-Id: <20220713055317.1888500-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220713055317.1888500-1-hch@lst.de>
References: <20220713055317.1888500-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Just print the block device name directly using the %pg format specifier.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ocfs2/cluster/heartbeat.c | 64 +++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 34 deletions(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index ea0e70c0fce09..5f83c0c0918c0 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -235,8 +235,6 @@ struct o2hb_region {
 	 * (hr_steady_iterations == 0) within hr_unsteady_iterations */
 	atomic_t		hr_unsteady_iterations;
 
-	char			hr_dev_name[BDEVNAME_SIZE];
-
 	unsigned int		hr_timeout_ms;
 
 	/* randomized as the region goes up and down so that a node
@@ -287,8 +285,8 @@ static void o2hb_write_timeout(struct work_struct *work)
 		container_of(work, struct o2hb_region,
 			     hr_write_timeout_work.work);
 
-	mlog(ML_ERROR, "Heartbeat write timeout to device %s after %u "
-	     "milliseconds\n", reg->hr_dev_name,
+	mlog(ML_ERROR, "Heartbeat write timeout to device %pg after %u "
+	     "milliseconds\n", reg->hr_bdev,
 	     jiffies_to_msecs(jiffies - reg->hr_last_timeout_start));
 
 	if (o2hb_global_heartbeat_active()) {
@@ -383,9 +381,9 @@ static void o2hb_nego_timeout(struct work_struct *work)
 
 	if (master_node == o2nm_this_node()) {
 		if (!test_bit(master_node, reg->hr_nego_node_bitmap)) {
-			printk(KERN_NOTICE "o2hb: node %d hb write hung for %ds on region %s (%s).\n",
+			printk(KERN_NOTICE "o2hb: node %d hb write hung for %ds on region %s (%pg).\n",
 				o2nm_this_node(), O2HB_NEGO_TIMEOUT_MS/1000,
-				config_item_name(&reg->hr_item), reg->hr_dev_name);
+				config_item_name(&reg->hr_item), reg->hr_bdev);
 			set_bit(master_node, reg->hr_nego_node_bitmap);
 		}
 		if (memcmp(reg->hr_nego_node_bitmap, live_node_bitmap,
@@ -399,8 +397,8 @@ static void o2hb_nego_timeout(struct work_struct *work)
 			return;
 		}
 
-		printk(KERN_NOTICE "o2hb: all nodes hb write hung, maybe region %s (%s) is down.\n",
-			config_item_name(&reg->hr_item), reg->hr_dev_name);
+		printk(KERN_NOTICE "o2hb: all nodes hb write hung, maybe region %s (%pg) is down.\n",
+			config_item_name(&reg->hr_item), reg->hr_bdev);
 		/* approve negotiate timeout request. */
 		o2hb_arm_timeout(reg);
 
@@ -419,9 +417,9 @@ static void o2hb_nego_timeout(struct work_struct *work)
 		}
 	} else {
 		/* negotiate timeout with master node. */
-		printk(KERN_NOTICE "o2hb: node %d hb write hung for %ds on region %s (%s), negotiate timeout with node %d.\n",
+		printk(KERN_NOTICE "o2hb: node %d hb write hung for %ds on region %s (%pg), negotiate timeout with node %d.\n",
 			o2nm_this_node(), O2HB_NEGO_TIMEOUT_MS/1000, config_item_name(&reg->hr_item),
-			reg->hr_dev_name, master_node);
+			reg->hr_bdev, master_node);
 		ret = o2hb_send_nego_msg(reg->hr_key, O2HB_NEGO_TIMEOUT_MSG,
 				master_node);
 		if (ret)
@@ -437,8 +435,8 @@ static int o2hb_nego_timeout_handler(struct o2net_msg *msg, u32 len, void *data,
 	struct o2hb_nego_msg *nego_msg;
 
 	nego_msg = (struct o2hb_nego_msg *)msg->buf;
-	printk(KERN_NOTICE "o2hb: receive negotiate timeout message from node %d on region %s (%s).\n",
-		nego_msg->node_num, config_item_name(&reg->hr_item), reg->hr_dev_name);
+	printk(KERN_NOTICE "o2hb: receive negotiate timeout message from node %d on region %s (%pg).\n",
+		nego_msg->node_num, config_item_name(&reg->hr_item), reg->hr_bdev);
 	if (nego_msg->node_num < O2NM_MAX_NODES)
 		set_bit(nego_msg->node_num, reg->hr_nego_node_bitmap);
 	else
@@ -452,8 +450,8 @@ static int o2hb_nego_approve_handler(struct o2net_msg *msg, u32 len, void *data,
 {
 	struct o2hb_region *reg = data;
 
-	printk(KERN_NOTICE "o2hb: negotiate timeout approved by master node on region %s (%s).\n",
-		config_item_name(&reg->hr_item), reg->hr_dev_name);
+	printk(KERN_NOTICE "o2hb: negotiate timeout approved by master node on region %s (%pg).\n",
+		config_item_name(&reg->hr_item), reg->hr_bdev);
 	o2hb_arm_timeout(reg);
 	return 0;
 }
@@ -689,8 +687,8 @@ static int o2hb_check_own_slot(struct o2hb_region *reg)
 	else
 		errstr = ERRSTR3;
 
-	mlog(ML_ERROR, "%s (%s): expected(%u:0x%llx, 0x%llx), "
-	     "ondisk(%u:0x%llx, 0x%llx)\n", errstr, reg->hr_dev_name,
+	mlog(ML_ERROR, "%s (%pg): expected(%u:0x%llx, 0x%llx), "
+	     "ondisk(%u:0x%llx, 0x%llx)\n", errstr, reg->hr_bdev,
 	     slot->ds_node_num, (unsigned long long)slot->ds_last_generation,
 	     (unsigned long long)slot->ds_last_time, hb_block->hb_node,
 	     (unsigned long long)le64_to_cpu(hb_block->hb_generation),
@@ -863,8 +861,8 @@ static void o2hb_set_quorum_device(struct o2hb_region *reg)
 		   sizeof(o2hb_live_node_bitmap)))
 		goto unlock;
 
-	printk(KERN_NOTICE "o2hb: Region %s (%s) is now a quorum device\n",
-	       config_item_name(&reg->hr_item), reg->hr_dev_name);
+	printk(KERN_NOTICE "o2hb: Region %s (%pg) is now a quorum device\n",
+	       config_item_name(&reg->hr_item), reg->hr_bdev);
 
 	set_bit(reg->hr_region_num, o2hb_quorum_region_bitmap);
 
@@ -922,8 +920,8 @@ static int o2hb_check_slot(struct o2hb_region *reg,
 		/* The node is live but pushed out a bad crc. We
 		 * consider it a transient miss but don't populate any
 		 * other values as they may be junk. */
-		mlog(ML_ERROR, "Node %d has written a bad crc to %s\n",
-		     slot->ds_node_num, reg->hr_dev_name);
+		mlog(ML_ERROR, "Node %d has written a bad crc to %pg\n",
+		     slot->ds_node_num, reg->hr_bdev);
 		o2hb_dump_slot(hb_block);
 
 		slot->ds_equal_samples++;
@@ -1002,11 +1000,11 @@ static int o2hb_check_slot(struct o2hb_region *reg,
 		slot_dead_ms = le32_to_cpu(hb_block->hb_dead_ms);
 		if (slot_dead_ms && slot_dead_ms != dead_ms) {
 			/* TODO: Perhaps we can fail the region here. */
-			mlog(ML_ERROR, "Node %d on device %s has a dead count "
+			mlog(ML_ERROR, "Node %d on device %pg has a dead count "
 			     "of %u ms, but our count is %u ms.\n"
 			     "Please double check your configuration values "
 			     "for 'O2CB_HEARTBEAT_THRESHOLD'\n",
-			     slot->ds_node_num, reg->hr_dev_name, slot_dead_ms,
+			     slot->ds_node_num, reg->hr_bdev, slot_dead_ms,
 			     dead_ms);
 		}
 		goto out;
@@ -1145,8 +1143,8 @@ static int o2hb_do_disk_heartbeat(struct o2hb_region *reg)
 		/* Do not re-arm the write timeout on I/O error - we
 		 * can't be sure that the new block ever made it to
 		 * disk */
-		mlog(ML_ERROR, "Write error %d on device \"%s\"\n",
-		     write_wc.wc_error, reg->hr_dev_name);
+		mlog(ML_ERROR, "Write error %d on device \"%pg\"\n",
+		     write_wc.wc_error, reg->hr_bdev);
 		ret = write_wc.wc_error;
 		goto bail;
 	}
@@ -1170,9 +1168,9 @@ static int o2hb_do_disk_heartbeat(struct o2hb_region *reg)
 	if (atomic_read(&reg->hr_steady_iterations) != 0) {
 		if (atomic_dec_and_test(&reg->hr_unsteady_iterations)) {
 			printk(KERN_NOTICE "o2hb: Unable to stabilize "
-			       "heartbeat on region %s (%s)\n",
+			       "heartbeat on region %s (%pg)\n",
 			       config_item_name(&reg->hr_item),
-			       reg->hr_dev_name);
+			       reg->hr_bdev);
 			atomic_set(&reg->hr_steady_iterations, 0);
 			reg->hr_aborted_start = 1;
 			wake_up(&o2hb_steady_queue);
@@ -1494,7 +1492,7 @@ static void o2hb_region_release(struct config_item *item)
 	struct page *page;
 	struct o2hb_region *reg = to_o2hb_region(item);
 
-	mlog(ML_HEARTBEAT, "hb region release (%s)\n", reg->hr_dev_name);
+	mlog(ML_HEARTBEAT, "hb region release (%pg)\n", reg->hr_bdev);
 
 	kfree(reg->hr_tmp_block);
 
@@ -1641,7 +1639,7 @@ static ssize_t o2hb_region_dev_show(struct config_item *item, char *page)
 	unsigned int ret = 0;
 
 	if (to_o2hb_region(item)->hr_bdev)
-		ret = sprintf(page, "%s\n", to_o2hb_region(item)->hr_dev_name);
+		ret = sprintf(page, "%pg\n", to_o2hb_region(item)->hr_bdev);
 
 	return ret;
 }
@@ -1798,8 +1796,6 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 		goto out2;
 	}
 
-	bdevname(reg->hr_bdev, reg->hr_dev_name);
-
 	sectsize = bdev_logical_block_size(reg->hr_bdev);
 	if (sectsize != reg->hr_block_bytes) {
 		mlog(ML_ERROR,
@@ -1895,8 +1891,8 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 		ret = -EIO;
 
 	if (hb_task && o2hb_global_heartbeat_active())
-		printk(KERN_NOTICE "o2hb: Heartbeat started on region %s (%s)\n",
-		       config_item_name(&reg->hr_item), reg->hr_dev_name);
+		printk(KERN_NOTICE "o2hb: Heartbeat started on region %s (%pg)\n",
+		       config_item_name(&reg->hr_item), reg->hr_bdev);
 
 out3:
 	if (ret < 0) {
@@ -2088,10 +2084,10 @@ static void o2hb_heartbeat_group_drop_item(struct config_group *group,
 			quorum_region = 1;
 		clear_bit(reg->hr_region_num, o2hb_quorum_region_bitmap);
 		spin_unlock(&o2hb_live_lock);
-		printk(KERN_NOTICE "o2hb: Heartbeat %s on region %s (%s)\n",
+		printk(KERN_NOTICE "o2hb: Heartbeat %s on region %s (%pg)\n",
 		       ((atomic_read(&reg->hr_steady_iterations) == 0) ?
 			"stopped" : "start aborted"), config_item_name(item),
-		       reg->hr_dev_name);
+		       reg->hr_bdev);
 	}
 
 	/*
-- 
2.30.2

