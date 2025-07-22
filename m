Return-Path: <linux-ext4+bounces-9158-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6654FB0E528
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Jul 2025 22:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 954C03B8051
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Jul 2025 20:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2866284678;
	Tue, 22 Jul 2025 20:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ndu7+U4I"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B9F157A67;
	Tue, 22 Jul 2025 20:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753217981; cv=none; b=bcQuCto6nU+4amBtD0/67L+2Sw5fs0/5zy6oJRzaRqV8j3csmjjcTvdtDZyQuxejc0TWoWyeeVM/1X+2l/TbSPXFBncNqjPBFwCQghBfEA+ZoLdPMZGsBAFXu7VWBbXakFiitTTx/ylDJHYBZUfh7nzdCRY/jCT2qboecs0JmsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753217981; c=relaxed/simple;
	bh=uAtBAfrRltBsbn1PP/aSEFmfzzF7bww7zAy3s85o/8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqZbNZTKL3thmLinpaj3g2H7c8iidTb0kjVN1gQyTCEyYXejGiwT1G/ICtGWW1fO/Yh4CsXitPdLG4Om8NDJJ5JxZE1ChqxXasaIOy0FpPsEjG3WbvBJzHsuOMhKp0WCrrS0NTb4p8duXUsrpUYsO1AWvtDr0p93hD/X7PLL5uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ndu7+U4I; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753217980; x=1784753980;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uAtBAfrRltBsbn1PP/aSEFmfzzF7bww7zAy3s85o/8o=;
  b=Ndu7+U4IXPRYK/l+xsU6R+8jmf40/kXs1+jPa/mbQ8Aas2QDaWniIkHE
   Ifx5Y/RgrqhJ2nbdol6Ac4D9aQK9SSFAJl1rd5cPfm2dWfAK63UNGiP7n
   2BXYkP05rhp4/ybRelZFQYqe+nC4Buc3j9AVMAg10WBYak3ZkiNCWvDJt
   6DzM+33lqCQqGltlY/UOrGFF65jmAKyiKcCKOT3xTQeXr7x9H3uVa9qoj
   3vSnulfY5TtsRZJhEfARlj3NC+phT9TRhvjSdmSKy5nNhPfc7gF5BnoU8
   4mlHMCs5V60UTsrfdniV5yJNJibF9CFa/sJ/cKfTqM0FO6TwSmN+wdKdz
   g==;
X-CSE-ConnectionGUID: wqGorkLPQ26UYC2I4HnNyA==
X-CSE-MsgGUID: Cmy0aQ9aTUapjbStXHZSqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55426009"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="55426009"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 13:59:39 -0700
X-CSE-ConnectionGUID: bNR4YOIOR+ui5jDYvqfMWw==
X-CSE-MsgGUID: B9Rj/7+KSlKsEtV5H0ysYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="164899590"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 13:59:39 -0700
Date: Tue, 22 Jul 2025 13:59:37 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/17] ext4: add ext4_try_lock_group() to skip busy
 groups
Message-ID: <aH_7ue3fNcLjzxYw@tassilo>
References: <20250714130327.1830534-1-libaokun1@huawei.com>
 <20250714130327.1830534-2-libaokun1@huawei.com>
 <87pldy78qc.fsf@linux.intel.com>
 <d87eab9a-8224-477f-ae81-d4f205ee78b6@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d87eab9a-8224-477f-ae81-d4f205ee78b6@huawei.com>

> As Ted mentioned, Ext4 has never guaranteed deterministic allocation. We
> do attempt a predetermined goal in ext4_mb_find_by_goal(), and this part
> has no trylock logic, meaning we'll always attempt to scan the target
> group once—that's deterministic.
> 
> However, if the target attempt fails, the primary goal for subsequent
> allocation is to find suitable free space as quickly as possible, so
> there's no need to contend with other processes for non-target groups.

If you want to do it as quickly as possible then trylock is also not a good
strategy. It requires moving the cache line of the lock from EXCLUSIVE
(on the owning CPU) to SHARED and then later back to unlock, which all require
slow communication. On a large system or with contention you will still
observe considerable latencies.

Better to figure out a scheme that doesn't require touching the lock
at all.

-Andi


