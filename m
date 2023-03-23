Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440416C7197
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Mar 2023 21:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCWUQy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Mar 2023 16:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCWUQx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Mar 2023 16:16:53 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8F5168AB
        for <linux-ext4@vger.kernel.org>; Thu, 23 Mar 2023 13:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679602605; x=1711138605;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2uDqmEwaU5mjJXXcalFZYkVQ7mXckIPLaYooLwrSK1w=;
  b=asL46ZNnSa1S+PJaagFr4Q9grfGZQvrD2X2lNXZnuRxKFv90LUh3K7Wq
   K5dHURIPy91YuwQYf/MgwexG3BtGDj7YdD7er9cX5/Aa0YL5U7j9n00Gw
   jXTSx8g16N355G0a7evn5m4rFqmzm6eNQQ5ZKg8H23M9HxqcBMZyqKF3n
   N9Er4PxcpGOMR10uJudBs3rUW28HolTYk8qET04YzTKm/I++XwmZ3n7Qe
   9WVK/9e4SvLbAXSczfbo7q8loscNQxpesz5d9VYRjasCsXoEGaK1zEzf5
   EOxKFelZFZcZFYfeKsYgrMte4da1AfMvUat4IAmT1ff4RtwQ5U7bWou3A
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="402193465"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="402193465"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 13:16:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="751634785"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="751634785"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 23 Mar 2023 13:16:42 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfRMX-000Eg2-2W;
        Thu, 23 Mar 2023 20:16:41 +0000
Date:   Fri, 24 Mar 2023 04:16:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Yan <yanaijie@huawei.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        lczerner@redhat.com, linux-ext4@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Jason Yan <yanaijie@huawei.com>
Subject: Re: [PATCH 4/8] ext4: factor out ext4_flex_groups_free()
Message-ID: <202303240449.6Cg6YXJO-lkp@intel.com>
References: <20230323140517.1070239-5-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323140517.1070239-5-yanaijie@huawei.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Jason,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tytso-ext4/dev]
[also build test WARNING on linus/master v6.3-rc3 next-20230323]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Yan/ext4-factor-out-ext4_hash_info_init/20230323-221039
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20230323140517.1070239-5-yanaijie%40huawei.com
patch subject: [PATCH 4/8] ext4: factor out ext4_flex_groups_free()
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20230324/202303240449.6Cg6YXJO-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/883a78e3cabf802d7a0e1487f65bf49b4a4e60fb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jason-Yan/ext4-factor-out-ext4_hash_info_init/20230323-221039
        git checkout 883a78e3cabf802d7a0e1487f65bf49b4a4e60fb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/ext4/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303240449.6Cg6YXJO-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/ext4/super.c: In function 'ext4_put_super':
>> fs/ext4/super.c:1262:13: warning: unused variable 'i' [-Wunused-variable]
    1262 |         int i, err;
         |             ^
   fs/ext4/super.c: In function '__ext4_fill_super':
   fs/ext4/super.c:5104:22: warning: unused variable 'i' [-Wunused-variable]
    5104 |         unsigned int i;
         |                      ^


vim +/i +1262 fs/ext4/super.c

883a78e3cabf80 Jason Yan               2023-03-23  1256  
617ba13b31fbf5 Mingming Cao            2006-10-11  1257  static void ext4_put_super(struct super_block *sb)
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1258  {
617ba13b31fbf5 Mingming Cao            2006-10-11  1259  	struct ext4_sb_info *sbi = EXT4_SB(sb);
617ba13b31fbf5 Mingming Cao            2006-10-11  1260  	struct ext4_super_block *es = sbi->s_es;
97abd7d4b5d9c4 Theodore Ts'o           2017-02-04  1261  	int aborted = 0;
ef2cabf7c6d838 Hidehiro Kawai          2008-10-27 @1262  	int i, err;
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1263  
5e47868fb94b63 Ritesh Harjani          2020-03-18  1264  	/*
5e47868fb94b63 Ritesh Harjani          2020-03-18  1265  	 * Unregister sysfs before destroying jbd2 journal.
5e47868fb94b63 Ritesh Harjani          2020-03-18  1266  	 * Since we could still access attr_journal_task attribute via sysfs
5e47868fb94b63 Ritesh Harjani          2020-03-18  1267  	 * path which could have sbi->s_journal->j_task as NULL
b98535d091795a Ye Bin                  2022-03-22  1268  	 * Unregister sysfs before flush sbi->s_error_work.
b98535d091795a Ye Bin                  2022-03-22  1269  	 * Since user may read /proc/fs/ext4/xx/mb_groups during umount, If
b98535d091795a Ye Bin                  2022-03-22  1270  	 * read metadata verify failed then will queue error work.
b98535d091795a Ye Bin                  2022-03-22  1271  	 * flush_stashed_error_work will call start_this_handle may trigger
b98535d091795a Ye Bin                  2022-03-22  1272  	 * BUG_ON.
5e47868fb94b63 Ritesh Harjani          2020-03-18  1273  	 */
5e47868fb94b63 Ritesh Harjani          2020-03-18  1274  	ext4_unregister_sysfs(sb);
5e47868fb94b63 Ritesh Harjani          2020-03-18  1275  
4808cb5b98b436 Zhang Yi                2022-04-12  1276  	if (___ratelimit(&ext4_mount_msg_ratelimit, "EXT4-fs unmount"))
bb0fbc782ee9fa Lukas Czerner           2022-11-08  1277  		ext4_msg(sb, KERN_INFO, "unmounting filesystem %pU.",
bb0fbc782ee9fa Lukas Czerner           2022-11-08  1278  			 &sb->s_uuid);
4808cb5b98b436 Zhang Yi                2022-04-12  1279  
b98535d091795a Ye Bin                  2022-03-22  1280  	ext4_unregister_li_request(sb);
b98535d091795a Ye Bin                  2022-03-22  1281  	ext4_quota_off_umount(sb);
b98535d091795a Ye Bin                  2022-03-22  1282  
b98535d091795a Ye Bin                  2022-03-22  1283  	flush_work(&sbi->s_error_work);
b98535d091795a Ye Bin                  2022-03-22  1284  	destroy_workqueue(sbi->rsv_conversion_wq);
b98535d091795a Ye Bin                  2022-03-22  1285  	ext4_release_orphan_info(sb);
b98535d091795a Ye Bin                  2022-03-22  1286  
0390131ba84fd3 Frank Mayhar            2009-01-07  1287  	if (sbi->s_journal) {
97abd7d4b5d9c4 Theodore Ts'o           2017-02-04  1288  		aborted = is_journal_aborted(sbi->s_journal);
ef2cabf7c6d838 Hidehiro Kawai          2008-10-27  1289  		err = jbd2_journal_destroy(sbi->s_journal);
47b4a50bebfd34 Jan Kara                2008-07-11  1290  		sbi->s_journal = NULL;
878520ac45f9f6 Theodore Ts'o           2019-11-19  1291  		if ((err < 0) && !aborted) {
54d3adbc29f0c7 Theodore Ts'o           2020-03-28  1292  			ext4_abort(sb, -err, "Couldn't clean up the journal");
0390131ba84fd3 Frank Mayhar            2009-01-07  1293  		}
878520ac45f9f6 Theodore Ts'o           2019-11-19  1294  	}
d4edac314e9ad0 Josef Bacik             2009-12-08  1295  
d3922a777f9b4c Zheng Liu               2013-07-01  1296  	ext4_es_unregister_shrinker(sbi);
292a089d78d3e2 Steven Rostedt (Google  2022-12-20  1297) 	timer_shutdown_sync(&sbi->s_err_report);
d4edac314e9ad0 Josef Bacik             2009-12-08  1298  	ext4_release_system_zone(sb);
d4edac314e9ad0 Josef Bacik             2009-12-08  1299  	ext4_mb_release(sb);
d4edac314e9ad0 Josef Bacik             2009-12-08  1300  	ext4_ext_release(sb);
d4edac314e9ad0 Josef Bacik             2009-12-08  1301  
bc98a42c1f7d0f David Howells           2017-07-17  1302  	if (!sb_rdonly(sb) && !aborted) {
e2b911c53584a9 Darrick J. Wong         2015-10-17  1303  		ext4_clear_feature_journal_needs_recovery(sb);
02f310fcf47fa9 Jan Kara                2021-08-16  1304  		ext4_clear_feature_orphan_present(sb);
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1305  		es->s_state = cpu_to_le16(sbi->s_mount_state);
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1306  	}
bc98a42c1f7d0f David Howells           2017-07-17  1307  	if (!sb_rdonly(sb))
4392fbc4bab57d Jan Kara                2020-12-16  1308  		ext4_commit_super(sb);
a8e25a83245618 Artem Bityutskiy        2012-03-21  1309  
d7cdc05df16e78 Jason Yan               2023-03-23  1310  	ext4_group_desc_free(sbi);
883a78e3cabf80 Jason Yan               2023-03-23  1311  	ext4_flex_groups_free(sbi);
57df61a7d6477e Jason Yan               2023-03-23  1312  	ext4_percpu_param_destroy(sbi);
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1313  #ifdef CONFIG_QUOTA
a2d4a646e61954 Jan Kara                2014-09-11  1314  	for (i = 0; i < EXT4_MAXQUOTAS; i++)
33458eaba4dfe7 Theodore Ts'o           2018-10-12  1315  		kfree(get_qf_name(sb, sbi, i));
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1316  #endif
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1317  
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1318  	/* Debugging code just in case the in-memory inode orphan list
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1319  	 * isn't empty.  The on-disk one can be non-empty if we've
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1320  	 * detected an error and taken the fs readonly, but the
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1321  	 * in-memory list had better be clean by this point. */
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1322  	if (!list_empty(&sbi->s_orphan))
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1323  		dump_orphan_list(sb, sbi);
837c23fbc1b812 Chunguang Xu            2020-11-07  1324  	ASSERT(list_empty(&sbi->s_orphan));
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1325  
89d96a6f8e6491 Theodore Ts'o           2015-06-20  1326  	sync_blockdev(sb->s_bdev);
f98393a64ca139 Peter Zijlstra          2007-05-06  1327  	invalidate_bdev(sb->s_bdev);
ee7ed3aa0f0862 Chunguang Xu            2020-09-24  1328  	if (sbi->s_journal_bdev && sbi->s_journal_bdev != sb->s_bdev) {
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1329  		/*
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1330  		 * Invalidate the journal device's buffers.  We don't want them
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1331  		 * floating about in memory - the physical journal device may
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1332  		 * hotswapped, and it breaks the `ro-after' testing code.
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1333  		 */
ee7ed3aa0f0862 Chunguang Xu            2020-09-24  1334  		sync_blockdev(sbi->s_journal_bdev);
ee7ed3aa0f0862 Chunguang Xu            2020-09-24  1335  		invalidate_bdev(sbi->s_journal_bdev);
617ba13b31fbf5 Mingming Cao            2006-10-11  1336  		ext4_blkdev_remove(sbi);
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1337  	}
50c15df69e062b Chengguang Xu           2018-12-04  1338  
dec214d00e0d78 Tahsin Erdogan          2017-06-22  1339  	ext4_xattr_destroy_cache(sbi->s_ea_inode_cache);
dec214d00e0d78 Tahsin Erdogan          2017-06-22  1340  	sbi->s_ea_inode_cache = NULL;
50c15df69e062b Chengguang Xu           2018-12-04  1341  
47387409ee2e09 Tahsin Erdogan          2017-06-22  1342  	ext4_xattr_destroy_cache(sbi->s_ea_block_cache);
47387409ee2e09 Tahsin Erdogan          2017-06-22  1343  	sbi->s_ea_block_cache = NULL;
50c15df69e062b Chengguang Xu           2018-12-04  1344  
618f003199c618 Pavel Skripkin          2021-04-30  1345  	ext4_stop_mmpd(sbi);
618f003199c618 Pavel Skripkin          2021-04-30  1346  
9060dd2c5036b1 Eric Sandeen            2016-11-26  1347  	brelse(sbi->s_sbh);
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1348  	sb->s_fs_info = NULL;
3197ebdb130473 Theodore Ts'o           2009-03-31  1349  	/*
3197ebdb130473 Theodore Ts'o           2009-03-31  1350  	 * Now that we are completely done shutting down the
3197ebdb130473 Theodore Ts'o           2009-03-31  1351  	 * superblock, we need to actually destroy the kobject.
3197ebdb130473 Theodore Ts'o           2009-03-31  1352  	 */
3197ebdb130473 Theodore Ts'o           2009-03-31  1353  	kobject_put(&sbi->s_kobj);
3197ebdb130473 Theodore Ts'o           2009-03-31  1354  	wait_for_completion(&sbi->s_kobj_unregister);
0441984a339897 Darrick J. Wong         2012-04-29  1355  	if (sbi->s_chksum_driver)
0441984a339897 Darrick J. Wong         2012-04-29  1356  		crypto_free_shash(sbi->s_chksum_driver);
705895b61133ef Pekka Enberg            2009-02-15  1357  	kfree(sbi->s_blockgroup_lock);
8012b866085523 Shiyang Ruan            2022-06-03  1358  	fs_put_dax(sbi->s_daxdev, NULL);
ac4acb1f4b2b6b Eric Biggers            2020-09-16  1359  	fscrypt_free_dummy_policy(&sbi->s_dummy_enc_policy);
5298d4bfe80f6a Christoph Hellwig       2022-01-18  1360  #if IS_ENABLED(CONFIG_UNICODE)
f8f4acb6cded4e Daniel Rosenberg        2020-10-28  1361  	utf8_unload(sb->s_encoding);
c83ad55eaa91c8 Gabriel Krisman Bertazi 2019-04-25  1362  #endif
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1363  	kfree(sbi);
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1364  }
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1365  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
