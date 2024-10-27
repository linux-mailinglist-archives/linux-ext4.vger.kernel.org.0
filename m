Return-Path: <linux-ext4+bounces-4820-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEECA9B1F2A
	for <lists+linux-ext4@lfdr.de>; Sun, 27 Oct 2024 17:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5F28B20F33
	for <lists+linux-ext4@lfdr.de>; Sun, 27 Oct 2024 16:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E761714A0;
	Sun, 27 Oct 2024 16:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KBq3PcTM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089273F9D2;
	Sun, 27 Oct 2024 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730045237; cv=none; b=vEjenWQXF+9gA2Tzhb6/AF/UY68Yfp+NcX3bKu6QuJtL9NOOzc97/VufbkgIE/IDEG6elwX9WxPT1WrakbI1SczUAl7EyMP0TUkR4f36ya8LpxRMo1UCN/oEOMcJlIxo5iyHB4l6p0wakM+5k9j65zB5wCXTxcnpRZwC+o36fgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730045237; c=relaxed/simple;
	bh=CYHkZfm8iwSSvr9V7w1CeY7lV93DYunt3X+q0M2jOc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5pYFXVG+JCnWKY24qIKfs1ctQsPT1wlCv3QmxEEqy8CRVx/zSKYkt1Fk+e86Qbj4IoqQFHNbxaI88BIeOS7iVhvfS8q9fgPjW4FOcZ3XeZ3CKSptclEneWJG7ZwqKs7tdX1rIGchB2ZFEpiTvQSlRNxGIcYybuRJOIQerWyi+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KBq3PcTM; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730045234; x=1761581234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CYHkZfm8iwSSvr9V7w1CeY7lV93DYunt3X+q0M2jOc8=;
  b=KBq3PcTMdQPzuRspE6E0tcsq5mATUdiKEBryfNMOE/Fp0RDlcQnMEcVO
   NjUwNnv9tVt1EvA9kAtRijB5dtCLuBb7tWAnaJVqYwBuDmRZaqw7vboEo
   o6VNRoOohCBzMTIjszu0dY+lkj8L9kJE87jh/CQVERFoLEj0Ga30j+9Wv
   pdkS4QmzyzRzH4aqxk3KYFT+JwxPCvmDdvFsLfKbrsKgvnqppn+3IHzNh
   wm1sRUE3IswB2qg6hNKn1ZRNIlbNOTsqogmCE+CR3GiH9FkXrHZh3eUZ7
   UAxh5PXQ43yOE+VxJv2Ij2UMstzaZDcAAu4bMrDpf3Cm0XiVg6klbnEfQ
   w==;
X-CSE-ConnectionGUID: GY3JQ9BiTxW8Bkwp+Lwc7A==
X-CSE-MsgGUID: rpviwcgmToigLCyZCocjKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="40230031"
X-IronPort-AV: E=Sophos;i="6.11,237,1725346800"; 
   d="scan'208";a="40230031"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 09:07:13 -0700
X-CSE-ConnectionGUID: dSVHPvDxTOquftTvy3tDpQ==
X-CSE-MsgGUID: dmz4llJaRUCmfuS6sx5+vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="86140462"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 27 Oct 2024 09:07:11 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t55nI-000ao4-2F;
	Sun, 27 Oct 2024 16:07:08 +0000
Date: Mon, 28 Oct 2024 00:06:55 +0800
From: kernel test robot <lkp@intel.com>
To: Edward Adam Davis <eadavis@qq.com>,
	syzbot+0c99c3f90699936c1e77@syzkaller.appspotmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	tytso@mit.edu
Subject: Re: [PATCH] ext4: Add a sanity check for next dentry when insert
Message-ID: <202410272335.nwupXeQD-lkp@intel.com>
References: <tencent_E4CFC65D09852ECE2EF28C83A7C3C6E41206@qq.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_E4CFC65D09852ECE2EF28C83A7C3C6E41206@qq.com>

Hi Edward,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tytso-ext4/dev]
[also build test WARNING on linus/master v6.12-rc4 next-20241025]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Edward-Adam-Davis/ext4-Add-a-sanity-check-for-next-dentry-when-insert/20241027-191200
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/tencent_E4CFC65D09852ECE2EF28C83A7C3C6E41206%40qq.com
patch subject: [PATCH] ext4: Add a sanity check for next dentry when insert
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241027/202410272335.nwupXeQD-lkp@intel.com/config)
compiler: clang version 19.1.2 (https://github.com/llvm/llvm-project 7ba7d8e2f7b6445b60679da826210cdde29eaf8b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241027/202410272335.nwupXeQD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410272335.nwupXeQD-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/ext4/namei.c:29:
   In file included from include/linux/pagemap.h:8:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> fs/ext4/namei.c:2087:5: warning: no previous prototype for function 'ext4_check_next_dentry' [-Wmissing-prototypes]
    2087 | int ext4_check_next_dentry(struct inode *dir,
         |     ^
   fs/ext4/namei.c:2087:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    2087 | int ext4_check_next_dentry(struct inode *dir,
         | ^
         | static 
   5 warnings generated.


vim +/ext4_check_next_dentry +2087 fs/ext4/namei.c

  2086	
> 2087	int ext4_check_next_dentry(struct inode *dir,
  2088				struct inode *inode,
  2089				struct ext4_dir_entry_2 *de,
  2090				int buf_size,
  2091				struct ext4_filename *fname)
  2092	{
  2093		int nlen, rlen;
  2094	
  2095		nlen = ext4_dir_rec_len(de->name_len, dir);
  2096		rlen = ext4_rec_len_from_disk(de->rec_len, buf_size);
  2097		if (de->inode) {
  2098			struct ext4_dir_entry_2 *nde =
  2099				(struct ext4_dir_entry_2 *)((char *)de + nlen);
  2100			nde->rec_len = ext4_rec_len_to_disk(rlen - nlen, buf_size);
  2101			de->rec_len = ext4_rec_len_to_disk(nlen, buf_size);
  2102			de = nde;
  2103			rlen = ext4_rec_len_from_disk(de->rec_len, buf_size);
  2104			return fname_len(fname) > rlen - EXT4_BASE_DIR_LEN;
  2105		}
  2106	
  2107		return 0;
  2108	}
  2109	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

