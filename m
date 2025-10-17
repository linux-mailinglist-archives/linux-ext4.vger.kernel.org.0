Return-Path: <linux-ext4+bounces-10945-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD1ABE8D20
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Oct 2025 15:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E7A0135C25E
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Oct 2025 13:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E018534F49A;
	Fri, 17 Oct 2025 13:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CmgP2n/I"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D999346A11
	for <linux-ext4@vger.kernel.org>; Fri, 17 Oct 2025 13:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707451; cv=none; b=PFtbuVx4CyEAUfJWDMOD8/2QjlW0Fs5dgAzBh6NzVJh+YMToC7F3sNPFrdp8hS4exaJnBeAMnbFnkuubj6DmMnt2plM9+CepKt3IxbvBl46WYcBtuMTYjqC3MuKRYuTTiRO64O+M4muWHRr+7t34nJZCUwZI/Bss7X1n219LXPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707451; c=relaxed/simple;
	bh=pAenj/kR7GZywC+6OPKVCQf+kJvJjJVxvjfV3pJSzbI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=qYWXX1vsxSMHZLW+zn0g9z07k7G8pRhjQp4QNtV/dfEedlg3/5PcmPK7cCRkdDdU+Pf36sYQ5BfpzWm1BbsfgB8ppnZpq74dxlTE83FWICjIlyj2CNE31KE14kOWX7TfI+xWSdv9HPOTAsuFhYeNVmrIhtxfJAaCBGk/TlrJw0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CmgP2n/I; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760707450; x=1792243450;
  h=message-id:date:mime-version:from:subject:to:cc:
   content-transfer-encoding;
  bh=pAenj/kR7GZywC+6OPKVCQf+kJvJjJVxvjfV3pJSzbI=;
  b=CmgP2n/I2OKJ0lzHfZyZ5P6jI90hIcZlHDf/CHL7zoKyg7FNnOe+8RtY
   HxsxQNah7oLnd7zNylh4t9iXdws7eZGFbcgoqoxOoBqwUJ/9/FXLnaWpa
   0qmvAlLvun29Xka1de8/gK0M8FmQG5eTBqCrDRS6mzE8zDWNmFhUagVzi
   pAKXd4MoFfAEi1/0cdVbQkh5IWrvCVwWleR5sRQPo7ODa5wwpM3VDhBVI
   w5Ye1rdlCIlNv923tBurNS2bp0HWeAjFIcZ2voc7EixtcRHqK+YxSooIV
   3o95RxHzqUstirLd8Ytm1ioonDA+yRN2yxqy0jcsSPKRDtJ+D329UVdXH
   g==;
X-CSE-ConnectionGUID: coWDNhdFTTipIvbRXMqXzQ==
X-CSE-MsgGUID: eosjGio7Q8KDonu7ViySdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="66564135"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="66564135"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 06:24:09 -0700
X-CSE-ConnectionGUID: 1qv6guzqRH+XNvX9SWgTeQ==
X-CSE-MsgGUID: RipzacF1RS2e2fkdNTfmQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="182677368"
Received: from kwachows-mobl.ger.corp.intel.com (HELO [10.94.253.106]) ([10.94.253.106])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 06:24:07 -0700
Message-ID: <844e5cd4-462e-4b88-b3b5-816465a3b7e3@linux.intel.com>
Date: Fri, 17 Oct 2025 15:24:05 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Karol Wachowski <karol.wachowski@linux.intel.com>
Subject: Possible regression in pin_user_pages_fast() behavior after commit
 7ac67301e82f ("ext4: enable large folio for regular file")
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
To: yi.zhang@huawei.com, tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

I’m not entirely sure if this is right way to report this.

I’ve encountered what appears to be a regression (or at least a
behavioral change) related to pin_user_pages_fast() when used with
FOLL_LONGTERM on a Copy-on-Write (CoW) mapping (i.e. VM_MAYWRITE without
VM_SHARED). Specifically, the call never finishes when the requested
size exceeds 8 MB.

The same scenario works correctly prior to the following change:
commit 7ac67301e82f02b77a5c8e7377a1f414ef108b84
Author: Zhang Yi <yi.zhang@huawei.com>
Date:   Mon May 12 14:33:19 2025 +0800

    ext4: enable large folio for regular file

It seems the issue manifests when pin_user_pages_fast() falls back to
_gup_longterm_locked(). In that case, we end up calling
handle_mm_fault() with FAULT_FLAG_UNSHARE, which splits the PMD. 
From ftrace, it looks like the kernel enters an apparent infinite loop
of handle_mm_fault() which in turn invokes filemap_map_pages() from the
ext4 ops.

  1)   1.553 us    |      handle_mm_fault();
  1)   0.126 us    |      __cond_resched();
  1)   0.055 us    |      vma_pgtable_walk_begin();
  1)   0.057 us    |      _raw_spin_lock();
  1)   0.111 us    |      _raw_spin_unlock();
  1)   0.050 us    |      vma_pgtable_walk_end();
  1)   1.521 us    |      handle_mm_fault();
  1)   0.122 us    |      __cond_resched();
  1)   0.055 us    |      vma_pgtable_walk_begin();
  1)   0.288 us    |      _raw_spin_lock();
  1)   0.053 us    |      _raw_spin_unlock();
  1)   0.048 us    |      vma_pgtable_walk_end();
  1)   1.484 us    |      handle_mm_fault();
  1)   0.124 us    |      __cond_resched();
  1)   0.056 us    |      vma_pgtable_walk_begin();
  1)   0.272 us    |      _raw_spin_lock();
  1)   0.051 us    |      _raw_spin_unlock();
  1)   0.050 us    |      vma_pgtable_walk_end();
  1)   1.566 us    |      handle_mm_fault();
  1)   0.211 us    |      __cond_resched();
  1)   0.107 us    |      vma_pgtable_walk_begin();
  1)   0.054 us    |      _raw_spin_lock();
  1)   0.052 us    |      _raw_spin_unlock();
  1)   0.049 us    |      vma_pgtable_walk_end();

I haven’t been able to gather more detailed diagnostics yet, but I’d
appreciate any guidance on whether this is a known issue, or if
additional debugging information would be helpful.

-
Karol


