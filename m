Return-Path: <linux-ext4+bounces-8517-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C427FADF315
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Jun 2025 18:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C997168E95
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Jun 2025 16:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E89A2FEE12;
	Wed, 18 Jun 2025 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CR8Py3et"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5202D2FEE30;
	Wed, 18 Jun 2025 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750265654; cv=none; b=VYIK409iRbqVfpkptYaljEITys3N+gYRxtD8aLG5NoUc00k/L17rynumn/6qBQ1DFhIUgJR+8YUlYI7oQ9FPlB0kkBF65VS9Pli8ghOeslqO9eXf+PozVcHsQekTetkCJQTqIAzDukColqE0OZ1tGhRu/N29RXcpqTHtOTlEyZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750265654; c=relaxed/simple;
	bh=fLxaZl4fUsD/kUCYbiqh9qHAbpI8sHC7anX6i5OIkCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpHbn/wPk1zYoHqENvJbeYuHYSD5dQ8qVNrVJIJeDSWi1SQ8Kkd3lAvKxesobRdgA/Z1Kfq7L265KygROmxS6yj492YbwTD8of6+oKa0Z50Z2Aw6BW93gHi+wJKnGW92q2/nyYCVOJW8BAuSOl+0OUnHPWR9b/VR0C9t82stNOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CR8Py3et; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750265651; x=1781801651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fLxaZl4fUsD/kUCYbiqh9qHAbpI8sHC7anX6i5OIkCU=;
  b=CR8Py3et4CMqZBXIieAmH39c532lFLM8yUuZ727HlWddg3JsF/qIRP3v
   1EUijONNArdEOnCIS8mpgpZNfN3BgzULBOKTE4MqmzQSlnbhmrxm5FmYw
   7cfboRS2WRpHF8RGtD5QQ14JBRu7ZvT7NefOqVOhGh7GYEOxnhxAmkFST
   KPSLd6k03q8uWSguLUbV6aRl1WIMPp1o2xy+KjeoyvCspLMCfcY8FHoMT
   FtR+5MtIPHZAuI8tt4sfWnnyV0coyqHAn6axAcSKAudWk2cP8ob6wEQUZ
   HmmrZbZOdj56TB061UkDVeDCJKhplQfxJUUEKg11Z2QejQBUbI5UsXwiy
   w==;
X-CSE-ConnectionGUID: DcVGGFHmSwukhuFWvCnmkQ==
X-CSE-MsgGUID: FLovYuVhS2+Y3iMvKtPXIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="56314752"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="56314752"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 09:54:10 -0700
X-CSE-ConnectionGUID: APum73ZBR9mRC8sJtLUPbA==
X-CSE-MsgGUID: udQ5ZeYFSWGuMe9lD+HUoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="154613930"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 18 Jun 2025 09:54:08 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uRw33-000Jzq-1W;
	Wed, 18 Jun 2025 16:54:05 +0000
Date: Thu, 19 Jun 2025 00:53:06 +0800
From: kernel test robot <lkp@intel.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux ext4 <linux-ext4@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jonathan Corbet <corbet@lwn.net>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 3/4] Documentation: ext4: Slurp included subdocs in
 dynamic structures docs
Message-ID: <202506190011.J5FYoooF-lkp@intel.com>
References: <20250618111544.22602-4-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618111544.22602-4-bagasdotme@gmail.com>

Hi Bagas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d3f825032091fc14c7d5e34bcd54317ae4246903]

url:    https://github.com/intel-lab-lkp/linux/commits/Bagas-Sanjaya/Documentation-ext4-Slurp-included-subdocs-in-high-level-overview-docs/20250618-191724
base:   d3f825032091fc14c7d5e34bcd54317ae4246903
patch link:    https://lore.kernel.org/r/20250618111544.22602-4-bagasdotme%40gmail.com
patch subject: [PATCH 3/4] Documentation: ext4: Slurp included subdocs in dynamic structures docs
reproduce: (https://download.01.org/0day-ci/archive/20250619/202506190011.J5FYoooF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506190011.J5FYoooF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/translations/zh_TW/dev-tools/gdb-kernel-debugging.rst references a file that doesn't exist: Documentation/dev-tools/gdb-kernel-debugging.rst
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/leds/ti,tps6131x.yaml
   Warning: arch/riscv/kernel/kexec_image.c references a file that doesn't exist: Documentation/riscv/boot-image-header.rst
   Warning: drivers/clocksource/timer-armada-370-xp.c references a file that doesn't exist: Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
>> Warning: fs/ext4/inode-test.c references a file that doesn't exist: Documentation/filesystems/ext4/inodes.rst
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

