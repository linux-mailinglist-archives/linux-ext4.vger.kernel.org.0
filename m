Return-Path: <linux-ext4+bounces-6427-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C11CCA339CF
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2025 09:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E0A17A1986
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2025 08:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C65820B209;
	Thu, 13 Feb 2025 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KYHySxO1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7779220AF72
	for <linux-ext4@vger.kernel.org>; Thu, 13 Feb 2025 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739434803; cv=none; b=koDf29BwACbW2pwep/CJO64JcnmcF1+7xVlO6bxYgoGQZZDYgPDoAlqvsxUmMMAplGmSfakvoWjTGq4ooJVqMQPrZNWre4JGAbPL3rbHSUfE19rQGAxs9Ad052Pxy94m40cGAJoDNSm0bZk4wLegxbtWpFJq+6Sn9Xs5ZvF4GUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739434803; c=relaxed/simple;
	bh=sMYMT/72AO3f938GObHaUBrqUL9VAIdgv5rAm0fKuLE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W/SUXWbERlwPXYTJseJSNpb1YC3m/uPBM6opc6RpQCq9o/HF0uaE32Nu9INAG8e/zEXMm4dkHB7EC3S1R8FOWK7S8uaRGVlEXQyyqoOOH1eWNtRGDjROFxbeKqGB2IjoYLy6/am9Jx6YZC9Tn8WPRug/cqYMBDqAJKYMc8opMMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KYHySxO1; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739434801; x=1770970801;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sMYMT/72AO3f938GObHaUBrqUL9VAIdgv5rAm0fKuLE=;
  b=KYHySxO1E46heDcnUHx6qrpeoihigpkrIsvYIZMJL2PxyVJH7wwfxHpm
   HRiTAwlENEMgErGrml9GkvPWdfjPo3rUqokTUGbFlmxn0fjEGFUHFkbyw
   iO8NOIJ5FYW3eXajtt4C7kkpQdXiaEt/7b4nlqnjMIgKBfauJFKurADeF
   7UAIInpaHr6u/TT0P4eyWQfGGFd0l/XEYYQ8Rj7IITqXRpJk3BLv6MyqE
   uXqFC0I5/Pt8hUIE6k8mtictpTgIPO/++QFJVkYGOtEXFdhoygW/fdVtU
   LfRhGXl8XLHah5ctt2zTY6Vp80oBOPKHY4fx3fUaj5wtvPigcdrav2Jjh
   A==;
X-CSE-ConnectionGUID: 1O3a711VSAqimGeMpMqW/g==
X-CSE-MsgGUID: mRYREhWwS4S1ml3wjKNsCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="43775063"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="43775063"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 00:20:01 -0800
X-CSE-ConnectionGUID: VS9QBJ0ET1WosNHXwDUdzA==
X-CSE-MsgGUID: xA1eUFNlQC+tT7Mf3YevUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="113604444"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 13 Feb 2025 00:19:59 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tiURx-0016mn-0M;
	Thu, 13 Feb 2025 08:19:57 +0000
Date: Thu, 13 Feb 2025 16:19:53 +0800
From: kernel test robot <lkp@intel.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: oe-kbuild-all@lists.linux.dev, linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev 15/15] include/linux/fs.h:1268:12: error: 'struct
 super_block' has no member named 's_encoding_flags'
Message-ID: <202502131639.HjJlsWin-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
head:   ab00acfcfc62ade16f642841d8807816b27b8944
commit: ab00acfcfc62ade16f642841d8807816b27b8944 [15/15] ext4: introduce linear search for dentries
config: x86_64-buildonly-randconfig-002-20250213 (https://download.01.org/0day-ci/archive/20250213/202502131639.HjJlsWin-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250213/202502131639.HjJlsWin-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502131639.HjJlsWin-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/ext4/namei.c:28:
   fs/ext4/namei.c: In function '__ext4_find_entry':
>> include/linux/fs.h:1268:12: error: 'struct super_block' has no member named 's_encoding_flags'
    1268 |         (sb->s_encoding_flags & SB_ENC_NO_COMPAT_FALLBACK_FL)
         |            ^~
   fs/ext4/namei.c:1602:27: note: in expansion of macro 'sb_no_casefold_compat_fallback'
    1602 |                 else if (!sb_no_casefold_compat_fallback(dir->i_sb) &&
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +1268 include/linux/fs.h

  1263	
  1264	#define sb_has_strict_encoding(sb) \
  1265		(sb->s_encoding_flags & SB_ENC_STRICT_MODE_FL)
  1266	
  1267	#define sb_no_casefold_compat_fallback(sb) \
> 1268		(sb->s_encoding_flags & SB_ENC_NO_COMPAT_FALLBACK_FL)
  1269	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

