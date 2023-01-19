Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FEF672DDD
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Jan 2023 02:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjASBNG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Jan 2023 20:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjASBNC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Jan 2023 20:13:02 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501B7683FE;
        Wed, 18 Jan 2023 17:12:59 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ny4PL5N8Jz4f3jLm;
        Thu, 19 Jan 2023 09:12:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgC3YiAXmchj7jA8Bw--.49635S4;
        Thu, 19 Jan 2023 09:12:57 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH] ext4: init error handle resource before init group descriptors
Date:   Thu, 19 Jan 2023 09:37:11 +0800
Message-Id: <20230119013711.86680-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgC3YiAXmchj7jA8Bw--.49635S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAFy8Xr1fWrWUKw48Kr1ftFb_yoW5Ary7pa
        s8CwnrCry5Grykua18Aa4vqFy0ka10kFW5GryfW3WfZas2qFyDXF1aqF1YyFyjgFZ7uw1f
        Xa1kG347Cr17C3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
        c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJV
        Cq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBI
        daVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

Now, 's_err_report' timer is init after ext4_group_desc_init() when fill
super. Theoretically, ext4_group_desc_init() may access to error handle
as follows:
__ext4_fill_super
  ext4_group_desc_init
    ext4_check_descriptors
      ext4_get_group_desc
        ext4_error
          ext4_handle_error
            ext4_commit_super
              ext4_update_super
                if (!es->s_error_count)
                  mod_timer(&sbi->s_err_report, jiffies + 24*60*60*HZ);
		  --> Accessing Uninitialized Variables
timer_setup(&sbi->s_err_report, print_daily_error_info, 0);

Maybe above issue is just theoretical, as ext4_check_descriptors() didn't
judge 'gpd' which get from ext4_get_group_desc(), if access to error handle
ext4_get_group_desc() will return NULL, then will trigger null-ptr-deref in
ext4_check_descriptors().
However, from the perspective of pure code, it is better to initialize
resource that may need to be used first.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/super.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b31db521d6bf..dc3907dff13a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4738,7 +4738,6 @@ static int ext4_group_desc_init(struct super_block *sb,
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	unsigned int db_count;
 	ext4_fsblk_t block;
-	int ret;
 	int i;
 
 	db_count = (sbi->s_groups_count + EXT4_DESC_PER_BLOCK(sb) - 1) /
@@ -4778,8 +4777,7 @@ static int ext4_group_desc_init(struct super_block *sb,
 			ext4_msg(sb, KERN_ERR,
 			       "can't read group descriptor %d", i);
 			sbi->s_gdb_count = i;
-			ret = PTR_ERR(bh);
-			goto out;
+			return PTR_ERR(bh);
 		}
 		rcu_read_lock();
 		rcu_dereference(sbi->s_group_desc)[i] = bh;
@@ -4788,13 +4786,10 @@ static int ext4_group_desc_init(struct super_block *sb,
 	sbi->s_gdb_count = db_count;
 	if (!ext4_check_descriptors(sb, logical_sb_block, first_not_zeroed)) {
 		ext4_msg(sb, KERN_ERR, "group descriptors corrupted!");
-		ret = -EFSCORRUPTED;
-		goto out;
+		return -EFSCORRUPTED;
 	}
+
 	return 0;
-out:
-	ext4_group_desc_free(sbi);
-	return ret;
 }
 
 static int ext4_load_and_init_journal(struct super_block *sb,
@@ -5220,14 +5215,14 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	if (ext4_geometry_check(sb, es))
 		goto failed_mount;
 
-	err = ext4_group_desc_init(sb, es, logical_sb_block, &first_not_zeroed);
-	if (err)
-		goto failed_mount;
-
 	timer_setup(&sbi->s_err_report, print_daily_error_info, 0);
 	spin_lock_init(&sbi->s_error_lock);
 	INIT_WORK(&sbi->s_error_work, flush_stashed_error_work);
 
+	err = ext4_group_desc_init(sb, es, logical_sb_block, &first_not_zeroed);
+	if (err)
+		goto failed_mount3;
+
 	/* Register extent status tree shrinker */
 	if (ext4_es_register_shrinker(sbi))
 		goto failed_mount3;
-- 
2.31.1

