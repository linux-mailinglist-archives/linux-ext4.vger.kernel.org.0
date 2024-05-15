Return-Path: <linux-ext4+bounces-2527-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2658C6731
	for <lists+linux-ext4@lfdr.de>; Wed, 15 May 2024 15:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DB291F273DC
	for <lists+linux-ext4@lfdr.de>; Wed, 15 May 2024 13:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF0412E1FE;
	Wed, 15 May 2024 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RDtUKDbu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C6212D77B;
	Wed, 15 May 2024 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715779011; cv=none; b=t2sskMWoePTWkUj1Dna5oxyLgk192JSh1WtqaWZU5K8mbmygfXaSvKHAkIS8zjVRYivht9mP6XPaBSmTyJjN1OtQI3lO3mXxDo1EpWoHpTYYQegx1l2yQcDNKukUArpUDeEjiTpQJPTErWdDKD+IORAkAD/1o9Dtj+xupHA+1S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715779011; c=relaxed/simple;
	bh=6Suti5BG8hbQxAoyYe7aKDviSAwS07hFSe3bf5Ox+o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQQPHrLOFyvvjaCad8EuhDnjzwdWdcGP59cySfgf7zGkmHsK29YbK2nKlpUWYBE3ygCgLisOa/nr02pvzCzhZGAhDv7nsKcM0OB9+ZenJMW9nTpDF08aCMcPrACUSaM2FRwEwy1Sy1/dG6DlCraCvZ2YHd3i/+x5p8DfLycNsYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RDtUKDbu; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715779010; x=1747315010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6Suti5BG8hbQxAoyYe7aKDviSAwS07hFSe3bf5Ox+o4=;
  b=RDtUKDbu9UPCOOAizf/wM7DKyniH5yWci3wot+D2aDUd3bH8raGwJk7v
   SWU8ZWWgiLym6cnCvj7/VWSG8xX7psfhLxZjEZTBCmoyCZF1JMiI85gb6
   BeaYFNsxdIBpbVqJIX4QT1VKvLsXJ8rj1fAMz7Oi/OnDQ5hXDkS6GTzkv
   8gxIywWAy7c39DElthgfcSyp9D5EHB0AuxAJuWGIyKucSyrgvLxUizkKs
   SG/vV35+gmNJ+ci4yoV/7arFVqAmJnxb3jMiMAH/kRujscL/tV//QDFVG
   h/IEIQnjlbHRIpSetTuKdTyLUSH1pNxfuV4ku3IuS/tuAQ2HLXUI8IyYW
   Q==;
X-CSE-ConnectionGUID: LTPQbDxFQVuH/vrVRtX3Kg==
X-CSE-MsgGUID: q+QwLa+XREiPL7NeMhgOLQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="29347559"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="29347559"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 06:16:47 -0700
X-CSE-ConnectionGUID: +BgsFfFWTuS6NvBr+jXxFw==
X-CSE-MsgGUID: opRpAD/iQjGyIdcjisO4/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="31179419"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 15 May 2024 06:16:44 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7EUq-000Cqj-2b;
	Wed, 15 May 2024 13:16:40 +0000
Date: Wed, 15 May 2024 21:16:23 +0800
From: kernel test robot <lkp@intel.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
	jack@suse.cz, yi.zhang@huawei.com, yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 1/3] iomap: pass blocksize to iomap_truncate_page()
Message-ID: <202405152037.DjvUiyJ1-lkp@intel.com>
References: <20240515022829.2455554-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515022829.2455554-2-yi.zhang@huaweicloud.com>

Hi Zhang,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on linus/master v6.9 next-20240515]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhang-Yi/iomap-pass-blocksize-to-iomap_truncate_page/20240515-104121
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20240515022829.2455554-2-yi.zhang%40huaweicloud.com
patch subject: [PATCH 1/3] iomap: pass blocksize to iomap_truncate_page()
config: xtensa-allnoconfig (https://download.01.org/0day-ci/archive/20240515/202405152037.DjvUiyJ1-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240515/202405152037.DjvUiyJ1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405152037.DjvUiyJ1-lkp@intel.com/

All errors (new ones prefixed by >>):

   xtensa-linux-ld: fs/iomap/buffered-io.o: in function `iomap_file_unshare':
   buffered-io.c:(.text+0x1f48): undefined reference to `__moddi3'
>> xtensa-linux-ld: buffered-io.c:(.text+0x1f57): undefined reference to `__moddi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

