Return-Path: <linux-ext4+bounces-10974-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A39AFBEE5F9
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Oct 2025 15:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58CF93A935C
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Oct 2025 13:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC99B2857CF;
	Sun, 19 Oct 2025 13:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j7T5K1FU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C511A9F9F;
	Sun, 19 Oct 2025 13:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760879266; cv=none; b=fMsW8hJxu7mB82u/DsSwFPK2iIbb7DjH1oBzn+M5rP2xnSPEiVQQs8w9GH4YZaHy7n2HNxIqLP+yOeGBX68fj+un2TdUFwrZpXzKH1Plar/JYrtLYBO1uWf3e1NrlTuCkt49exy2XeCfZrZfmwye4prXut+363pTlsdTScly7qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760879266; c=relaxed/simple;
	bh=M3CZu+UDGw/6042g6ntd18gqj6X8PPWKg2ZypUsADho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnBLh2kmGKjhBKgIskWJ/0jMM3p9y52UXRwLvw6PHDKnlKIce+YL0jiDV7z4dGjLBLt/JeIAtNvcAhrBpDmAfftEeCQ961R6ezU4BHO2GsdjUbSctmouvapcWu5hRo5vA9Lv4SQKde/o8+eHag9qT8gf7LP0TRPP/q4BD9ISvjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j7T5K1FU; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760879264; x=1792415264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M3CZu+UDGw/6042g6ntd18gqj6X8PPWKg2ZypUsADho=;
  b=j7T5K1FUo5HWpQHfacBi4vaeRxjKhrlwshc2FMcw257seDyuN5GVSkN1
   RVk1LnOVxVAaeEV1hIB+mj1DtlrzxriKSQcDtPcZ9rNp0My7kMwhbWIOZ
   BjWW8UfU9LCUWQc1mFLiZvfhzoS6BsMShr/q31bVyF3irDVy8dPpUQ5sz
   +BdBBjnR8TD9INaHKDkWauhjL2P87VdagAf4Xf5BBHDBTvjHbCB4IYhf+
   WTbKjlIY3U5V2IlCsN5ZEEnqpxWT1cnbCrtYhNbQQSuophGU4VOheAgYi
   +uKrdJC3eQv8Nu88v74RbK06XvvSTg9tt4PAfklHL7DnARr1Oq8E3CJYH
   Q==;
X-CSE-ConnectionGUID: 4DdtvAyxSAmj9FPeSlqIVw==
X-CSE-MsgGUID: 0e4KLGiBTdGlfpk5CuQIIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="73315973"
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="73315973"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 06:07:44 -0700
X-CSE-ConnectionGUID: INFiyw/0TluIKLqZK5qc1g==
X-CSE-MsgGUID: EK1hSitOSkKfpoDsQzU25g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="183142744"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 19 Oct 2025 06:07:42 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vAT8N-00095R-2F;
	Sun, 19 Oct 2025 13:07:39 +0000
Date: Sun, 19 Oct 2025 21:06:59 +0800
From: kernel test robot <lkp@intel.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] jbd2: assign different lock_class_key for different
 filesystem
Message-ID: <202510192155.eZoaLgzE-lkp@intel.com>
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
config: arm-randconfig-002-20251019 (https://download.01.org/0day-ci/archive/20251019/202510192155.eZoaLgzE-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251019/202510192155.eZoaLgzE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510192155.eZoaLgzE-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/jbd2/journal.c: In function 'journal_init_common':
>> fs/jbd2/journal.c:1553:24: error: 'EXT4_SUPER_MAGIC' undeclared (first use in this function)
    1553 |             fsmagic == EXT4_SUPER_MAGIC) {
         |                        ^~~~~~~~~~~~~~~~
   fs/jbd2/journal.c:1553:24: note: each undeclared identifier is reported only once for each function it appears in
>> fs/jbd2/journal.c:1562:31: error: 'OCFS2_SUPER_MAGIC' undeclared (first use in this function)
    1562 |                    fsmagic == OCFS2_SUPER_MAGIC) {
         |                               ^~~~~~~~~~~~~~~~~


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

