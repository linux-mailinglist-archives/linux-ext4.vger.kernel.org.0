Return-Path: <linux-ext4+bounces-7881-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F45AB6BB5
	for <lists+linux-ext4@lfdr.de>; Wed, 14 May 2025 14:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86EB0169DF6
	for <lists+linux-ext4@lfdr.de>; Wed, 14 May 2025 12:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB5927991F;
	Wed, 14 May 2025 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6UbKUSJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E70A2798F0;
	Wed, 14 May 2025 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747226793; cv=none; b=Pyf1vFFdv3mEMxmuwU8ykPBiqL1wDL/3sy9ek3gQgrEJ9e9UFFZYx/JV+6A4n9zoT+Zjri2HaSjd3MFZo2/ry30rme9WeG659q0FWd4eAIzwfXcNIMIT3z8SqJsJOFcx5k7AIfWsk1MLsf06mweT09Bc4u5nOA8QWEYStOnNoW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747226793; c=relaxed/simple;
	bh=BUgSEOK7zJn4CATqu59tiupdNB3czkL+OCUJvfXe/1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmgzUzI6sIF8hvZbGkR6MXihk1DPgrwLbE9tFw2egIBuVmQduBsM5j3oiar7ujG2dpsnofooSFklxJhjelghjbyYqpePJVOGBv/Eou86Yo9+Q2P8FZRHd0bzcjWpJkYhr5GeciOOkpEye+Xn/tpB9KGzMkf1RUeSX0uiORy2fuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d6UbKUSJ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747226790; x=1778762790;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BUgSEOK7zJn4CATqu59tiupdNB3czkL+OCUJvfXe/1U=;
  b=d6UbKUSJB5yEbfk3ajTt+aG8p79O8YOeHbgtRrQm8YZU04YQ3ki6BSls
   KH5YeNH2WUaJghnQ2IbySabcgMnwOtVeYmih4V+kp/SKv1no2KkAYmooH
   VTWZc8UouJKIhxsSOsZcOZgKmNaeafPJq5S/7i+73GK8QeJgcvqYo8TsR
   ftde1PWJZ08cKI59qKxos7QcWoecJrGKLqu3TrkMW7/9PDoWklyin/P0G
   kLQi83+kDOIVvMZalCKjKqrs0R8Px+gozBEwxNWONyYOR19gMqUH9jvC6
   3Rr8g4EY9Vl2KpXyqBbACoLaqR5pt9DJPN3oGINd2U7sPaX3Ae+xOeF5m
   A==;
X-CSE-ConnectionGUID: sZ+y3uFrTcKBqf+jdD7xpA==
X-CSE-MsgGUID: pBvpslkFR1yg56rG59mnLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="48992264"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="48992264"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 05:46:29 -0700
X-CSE-ConnectionGUID: rUXdi+5SR7qQyzL3Wy2ykQ==
X-CSE-MsgGUID: x2SA57B0SQaTgc5J+7zhNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="169118792"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 14 May 2025 05:46:23 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uFBV6-000H7N-2B;
	Wed, 14 May 2025 12:46:20 +0000
Date: Wed, 14 May 2025 20:46:11 +0800
From: kernel test robot <lkp@intel.com>
To: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	kernel_team@skhynix.com, torvalds@linux-foundation.org,
	damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, will@kernel.org,
	tglx@linutronix.de, rostedt@goodmis.org, joel@joelfernandes.org,
	sashal@kernel.org, daniel.vetter@ffwll.ch, duyuyang@gmail.com,
	johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
	willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
	gregkh@linuxfoundation.org, kernel-team@lge.com, linux-mm@kvack.org,
	akpm@linux-foundation.org, mhocko@kernel.org, minchan@kernel.org,
	hannes@cmpxchg.org, vdavydov.dev@gmail.com
Subject: Re: [PATCH v15 33/43] dept: assign unique dept_key to each distinct
 dma fence caller
Message-ID: <202505142049.8vYH34nZ-lkp@intel.com>
References: <20250513100730.12664-34-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250513100730.12664-34-byungchul@sk.com>

Hi Byungchul,

kernel test robot noticed the following build errors:

[auto build test ERROR on 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3]

url:    https://github.com/intel-lab-lkp/linux/commits/Byungchul-Park/llist-move-llist_-head-node-definition-to-types-h/20250513-181346
base:   82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3
patch link:    https://lore.kernel.org/r/20250513100730.12664-34-byungchul%40sk.com
patch subject: [PATCH v15 33/43] dept: assign unique dept_key to each distinct dma fence caller
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20250514/202505142049.8vYH34nZ-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250514/202505142049.8vYH34nZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505142049.8vYH34nZ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1372:3: error: cannot jump from this indirect goto statement to one of its possible targets
    1372 |                 drm_exec_retry_on_contention(&exec);
         |                 ^
   include/drm/drm_exec.h:123:4: note: expanded from macro 'drm_exec_retry_on_contention'
     123 |                         goto *__drm_exec_retry_ptr;             \
         |                         ^
   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1399:2: note: possible target of indirect goto statement
    1399 |         dma_fence_wait(fence, false);
         |         ^
   include/linux/dma-fence.h:679:2: note: expanded from macro 'dma_fence_wait'
     679 |         sdt_might_sleep_start_timeout(NULL, MAX_SCHEDULE_TIMEOUT);      \
         |         ^
   include/linux/dept_sdt.h:45:45: note: expanded from macro 'sdt_might_sleep_start_timeout'
      45 |                 dept_stage_wait(__m, __m ? NULL : &__key, _THIS_IP_, __func__, t);\
         |                                                           ^
   include/linux/instruction_pointer.h:10:41: note: expanded from macro '_THIS_IP_'
      10 | #define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
         |                                         ^
   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1399:2: note: jump enters a statement expression
   include/linux/dma-fence.h:679:2: note: expanded from macro 'dma_fence_wait'
     679 |         sdt_might_sleep_start_timeout(NULL, MAX_SCHEDULE_TIMEOUT);      \
         |         ^
   include/linux/dept_sdt.h:45:45: note: expanded from macro 'sdt_might_sleep_start_timeout'
      45 |                 dept_stage_wait(__m, __m ? NULL : &__key, _THIS_IP_, __func__, t);\
         |                                                           ^
   include/linux/instruction_pointer.h:10:20: note: expanded from macro '_THIS_IP_'
      10 | #define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
         |                    ^
   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1399:2: note: jump enters a statement expression
   include/linux/dma-fence.h:675:38: note: expanded from macro 'dma_fence_wait'
     675 | #define dma_fence_wait(f, intr)                                         \
         |                                                                         ^
   1 error generated.
--
>> drivers/gpu/drm/xe/xe_svm.c:807:3: error: cannot jump from this indirect goto statement to one of its possible targets
     807 |                 drm_exec_retry_on_contention(&exec);
         |                 ^
   include/drm/drm_exec.h:123:4: note: expanded from macro 'drm_exec_retry_on_contention'
     123 |                         goto *__drm_exec_retry_ptr;             \
         |                         ^
   drivers/gpu/drm/xe/xe_svm.c:831:2: note: possible target of indirect goto statement
     831 |         dma_fence_wait(fence, false);
         |         ^
   include/linux/dma-fence.h:679:2: note: expanded from macro 'dma_fence_wait'
     679 |         sdt_might_sleep_start_timeout(NULL, MAX_SCHEDULE_TIMEOUT);      \
         |         ^
   include/linux/dept_sdt.h:45:45: note: expanded from macro 'sdt_might_sleep_start_timeout'
      45 |                 dept_stage_wait(__m, __m ? NULL : &__key, _THIS_IP_, __func__, t);\
         |                                                           ^
   include/linux/instruction_pointer.h:10:41: note: expanded from macro '_THIS_IP_'
      10 | #define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
         |                                         ^
   drivers/gpu/drm/xe/xe_svm.c:831:2: note: jump enters a statement expression
   include/linux/dma-fence.h:679:2: note: expanded from macro 'dma_fence_wait'
     679 |         sdt_might_sleep_start_timeout(NULL, MAX_SCHEDULE_TIMEOUT);      \
         |         ^
   include/linux/dept_sdt.h:45:45: note: expanded from macro 'sdt_might_sleep_start_timeout'
      45 |                 dept_stage_wait(__m, __m ? NULL : &__key, _THIS_IP_, __func__, t);\
         |                                                           ^
   include/linux/instruction_pointer.h:10:20: note: expanded from macro '_THIS_IP_'
      10 | #define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
         |                    ^
   drivers/gpu/drm/xe/xe_svm.c:831:2: note: jump enters a statement expression
   include/linux/dma-fence.h:675:38: note: expanded from macro 'dma_fence_wait'
     675 | #define dma_fence_wait(f, intr)                                         \
         |                                                                         ^
   1 error generated.
--
>> drivers/gpu/drm/xe/xe_gt_pagefault.c:164:3: error: cannot jump from this indirect goto statement to one of its possible targets
     164 |                 drm_exec_retry_on_contention(&exec);
         |                 ^
   include/drm/drm_exec.h:123:4: note: expanded from macro 'drm_exec_retry_on_contention'
     123 |                         goto *__drm_exec_retry_ptr;             \
         |                         ^
   drivers/gpu/drm/xe/xe_gt_pagefault.c:181:2: note: possible target of indirect goto statement
     181 |         dma_fence_wait(fence, false);
         |         ^
   include/linux/dma-fence.h:679:2: note: expanded from macro 'dma_fence_wait'
     679 |         sdt_might_sleep_start_timeout(NULL, MAX_SCHEDULE_TIMEOUT);      \
         |         ^
   include/linux/dept_sdt.h:45:45: note: expanded from macro 'sdt_might_sleep_start_timeout'
      45 |                 dept_stage_wait(__m, __m ? NULL : &__key, _THIS_IP_, __func__, t);\
         |                                                           ^
   include/linux/instruction_pointer.h:10:41: note: expanded from macro '_THIS_IP_'
      10 | #define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
         |                                         ^
   drivers/gpu/drm/xe/xe_gt_pagefault.c:181:2: note: jump enters a statement expression
   include/linux/dma-fence.h:679:2: note: expanded from macro 'dma_fence_wait'
     679 |         sdt_might_sleep_start_timeout(NULL, MAX_SCHEDULE_TIMEOUT);      \
         |         ^
   include/linux/dept_sdt.h:45:45: note: expanded from macro 'sdt_might_sleep_start_timeout'
      45 |                 dept_stage_wait(__m, __m ? NULL : &__key, _THIS_IP_, __func__, t);\
         |                                                           ^
   include/linux/instruction_pointer.h:10:20: note: expanded from macro '_THIS_IP_'
      10 | #define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
         |                    ^
   drivers/gpu/drm/xe/xe_gt_pagefault.c:181:2: note: jump enters a statement expression
   include/linux/dma-fence.h:675:38: note: expanded from macro 'dma_fence_wait'
     675 | #define dma_fence_wait(f, intr)                                         \
         |                                                                         ^
   1 error generated.


vim +1372 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c

f1d93c9c2722a2 Jack Xiao       2020-03-27  1357  
737dad0b5d609f Jack Xiao       2020-09-09  1358  int amdgpu_mes_ctx_unmap_meta_data(struct amdgpu_device *adev,
737dad0b5d609f Jack Xiao       2020-09-09  1359  				   struct amdgpu_mes_ctx_data *ctx_data)
737dad0b5d609f Jack Xiao       2020-09-09  1360  {
737dad0b5d609f Jack Xiao       2020-09-09  1361  	struct amdgpu_bo_va *bo_va = ctx_data->meta_data_va;
737dad0b5d609f Jack Xiao       2020-09-09  1362  	struct amdgpu_bo *bo = ctx_data->meta_data_obj;
737dad0b5d609f Jack Xiao       2020-09-09  1363  	struct amdgpu_vm *vm = bo_va->base.vm;
2acc73f81f2500 Christian König 2022-08-16  1364  	struct dma_fence *fence;
2acc73f81f2500 Christian König 2022-08-16  1365  	struct drm_exec exec;
2acc73f81f2500 Christian König 2022-08-16  1366  	long r;
2acc73f81f2500 Christian König 2022-08-16  1367  
05d249352f1ae9 Rob Clark       2023-11-20  1368  	drm_exec_init(&exec, 0, 0);
2acc73f81f2500 Christian König 2022-08-16  1369  	drm_exec_until_all_locked(&exec) {
2acc73f81f2500 Christian König 2022-08-16  1370  		r = drm_exec_lock_obj(&exec,
2acc73f81f2500 Christian König 2022-08-16  1371  				      &ctx_data->meta_data_obj->tbo.base);
2acc73f81f2500 Christian König 2022-08-16 @1372  		drm_exec_retry_on_contention(&exec);
2acc73f81f2500 Christian König 2022-08-16  1373  		if (unlikely(r))
2acc73f81f2500 Christian König 2022-08-16  1374  			goto out_unlock;
737dad0b5d609f Jack Xiao       2020-09-09  1375  
2acc73f81f2500 Christian König 2022-08-16  1376  		r = amdgpu_vm_lock_pd(vm, &exec, 0);
2acc73f81f2500 Christian König 2022-08-16  1377  		drm_exec_retry_on_contention(&exec);
2acc73f81f2500 Christian König 2022-08-16  1378  		if (unlikely(r))
2acc73f81f2500 Christian König 2022-08-16  1379  			goto out_unlock;
737dad0b5d609f Jack Xiao       2020-09-09  1380  	}
737dad0b5d609f Jack Xiao       2020-09-09  1381  
737dad0b5d609f Jack Xiao       2020-09-09  1382  	amdgpu_vm_bo_del(adev, bo_va);
737dad0b5d609f Jack Xiao       2020-09-09  1383  	if (!amdgpu_vm_ready(vm))
737dad0b5d609f Jack Xiao       2020-09-09  1384  		goto out_unlock;
737dad0b5d609f Jack Xiao       2020-09-09  1385  
2acc73f81f2500 Christian König 2022-08-16  1386  	r = dma_resv_get_singleton(bo->tbo.base.resv, DMA_RESV_USAGE_BOOKKEEP,
2acc73f81f2500 Christian König 2022-08-16  1387  				   &fence);
737dad0b5d609f Jack Xiao       2020-09-09  1388  	if (r)
737dad0b5d609f Jack Xiao       2020-09-09  1389  		goto out_unlock;
737dad0b5d609f Jack Xiao       2020-09-09  1390  	if (fence) {
737dad0b5d609f Jack Xiao       2020-09-09  1391  		amdgpu_bo_fence(bo, fence, true);
737dad0b5d609f Jack Xiao       2020-09-09  1392  		fence = NULL;
737dad0b5d609f Jack Xiao       2020-09-09  1393  	}
737dad0b5d609f Jack Xiao       2020-09-09  1394  
737dad0b5d609f Jack Xiao       2020-09-09  1395  	r = amdgpu_vm_clear_freed(adev, vm, &fence);
737dad0b5d609f Jack Xiao       2020-09-09  1396  	if (r || !fence)
737dad0b5d609f Jack Xiao       2020-09-09  1397  		goto out_unlock;
737dad0b5d609f Jack Xiao       2020-09-09  1398  
737dad0b5d609f Jack Xiao       2020-09-09  1399  	dma_fence_wait(fence, false);
737dad0b5d609f Jack Xiao       2020-09-09  1400  	amdgpu_bo_fence(bo, fence, true);
737dad0b5d609f Jack Xiao       2020-09-09  1401  	dma_fence_put(fence);
737dad0b5d609f Jack Xiao       2020-09-09  1402  
737dad0b5d609f Jack Xiao       2020-09-09  1403  out_unlock:
737dad0b5d609f Jack Xiao       2020-09-09  1404  	if (unlikely(r < 0))
737dad0b5d609f Jack Xiao       2020-09-09  1405  		dev_err(adev->dev, "failed to clear page tables (%ld)\n", r);
2acc73f81f2500 Christian König 2022-08-16  1406  	drm_exec_fini(&exec);
737dad0b5d609f Jack Xiao       2020-09-09  1407  
737dad0b5d609f Jack Xiao       2020-09-09  1408  	return r;
737dad0b5d609f Jack Xiao       2020-09-09  1409  }
737dad0b5d609f Jack Xiao       2020-09-09  1410  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

