Return-Path: <linux-ext4+bounces-9239-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D1AB16228
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jul 2025 16:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A093AE504
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jul 2025 14:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB29A2D663B;
	Wed, 30 Jul 2025 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GxJ1lA5s"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF51D4A35;
	Wed, 30 Jul 2025 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753884134; cv=none; b=Z5ITmGRbTPhlSVdhdwMIBMmAO42j+Tn4QT8qTYYM4KpVKhwRduYMnAyonHCflf+vEz5Dc7GwoMYk8miR85APJ21CmCaAkuv/5CUbufNP2TqMv3ELgB6TMks1HXcV66FnbCM+llM85ay/ZU0tqE/PK2WLearzDGU1j72J7XxsC2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753884134; c=relaxed/simple;
	bh=0BLbPWoAkccqrcMSi8mjHp7OXZ+rlZZMXMeX2aDlMi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGdiv8OqS3otN1K7gFZHI4yMYGbVv3hycIeZEt7uVGBJFtEXT1dctZP097gDZGOYmmNIBHuB/qzahG4iUeAA5WYjFmRZV+UfFelg1hp8U+Iq+4pCje4jGVtHJ7acF6/DlaVQsrPDME7JSRA+gU4vMgpTTgzRCVFDa6hBiA6fQJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GxJ1lA5s; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753884133; x=1785420133;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0BLbPWoAkccqrcMSi8mjHp7OXZ+rlZZMXMeX2aDlMi0=;
  b=GxJ1lA5srxm6fwU5e5xH0KST3G4aV7JFbXn4/bI1Q/FyYHUv9eqhodva
   8lL3GmmXrBhpAfw0odxA44cGFnYPgzFaxlJfoiR/3fdi40kvNRnKwf1Jz
   qbSWo63C/8F6Wj7A4Thc+ZhZyLG3yMGpH7VReOg3oc0iU5wNVoVlfPfqm
   FicPyvV835EpZ0v5D86OUOBu7PQ5PNgtD3orbUuRbtnNXkBVBh5Pr+C9d
   4/EBwBWg56G5CesV8JbynXSRuBSNlnxZiF5P/tYS3n0/iapoyGuRanDcn
   qWddYe7cGdj9dvO08yRvjhBD19SfuI/lW+5kXsCHOv9bzOhsNBZ3sijT+
   g==;
X-CSE-ConnectionGUID: jn14AU6XRfCOJ5LF/s2Z6g==
X-CSE-MsgGUID: AWhxByh/RIqaX4dXbJcbFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="59827348"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="59827348"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 07:02:12 -0700
X-CSE-ConnectionGUID: J0Bdc9G3QzaHmQdTpiKA5w==
X-CSE-MsgGUID: A8ChVYndRhuswCvmXNMZDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="200170995"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 30 Jul 2025 07:02:11 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id F3CA017; Wed, 30 Jul 2025 17:02:41 +0200 (CEST)
Date: Wed, 30 Jul 2025 17:02:41 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>,
	linux-hardening@vger.kernel.org, ethan@ethancedwards.com
Subject: Re: [PATCH 2/3] ext4: use memcpy() instead of strcpy()
Message-ID: <aIo0EVzhbbLd89sV@black.igk.intel.com>
References: <20250712181249.434530-1-tytso@mit.edu>
 <20250712181249.434530-2-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250712181249.434530-2-tytso@mit.edu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Jul 12, 2025 at 02:12:48PM -0400, Theodore Ts'o wrote:
> The strcpy() function is considered dangerous and eeeevil by people
> who are using sophisticated code analysis tools such as "grep".  This
> is true even when a quick inspection would show that the source is a
> constant string ("." or "..") and the destination is a fixed array
> which is guaranteed to have enough space.  Make the "grep" code
> analysis tool happy by using memcpy() isstead of strcpy().  :-)

Why simple 2-arg strscpy() can't be used?

...

> -			strcpy(fake.name, ".");
> +			memcpy(fake.name, ".", 2);

s/strcpy/strscpy/

-- 
With Best Regards,
Andy Shevchenko



