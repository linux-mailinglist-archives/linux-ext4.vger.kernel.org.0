Return-Path: <linux-ext4+bounces-11332-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A8FC195D7
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Oct 2025 10:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 538754F6D30
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Oct 2025 09:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D5C322C88;
	Wed, 29 Oct 2025 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G0yyi71Q"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691A015ECD7;
	Wed, 29 Oct 2025 09:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761729788; cv=none; b=d+V59XC0cn5cjTVFQTWFrQXBQyYPrgLPUtyi22uEUFCFC7J5dYSDmleIAd1eqAQT8vUyWgqnxin5Gfo99fNJzAL2YSa3itYRInDnPF3iIDfpFWlBVBGYj3Aom+TclcnNJ9tWwDLON98T8vfGY22b8l/BoG+ACjtKOBl5h7bbbu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761729788; c=relaxed/simple;
	bh=Dz67qM6WpNTGZoHDbHtWK4azoMzpQZOCDpIC1elvdKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIp74yB7qTe31Hy1aWOttei887m+6w+uwkfhhmXZDwdngE9UxBvhAup54ZJYtgyTeDedEpmttRSkkrGTvdRaNAfp26UwSO++6VZgQEMC80pGEx0cW41Eg8b5GAbtqp5SX0WQ992rYpmCoqPgcZhvrKCl4mHrASOS1E0MgBeIcHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G0yyi71Q; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761729786; x=1793265786;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dz67qM6WpNTGZoHDbHtWK4azoMzpQZOCDpIC1elvdKo=;
  b=G0yyi71QCNzK7uwKukj7AyuQGY9wrnsquWzNEkMBIe5dfKs2UPd5kgMq
   sX18fXi7BPw91TOQ+T5sTuav3P1BBPlHf3Wj7Ouokazjgjwki+JAkmLwU
   nDW4yv33+0pDG+S+QmNqG5aMyUynFPiXid483zuE5pjVySrlzre/x2FXm
   zYGRLhhg/G45cL/qdxoWOup3DSqy4SUJepIUom3kjIl+9qYZkVb/UOt6k
   KdHcm/fOTuMt+FJTISETHwI+xR/lK/4Jql34VIojJnkIhMc7Q3Cmg4REa
   GlTMPWeuDu20dlfgtr8semqhRZ+eAMjZtTt+thLtTvu+fFRsb/m/lGoYc
   g==;
X-CSE-ConnectionGUID: U3LIg+bYSGqgCijF4MC8Hw==
X-CSE-MsgGUID: e6xYVHkSQd+soXESwl3hwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63052509"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="63052509"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 02:23:05 -0700
X-CSE-ConnectionGUID: R8nMR3YdSEewm17v+rh43w==
X-CSE-MsgGUID: v6tLbISvQraq3Igo0LAqIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="189669438"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 29 Oct 2025 02:22:59 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vE2OK-000KS1-0Z;
	Wed, 29 Oct 2025 09:22:53 +0000
Date: Wed, 29 Oct 2025 17:22:26 +0800
From: kernel test robot <lkp@intel.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>, Theodore Ts'o <tytso@mit.edu>
Cc: oe-kbuild-all@lists.linux.dev, Fedor Pchelkin <pchelkin@ispras.ru>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH 1/2] ext4: fix up copying of mount_opts in superblock
 tuning ioctls
Message-ID: <202510291703.2nhl90qz-lkp@intel.com>
References: <20251028130949.599847-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028130949.599847-1-pchelkin@ispras.ru>

Hi Fedor,

kernel test robot noticed the following build errors:

[auto build test ERROR on tytso-ext4/dev]
[also build test ERROR on linus/master v6.18-rc3 next-20251029]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Fedor-Pchelkin/ext4-fix-string-copying-in-parse_apply_sb_mount_options/20251028-211235
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20251028130949.599847-1-pchelkin%40ispras.ru
patch subject: [PATCH 1/2] ext4: fix up copying of mount_opts in superblock tuning ioctls
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20251029/202510291703.2nhl90qz-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251029/202510291703.2nhl90qz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510291703.2nhl90qz-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/ext4.h:141:30: error: expected ':', ',', ';', '}' or '__attribute__' before '__nonstring'
     141 |         __u8  mount_opts[64] __nonstring;
         |                              ^~~~~~~~~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

