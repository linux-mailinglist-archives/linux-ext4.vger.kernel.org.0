Return-Path: <linux-ext4+bounces-9057-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC87B096E8
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Jul 2025 00:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75193A40991
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 22:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4D523D282;
	Thu, 17 Jul 2025 22:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jOPAXHma"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0083023C50C;
	Thu, 17 Jul 2025 22:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752791311; cv=none; b=lihLBwy4yYjo+RnBZYkNqIcTIN6YOPJy67TnTQg66eGgSOFuVJ+h3kvUMy5FCPAQCmSCJMKoEzX33AoEvOO9epwlmNAcf+w+3HKe88yR2jWqxvxETIjr/dpXHdp/+epBcMFFjCVzf9Ck32W8T7i4JHUgLKXaKQNQd9ud25b/GEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752791311; c=relaxed/simple;
	bh=p0vDHWck1FU222M+GzNOyMhrIFdZ1185CKWEBiG97pw=;
	h=From:To:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=NhxuR+I0OEIIKeksbFNxlSd0jrqQRKZNDgtNHFv7cef+3hCDAwIWnY8zLCP0/zQNdmwdB4JUO1PUqLPffsC8ctu6WKjIbfVJxYe5MdGdspqt1OdA4kLgi+jRB2ntZnjA9f/np4oNArwiIV+hplwEvqx+AiQldDD6rtnyfbayy0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jOPAXHma; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752791309; x=1784327309;
  h=from:to:subject:references:date:in-reply-to:message-id:
   mime-version;
  bh=p0vDHWck1FU222M+GzNOyMhrIFdZ1185CKWEBiG97pw=;
  b=jOPAXHmak536Ws+HNXrpOIBMpiTkCY+NtLEa/WGiBZVKXa3LP6b+U5KD
   ofMBGz+vHrUG1z0QunH9a3LWNJkQTsMYowNSW7Yh9TYnB92yEeuqwdiae
   xrFF2RaCBsdeaiBdMEtb2AUPisQhdp6C+46HhH+sDs2J0VRu/YJIWiQFF
   aS0IK3t33KlQq4Pkgo8wC+etyWrbJ5OazgUKycDJIAitWoSBR8J/4WtsI
   6dSvZ6TfHeCNJi5bt8CFyHCiSZe1c9Gtg5LQLOfSXqEr/bBFrB8FbqPsD
   0fhp+WuxvTYSzle7C/b1V5UBx1ttdkKySGgjZKEeRbj+0H8dB5a57CucN
   w==;
X-CSE-ConnectionGUID: yBU33cxgTkCAHi90kuxKKg==
X-CSE-MsgGUID: jMNWDdGmQbOWns5TpNQMFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="80528871"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="80528871"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 15:28:28 -0700
X-CSE-ConnectionGUID: dnwYRp6eS9y9rqDEVZGlrw==
X-CSE-MsgGUID: QcKNG3EqTmGXv5bavCi+QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="157586665"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by fmviesa007.fm.intel.com with ESMTP; 17 Jul 2025 15:28:28 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id EE97A3011B8; Thu, 17 Jul 2025 15:28:27 -0700 (PDT)
From: Andi Kleen <ak@linux.intel.com>
To: libaokun1@huawei.com, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/17] ext4: add ext4_try_lock_group() to skip busy
 groups
References: <20250714130327.1830534-1-libaokun1@huawei.com>
	<20250714130327.1830534-2-libaokun1@huawei.com>
Date: Thu, 17 Jul 2025 15:28:27 -0700
In-Reply-To: <20250714130327.1830534-2-libaokun1@huawei.com> (Baokun Li's
	message of "Mon, 14 Jul 2025 21:03:11 +0800")
Message-ID: <87pldy78qc.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baokun Li <libaokun1@huawei.com> writes:

> When ext4 allocates blocks, we used to just go through the block groups
> one by one to find a good one. But when there are tons of block groups
> (like hundreds of thousands or even millions) and not many have free space
> (meaning they're mostly full), it takes a really long time to check them
> all, and performance gets bad. So, we added the "mb_optimize_scan" mount
> option (which is on by default now). It keeps track of some group lists,
> so when we need a free block, we can just grab a likely group from the
> right list. This saves time and makes block allocation much faster.
>
> But when multiple processes or containers are doing similar things, like
> constantly allocating 8k blocks, they all try to use the same block group
> in the same list. Even just two processes doing this can cut the IOPS in
> half. For example, one container might do 300,000 IOPS, but if you run two
> at the same time, the total is only 150,000.
>
> Since we can already look at block groups in a non-linear way, the first
> and last groups in the same list are basically the same for finding a block
> right now. Therefore, add an ext4_try_lock_group() helper function to skip
> the current group when it is locked by another process, thereby avoiding
> contention with other processes. This helps ext4 make better use of having
> multiple block groups.

It seems this makes block allocation non deterministic, but depend on
the system load. I can see where this could cause problems when
reproducing bugs at least, but perhaps also in other cases.

Better perhaps just round robin the groups?
Or at least add a way to turn it off.

-Andi

