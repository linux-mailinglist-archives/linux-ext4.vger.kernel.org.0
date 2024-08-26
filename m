Return-Path: <linux-ext4+bounces-3889-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F66A95FC6E
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2024 00:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC5CAB2152D
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Aug 2024 22:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E174B19CD0F;
	Mon, 26 Aug 2024 22:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A7MsA1xR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A1B19342A;
	Mon, 26 Aug 2024 22:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724710116; cv=none; b=N6o/bDs7yRNzgwdbCdPSoFdoBo60wTs4W6diInrjbaE5OIbZ0gvBhnN24M+9oI9c1+W3TdbLFT72uuY7m/ID3CYNh6a2bBQmicsFsMCmtlAu8T1wkgqDVcVapOBIxWH8Ql13R9IiQQ/prTfXOIAeDP+LDWCcD0fhDgphrvml3K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724710116; c=relaxed/simple;
	bh=MTJqgXRrpWsKtfxj39yoPmid/iW6hxkvaquXtjAl2hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOT1qMKuYkpH/dF+Zldztto0ZxgWLMajVnQAZk0YEDOJkEVT+SNtAddLxwHTQl9VPT51c6v6kLZjWRDelvgzqG/H+mU/eF9oZ5M5ubFNbEnDLuSu3BxEbiJbOpbb/QYy5nohJK2NM/qXAdVBDiXABC+oZvFjwANeZ3dLtOid+VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A7MsA1xR; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724710114; x=1756246114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MTJqgXRrpWsKtfxj39yoPmid/iW6hxkvaquXtjAl2hE=;
  b=A7MsA1xRrd1Hx9RxV/NwrVuxYTlcA0awSsWnk4npQIbV15YbAc0heCaq
   my5mawcImlkQ7WdPaJVfhBo/mJ24zuszSGr38yYEg0KSbb7612CnhXZj1
   FEudWT/G/WEZjsj3p7jI5A1eQtFxa7zn7fIBZrv317vK8S40bN+Jzln3S
   dgNwvHa+4T/IFIT3JKkpANFVmylfnKoeID1JiPiL+t+rSHUpQcbmdbhCR
   TGbe6U5CxOEcMewfaQDMv32eHtwIFWpw1GE1Z3d2ScTtwlg3nnfCPe2e9
   DeewG/+0mZ4UVq1mtl3BhWsIEqKfzXLDqBtmRI/ZMAyREz/qLxP/iAcRg
   g==;
X-CSE-ConnectionGUID: ks4BfuX5Tyq3A4kBqbx6XQ==
X-CSE-MsgGUID: UFDcbn3gQn2aGYwETd16+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="40663726"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="40663726"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:08:34 -0700
X-CSE-ConnectionGUID: 4JVCmYgVQcu+R5/RgJWewA==
X-CSE-MsgGUID: 8eEoDP5SRC2x05sHFey3mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="62816508"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 26 Aug 2024 15:08:31 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sihsz-000Hdm-0a;
	Mon, 26 Aug 2024 22:08:29 +0000
Date: Tue, 27 Aug 2024 06:07:36 +0800
From: kernel test robot <lkp@intel.com>
To: Ahmed Ehab <bottaawesome633@gmail.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	linux-ext4@vger.kernel.org, syzkaller@googlegroups.com
Subject: Re: [PATCH v6 2/2] locking/lockdep: Test no new string literal is
 created in lockdep_set_subclass()
Message-ID: <202408270559.rym5UAv9-lkp@intel.com>
References: <20240824221031.7751-2-bottaawesome633@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824221031.7751-2-bottaawesome633@gmail.com>

Hi Ahmed,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/locking/core]
[also build test ERROR on tip/master arm-perf/for-next/perf linus/master tip/auto-latest v6.11-rc5 next-20240826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ahmed-Ehab/locking-lockdep-Test-no-new-string-literal-is-created-in-lockdep_set_subclass/20240826-145215
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20240824221031.7751-2-bottaawesome633%40gmail.com
patch subject: [PATCH v6 2/2] locking/lockdep: Test no new string literal is created in lockdep_set_subclass()
config: i386-buildonly-randconfig-003-20240827 (https://download.01.org/0day-ci/archive/20240827/202408270559.rym5UAv9-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408270559.rym5UAv9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408270559.rym5UAv9-lkp@intel.com/

All errors (new ones prefixed by >>):

   lib/locking-selftest.c: In function 'lock_class_subclass_X1':
>> lib/locking-selftest.c:2715:60: error: 'struct rw_semaphore' has no member named 'dep_map'
    2715 |         const char *name_before_setting_subclass = rwsem_X1.dep_map.name;
         |                                                            ^
   lib/locking-selftest.c:2719:47: error: 'struct rw_semaphore' has no member named 'dep_map'
    2719 |         name_after_setting_subclass = rwsem_X1.dep_map.name;
         |                                               ^


vim +2715 lib/locking-selftest.c

  2712	
  2713	static void lock_class_subclass_X1(void)
  2714	{
> 2715		const char *name_before_setting_subclass = rwsem_X1.dep_map.name;
  2716		const char *name_after_setting_subclass;
  2717	
  2718		lockdep_set_subclass(&rwsem_X1, 1);
  2719		name_after_setting_subclass = rwsem_X1.dep_map.name;
  2720		DEBUG_LOCKS_WARN_ON(name_before_setting_subclass != name_after_setting_subclass);
  2721	}
  2722	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

