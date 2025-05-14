Return-Path: <linux-ext4+bounces-7880-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A274AB6B34
	for <lists+linux-ext4@lfdr.de>; Wed, 14 May 2025 14:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 055F416F98B
	for <lists+linux-ext4@lfdr.de>; Wed, 14 May 2025 12:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD33275864;
	Wed, 14 May 2025 12:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDesafKP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5367020C016;
	Wed, 14 May 2025 12:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747224929; cv=none; b=LU2AX9fsathzzRDECcjqXKbI2hPtl3uuqZMiJgpPXI6PLOspxbjBsfPkhSp4sBLK/hgdvi2CIrmpfDBNs4/N6BUVNgwgTH4Wo/SfdO+k2n1MSr++5egK2r2lUudivkps7yTu5SOq5DphRLIbt0w93sMM/JxMnXB55ssnRnwSe2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747224929; c=relaxed/simple;
	bh=Wq2iBIEwsY6FhRxgTv+U9RMmZ6m7AXpMshuV5t9m3Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6VzaufGda65EAPZ2JTK2E+JwmzKBuSGJbbYPRfsSWvXbYwLOWO7W3O3pQlsNp9Ej6l6uvOg8gx35d31mZsh0CoHpSXZjfgk8Xwu1krlkotK73v/7EDWZVeYdTXZQg4LWW9hHhPPqJMJh9MQQ21GdeYJ1utWcLtnLRC2qeymT4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDesafKP; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747224927; x=1778760927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wq2iBIEwsY6FhRxgTv+U9RMmZ6m7AXpMshuV5t9m3Ts=;
  b=dDesafKPYQHLMRrBmrBv4lFR5wKME8x9zZTm2xem+9Tg4VshNuOCRBej
   0Lwx5wNiq8G234hSLdQWNmlecm9zq4dzNaah1p8+cX8p5x2IFtnv/YhUN
   bOVCvI/urVfYGC6QH1+6JJOOcv6mO4aHDlKzuAR0oHFb1w2VZFR3fPj9Z
   3b88bPv7o8p09wEW/56nZRO26WjqImEfW4Pg6vu/m/e6yLzwVWQvheOga
   3daTaywV0VOPkMs9gvmJYfwzcQ5NB7hEyLcjwfQzcEWFtQet3AGSVYegP
   KRFd6JTq5AUcXfI1bFXqomj72MNYFSHe08ZzNUZZZLqGscD8tswDyTAj1
   w==;
X-CSE-ConnectionGUID: I4gjvmluRTmZJEfiNRh8QQ==
X-CSE-MsgGUID: rt5xYqyLRNOJIYD4Wcddmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="71621443"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="71621443"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 05:15:26 -0700
X-CSE-ConnectionGUID: 10hiSKPcTemNRJ3E3wInOw==
X-CSE-MsgGUID: v2pUpbBIT0uxm7g3oN8LFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="138071684"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 14 May 2025 05:15:19 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uFB13-000H5P-1n;
	Wed, 14 May 2025 12:15:17 +0000
Date: Wed, 14 May 2025 20:14:36 +0800
From: kernel test robot <lkp@intel.com>
To: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, kernel_team@skhynix.com,
	torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
	will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
	joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
	duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
	tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
	amir73il@gmail.com, gregkh@linuxfoundation.org, kernel-team@lge.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
	minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com
Subject: Re: [PATCH v15 02/43] dept: implement DEPT(DEPendency Tracker)
Message-ID: <202505142038.OTu01zaa-lkp@intel.com>
References: <20250513100730.12664-3-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513100730.12664-3-byungchul@sk.com>

Hi Byungchul,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3]

url:    https://github.com/intel-lab-lkp/linux/commits/Byungchul-Park/llist-move-llist_-head-node-definition-to-types-h/20250513-181346
base:   82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3
patch link:    https://lore.kernel.org/r/20250513100730.12664-3-byungchul%40sk.com
patch subject: [PATCH v15 02/43] dept: implement DEPT(DEPendency Tracker)
config: x86_64-kismet-CONFIG_DEBUG_MUTEXES-CONFIG_DEPT-0-0 (https://download.01.org/0day-ci/archive/20250514/202505142038.OTu01zaa-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250514/202505142038.OTu01zaa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505142038.OTu01zaa-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for DEBUG_MUTEXES when selected by DEPT
   WARNING: unmet direct dependencies detected for DEBUG_RWSEMS
     Depends on [n]: DEBUG_KERNEL [=y] && !PREEMPT_RT [=y]
     Selected by [y]:
     - DEPT [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
   
   WARNING: unmet direct dependencies detected for DEBUG_MUTEXES
     Depends on [n]: DEBUG_KERNEL [=y] && !PREEMPT_RT [=y]
     Selected by [y]:
     - DEPT [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

