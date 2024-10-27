Return-Path: <linux-ext4+bounces-4819-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A994F9B1F21
	for <lists+linux-ext4@lfdr.de>; Sun, 27 Oct 2024 16:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7691F215D1
	for <lists+linux-ext4@lfdr.de>; Sun, 27 Oct 2024 15:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8946E1714B4;
	Sun, 27 Oct 2024 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L5clGHnd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034C76FB6;
	Sun, 27 Oct 2024 15:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730043975; cv=none; b=GmutSOzy+Zrv8pUFOUldh1FqluyYnuVxMfcusnWK+7ty9beKk1dXMpBU5l5meSzAqxqbJzO3ZjiOBHSx5mOLAgo3uFbas7Bo5fqEbmF0b4ZGDRwwJeZn3SL8zgBo4txFjoxJ5Bz/+4zobJmNbXV4JiQTeGMxYCBJBolaPZmbkP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730043975; c=relaxed/simple;
	bh=jCWOO8c7lQeX52GgTvhBNPUhAu/rl0nx5lJ5UkOQ/vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2u1b6Gk9sNmgjtFAXlfcGT+27Iax1xa8Ph89uwf2flfMsMu60zEaY2IU6pUNLKqpLg1WHr+7hd3digJiwrocNIoqC4JgGAumhqRgVOoUzh9YPUD7YUIlr3ORKyTsUiwPUL1Tm30mOArlUN5zpeakmRJuXAUb8uvAi+OHSz9sL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L5clGHnd; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730043973; x=1761579973;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jCWOO8c7lQeX52GgTvhBNPUhAu/rl0nx5lJ5UkOQ/vU=;
  b=L5clGHndp51vpkJetxH/VV+w4lmUdjZz5vOS5xS8uvKUf6FxPSDcSwtc
   oEJjc64DVSgtWdJD8m9OH7Pvh62FGXFsI4la1JHPQSbxxvFGg5bMjKpm1
   vnbLzMf3qxWuY4LElm9lzSlQa9UvE1BUptngRYQ59gcwJPxOmJevmqz1D
   pjMBtUSl8w1vfTdBKcCt7/lfRZbAgZ+BMiBA7K0/eQsCnbGdYb//wx4MS
   3+8wOlRnTmv4xVMQbyPExkLRzoe0AewQ7DTBwDw0mQVKhpUnzeKIvCakT
   hPZuNy/zmuou6b46aVUodul232HqSVpFPP2FrEdBFLJSM+PpFbJ7hPRwV
   g==;
X-CSE-ConnectionGUID: UvmSHUDbTCyLiXSNXU4oRQ==
X-CSE-MsgGUID: y1QW7I+MSa+KVTWQqk0Elw==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29087611"
X-IronPort-AV: E=Sophos;i="6.11,237,1725346800"; 
   d="scan'208";a="29087611"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 08:46:12 -0700
X-CSE-ConnectionGUID: SFmJGIQ5SI+TdjcUisIrqA==
X-CSE-MsgGUID: iQQYfilWRzaFKRyYvF/jRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,237,1725346800"; 
   d="scan'208";a="81829890"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 27 Oct 2024 08:46:10 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t55Sx-000an4-2v;
	Sun, 27 Oct 2024 15:46:07 +0000
Date: Sun, 27 Oct 2024 23:45:45 +0800
From: kernel test robot <lkp@intel.com>
To: Edward Adam Davis <eadavis@qq.com>,
	syzbot+0c99c3f90699936c1e77@syzkaller.appspotmail.com
Cc: oe-kbuild-all@lists.linux.dev, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [PATCH] ext4: Add a sanity check for next dentry when insert
Message-ID: <202410272114.DrZ8huEU-lkp@intel.com>
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
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20241027/202410272114.DrZ8huEU-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241027/202410272114.DrZ8huEU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410272114.DrZ8huEU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/ext4/namei.c:2087:5: warning: no previous prototype for 'ext4_check_next_dentry' [-Wmissing-prototypes]
    2087 | int ext4_check_next_dentry(struct inode *dir,
         |     ^~~~~~~~~~~~~~~~~~~~~~


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

