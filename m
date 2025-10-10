Return-Path: <linux-ext4+bounces-10753-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 025BCBCCC7F
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Oct 2025 13:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F15A519E1B11
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Oct 2025 11:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00B1283CB8;
	Fri, 10 Oct 2025 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VSq3om9A"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBD34414;
	Fri, 10 Oct 2025 11:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760095892; cv=none; b=jSBnEG8N18FNZXH0+yQpG3XclmNbLgYmb72/fZj+AuhRURxt3CLmY6T+TvGeOoq7nU2uQoafcuott0HFFSGaWjdbimb4Vkq+YwxmF+cTtLcDUGoIo6Mj3o45kaZfBdiVPEoFJ7Ti/CMmCe5w3bAeMbysH/rZKqNo8OLskXv61eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760095892; c=relaxed/simple;
	bh=cJo0B2S+cA8lzwnu2M2IUcY4hw9CqzMyqc2bKFP90jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDjvohx+wc1ntBO1r0F/vIv37fV+Wugg6JW/l0FpdWwL4zmL8gWl/9RLbokO0NPt7iB3rpG66pbBjoALJVvUqjlEqO/LJYO1Bex8WgIG9bu8WV+LS6m9vAiNOUw4NgE6ve3lUkKymPjy59WlGFwCQmZpXzQ8nhLkS5crU3dB5tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VSq3om9A; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760095891; x=1791631891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cJo0B2S+cA8lzwnu2M2IUcY4hw9CqzMyqc2bKFP90jA=;
  b=VSq3om9AEjZKikTXK6CDbaWTdPhMmLVkEPXKYyYdRKUAQdpMq5DFhvb3
   lsD0SInHvFMf6Z6QymH3K9KW3cIMDidx1Q2rQv+QnxmOpFhT+XrUL8RVw
   j8IyZPr2A9OaGUDMtv9+d0zkfXTHDQsCHZTcmrSbrByymwSEug46AJ7zt
   KhTneYw6zfAcfJ9hSxPCuHIB+NsgVApVfBla2F01sLGApKnQrAuGpodP3
   nTL34bASm6FKkeSVNYCCOiKCs+REaHoEHWMqXuVdKl2YWTTSRgVKEm8+c
   xYmUExkvoBN6kAM4EqgvJnVLjtPoC+CDuohx/rpWa6mNP52E3qaW0g7Fb
   Q==;
X-CSE-ConnectionGUID: qPTX7foORha98mXAicpw3g==
X-CSE-MsgGUID: iPAK4Ar4RbCV4GuL6msAOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="49875867"
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; 
   d="scan'208";a="49875867"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 04:31:30 -0700
X-CSE-ConnectionGUID: bE1E7ZDISlehYaCKgbxf1A==
X-CSE-MsgGUID: /aU+BrapQBiGTeh1j+wz9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; 
   d="scan'208";a="180644249"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 10 Oct 2025 04:31:27 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7BLJ-0002b1-1D;
	Fri, 10 Oct 2025 11:31:25 +0000
Date: Fri, 10 Oct 2025 19:31:00 +0800
From: kernel test robot <lkp@intel.com>
To: Ahmet Eray Karadag <eraykrdg1@gmail.com>, tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: oe-kbuild-all@lists.linux.dev, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org, Ahmet Eray Karadag <eraykrdg1@gmail.com>,
	syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com,
	Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Subject: Re: [PATCH] Fix: ext4: add sanity check for inode inline write range
Message-ID: <202510101841.kobch6UW-lkp@intel.com>
References: <20251007234221.28643-2-eraykrdg1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007234221.28643-2-eraykrdg1@gmail.com>

Hi Ahmet,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tytso-ext4/dev]
[also build test WARNING on linus/master v6.17 next-20251009]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ahmet-Eray-Karadag/Fix-ext4-add-sanity-check-for-inode-inline-write-range/20251010-013008
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20251007234221.28643-2-eraykrdg1%40gmail.com
patch subject: [PATCH] Fix: ext4: add sanity check for inode inline write range
config: powerpc-randconfig-r073-20251010 (https://download.01.org/0day-ci/archive/20251010/202510101841.kobch6UW-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.3.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510101841.kobch6UW-lkp@intel.com/

smatch warnings:
fs/ext4/inline.c:789 ext4_write_inline_data_end() warn: inconsistent indenting
fs/ext4/inline.c:854 ext4_write_inline_data_end() error: uninitialized symbol 'ret2'.

vim +789 fs/ext4/inline.c

   775	
   776	int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
   777				       unsigned copied, struct folio *folio)
   778	{
   779		handle_t *handle = ext4_journal_current_handle();
   780		int no_expand;
   781		void *kaddr;
   782		struct ext4_iloc iloc;
   783		int ret = 0, ret2;
   784	
   785		if ((pos + len) > EXT4_I(inode)->i_inline_size) {
   786				ext4_warning_inode(inode,
   787					"inline write beyond capacity (pos=%lld, len=%u, inline_size=%d)",
   788					pos, len, EXT4_I(inode)->i_inline_size);
 > 789			folio_unlock(folio);
   790			folio_put(folio);
   791			ret = -EINVAL;
   792			goto out;
   793		}
   794	
   795		if (unlikely(copied < len) && !folio_test_uptodate(folio))
   796			copied = 0;
   797	
   798		if (likely(copied)) {
   799			ret = ext4_get_inode_loc(inode, &iloc);
   800			if (ret) {
   801				folio_unlock(folio);
   802				folio_put(folio);
   803				ext4_std_error(inode->i_sb, ret);
   804				goto out;
   805			}
   806			ext4_write_lock_xattr(inode, &no_expand);
   807			BUG_ON(!ext4_has_inline_data(inode));
   808	
   809			/*
   810			 * ei->i_inline_off may have changed since
   811			 * ext4_write_begin() called
   812			 * ext4_try_to_write_inline_data()
   813			 */
   814			(void) ext4_find_inline_data_nolock(inode);
   815	
   816			kaddr = kmap_local_folio(folio, 0);
   817			ext4_write_inline_data(inode, &iloc, kaddr, pos, copied);
   818			kunmap_local(kaddr);
   819			folio_mark_uptodate(folio);
   820			/* clear dirty flag so that writepages wouldn't work for us. */
   821			folio_clear_dirty(folio);
   822	
   823			ext4_write_unlock_xattr(inode, &no_expand);
   824			brelse(iloc.bh);
   825	
   826			/*
   827			 * It's important to update i_size while still holding folio
   828			 * lock: page writeout could otherwise come in and zero
   829			 * beyond i_size.
   830			 */
   831			ext4_update_inode_size(inode, pos + copied);
   832		}
   833		folio_unlock(folio);
   834		folio_put(folio);
   835	
   836		/*
   837		 * Don't mark the inode dirty under folio lock. First, it unnecessarily
   838		 * makes the holding time of folio lock longer. Second, it forces lock
   839		 * ordering of folio lock and transaction start for journaling
   840		 * filesystems.
   841		 */
   842		if (likely(copied))
   843			mark_inode_dirty(inode);
   844	out:
   845		/*
   846		 * If we didn't copy as much data as expected, we need to trim back
   847		 * size of xattr containing inline data.
   848		 */
   849		if (pos + len > inode->i_size && ext4_can_truncate(inode))
   850			ext4_orphan_add(handle, inode);
   851		if (handle)
   852			ret2 = ext4_journal_stop(handle);
   853		if (!ret)
 > 854			ret = ret2;
   855		if (pos + len > inode->i_size) {
   856			ext4_truncate_failed_write(inode);
   857			/*
   858			 * If truncate failed early the inode might still be
   859			 * on the orphan list; we need to make sure the inode
   860			 * is removed from the orphan list in that case.
   861			 */
   862			if (inode->i_nlink)
   863				ext4_orphan_del(NULL, inode);
   864		}
   865		return ret ? ret : copied;
   866	}
   867	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

