Return-Path: <linux-ext4+bounces-4948-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3825A9BBD51
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Nov 2024 19:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39F628265E
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Nov 2024 18:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0ABF1C07DA;
	Mon,  4 Nov 2024 18:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G6vN/V5R"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0161632F4
	for <linux-ext4@vger.kernel.org>; Mon,  4 Nov 2024 18:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730745274; cv=none; b=liLbVrn74I60kWYVHissZK4nAo9FPSYoNgi66f5+9LRCb7v0DRiZYU9BIq5MMwKVXUdA8nRguX4G9ShOLaPYPDRpRDO4Ovg2otcWB+fLWTmcGEGksrBjsUOjzOUO1IB7JYuIArdBaRYevn+GN+tdG5dOOVZtKkNL9zvhOCQXkV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730745274; c=relaxed/simple;
	bh=IXcS6vUByk+FSQKuoslvQU19p/ljasNZx9yQSSft1Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhQSn0BUgC7MKPsoMqNtZJioT1a0QzBDBS5UAsq70VvQzBBFY8+q+tLkeNPAuv2VlfiRG/tKABsFaXH5cTy/oB6lwuPF6R69SzUDQNhD9mr6zg7h+2b6v4EnAD8r6Id4G/BYVgzFZWiy80sVjzjRZHMizNMG9z2hCVrkzSAX9Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G6vN/V5R; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730745272; x=1762281272;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IXcS6vUByk+FSQKuoslvQU19p/ljasNZx9yQSSft1Vs=;
  b=G6vN/V5RHfiDc4rzcEHi21OQJxoKN9mRAqRzrqFlO+F59V0IO68Rlw59
   k7uAq9JRmBDa1kmOQy+5ZPaLaWM+2Wy4j8ZuI3XnFF4hZBIZ/dFUwLDgr
   VluyMWIZ79KdmRbqGYL/EiDIdhNCHv4r0zKi/6/xnWt9BcQ+KSX1xDbS5
   9YgAUCZ65j0GeCbKi3pdAVbWkRszZWa5Uq0NH8zTaVF1Qk99nbCP09fFG
   M+j80LqbA+6+Qxyi8QeE44HLJmX++z4uDy5W07QXpx3WLjui2OKHtnDRd
   NE639hBKeiQIwBEPsHG5b4uDPe5ej/ERUfTfen0LiHHnNYcGKxTJ5e8mn
   Q==;
X-CSE-ConnectionGUID: nXDHKcPvSa+i7fTWwstvew==
X-CSE-MsgGUID: w6dDZNApT5WPq3YwQJnQ6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30404314"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30404314"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 10:34:32 -0800
X-CSE-ConnectionGUID: b/I5X4a4R+uZv4B6FmchEg==
X-CSE-MsgGUID: x9zZWTtLTLme6Ql/wu3GtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="84174077"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 04 Nov 2024 10:34:31 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t81uF-000l81-2r;
	Mon, 04 Nov 2024 18:34:27 +0000
Date: Tue, 5 Nov 2024 02:33:54 +0800
From: kernel test robot <lkp@intel.com>
To: Li Dongyang <dongyangli@ddn.com>, linux-ext4@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Andreas Dilger <adilger@dilger.ca>,
	Alex Zhuravlev <bzzz@whamcloud.com>
Subject: Re: [PATCH] jbd2: use rhashtable for revoke records during replay
Message-ID: <202411050244.brqvdySO-lkp@intel.com>
References: <20241104090550.256635-1-dongyangli@ddn.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104090550.256635-1-dongyangli@ddn.com>

Hi Li,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on tytso-ext4/dev linus/master v6.12-rc6 next-20241104]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Dongyang/jbd2-use-rhashtable-for-revoke-records-during-replay/20241104-170737
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20241104090550.256635-1-dongyangli%40ddn.com
patch subject: [PATCH] jbd2: use rhashtable for revoke records during replay
config: arm-randconfig-002-20241104 (https://download.01.org/0day-ci/archive/20241105/202411050244.brqvdySO-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 639a7ac648f1e50ccd2556e17d401c04f9cce625)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241105/202411050244.brqvdySO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411050244.brqvdySO-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/ext4/fsync.c:29:
   In file included from include/linux/writeback.h:13:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/arm/include/asm/cacheflush.h:10:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from fs/ext4/fsync.c:33:
   In file included from fs/ext4/ext4.h:24:
>> include/linux/jbd2.h:1128:20: error: field has incomplete type 'struct rhashtable'
    1128 |         struct rhashtable       j_revoke_rhtable;
         |                                 ^
   include/linux/jbd2.h:1128:9: note: forward declaration of 'struct rhashtable'
    1128 |         struct rhashtable       j_revoke_rhtable;
         |                ^
   1 warning and 1 error generated.


vim +1128 include/linux/jbd2.h

   745	
   746	/**
   747	 * struct journal_s - The journal_s type is the concrete type associated with
   748	 *     journal_t.
   749	 */
   750	struct journal_s
   751	{
   752		/**
   753		 * @j_flags: General journaling state flags [j_state_lock,
   754		 * no lock for quick racy checks]
   755		 */
   756		unsigned long		j_flags;
   757	
   758		/**
   759		 * @j_errno:
   760		 *
   761		 * Is there an outstanding uncleared error on the journal (from a prior
   762		 * abort)? [j_state_lock]
   763		 */
   764		int			j_errno;
   765	
   766		/**
   767		 * @j_abort_mutex: Lock the whole aborting procedure.
   768		 */
   769		struct mutex		j_abort_mutex;
   770	
   771		/**
   772		 * @j_sb_buffer: The first part of the superblock buffer.
   773		 */
   774		struct buffer_head	*j_sb_buffer;
   775	
   776		/**
   777		 * @j_superblock: The second part of the superblock buffer.
   778		 */
   779		journal_superblock_t	*j_superblock;
   780	
   781		/**
   782		 * @j_state_lock: Protect the various scalars in the journal.
   783		 */
   784		rwlock_t		j_state_lock;
   785	
   786		/**
   787		 * @j_barrier_count:
   788		 *
   789		 * Number of processes waiting to create a barrier lock [j_state_lock,
   790		 * no lock for quick racy checks]
   791		 */
   792		int			j_barrier_count;
   793	
   794		/**
   795		 * @j_barrier: The barrier lock itself.
   796		 */
   797		struct mutex		j_barrier;
   798	
   799		/**
   800		 * @j_running_transaction:
   801		 *
   802		 * Transactions: The current running transaction...
   803		 * [j_state_lock, no lock for quick racy checks] [caller holding
   804		 * open handle]
   805		 */
   806		transaction_t		*j_running_transaction;
   807	
   808		/**
   809		 * @j_committing_transaction:
   810		 *
   811		 * the transaction we are pushing to disk
   812		 * [j_state_lock] [caller holding open handle]
   813		 */
   814		transaction_t		*j_committing_transaction;
   815	
   816		/**
   817		 * @j_checkpoint_transactions:
   818		 *
   819		 * ... and a linked circular list of all transactions waiting for
   820		 * checkpointing. [j_list_lock]
   821		 */
   822		transaction_t		*j_checkpoint_transactions;
   823	
   824		/**
   825		 * @j_wait_transaction_locked:
   826		 *
   827		 * Wait queue for waiting for a locked transaction to start committing,
   828		 * or for a barrier lock to be released.
   829		 */
   830		wait_queue_head_t	j_wait_transaction_locked;
   831	
   832		/**
   833		 * @j_wait_done_commit: Wait queue for waiting for commit to complete.
   834		 */
   835		wait_queue_head_t	j_wait_done_commit;
   836	
   837		/**
   838		 * @j_wait_commit: Wait queue to trigger commit.
   839		 */
   840		wait_queue_head_t	j_wait_commit;
   841	
   842		/**
   843		 * @j_wait_updates: Wait queue to wait for updates to complete.
   844		 */
   845		wait_queue_head_t	j_wait_updates;
   846	
   847		/**
   848		 * @j_wait_reserved:
   849		 *
   850		 * Wait queue to wait for reserved buffer credits to drop.
   851		 */
   852		wait_queue_head_t	j_wait_reserved;
   853	
   854		/**
   855		 * @j_fc_wait:
   856		 *
   857		 * Wait queue to wait for completion of async fast commits.
   858		 */
   859		wait_queue_head_t	j_fc_wait;
   860	
   861		/**
   862		 * @j_checkpoint_mutex:
   863		 *
   864		 * Semaphore for locking against concurrent checkpoints.
   865		 */
   866		struct mutex		j_checkpoint_mutex;
   867	
   868		/**
   869		 * @j_chkpt_bhs:
   870		 *
   871		 * List of buffer heads used by the checkpoint routine.  This
   872		 * was moved from jbd2_log_do_checkpoint() to reduce stack
   873		 * usage.  Access to this array is controlled by the
   874		 * @j_checkpoint_mutex.  [j_checkpoint_mutex]
   875		 */
   876		struct buffer_head	*j_chkpt_bhs[JBD2_NR_BATCH];
   877	
   878		/**
   879		 * @j_shrinker:
   880		 *
   881		 * Journal head shrinker, reclaim buffer's journal head which
   882		 * has been written back.
   883		 */
   884		struct shrinker		*j_shrinker;
   885	
   886		/**
   887		 * @j_checkpoint_jh_count:
   888		 *
   889		 * Number of journal buffers on the checkpoint list. [j_list_lock]
   890		 */
   891		struct percpu_counter	j_checkpoint_jh_count;
   892	
   893		/**
   894		 * @j_shrink_transaction:
   895		 *
   896		 * Record next transaction will shrink on the checkpoint list.
   897		 * [j_list_lock]
   898		 */
   899		transaction_t		*j_shrink_transaction;
   900	
   901		/**
   902		 * @j_head:
   903		 *
   904		 * Journal head: identifies the first unused block in the journal.
   905		 * [j_state_lock]
   906		 */
   907		unsigned long		j_head;
   908	
   909		/**
   910		 * @j_tail:
   911		 *
   912		 * Journal tail: identifies the oldest still-used block in the journal.
   913		 * [j_state_lock]
   914		 */
   915		unsigned long		j_tail;
   916	
   917		/**
   918		 * @j_free:
   919		 *
   920		 * Journal free: how many free blocks are there in the journal?
   921		 * [j_state_lock]
   922		 */
   923		unsigned long		j_free;
   924	
   925		/**
   926		 * @j_first:
   927		 *
   928		 * The block number of the first usable block in the journal
   929		 * [j_state_lock].
   930		 */
   931		unsigned long		j_first;
   932	
   933		/**
   934		 * @j_last:
   935		 *
   936		 * The block number one beyond the last usable block in the journal
   937		 * [j_state_lock].
   938		 */
   939		unsigned long		j_last;
   940	
   941		/**
   942		 * @j_fc_first:
   943		 *
   944		 * The block number of the first fast commit block in the journal
   945		 * [j_state_lock].
   946		 */
   947		unsigned long		j_fc_first;
   948	
   949		/**
   950		 * @j_fc_off:
   951		 *
   952		 * Number of fast commit blocks currently allocated. Accessed only
   953		 * during fast commit. Currently only process can do fast commit, so
   954		 * this field is not protected by any lock.
   955		 */
   956		unsigned long		j_fc_off;
   957	
   958		/**
   959		 * @j_fc_last:
   960		 *
   961		 * The block number one beyond the last fast commit block in the journal
   962		 * [j_state_lock].
   963		 */
   964		unsigned long		j_fc_last;
   965	
   966		/**
   967		 * @j_dev: Device where we store the journal.
   968		 */
   969		struct block_device	*j_dev;
   970	
   971		/**
   972		 * @j_blocksize: Block size for the location where we store the journal.
   973		 */
   974		int			j_blocksize;
   975	
   976		/**
   977		 * @j_blk_offset:
   978		 *
   979		 * Starting block offset into the device where we store the journal.
   980		 */
   981		unsigned long long	j_blk_offset;
   982	
   983		/**
   984		 * @j_devname: Journal device name.
   985		 */
   986		char			j_devname[BDEVNAME_SIZE+24];
   987	
   988		/**
   989		 * @j_fs_dev:
   990		 *
   991		 * Device which holds the client fs.  For internal journal this will be
   992		 * equal to j_dev.
   993		 */
   994		struct block_device	*j_fs_dev;
   995	
   996		/**
   997		 * @j_fs_dev_wb_err:
   998		 *
   999		 * Records the errseq of the client fs's backing block device.
  1000		 */
  1001		errseq_t		j_fs_dev_wb_err;
  1002	
  1003		/**
  1004		 * @j_total_len: Total maximum capacity of the journal region on disk.
  1005		 */
  1006		unsigned int		j_total_len;
  1007	
  1008		/**
  1009		 * @j_reserved_credits:
  1010		 *
  1011		 * Number of buffers reserved from the running transaction.
  1012		 */
  1013		atomic_t		j_reserved_credits;
  1014	
  1015		/**
  1016		 * @j_list_lock: Protects the buffer lists and internal buffer state.
  1017		 */
  1018		spinlock_t		j_list_lock;
  1019	
  1020		/**
  1021		 * @j_inode:
  1022		 *
  1023		 * Optional inode where we store the journal.  If present, all
  1024		 * journal block numbers are mapped into this inode via bmap().
  1025		 */
  1026		struct inode		*j_inode;
  1027	
  1028		/**
  1029		 * @j_tail_sequence:
  1030		 *
  1031		 * Sequence number of the oldest transaction in the log [j_state_lock]
  1032		 */
  1033		tid_t			j_tail_sequence;
  1034	
  1035		/**
  1036		 * @j_transaction_sequence:
  1037		 *
  1038		 * Sequence number of the next transaction to grant [j_state_lock]
  1039		 */
  1040		tid_t			j_transaction_sequence;
  1041	
  1042		/**
  1043		 * @j_commit_sequence:
  1044		 *
  1045		 * Sequence number of the most recently committed transaction
  1046		 * [j_state_lock, no lock for quick racy checks]
  1047		 */
  1048		tid_t			j_commit_sequence;
  1049	
  1050		/**
  1051		 * @j_commit_request:
  1052		 *
  1053		 * Sequence number of the most recent transaction wanting commit
  1054		 * [j_state_lock, no lock for quick racy checks]
  1055		 */
  1056		tid_t			j_commit_request;
  1057	
  1058		/**
  1059		 * @j_uuid:
  1060		 *
  1061		 * Journal uuid: identifies the object (filesystem, LVM volume etc)
  1062		 * backed by this journal.  This will eventually be replaced by an array
  1063		 * of uuids, allowing us to index multiple devices within a single
  1064		 * journal and to perform atomic updates across them.
  1065		 */
  1066		__u8			j_uuid[16];
  1067	
  1068		/**
  1069		 * @j_task: Pointer to the current commit thread for this journal.
  1070		 */
  1071		struct task_struct	*j_task;
  1072	
  1073		/**
  1074		 * @j_max_transaction_buffers:
  1075		 *
  1076		 * Maximum number of metadata buffers to allow in a single compound
  1077		 * commit transaction.
  1078		 */
  1079		int			j_max_transaction_buffers;
  1080	
  1081		/**
  1082		 * @j_revoke_records_per_block:
  1083		 *
  1084		 * Number of revoke records that fit in one descriptor block.
  1085		 */
  1086		int			j_revoke_records_per_block;
  1087	
  1088		/**
  1089		 * @j_transaction_overhead_buffers:
  1090		 *
  1091		 * Number of blocks each transaction needs for its own bookkeeping
  1092		 */
  1093		int			j_transaction_overhead_buffers;
  1094	
  1095		/**
  1096		 * @j_commit_interval:
  1097		 *
  1098		 * What is the maximum transaction lifetime before we begin a commit?
  1099		 */
  1100		unsigned long		j_commit_interval;
  1101	
  1102		/**
  1103		 * @j_commit_timer: The timer used to wakeup the commit thread.
  1104		 */
  1105		struct timer_list	j_commit_timer;
  1106	
  1107		/**
  1108		 * @j_revoke_lock: Protect the revoke table.
  1109		 */
  1110		spinlock_t		j_revoke_lock;
  1111	
  1112		/**
  1113		 * @j_revoke:
  1114		 *
  1115		 * The revoke table - maintains the list of revoked blocks in the
  1116		 * current transaction.
  1117		 */
  1118		struct jbd2_revoke_table_s *j_revoke;
  1119	
  1120		/**
  1121		 * @j_revoke_table: Alternate revoke tables for j_revoke.
  1122		 */
  1123		struct jbd2_revoke_table_s *j_revoke_table[2];
  1124	
  1125		/**
  1126		 * @j_revoke_rhtable:	rhashtable for revoke records during recovery
  1127		 */
> 1128		struct rhashtable	j_revoke_rhtable;
  1129	
  1130		/**
  1131		 * @j_wbuf: Array of bhs for jbd2_journal_commit_transaction.
  1132		 */
  1133		struct buffer_head	**j_wbuf;
  1134	
  1135		/**
  1136		 * @j_fc_wbuf: Array of fast commit bhs for fast commit. Accessed only
  1137		 * during a fast commit. Currently only process can do fast commit, so
  1138		 * this field is not protected by any lock.
  1139		 */
  1140		struct buffer_head	**j_fc_wbuf;
  1141	
  1142		/**
  1143		 * @j_wbufsize:
  1144		 *
  1145		 * Size of @j_wbuf array.
  1146		 */
  1147		int			j_wbufsize;
  1148	
  1149		/**
  1150		 * @j_fc_wbufsize:
  1151		 *
  1152		 * Size of @j_fc_wbuf array.
  1153		 */
  1154		int			j_fc_wbufsize;
  1155	
  1156		/**
  1157		 * @j_last_sync_writer:
  1158		 *
  1159		 * The pid of the last person to run a synchronous operation
  1160		 * through the journal.
  1161		 */
  1162		pid_t			j_last_sync_writer;
  1163	
  1164		/**
  1165		 * @j_average_commit_time:
  1166		 *
  1167		 * The average amount of time in nanoseconds it takes to commit a
  1168		 * transaction to disk. [j_state_lock]
  1169		 */
  1170		u64			j_average_commit_time;
  1171	
  1172		/**
  1173		 * @j_min_batch_time:
  1174		 *
  1175		 * Minimum time that we should wait for additional filesystem operations
  1176		 * to get batched into a synchronous handle in microseconds.
  1177		 */
  1178		u32			j_min_batch_time;
  1179	
  1180		/**
  1181		 * @j_max_batch_time:
  1182		 *
  1183		 * Maximum time that we should wait for additional filesystem operations
  1184		 * to get batched into a synchronous handle in microseconds.
  1185		 */
  1186		u32			j_max_batch_time;
  1187	
  1188		/**
  1189		 * @j_commit_callback:
  1190		 *
  1191		 * This function is called when a transaction is closed.
  1192		 */
  1193		void			(*j_commit_callback)(journal_t *,
  1194							     transaction_t *);
  1195	
  1196		/**
  1197		 * @j_submit_inode_data_buffers:
  1198		 *
  1199		 * This function is called for all inodes associated with the
  1200		 * committing transaction marked with JI_WRITE_DATA flag
  1201		 * before we start to write out the transaction to the journal.
  1202		 */
  1203		int			(*j_submit_inode_data_buffers)
  1204						(struct jbd2_inode *);
  1205	
  1206		/**
  1207		 * @j_finish_inode_data_buffers:
  1208		 *
  1209		 * This function is called for all inodes associated with the
  1210		 * committing transaction marked with JI_WAIT_DATA flag
  1211		 * after we have written the transaction to the journal
  1212		 * but before we write out the commit block.
  1213		 */
  1214		int			(*j_finish_inode_data_buffers)
  1215						(struct jbd2_inode *);
  1216	
  1217		/*
  1218		 * Journal statistics
  1219		 */
  1220	
  1221		/**
  1222		 * @j_history_lock: Protect the transactions statistics history.
  1223		 */
  1224		spinlock_t		j_history_lock;
  1225	
  1226		/**
  1227		 * @j_proc_entry: procfs entry for the jbd statistics directory.
  1228		 */
  1229		struct proc_dir_entry	*j_proc_entry;
  1230	
  1231		/**
  1232		 * @j_stats: Overall statistics.
  1233		 */
  1234		struct transaction_stats_s j_stats;
  1235	
  1236		/**
  1237		 * @j_failed_commit: Failed journal commit ID.
  1238		 */
  1239		unsigned int		j_failed_commit;
  1240	
  1241		/**
  1242		 * @j_private:
  1243		 *
  1244		 * An opaque pointer to fs-private information.  ext3 puts its
  1245		 * superblock pointer here.
  1246		 */
  1247		void *j_private;
  1248	
  1249		/**
  1250		 * @j_chksum_driver:
  1251		 *
  1252		 * Reference to checksum algorithm driver via cryptoapi.
  1253		 */
  1254		struct crypto_shash *j_chksum_driver;
  1255	
  1256		/**
  1257		 * @j_csum_seed:
  1258		 *
  1259		 * Precomputed journal UUID checksum for seeding other checksums.
  1260		 */
  1261		__u32 j_csum_seed;
  1262	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

