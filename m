Return-Path: <linux-ext4+bounces-10975-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03344BEE606
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Oct 2025 15:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3CE189AC88
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Oct 2025 13:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3E52E427C;
	Sun, 19 Oct 2025 13:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dT/5+JF8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD95221A434;
	Sun, 19 Oct 2025 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760880544; cv=none; b=RtTCZNTMfQSXCwAXSOFqvlqpMmq+vkipSqtxs+2CgHaUKJemAmrGN+NA58A23CYcyEYvU87bB9QlBrgZynsH1+JDQFAmL+tQrbbSvDRruQg2mf3yl5Ujb5b6zrPIysQwX6xhraVX/6qws+tgMoWekw3l4HtYvWHo4cgAbjrU7Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760880544; c=relaxed/simple;
	bh=qbs3tLdkcGRTqjHT2PtXxvoi1t+zZQckJoSb+3WgIbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfF3CCS8WdZ5cvV/e0xZsNRU0di/Rk17+sFj69fGfTiZRGRp95Tnes4bkTENAZfG2gzrKMjHS8JdCS8bUKRspCLRD0N0wqTx7ydt0kxk3m1eECDaZuTCPX0RDow1OSGKC4c6MIgGgUpooQMp07K4wr9jCQTjrWXuAWvpYkP483M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dT/5+JF8; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760880543; x=1792416543;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qbs3tLdkcGRTqjHT2PtXxvoi1t+zZQckJoSb+3WgIbs=;
  b=dT/5+JF8ddTq2XFQ26HPq3aCW7Lbbok6pBxqU3XITy/dMq4vNyjXM597
   fAbSXlASl3IsAuNtEzNHOpaVnHHQ+uGknbJSJwt0QrLDUe7CFhO3/JsXf
   iJq7Cp6Mqmcgsf/YPjqjA+9BZ/SREpy+hOCp38ktLKCJVDH8sVdrCxOra
   2ciTZAkwKLstie2VUP6FFcuObgndOZ7xeDXCVckWf8B/k9gdMWnvsPmqh
   jXLGKyyPIPH4cRAelTXl0WkhLadbcF0dFSPjWA2rsyrXa+H8qx0MYTmGd
   VvzMaoJ7XjkEVBWXA8H+7C6qsJa14oq4k57iL+1KdYS+TM9ZPiFlNIvXZ
   A==;
X-CSE-ConnectionGUID: QZhL9Q/6R1GrS6H7YdLK5g==
X-CSE-MsgGUID: zjjbblRCSWyz3HT9wv327Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="62727622"
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="62727622"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 06:29:02 -0700
X-CSE-ConnectionGUID: rxNnOZchSEGIur3y4ihmYw==
X-CSE-MsgGUID: FvEixj3ZQLyqGHWZebZWmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="187550589"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 19 Oct 2025 06:28:59 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vATSz-00096b-2p;
	Sun, 19 Oct 2025 13:28:57 +0000
Date: Sun, 19 Oct 2025 21:28:11 +0800
From: kernel test robot <lkp@intel.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] jbd2: assign different lock_class_key for different
 filesystem
Message-ID: <202510192128.u69Bbmpz-lkp@intel.com>
References: <e42f1471-a88a-4938-8743-1d5b171c47ec@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e42f1471-a88a-4938-8743-1d5b171c47ec@I-love.SAKURA.ne.jp>

Hi Tetsuo,

kernel test robot noticed the following build errors:

[auto build test ERROR on tytso-ext4/dev]
[also build test ERROR on linus/master brauner-vfs/vfs.all v6.18-rc1 next-20251017]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tetsuo-Handa/jbd2-assign-different-lock_class_key-for-different-filesystem/20251019-185450
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/e42f1471-a88a-4938-8743-1d5b171c47ec%40I-love.SAKURA.ne.jp
patch subject: [PATCH] jbd2: assign different lock_class_key for different filesystem
config: x86_64-buildonly-randconfig-001-20251019 (https://download.01.org/0day-ci/archive/20251019/202510192128.u69Bbmpz-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251019/202510192128.u69Bbmpz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510192128.u69Bbmpz-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/jbd2/journal.c:1553:17: error: use of undeclared identifier 'EXT4_SUPER_MAGIC'
    1553 |             fsmagic == EXT4_SUPER_MAGIC) {
         |                        ^
>> fs/jbd2/journal.c:1562:17: error: use of undeclared identifier 'OCFS2_SUPER_MAGIC'
    1562 |                    fsmagic == OCFS2_SUPER_MAGIC) {
         |                               ^
   fs/jbd2/journal.c:1585:17: error: use of undeclared identifier 'EXT4_SUPER_MAGIC'
    1585 |             fsmagic == EXT4_SUPER_MAGIC)
         |                        ^
   fs/jbd2/journal.c:1589:15: error: use of undeclared identifier 'OCFS2_SUPER_MAGIC'
    1589 |                  fsmagic == OCFS2_SUPER_MAGIC)
         |                             ^
   4 errors generated.


vim +/EXT4_SUPER_MAGIC +1553 fs/jbd2/journal.c

  1508	
  1509	
  1510	/*
  1511	 * Management for journal control blocks: functions to create and
  1512	 * destroy journal_t structures, and to initialise and read existing
  1513	 * journal blocks from disk.  */
  1514	
  1515	/* The journal_init_common() function creates and fills a journal_t object
  1516	 * in memory. It calls journal_load_superblock() to load the on-disk journal
  1517	 * superblock and initialize the journal_t object.
  1518	 */
  1519	
  1520	static journal_t *journal_init_common(struct block_device *bdev, struct block_device *fs_dev,
  1521					      unsigned long long start, int len, int blocksize,
  1522					      unsigned long fsmagic)
  1523	{
  1524		static struct lock_class_key jbd2_trans_commit_key_ext4;
  1525		static struct lock_class_key jbd2_trans_commit_key_ocfs2;
  1526		static struct lock_class_key jbd2_trans_commit_key_unknown;
  1527		journal_t *journal;
  1528		int err;
  1529		int n;
  1530	
  1531		journal = kzalloc(sizeof(*journal), GFP_KERNEL);
  1532		if (!journal)
  1533			return ERR_PTR(-ENOMEM);
  1534	
  1535		journal->j_blocksize = blocksize;
  1536		journal->j_dev = bdev;
  1537		journal->j_fs_dev = fs_dev;
  1538		journal->j_blk_offset = start;
  1539		journal->j_total_len = len;
  1540		jbd2_init_fs_dev_write_error(journal);
  1541	
  1542		err = journal_load_superblock(journal);
  1543		if (err)
  1544			goto err_cleanup;
  1545	
  1546		init_waitqueue_head(&journal->j_wait_transaction_locked);
  1547		init_waitqueue_head(&journal->j_wait_done_commit);
  1548		init_waitqueue_head(&journal->j_wait_commit);
  1549		init_waitqueue_head(&journal->j_wait_updates);
  1550		init_waitqueue_head(&journal->j_wait_reserved);
  1551		init_waitqueue_head(&journal->j_fc_wait);
  1552		if (IS_ENABLED(CONFIG_LOCKDEP) && IS_ENABLED(CONFIG_EXT4_FS) &&
> 1553		    fsmagic == EXT4_SUPER_MAGIC) {
  1554			mutex_init(&journal->j_abort_mutex);
  1555			mutex_init(&journal->j_barrier);
  1556			mutex_init(&journal->j_checkpoint_mutex);
  1557			spin_lock_init(&journal->j_revoke_lock);
  1558			spin_lock_init(&journal->j_list_lock);
  1559			spin_lock_init(&journal->j_history_lock);
  1560			rwlock_init(&journal->j_state_lock);
  1561		} else if (IS_ENABLED(CONFIG_LOCKDEP) && IS_ENABLED(CONFIG_OCFS2_FS) &&
> 1562			   fsmagic == OCFS2_SUPER_MAGIC) {
  1563			mutex_init(&journal->j_abort_mutex);
  1564			mutex_init(&journal->j_barrier);
  1565			mutex_init(&journal->j_checkpoint_mutex);
  1566			spin_lock_init(&journal->j_revoke_lock);
  1567			spin_lock_init(&journal->j_list_lock);
  1568			spin_lock_init(&journal->j_history_lock);
  1569			rwlock_init(&journal->j_state_lock);
  1570		} else {
  1571			mutex_init(&journal->j_abort_mutex);
  1572			mutex_init(&journal->j_barrier);
  1573			mutex_init(&journal->j_checkpoint_mutex);
  1574			spin_lock_init(&journal->j_revoke_lock);
  1575			spin_lock_init(&journal->j_list_lock);
  1576			spin_lock_init(&journal->j_history_lock);
  1577			rwlock_init(&journal->j_state_lock);
  1578		}
  1579	
  1580		journal->j_commit_interval = (HZ * JBD2_DEFAULT_MAX_COMMIT_AGE);
  1581		journal->j_min_batch_time = 0;
  1582		journal->j_max_batch_time = 15000; /* 15ms */
  1583		atomic_set(&journal->j_reserved_credits, 0);
  1584		if (IS_ENABLED(CONFIG_LOCKDEP) && IS_ENABLED(CONFIG_EXT4_FS) &&
  1585		    fsmagic == EXT4_SUPER_MAGIC)
  1586			lockdep_init_map(&journal->j_trans_commit_map, "jbd2_handle_ext4",
  1587					 &jbd2_trans_commit_key_ext4, 0);
  1588		else if (IS_ENABLED(CONFIG_LOCKDEP) && IS_ENABLED(CONFIG_OCFS2_FS) &&
  1589			 fsmagic == OCFS2_SUPER_MAGIC)
  1590			lockdep_init_map(&journal->j_trans_commit_map, "jbd2_handle_ocfs2",
  1591					 &jbd2_trans_commit_key_ocfs2, 0);
  1592		else
  1593			lockdep_init_map(&journal->j_trans_commit_map, "jbd2_handle_unknown",
  1594					 &jbd2_trans_commit_key_unknown, 0);
  1595	
  1596		/* The journal is marked for error until we succeed with recovery! */
  1597		journal->j_flags = JBD2_ABORT;
  1598	
  1599		/* Set up a default-sized revoke table for the new mount. */
  1600		err = jbd2_journal_init_revoke(journal, JOURNAL_REVOKE_DEFAULT_HASH);
  1601		if (err)
  1602			goto err_cleanup;
  1603	
  1604		/*
  1605		 * journal descriptor can store up to n blocks, we need enough
  1606		 * buffers to write out full descriptor block.
  1607		 */
  1608		err = -ENOMEM;
  1609		n = journal->j_blocksize / jbd2_min_tag_size();
  1610		journal->j_wbufsize = n;
  1611		journal->j_fc_wbuf = NULL;
  1612		journal->j_wbuf = kmalloc_array(n, sizeof(struct buffer_head *),
  1613						GFP_KERNEL);
  1614		if (!journal->j_wbuf)
  1615			goto err_cleanup;
  1616	
  1617		err = percpu_counter_init(&journal->j_checkpoint_jh_count, 0,
  1618					  GFP_KERNEL);
  1619		if (err)
  1620			goto err_cleanup;
  1621	
  1622		journal->j_shrink_transaction = NULL;
  1623	
  1624		journal->j_shrinker = shrinker_alloc(0, "jbd2-journal:(%u:%u)",
  1625						     MAJOR(bdev->bd_dev),
  1626						     MINOR(bdev->bd_dev));
  1627		if (!journal->j_shrinker) {
  1628			err = -ENOMEM;
  1629			goto err_cleanup;
  1630		}
  1631	
  1632		journal->j_shrinker->scan_objects = jbd2_journal_shrink_scan;
  1633		journal->j_shrinker->count_objects = jbd2_journal_shrink_count;
  1634		journal->j_shrinker->private_data = journal;
  1635	
  1636		shrinker_register(journal->j_shrinker);
  1637	
  1638		return journal;
  1639	
  1640	err_cleanup:
  1641		percpu_counter_destroy(&journal->j_checkpoint_jh_count);
  1642		kfree(journal->j_wbuf);
  1643		jbd2_journal_destroy_revoke(journal);
  1644		journal_fail_superblock(journal);
  1645		kfree(journal);
  1646		return ERR_PTR(err);
  1647	}
  1648	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

