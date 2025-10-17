Return-Path: <linux-ext4+bounces-10946-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 185BBBE8D82
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Oct 2025 15:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E83B24EA6EE
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Oct 2025 13:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E436B3570A2;
	Fri, 17 Oct 2025 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GiENt0JJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AB8350D56
	for <linux-ext4@vger.kernel.org>; Fri, 17 Oct 2025 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707809; cv=none; b=o5rw8yh4wF+4wGIe0WFllINbwCStVYDe0yP8Xpmu4Kqb1rk+iCIZPeGAtI0Hpl6iDVOUh00FEI/NqAIBYkrchixiR9fitUz+W+MzmK/xanBPVcJjD7NMqNSoyr4hcV6q+zFuZY0WYEknyiXdGheGWcW7DJASFZY7A4yGHr5j2cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707809; c=relaxed/simple;
	bh=MxsMYW5ZTe5uxpVUFR/5HQz8Da/v++CsU3c2XeXNtJQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mK2a9KCK2WZfNpttVtY4Kd1rNoHuZLR1piLlthlZBVXykvYjNybkgaQ873NgNrLiPm91TMV086zPR0SOA9sJ0NDADXJ3iceYusS76MRshJfYL2YC8TqCaQPdI7Sh+PqQycSBAW5WOTKv3jzmlRn0hqwdGT5EDLFRSMIjkOoDGTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GiENt0JJ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760707807; x=1792243807;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=MxsMYW5ZTe5uxpVUFR/5HQz8Da/v++CsU3c2XeXNtJQ=;
  b=GiENt0JJTdvf4XmNUHcLdeRgCwY0RkFfUkaASa1hzoqJ6emjNJeNo4L6
   +ykdIF9VsSmF7O6RHI/qdWzKFcO397v++XV1MdFUvVKFt5YO+0ZqMFf+y
   vKfmZRnoP+5VoSI6sY0W9EEcf61WPN/ogFI5gp65FO+st9nJFFEhexa8m
   iM3/mkQOo0rzPOnXcGaWaZt6UT4FGEAy3GBSoui0qcCVVIAgoK+3/lntt
   MUUx4ct1v6Zz+IiTZoBlycDSPfa9dMVL5RLJsPvVE3w8teK2glyK0jn9c
   nQCFHUA24ppAj82SE4J4te0iHpbe2RDZS0E/Yxbers+o5LFklBIBmXB1I
   g==;
X-CSE-ConnectionGUID: Iz8DZH21R8KpOuthKurQMg==
X-CSE-MsgGUID: TBnAt86BR5irZuJUlcZ9+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="65531771"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="65531771"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 06:30:07 -0700
X-CSE-ConnectionGUID: PxGi72THQNmt3P1H8OCNXA==
X-CSE-MsgGUID: Ol2N6qhOQsWRoNJIwj4hrw==
X-ExtLoop1: 1
Received: from kwachows-mobl.ger.corp.intel.com (HELO [10.94.253.106]) ([10.94.253.106])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 06:30:05 -0700
Message-ID: <a5452767-40bf-4621-8bbd-b693224ce6fd@linux.intel.com>
Date: Fri, 17 Oct 2025 15:30:03 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible regression in pin_user_pages_fast() behavior after
 commit 7ac67301e82f ("ext4: enable large folio for regular file")
From: Karol Wachowski <karol.wachowski@linux.intel.com>
To: yi.zhang@huawei.com, tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca
References: <844e5cd4-462e-4b88-b3b5-816465a3b7e3@linux.intel.com>
Content-Language: en-US
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <844e5cd4-462e-4b88-b3b5-816465a3b7e3@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Actually the threshold after which is starts to hang is 2 megabytes.

On 10/17/2025 3:24 PM, Karol Wachowski wrote:
> Hi,
>
> I’m not entirely sure if this is right way to report this.
>
> I’ve encountered what appears to be a regression (or at least a
> behavioral change) related to pin_user_pages_fast() when used with
> FOLL_LONGTERM on a Copy-on-Write (CoW) mapping (i.e. VM_MAYWRITE without
> VM_SHARED). Specifically, the call never finishes when the requested
> size exceeds 8 MB.
>
> The same scenario works correctly prior to the following change:
> commit 7ac67301e82f02b77a5c8e7377a1f414ef108b84
> Author: Zhang Yi <yi.zhang@huawei.com>
> Date:   Mon May 12 14:33:19 2025 +0800
>
>     ext4: enable large folio for regular file
>
> It seems the issue manifests when pin_user_pages_fast() falls back to
> _gup_longterm_locked(). In that case, we end up calling
> handle_mm_fault() with FAULT_FLAG_UNSHARE, which splits the PMD. 
> From ftrace, it looks like the kernel enters an apparent infinite loop
> of handle_mm_fault() which in turn invokes filemap_map_pages() from the
> ext4 ops.
>
>   1)   1.553 us    |      handle_mm_fault();
>   1)   0.126 us    |      __cond_resched();
>   1)   0.055 us    |      vma_pgtable_walk_begin();
>   1)   0.057 us    |      _raw_spin_lock();
>   1)   0.111 us    |      _raw_spin_unlock();
>   1)   0.050 us    |      vma_pgtable_walk_end();
>   1)   1.521 us    |      handle_mm_fault();
>   1)   0.122 us    |      __cond_resched();
>   1)   0.055 us    |      vma_pgtable_walk_begin();
>   1)   0.288 us    |      _raw_spin_lock();
>   1)   0.053 us    |      _raw_spin_unlock();
>   1)   0.048 us    |      vma_pgtable_walk_end();
>   1)   1.484 us    |      handle_mm_fault();
>   1)   0.124 us    |      __cond_resched();
>   1)   0.056 us    |      vma_pgtable_walk_begin();
>   1)   0.272 us    |      _raw_spin_lock();
>   1)   0.051 us    |      _raw_spin_unlock();
>   1)   0.050 us    |      vma_pgtable_walk_end();
>   1)   1.566 us    |      handle_mm_fault();
>   1)   0.211 us    |      __cond_resched();
>   1)   0.107 us    |      vma_pgtable_walk_begin();
>   1)   0.054 us    |      _raw_spin_lock();
>   1)   0.052 us    |      _raw_spin_unlock();
>   1)   0.049 us    |      vma_pgtable_walk_end();
>
> I haven’t been able to gather more detailed diagnostics yet, but I’d
> appreciate any guidance on whether this is a known issue, or if
> additional debugging information would be helpful.
>
> -
> Karol
>

