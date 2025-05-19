Return-Path: <linux-ext4+bounces-7966-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D49ABB673
	for <lists+linux-ext4@lfdr.de>; Mon, 19 May 2025 09:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4126D188C542
	for <lists+linux-ext4@lfdr.de>; Mon, 19 May 2025 07:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16F0268FFF;
	Mon, 19 May 2025 07:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lxT0k/dR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE162690FA
	for <linux-ext4@vger.kernel.org>; Mon, 19 May 2025 07:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747641305; cv=none; b=lZuBDJI+Qs2mPwYzjvKBHfti7affmqoCU01XYOOQd1EGV0ULqsgNYeZUo1oqTrXGFSSeCgH2fKLq/s4coVVnQ6320u5l3J4VIrk71DuNwUh9VetPmx7AIDn9wElg4CPkUAbxifOhjoq02bGzFY5F/xaIJGj983cyYWd2OnLhMIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747641305; c=relaxed/simple;
	bh=bAeiXyQ4xmGax9eWamxTcSKHYyxrTUjgOR14Hk+vcFs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fSkhtqpkcUC+RLn+Rx7GFvb4YrZ38F8+wuJoiZHArvNVSpjxt0++k9iJDdlMjJVSnXL5cJOhACZRcBypj/gfHoX3wkPfllQIladKP22T7fdDJRoWVqkQrvDBzArnL43AXTdFPwavBRJw1C4wPR6B4NwLrYZJwAXzn66jlo4jUB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lxT0k/dR; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747641303; x=1779177303;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bAeiXyQ4xmGax9eWamxTcSKHYyxrTUjgOR14Hk+vcFs=;
  b=lxT0k/dRA8V0JSEOJggLMu11kofFBtQpMQandP7/JcMCAcdrPrtTqX/s
   apK+qPk8LkTKUgZYsUe5+n0mdO0qWUhpZ1HvuFB2YHbTnR8oIZlMviIbI
   2XAn+HFSRgLFyiXuV6O7ddXTAv3s+qn3fydAbEeO0L86ENZ+7ZU+4oe7U
   HDBD2b23qW+4DvKQLqABsYmZajSUsWbskSu9ag5a34USzopnOasRll35h
   hK4DFOmhf3wfpM3PK1bBG3pyuVaChp0JWwwZlU9wtAN2meqjMZHmk41RQ
   ApnDz4PAKycc2i9Fh2MTfoz1eu7QCMjp2v1Naoj9TckoaXOl8WVJeow70
   w==;
X-CSE-ConnectionGUID: v7nt6K2jSrm4lO8WJqToag==
X-CSE-MsgGUID: PiGD7aP8Se6yL3YjgJ4Aog==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="67085143"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="67085143"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 00:55:01 -0700
X-CSE-ConnectionGUID: 9ZfPo66QSuOOrWTYMUmSoA==
X-CSE-MsgGUID: 0fry8PTfQlu7kCpNADEpoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139034883"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 19 May 2025 00:55:00 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uGvKr-000LGW-0O;
	Mon, 19 May 2025 07:54:57 +0000
Date: Mon, 19 May 2025 15:54:34 +0800
From: kernel test robot <lkp@intel.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-ext4@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: [tytso-ext4:dev 43/47] fs/ext4/inode.c:573:49-51: WARNING !A || A &&
 B is equivalent to !A || B
Message-ID: <202505191524.auftmOwK-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
head:   e4e129b9e3d37b21d78a5a6617c6987dafa9600d
commit: 2e7bad830aa9995dbc11577b8ee5090bc06b1b7b [43/47] ext4: Add support for EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS
config: alpha-randconfig-r062-20250519 (https://download.01.org/0day-ci/archive/20250519/202505191524.auftmOwK-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505191524.auftmOwK-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> fs/ext4/inode.c:573:49-51: WARNING !A || A && B is equivalent to !A || B

vim +573 fs/ext4/inode.c

   540	
   541	static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
   542					 struct ext4_map_blocks *map, int flags)
   543	{
   544		unsigned int status;
   545		int retval;
   546		unsigned int orig_mlen = map->m_len;
   547		unsigned int query_flags = flags & EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF;
   548	
   549		flags &= EXT4_EX_FILTER;
   550		if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
   551			retval = ext4_ext_map_blocks(handle, inode, map,
   552						     flags | query_flags);
   553		else
   554			retval = ext4_ind_map_blocks(handle, inode, map, flags);
   555	
   556		if (retval <= 0)
   557			return retval;
   558	
   559		if (unlikely(retval != map->m_len)) {
   560			ext4_warning(inode->i_sb,
   561				     "ES len assertion failed for inode "
   562				     "%lu: retval %d != map->m_len %d",
   563				     inode->i_ino, retval, map->m_len);
   564			WARN_ON(1);
   565		}
   566	
   567		/*
   568		 * No need to query next in leaf:
   569		 * - if returned extent is not last in leaf or
   570		 * - if the last in leaf is the full requested range
   571		 */
   572		if (!(map->m_flags & EXT4_MAP_QUERY_LAST_IN_LEAF) ||
 > 573				((map->m_flags & EXT4_MAP_QUERY_LAST_IN_LEAF) &&
   574				 (map->m_len == orig_mlen))) {
   575			status = map->m_flags & EXT4_MAP_UNWRITTEN ?
   576					EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
   577			ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
   578					      map->m_pblk, status, false);
   579			return retval;
   580		}
   581	
   582		return ext4_map_query_blocks_next_in_leaf(handle, inode, map,
   583							  orig_mlen);
   584	}
   585	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

