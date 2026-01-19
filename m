Return-Path: <linux-ext4+bounces-12966-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDC0D39C6E
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 03:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2285B3007267
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 02:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322E320C461;
	Mon, 19 Jan 2026 02:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gA/ULDw4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6100D1F91D6
	for <linux-ext4@vger.kernel.org>; Mon, 19 Jan 2026 02:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768790345; cv=none; b=PrvetNHev4q09sgY2qsPshgvUQxjjhG2vS7jSjKNSkSHY3+5jFfNkV0G61jpH6+uls/Z967m9UKLscUs4LnMjzDqZMOPbRCvhuLNyfg33JNKBq4SS5NQalqvViANHktqChOAiPJtnUszJMYs6zi54vxZaiYAjaW2KhGd5laOdJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768790345; c=relaxed/simple;
	bh=LQAyrtBFj7dnCG2N7cHEPx9+z8P++IpnVjHzhKeXFJI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AXAoD30qDggP3rE6HvytwgYJpa7Wm2RMmESLNVBGiIJ660qSFXW+RxL7oS8pKlNmXp/nJkE70f3yulWpdxiH45KhIVIcYluY3W5fxSxZ7DfXVtvOayvt9VPLcZJKGp0AFCkANiG0SJRHHgwG1T12cVuyy+EJT8h/kQiLaWMSWNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gA/ULDw4; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768790345; x=1800326345;
  h=date:from:to:cc:subject:message-id;
  bh=LQAyrtBFj7dnCG2N7cHEPx9+z8P++IpnVjHzhKeXFJI=;
  b=gA/ULDw4inQT1c1C4PROZuMvFudPgPpiegJstOPW/wbpeDOwLTkljGhF
   gCuIzu2i7eVzUol5XnC+Fsz8pUMiRbLJQxI4M4eKgo6TKrcYXjLHZ7iet
   Fzt9SOZCtxxzPbCdXFHEIlgZWceFHnxMULZSbvMN0lF/DT566YWLkiFkP
   pjfFHrgR9tdVWFdpli2AG4DOl2nzZEOKl4BFqeEyFJEgmkPgcUn4zSPFA
   y7X0Yx5tCy+0FvK7bEcV9BTpqMO5+YvNpr/t9XDLOJonM80174llGG1eA
   uRGPMGe3JyOuXrNo05dNG+b3ZvJo1V+/JIPN8FkmBX0s0FysVxVoZmBeV
   w==;
X-CSE-ConnectionGUID: cOEoHIDdS7+Mk7h+pB++ng==
X-CSE-MsgGUID: B7WynEuhTq6h+ZNgSaECCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="81113484"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="81113484"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 18:39:04 -0800
X-CSE-ConnectionGUID: 2Rhw8yn5SduUqjCbaiPNPQ==
X-CSE-MsgGUID: LYb3F0cSQpCUS7vW0q5cqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="236437864"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 18 Jan 2026 18:39:01 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vhfAR-00000000NMq-1R4k;
	Mon, 19 Jan 2026 02:38:59 +0000
Date: Mon, 19 Jan 2026 10:38:34 +0800
From: kernel test robot <lkp@intel.com>
To: Li Chen <me@linux.beauty>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Subject: [tytso-ext4:dev 35/37] fs/ext4/move_extent.c:324:26: error:
 use of undeclared identifier 'sb'
Message-ID: <202601191038.JQbdLRwC-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
head:   11f1ff3cc21a8e9ca9f509a664de5975469ec561
commit: ac9dc29e548da2c5895cfc28ac8e5b220ff45f63 [35/37] ext4: mark move extents fast-commit ineligible
config: s390-randconfig-002-20260119 (https://download.01.org/0day-ci/archive/20260119/202601191038.JQbdLRwC-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260119/202601191038.JQbdLRwC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601191038.JQbdLRwC-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/ext4/move_extent.c:324:26: error: use of undeclared identifier 'sb'
     324 |         ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_MOVE_EXT, handle);
         |                                 ^~
   1 error generated.


vim +/sb +324 fs/ext4/move_extent.c

   293	
   294	/*
   295	 * Save the data in original inode extent blocks and replace one folio size
   296	 * aligned original inode extent with one or one partial donor inode extent,
   297	 * and then write out the saved data in new original inode blocks. Pass out
   298	 * the replaced block count through m_len. Return 0 on success, and an error
   299	 * code otherwise.
   300	 */
   301	static int mext_move_extent(struct mext_data *mext, u64 *m_len)
   302	{
   303		struct inode *orig_inode = mext->orig_inode;
   304		struct inode *donor_inode = mext->donor_inode;
   305		struct ext4_map_blocks *orig_map = &mext->orig_map;
   306		unsigned int blkbits = orig_inode->i_blkbits;
   307		struct folio *folio[2] = {NULL, NULL};
   308		loff_t from, length;
   309		enum mext_move_type move_type = 0;
   310		handle_t *handle;
   311		u64 r_len = 0;
   312		unsigned int credits;
   313		int ret, ret2;
   314	
   315		*m_len = 0;
   316		trace_ext4_move_extent_enter(orig_inode, orig_map, donor_inode,
   317					     mext->donor_lblk);
   318		credits = ext4_chunk_trans_extent(orig_inode, 0) * 2;
   319		handle = ext4_journal_start(orig_inode, EXT4_HT_MOVE_EXTENTS, credits);
   320		if (IS_ERR(handle)) {
   321			ret = PTR_ERR(handle);
   322			goto out;
   323		}
 > 324		ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_MOVE_EXT, handle);
   325	
   326		ret = mext_move_begin(mext, folio, &move_type);
   327		if (ret)
   328			goto stop_handle;
   329	
   330		if (move_type == MEXT_SKIP_EXTENT)
   331			goto unlock;
   332	
   333		/*
   334		 * Copy the data. First, read the original inode data into the page
   335		 * cache. Then, release the existing mapping relationships and swap
   336		 * the extent. Finally, re-establish the new mapping relationships
   337		 * and dirty the page cache.
   338		 */
   339		if (move_type == MEXT_COPY_DATA) {
   340			from = offset_in_folio(folio[0],
   341					((loff_t)orig_map->m_lblk) << blkbits);
   342			length = ((loff_t)orig_map->m_len) << blkbits;
   343	
   344			ret = mext_folio_mkuptodate(folio[0], from, from + length);
   345			if (ret)
   346				goto unlock;
   347		}
   348	
   349		if (!filemap_release_folio(folio[0], 0) ||
   350		    !filemap_release_folio(folio[1], 0)) {
   351			ret = -EBUSY;
   352			goto unlock;
   353		}
   354	
   355		/* Move extent */
   356		ext4_double_down_write_data_sem(orig_inode, donor_inode);
   357		*m_len = ext4_swap_extents(handle, orig_inode, donor_inode,
   358					   orig_map->m_lblk, mext->donor_lblk,
   359					   orig_map->m_len, 1, &ret);
   360		ext4_double_up_write_data_sem(orig_inode, donor_inode);
   361	
   362		/* A short-length swap cannot occur after a successful swap extent. */
   363		if (WARN_ON_ONCE(!ret && (*m_len != orig_map->m_len)))
   364			ret = -EIO;
   365	
   366		if (!(*m_len) || (move_type == MEXT_MOVE_EXTENT))
   367			goto unlock;
   368	
   369		/* Copy data */
   370		length = (*m_len) << blkbits;
   371		ret2 = mext_folio_mkwrite(orig_inode, folio[0], from, from + length);
   372		if (ret2) {
   373			if (!ret)
   374				ret = ret2;
   375			goto repair_branches;
   376		}
   377		/*
   378		 * Even in case of data=writeback it is reasonable to pin
   379		 * inode to transaction, to prevent unexpected data loss.
   380		 */
   381		ret2 = ext4_jbd2_inode_add_write(handle, orig_inode,
   382				((loff_t)orig_map->m_lblk) << blkbits, length);
   383		if (!ret)
   384			ret = ret2;
   385	unlock:
   386		mext_folio_double_unlock(folio);
   387	stop_handle:
   388		ext4_journal_stop(handle);
   389	out:
   390		trace_ext4_move_extent_exit(orig_inode, orig_map->m_lblk, donor_inode,
   391					    mext->donor_lblk, orig_map->m_len, *m_len,
   392					    move_type, ret);
   393		return ret;
   394	
   395	repair_branches:
   396		ret2 = 0;
   397		ext4_double_down_write_data_sem(orig_inode, donor_inode);
   398		r_len = ext4_swap_extents(handle, donor_inode, orig_inode,
   399					  mext->donor_lblk, orig_map->m_lblk,
   400					  *m_len, 0, &ret2);
   401		ext4_double_up_write_data_sem(orig_inode, donor_inode);
   402		if (ret2 || r_len != *m_len) {
   403			ext4_error_inode_block(orig_inode, (sector_t)(orig_map->m_lblk),
   404					       EIO, "Unable to copy data block, data will be lost!");
   405			ret = -EIO;
   406		}
   407		*m_len = 0;
   408		goto unlock;
   409	}
   410	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

