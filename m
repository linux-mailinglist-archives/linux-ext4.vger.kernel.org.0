Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810266259C6
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Nov 2022 12:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbiKKLtW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Nov 2022 06:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbiKKLtJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Nov 2022 06:49:09 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2CA18E09
        for <linux-ext4@vger.kernel.org>; Fri, 11 Nov 2022 03:49:07 -0800 (PST)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N7xmy1d89zmVql;
        Fri, 11 Nov 2022 19:48:50 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 19:49:06 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 11 Nov
 2022 19:49:04 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <snitzer@kernel.org>, <Martin.Wilck@suse.com>, <ejt@redhat.com>,
        <jack@suse.cz>, <tytso@mit.edu>, <yi.zhang@huawei.com>,
        <chengzhihao1@huawei.com>
CC:     <dm-devel@redhat.com>, <linux-ext4@vger.kernel.org>
Subject: [dm-devel] [PATCH 3/3] dm thin: Fix ABBA deadlock between shrink_slab and dm_pool_abort_metadata
Date:   Fri, 11 Nov 2022 20:10:29 +0800
Message-ID: <20221111121029.3985561-4-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221111121029.3985561-1-chengzhihao1@huawei.com>
References: <20221111121029.3985561-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,WEIRD_PORT autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Following concurrent processes:

          P1(drop cache)                P2(kworker)
drop_caches_sysctl_handler
 drop_slab
  shrink_slab
   down_read(&shrinker_rwsem)  - LOCK A
   do_shrink_slab
    super_cache_scan
     prune_icache_sb
      dispose_list
       evict
        ext4_evict_inode
	 ext4_clear_inode
	  ext4_discard_preallocations
	   ext4_mb_load_buddy_gfp
	    ext4_mb_init_cache
	     ext4_read_block_bitmap_nowait
	      ext4_read_bh_nowait
	       submit_bh
	        dm_submit_bio
		                 do_worker
				  process_deferred_bios
				   commit
				    metadata_operation_failed
				     dm_pool_abort_metadata
				      down_write(&pmd->root_lock) - LOCK B
		                      __destroy_persistent_data_objects
				       dm_block_manager_destroy
				        dm_bufio_client_destroy
				         unregister_shrinker
					  down_write(&shrinker_rwsem)
		 thin_map                            |
		  dm_thin_find_block                 ↓
		   down_read(&pmd->root_lock) --> ABBA deadlock

, which triggers hung task:

[   76.974820] INFO: task kworker/u4:3:63 blocked for more than 15 seconds.
[   76.976019]       Not tainted 6.1.0-rc4-00011-g8f17dd350364-dirty #910
[   76.978521] task:kworker/u4:3    state:D stack:0     pid:63    ppid:2
[   76.978534] Workqueue: dm-thin do_worker
[   76.978552] Call Trace:
[   76.978564]  __schedule+0x6ba/0x10f0
[   76.978582]  schedule+0x9d/0x1e0
[   76.978588]  rwsem_down_write_slowpath+0x587/0xdf0
[   76.978600]  down_write+0xec/0x110
[   76.978607]  unregister_shrinker+0x2c/0xf0
[   76.978616]  dm_bufio_client_destroy+0x116/0x3d0
[   76.978625]  dm_block_manager_destroy+0x19/0x40
[   76.978629]  __destroy_persistent_data_objects+0x5e/0x70
[   76.978636]  dm_pool_abort_metadata+0x8e/0x100
[   76.978643]  metadata_operation_failed+0x86/0x110
[   76.978649]  commit+0x6a/0x230
[   76.978655]  do_worker+0xc6e/0xd90
[   76.978702]  process_one_work+0x269/0x630
[   76.978714]  worker_thread+0x266/0x630
[   76.978730]  kthread+0x151/0x1b0
[   76.978772] INFO: task test.sh:2646 blocked for more than 15 seconds.
[   76.979756]       Not tainted 6.1.0-rc4-00011-g8f17dd350364-dirty #910
[   76.982111] task:test.sh         state:D stack:0     pid:2646  ppid:2459
[   76.982128] Call Trace:
[   76.982139]  __schedule+0x6ba/0x10f0
[   76.982155]  schedule+0x9d/0x1e0
[   76.982159]  rwsem_down_read_slowpath+0x4f4/0x910
[   76.982173]  down_read+0x84/0x170
[   76.982177]  dm_thin_find_block+0x4c/0xd0
[   76.982183]  thin_map+0x201/0x3d0
[   76.982188]  __map_bio+0x5b/0x350
[   76.982195]  dm_submit_bio+0x2b6/0x930
[   76.982202]  __submit_bio+0x123/0x2d0
[   76.982209]  submit_bio_noacct_nocheck+0x101/0x3e0
[   76.982222]  submit_bio_noacct+0x389/0x770
[   76.982227]  submit_bio+0x50/0xc0
[   76.982232]  submit_bh_wbc+0x15e/0x230
[   76.982238]  submit_bh+0x14/0x20
[   76.982241]  ext4_read_bh_nowait+0xc5/0x130
[   76.982247]  ext4_read_block_bitmap_nowait+0x340/0xc60
[   76.982254]  ext4_mb_init_cache+0x1ce/0xdc0
[   76.982259]  ext4_mb_load_buddy_gfp+0x987/0xfa0
[   76.982263]  ext4_discard_preallocations+0x45d/0x830
[   76.982274]  ext4_clear_inode+0x48/0xf0
[   76.982280]  ext4_evict_inode+0xcf/0xc70
[   76.982285]  evict+0x119/0x2b0
[   76.982290]  dispose_list+0x43/0xa0
[   76.982294]  prune_icache_sb+0x64/0x90
[   76.982298]  super_cache_scan+0x155/0x210
[   76.982303]  do_shrink_slab+0x19e/0x4e0
[   76.982310]  shrink_slab+0x2bd/0x450
[   76.982317]  drop_slab+0xcc/0x1a0
[   76.982323]  drop_caches_sysctl_handler+0xb7/0xe0
[   76.982327]  proc_sys_call_handler+0x1bc/0x300
[   76.982331]  proc_sys_write+0x17/0x20
[   76.982334]  vfs_write+0x3d3/0x570
[   76.982342]  ksys_write+0x73/0x160
[   76.982347]  __x64_sys_write+0x1e/0x30
[   76.982352]  do_syscall_64+0x35/0x80
[   76.982357]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

Function metadata_operation_failed() is called when operations failed
on dm pool metadata, dm pool will destroy and recreate metadata. So,
shrinker will be unregistered and registered, which could down write
shrinker_rwsem under pmd_write_lock.
Add new helper dm_bufio_client_reset() based on functions __do_init and
__do_destroy, then dm pool could reset metadata without reinitializing
shrinker.

Fetch a reproducer in [Link].

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216676
Fixes: e49e582965b3 ("dm thin: add read only and fail io modes")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/md/dm-bufio.c                         | 43 +++++++++++++++++++
 drivers/md/dm-thin-metadata.c                 | 36 ++++++++++++++--
 drivers/md/persistent-data/dm-block-manager.c | 21 +++++++++
 drivers/md/persistent-data/dm-block-manager.h |  4 ++
 include/linux/dm-bufio.h                      | 10 +++++
 5 files changed, 111 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 5859d69d6944..c591bef61671 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -1968,6 +1968,49 @@ void dm_bufio_client_destroy(struct dm_bufio_client *c)
 }
 EXPORT_SYMBOL_GPL(dm_bufio_client_destroy);
 
+/*
+ * Reset the buffering interface
+ * Besides @c->shrinker, destroy and re-initialize all members in
+ * dm_bufio_client. The dm_bufio_client instance should be detroyed
+ * by caller even reset failed.
+ */
+int dm_bufio_client_reset(struct dm_bufio_client *c, struct block_device *bdev,
+			  unsigned int block_size,
+			  unsigned int reserved_buffers, unsigned int aux_size,
+			  void (*alloc_callback)(struct dm_buffer *),
+			  void (*write_callback)(struct dm_buffer *),
+			  unsigned int flags)
+{
+	int r;
+
+	if (!block_size || block_size & ((1 << SECTOR_SHIFT) - 1)) {
+		DMERR("%s: block size not specified or is not multiple of 512b", __func__);
+		return -EINVAL;
+	}
+
+	drop_buffers(c);
+	flush_work(&c->shrink_work);
+	mutex_lock(&dm_bufio_clients_lock);
+	list_del(&c->client_list);
+	dm_bufio_client_count--;
+	__cache_size_refresh();
+	mutex_unlock(&dm_bufio_clients_lock);
+	__do_destroy(c);
+
+	r = __do_init(c, bdev, block_size, reserved_buffers, aux_size,
+		      alloc_callback, write_callback, flags);
+
+	/* The instance should still be added list back if __do_init failed. */
+	mutex_lock(&dm_bufio_clients_lock);
+	dm_bufio_client_count++;
+	list_add(&c->client_list, &dm_bufio_all_clients);
+	__cache_size_refresh();
+	mutex_unlock(&dm_bufio_clients_lock);
+
+	return r;
+}
+EXPORT_SYMBOL_GPL(dm_bufio_client_reset);
+
 void dm_bufio_set_sector_offset(struct dm_bufio_client *c, sector_t start)
 {
 	c->start = start;
diff --git a/drivers/md/dm-thin-metadata.c b/drivers/md/dm-thin-metadata.c
index a27395c8621f..6c3096fdb4e8 100644
--- a/drivers/md/dm-thin-metadata.c
+++ b/drivers/md/dm-thin-metadata.c
@@ -1857,23 +1857,53 @@ static void __set_abort_with_changes_flags(struct dm_pool_metadata *pmd)
 		td->aborted_with_changes = td->changed;
 }
 
+static int __reset_persistent_data_objects(struct dm_pool_metadata *pmd)
+{
+	int r;
+
+	dm_sm_destroy(pmd->data_sm);
+	dm_sm_destroy(pmd->metadata_sm);
+	dm_tm_destroy(pmd->nb_tm);
+	dm_tm_destroy(pmd->tm);
+
+	r = dm_block_manager_reset(pmd->bm, pmd->bdev,
+				   THIN_METADATA_BLOCK_SIZE << SECTOR_SHIFT,
+				   THIN_MAX_CONCURRENT_LOCKS);
+	if (r) {
+		DMERR("could not reset block manager");
+		return r;
+	}
+
+	return __open_or_format_metadata(pmd, false);
+}
+
 int dm_pool_abort_metadata(struct dm_pool_metadata *pmd)
 {
 	int r = -EINVAL;
+	struct dm_block_manager *bm = NULL;
 
 	pmd_write_lock(pmd);
 	if (pmd->fail_io)
 		goto out;
 
 	__set_abort_with_changes_flags(pmd);
-	__destroy_persistent_data_objects(pmd);
-	r = __create_persistent_data_objects(pmd, false);
-	if (r)
+	r = __reset_persistent_data_objects(pmd);
+	if (r) {
 		pmd->fail_io = true;
+		bm = pmd->bm;
+		pmd->bm = NULL;
+		goto out_destroy_manager;
+	}
 
 out:
 	pmd_write_unlock(pmd);
 
+	return r;
+
+out_destroy_manager:
+	pmd_write_unlock(pmd);
+	dm_block_manager_destroy(bm);
+
 	return r;
 }
 
diff --git a/drivers/md/persistent-data/dm-block-manager.c b/drivers/md/persistent-data/dm-block-manager.c
index 11935864f50f..c02bc56f3f71 100644
--- a/drivers/md/persistent-data/dm-block-manager.c
+++ b/drivers/md/persistent-data/dm-block-manager.c
@@ -415,6 +415,27 @@ void dm_block_manager_destroy(struct dm_block_manager *bm)
 }
 EXPORT_SYMBOL_GPL(dm_block_manager_destroy);
 
+int dm_block_manager_reset(struct dm_block_manager *bm,
+			   struct block_device *bdev, unsigned int block_size,
+			   unsigned int max_held_per_thread)
+{
+	int r;
+
+	r = dm_bufio_client_reset(bm->bufio, bdev, block_size,
+				  max_held_per_thread,
+				  sizeof(struct buffer_aux),
+				  dm_block_manager_alloc_callback,
+				  dm_block_manager_write_callback, 0);
+	if (r)
+		goto out;
+
+	bm->read_only = false;
+
+out:
+	return r;
+}
+EXPORT_SYMBOL_GPL(dm_block_manager_reset);
+
 unsigned dm_bm_block_size(struct dm_block_manager *bm)
 {
 	return dm_bufio_get_block_size(bm->bufio);
diff --git a/drivers/md/persistent-data/dm-block-manager.h b/drivers/md/persistent-data/dm-block-manager.h
index e728937f376a..596f3d65f670 100644
--- a/drivers/md/persistent-data/dm-block-manager.h
+++ b/drivers/md/persistent-data/dm-block-manager.h
@@ -36,6 +36,10 @@ struct dm_block_manager *dm_block_manager_create(
 	unsigned max_held_per_thread);
 void dm_block_manager_destroy(struct dm_block_manager *bm);
 
+int dm_block_manager_reset(struct dm_block_manager *bm,
+	struct block_device *bdev, unsigned int block_size,
+	unsigned int max_held_per_thread);
+
 unsigned dm_bm_block_size(struct dm_block_manager *bm);
 dm_block_t dm_bm_nr_blocks(struct dm_block_manager *bm);
 
diff --git a/include/linux/dm-bufio.h b/include/linux/dm-bufio.h
index ee4f19c170ab..5af88b28a258 100644
--- a/include/linux/dm-bufio.h
+++ b/include/linux/dm-bufio.h
@@ -37,6 +37,16 @@ dm_bufio_client_create(struct block_device *bdev, unsigned int block_size,
  */
 void dm_bufio_client_destroy(struct dm_bufio_client *c);
 
+/*
+ * Reset a buffered IO cache on a given device
+ */
+int dm_bufio_client_reset(struct dm_bufio_client *c, struct block_device *bdev,
+			  unsigned int block_size,
+			  unsigned int reserved_buffers, unsigned int aux_size,
+			  void (*alloc_callback)(struct dm_buffer *),
+			  void (*write_callback)(struct dm_buffer *),
+			  unsigned int flags);
+
 /*
  * Set the sector range.
  * When this function is called, there must be no I/O in progress on the bufio
-- 
2.31.1

