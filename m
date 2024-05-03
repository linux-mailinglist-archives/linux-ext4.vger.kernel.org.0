Return-Path: <linux-ext4+bounces-2271-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 820758BA595
	for <lists+linux-ext4@lfdr.de>; Fri,  3 May 2024 05:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30961F23CB4
	for <lists+linux-ext4@lfdr.de>; Fri,  3 May 2024 03:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BAC1C683;
	Fri,  3 May 2024 03:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="McdLShCY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A909217C66
	for <linux-ext4@vger.kernel.org>; Fri,  3 May 2024 03:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714706139; cv=none; b=A4ZCX1y1fBnbS2tWLyynFchrHC8lMk8hDX6dV+YGiHCYSZYDSSytBA8B1W8sDHXCt4jemfF1KAxIzBN6Ih5fK38HxrN358HQXm+0I8TmB2bDQVFb0vaIid6MPBkn2BoC0PercIOkZU2RpbG9If3bi5mO/Jgw9eqyLdMfMYCX8GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714706139; c=relaxed/simple;
	bh=MXocKZDLZWja688de5gaJhOAfAuzW9dJi6b06eCcMlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9g6SXthhiLv68/+durTgsrEa4fX4OHZ24Ere+e4/C6XZ6MBLNuI3XD4AvJkXhKKgCMMYghHhk/jqfdvMBnXiLM5YS4e6HhdzJh54/geC600HIilhaSWXECH5jYj+QMA1VauN8jF3RNemJWV4JLa4cJ7liHqqT5vyyOS/0GZ7lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=McdLShCY; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-26-156-33.bstnma.fios.verizon.net [108.26.156.33])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4433EtkY032537
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 May 2024 23:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1714706099; bh=NAqoULF99IJZLWZbdS/0WDOtUiZwYwO7FwxqIEARW9o=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=McdLShCY+4nSQ/9AnagG/HjzZwTfLkbMnFAZk1OvJbC1gWkxj6PtyEocW0pW89iPw
	 B/vomUxiqjgnK3UoGyKHLGbFp+tFWir5bqyrR5WRBHLuAQvQjyqiiIKSAwP9ealtyk
	 OPEskfk6BfZ7W5s+/MAKfghpzTpOa2uG7pJTBwMeN+Y55BUFXAkI23Yatdp8bvOIKy
	 WBqXLVup1oe2g932mMndqoevprX3vwSZ58xpqiMKKcVNSFhB/PbNWaV6hJsv7aXPE3
	 arLQidyqISHH2j7LpueYpKtSB8SV/tYxfDeFOrwfAvdk2mh1dztpzEuhthiZKwJRSu
	 SB4ILQWTHfpQg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id A515515C02BB; Thu,  2 May 2024 23:14:55 -0400 (EDT)
Date: Thu, 2 May 2024 23:14:55 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Baokun Li <libaokun@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, ojaswin@linux.ibm.com, adobriyan@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH v4 0/9] ext4: avoid sysfs variables overflow causing
 BUG_ON/SOOB
Message-ID: <20240503031455.GF1743554@mit.edu>
References: <20240319113325.3110393-1-libaokun1@huawei.com>
 <985285f6-973b-30d5-4742-29cf5e8c0e27@huaweicloud.com>
 <8cf61cfc-8717-ee33-c94f-959212ce9c85@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cf61cfc-8717-ee33-c94f-959212ce9c85@huaweicloud.com>

On Fri, May 03, 2024 at 10:03:04AM +0800, Baokun Li wrote:
> Hi Ted,
> 
> Would you consider merging in this patchset in the current merge
> window? I would appreciate it if you could.

Yes, in fact it's next on my review list.  I've been working through
the patches on ext4's patchwork site roughly in chronological order
(focusing first on fixes and those that have been reviewed by other
folks).

Cheers,

					- Ted

