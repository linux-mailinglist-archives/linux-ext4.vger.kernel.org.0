Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E87D6C9961
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Mar 2023 03:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjC0Bnm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 26 Mar 2023 21:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjC0Bnl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 26 Mar 2023 21:43:41 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3ED46A9;
        Sun, 26 Mar 2023 18:43:39 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PlFs90n1czKx91;
        Mon, 27 Mar 2023 09:41:17 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 09:43:37 +0800
Message-ID: <ef1f08cc-51eb-4c6f-a245-e0dc6fb7759b@huawei.com>
Date:   Mon, 27 Mar 2023 09:43:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 1/2] ext4: turning quotas off if mount failed after enable
 quotas
To:     kernel test robot <lkp@intel.com>, <linux-ext4@vger.kernel.org>
CC:     <oe-kbuild-all@lists.linux.dev>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, <stable@kernel.org>
References: <20230325064732.1897482-2-libaokun1@huawei.com>
 <202303252258.vJkQLCe1-lkp@intel.com>
Content-Language: en-US
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <202303252258.vJkQLCe1-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/3/25 22:33, kernel test robot wrote:
> Hi Baokun,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on tytso-ext4/dev]
> [also build test WARNING on linus/master v6.3-rc3 next-20230324]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Baokun-Li/ext4-turning-quotas-off-if-mount-failed-after-enable-quotas/20230325-144948
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
> patch link:    https://lore.kernel.org/r/20230325064732.1897482-2-libaokun1%40huawei.com
> patch subject: [PATCH 1/2] ext4: turning quotas off if mount failed after enable quotas
> config: x86_64-randconfig-a002 (https://download.01.org/0day-ci/archive/20230325/202303252258.vJkQLCe1-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce (this is a W=1 build):
>          # https://github.com/intel-lab-lkp/linux/commit/0796673fe204bc43455489f7d9cdf18c1ca9c678
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Baokun-Li/ext4-turning-quotas-off-if-mount-failed-after-enable-quotas/20230325-144948
>          git checkout 0796673fe204bc43455489f7d9cdf18c1ca9c678
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          make W=1 O=build_dir ARCH=x86_64 olddefconfig
>          make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/ext4/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303252258.vJkQLCe1-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>     fs/ext4/super.c: In function '__ext4_fill_super':
>>> fs/ext4/super.c:5544:1: warning: label 'failed_mount9' defined but not used [-Wunused-label]
>      5544 | failed_mount9:
>           | ^~~~~~~~~~~~~


Thank you very much for testing!

I checked for compile alarms with W=1, but I tested with CONFIG_QUOTA 
enabled, so I missed that.

I will send a v2 patch to fix the issue. Tanks again!

>
> vim +/failed_mount9 +5544 fs/ext4/super.c
>
> 9b2ff35753c051 Jan Kara                2013-03-02  5499
> bc71726c725767 zhangyi (F              2020-06-20  5500) 	/*
> bc71726c725767 zhangyi (F              2020-06-20  5501) 	 * Save the original bdev mapping's wb_err value which could be
> bc71726c725767 zhangyi (F              2020-06-20  5502) 	 * used to detect the metadata async write error.
> bc71726c725767 zhangyi (F              2020-06-20  5503) 	 */
> bc71726c725767 zhangyi (F              2020-06-20  5504) 	spin_lock_init(&sbi->s_bdev_wb_lock);
> bc71726c725767 zhangyi (F              2020-06-20  5505) 	errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
> bc71726c725767 zhangyi (F              2020-06-20  5506) 				 &sbi->s_bdev_wb_err);
> bc71726c725767 zhangyi (F              2020-06-20  5507) 	sb->s_bdev->bd_super = sb;
> 617ba13b31fbf5 Mingming Cao            2006-10-11  5508  	EXT4_SB(sb)->s_mount_state |= EXT4_ORPHAN_FS;
> 617ba13b31fbf5 Mingming Cao            2006-10-11  5509  	ext4_orphan_cleanup(sb, es);
> 617ba13b31fbf5 Mingming Cao            2006-10-11  5510  	EXT4_SB(sb)->s_mount_state &= ~EXT4_ORPHAN_FS;
> 9b6641dd95a0c4 Ye Bin                  2022-05-25  5511  	/*
> 9b6641dd95a0c4 Ye Bin                  2022-05-25  5512  	 * Update the checksum after updating free space/inode counters and
> 9b6641dd95a0c4 Ye Bin                  2022-05-25  5513  	 * ext4_orphan_cleanup. Otherwise the superblock can have an incorrect
> 9b6641dd95a0c4 Ye Bin                  2022-05-25  5514  	 * checksum in the buffer cache until it is written out and
> 9b6641dd95a0c4 Ye Bin                  2022-05-25  5515  	 * e2fsprogs programs trying to open a file system immediately
> 9b6641dd95a0c4 Ye Bin                  2022-05-25  5516  	 * after it is mounted can fail.
> 9b6641dd95a0c4 Ye Bin                  2022-05-25  5517  	 */
> 9b6641dd95a0c4 Ye Bin                  2022-05-25  5518  	ext4_superblock_csum_set(sb);
> 0390131ba84fd3 Frank Mayhar            2009-01-07  5519  	if (needs_recovery) {
> b31e15527a9bb7 Eric Sandeen            2009-06-04  5520  		ext4_msg(sb, KERN_INFO, "recovery complete");
> 11215630aada28 Jan Kara                2020-07-10  5521  		err = ext4_mark_recovery_complete(sb, es);
> 11215630aada28 Jan Kara                2020-07-10  5522  		if (err)
> 0796673fe204bc Baokun Li               2023-03-25  5523  			goto failed_mount10;
> 0390131ba84fd3 Frank Mayhar            2009-01-07  5524  	}
> 0390131ba84fd3 Frank Mayhar            2009-01-07  5525
> 70200574cc229f Christoph Hellwig       2022-04-15  5526  	if (test_opt(sb, DISCARD) && !bdev_max_discard_sectors(sb->s_bdev))
> 79add3a3f795e6 Lukas Czerner           2012-11-08  5527  		ext4_msg(sb, KERN_WARNING,
> 70200574cc229f Christoph Hellwig       2022-04-15  5528  			 "mounting with \"discard\" option, but the device does not support discard");
> 79add3a3f795e6 Lukas Czerner           2012-11-08  5529
> 66e61a9e9504f6 Theodore Ts'o           2010-07-27  5530  	if (es->s_error_count)
> 66e61a9e9504f6 Theodore Ts'o           2010-07-27  5531  		mod_timer(&sbi->s_err_report, jiffies + 300*HZ); /* 5 minutes */
> ac27a0ec112a08 Dave Kleikamp           2006-10-11  5532
> efbed4dc5857f8 Theodore Ts'o           2013-10-17  5533  	/* Enable message ratelimiting. Default is 10 messages per 5 secs. */
> efbed4dc5857f8 Theodore Ts'o           2013-10-17  5534  	ratelimit_state_init(&sbi->s_err_ratelimit_state, 5 * HZ, 10);
> efbed4dc5857f8 Theodore Ts'o           2013-10-17  5535  	ratelimit_state_init(&sbi->s_warning_ratelimit_state, 5 * HZ, 10);
> efbed4dc5857f8 Theodore Ts'o           2013-10-17  5536  	ratelimit_state_init(&sbi->s_msg_ratelimit_state, 5 * HZ, 10);
> 1cf006ed19a887 Dmitry Monakhov         2020-07-25  5537  	atomic_set(&sbi->s_warning_count, 0);
> 1cf006ed19a887 Dmitry Monakhov         2020-07-25  5538  	atomic_set(&sbi->s_msg_count, 0);
> efbed4dc5857f8 Theodore Ts'o           2013-10-17  5539
> ac27a0ec112a08 Dave Kleikamp           2006-10-11  5540  	return 0;
> ac27a0ec112a08 Dave Kleikamp           2006-10-11  5541
> 0796673fe204bc Baokun Li               2023-03-25  5542  failed_mount10:
> 0796673fe204bc Baokun Li               2023-03-25  5543  	ext4_quota_off_umount(sb);
> 02f310fcf47fa9 Jan Kara                2021-08-16 @5544  failed_mount9:
> 02f310fcf47fa9 Jan Kara                2021-08-16  5545  	ext4_release_orphan_info(sb);
> 72ba74508b2857 Theodore Ts'o           2013-01-24  5546  failed_mount8:
> ebd173beb8db5b Theodore Ts'o           2015-09-23  5547  	ext4_unregister_sysfs(sb);
> cb8d53d2c97369 Eric Biggers            2020-09-22  5548  	kobject_put(&sbi->s_kobj);
> dcf2d804ed6ffe Tao Ma                  2011-10-06  5549  failed_mount7:
> dcf2d804ed6ffe Tao Ma                  2011-10-06  5550  	ext4_unregister_li_request(sb);
> dcf2d804ed6ffe Tao Ma                  2011-10-06  5551  failed_mount6:
> f9ae9cf5d72b39 Theodore Ts'o           2014-07-11  5552  	ext4_mb_release(sb);
> 7c990728b99ed6 Suraj Jitindar Singh    2020-02-18  5553  	rcu_read_lock();
> 7c990728b99ed6 Suraj Jitindar Singh    2020-02-18  5554  	flex_groups = rcu_dereference(sbi->s_flex_groups);
> 7c990728b99ed6 Suraj Jitindar Singh    2020-02-18  5555  	if (flex_groups) {
> 7c990728b99ed6 Suraj Jitindar Singh    2020-02-18  5556  		for (i = 0; i < sbi->s_flex_groups_allocated; i++)
> 7c990728b99ed6 Suraj Jitindar Singh    2020-02-18  5557  			kvfree(flex_groups[i]);
> 7c990728b99ed6 Suraj Jitindar Singh    2020-02-18  5558  		kvfree(flex_groups);
> 7c990728b99ed6 Suraj Jitindar Singh    2020-02-18  5559  	}
> 7c990728b99ed6 Suraj Jitindar Singh    2020-02-18  5560  	rcu_read_unlock();
> d5e03cbb0c88cd Theodore Ts'o           2014-07-15  5561  	percpu_counter_destroy(&sbi->s_freeclusters_counter);
> d5e03cbb0c88cd Theodore Ts'o           2014-07-15  5562  	percpu_counter_destroy(&sbi->s_freeinodes_counter);
> d5e03cbb0c88cd Theodore Ts'o           2014-07-15  5563  	percpu_counter_destroy(&sbi->s_dirs_counter);
> d5e03cbb0c88cd Theodore Ts'o           2014-07-15  5564  	percpu_counter_destroy(&sbi->s_dirtyclusters_counter);
> efc61345274d6c Eric Whitney            2021-02-18  5565  	percpu_counter_destroy(&sbi->s_sra_exceeded_retry_limit);
> bbd55937de8f27 Eric Biggers            2020-02-19  5566  	percpu_free_rwsem(&sbi->s_writepages_rwsem);
> 007649375f6af2 Azat Khuzhin            2014-04-07  5567  failed_mount5:
> f9ae9cf5d72b39 Theodore Ts'o           2014-07-11  5568  	ext4_ext_release(sb);
> f9ae9cf5d72b39 Theodore Ts'o           2014-07-11  5569  	ext4_release_system_zone(sb);
> f9ae9cf5d72b39 Theodore Ts'o           2014-07-11  5570  failed_mount4a:
> 94bf608a18fa44 Al Viro                 2012-01-09  5571  	dput(sb->s_root);
> 32a9bb57d7c1fd Manish Katiyar          2011-02-27  5572  	sb->s_root = NULL;
> 94bf608a18fa44 Al Viro                 2012-01-09  5573  failed_mount4:
> b31e15527a9bb7 Eric Sandeen            2009-06-04  5574  	ext4_msg(sb, KERN_ERR, "mount failed");
> 2e8fa54e3b48e4 Jan Kara                2013-06-04  5575  	if (EXT4_SB(sb)->rsv_conversion_wq)
> 2e8fa54e3b48e4 Jan Kara                2013-06-04  5576  		destroy_workqueue(EXT4_SB(sb)->rsv_conversion_wq);
> 4c0425ff68b1b8 Mingming Cao            2009-09-28  5577  failed_mount_wq:
> dec214d00e0d78 Tahsin Erdogan          2017-06-22  5578  	ext4_xattr_destroy_cache(sbi->s_ea_inode_cache);
> dec214d00e0d78 Tahsin Erdogan          2017-06-22  5579  	sbi->s_ea_inode_cache = NULL;
> 50c15df69e062b Chengguang Xu           2018-12-04  5580
> 47387409ee2e09 Tahsin Erdogan          2017-06-22  5581  	ext4_xattr_destroy_cache(sbi->s_ea_block_cache);
> 47387409ee2e09 Tahsin Erdogan          2017-06-22  5582  	sbi->s_ea_block_cache = NULL;
> 50c15df69e062b Chengguang Xu           2018-12-04  5583
> 0390131ba84fd3 Frank Mayhar            2009-01-07  5584  	if (sbi->s_journal) {
> bb9464e08309f6 yangerkun               2021-09-24  5585  		/* flush s_error_work before journal destroy. */
> bb9464e08309f6 yangerkun               2021-09-24  5586  		flush_work(&sbi->s_error_work);
> dab291af8d6307 Mingming Cao            2006-10-11  5587  		jbd2_journal_destroy(sbi->s_journal);
> 47b4a50bebfd34 Jan Kara                2008-07-11  5588  		sbi->s_journal = NULL;
> 0390131ba84fd3 Frank Mayhar            2009-01-07  5589  	}
> 50460fe8c6d1d9 Darrick J. Wong         2014-10-30  5590  failed_mount3a:
> d3922a777f9b4c Zheng Liu               2013-07-01  5591  	ext4_es_unregister_shrinker(sbi);
> eb68d0e2fc5a4e Zheng Liu               2014-09-01  5592  failed_mount3:
> bb9464e08309f6 yangerkun               2021-09-24  5593  	/* flush s_error_work before sbi destroy */
> c92dc856848f32 Jan Kara                2020-11-27  5594  	flush_work(&sbi->s_error_work);
> 2a4ae3bcdf05b8 Jan Kara                2021-03-15  5595  	del_timer_sync(&sbi->s_err_report);
> 618f003199c618 Pavel Skripkin          2021-04-30  5596  	ext4_stop_mmpd(sbi);
> a4e6a511d7de5d Jason Yan               2022-09-16  5597  	ext4_group_desc_free(sbi);
> ac27a0ec112a08 Dave Kleikamp           2006-10-11  5598  failed_mount:
> 0441984a339897 Darrick J. Wong         2012-04-29  5599  	if (sbi->s_chksum_driver)
> 0441984a339897 Darrick J. Wong         2012-04-29  5600  		crypto_free_shash(sbi->s_chksum_driver);
> c83ad55eaa91c8 Gabriel Krisman Bertazi 2019-04-25  5601
>
-- 
With Best Regards,
Baokun Li
.
