Return-Path: <linux-ext4+bounces-11948-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BB0C76E7B
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 03:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id D4CA428BC4
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 02:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F8B27AC3A;
	Fri, 21 Nov 2025 01:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="oO7FkeeE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7AB24DD17;
	Fri, 21 Nov 2025 01:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763690365; cv=none; b=tQ/p/15SmbKc0HnFnpBGWKEMK6Lp8bTuigQpultDgXS2wFeY59n6Fqk/Z5nCwBgQAabNcGJBWzdCiJ03r6L3AIAnEwGhdUNjO5BawdLrg5CE3NSXWsn6ZHXyFdztbhaO3OalIe+rKYpRkzLvLf7eF6b1k9BItXVsf8SlwLiKquk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763690365; c=relaxed/simple;
	bh=GIp0009+sUVrkjvzUUTzbgJHB8S8wPYfh9xGIoGtLHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aIULNBGyrS348q1HMZfvsZMd7IHN1FZBWOmKlIU3lnQxGCgR7qCuJktQDa2Ljd3l3eaL3UHXbBmPt8wwMK67ntys2yvpr6BPvsON5DbjXnHnO4QOQ7vcRlHLvmIPZLa6e2EFJqWZkUP0ONpFuQYm36RPd9cZrctZ2bp2VtdHOts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=oO7FkeeE; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8IxzA0xrDRDuCux7I/75OlQIhFWCZrW9huNpmM6c2T4=;
	b=oO7FkeeEM51Lb0MdKyJBUbM6TX/LcMbaZV5EhyhjfHqfclk+U4zfapIHF0azYgBWx4ArKTKFx
	t1YMU4B8OtTLHcwOMOGbTPmPOiUaxsDtrg1EantBTQm5YrxNot4nuuWzXt+yXisLgrQyNykC0+Z
	YNOxmRW6pQM+62Tv2PpG1v0=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dCJJf6xhjz12Lhq;
	Fri, 21 Nov 2025 09:57:54 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id A0BBB18048B;
	Fri, 21 Nov 2025 09:59:21 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 21 Nov
 2025 09:59:20 +0800
Message-ID: <e588e7d9-54bb-4fa2-ab31-1381dc5a3987@huawei.com>
Date: Fri, 21 Nov 2025 09:59:18 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/24] ext4: make data=journal support large block size
Content-Language: en-GB
To: Theodore Tso <tytso@mit.edu>
CC: Dan Carpenter <dan.carpenter@linaro.org>, <oe-kbuild@lists.linux.dev>,
	<libaokun@huaweicloud.com>, <linux-ext4@vger.kernel.org>, <lkp@intel.com>,
	<oe-kbuild-all@lists.linux.dev>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<linux-kernel@vger.kernel.org>, <kernel@pankajraghav.com>,
	<mcgrof@kernel.org>, <ebiggers@kernel.org>, <willy@infradead.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
	Baokun Li <libaokun1@huawei.com>
References: <202511161433.qI6uGU0m-lkp@intel.com>
 <ce363839-18af-4372-b7c2-e08cb053e403@huawei.com>
 <20251120154104.GA13687@macsyma-3.local>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251120154104.GA13687@macsyma-3.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-11-20 23:41, Theodore Tso wrote:
> On Thu, Nov 20, 2025 at 09:21:23AM +0800, Baokun Li wrote:
>> Oops! You nailed it. My bad, I totally forgot that unlock here, which
>> definitely left the lock unbalanced. I'll get that fixed up in v3.
> I think you meant v4 (since the current patch series are v3 :-). 

Haha, yes, , I messed up the version number. 😅

>  When
> do you think you might be able to get the next version of this patch
> series ready?  I think we're almost ready to land this feature!
>
>        	       	       	     	    	     - Ted
>
Yep, the current tests look clean! Good news on the dependencies too:
[1] and [2] are already merged to next.

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=ee040cbd6e48
[2]:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=50b2a4f19b22

I'll be sending out v4 today to fix the issue Dan mentioned, and then
I think this feature is ready to land! 

[P.S.: I noticed Christoph Hellwig and Eric Biggers are cleaning up the
 fscrypt API. That might clear the way for us to ditch the "no fscrypt
 support for ext4 LBS" restriction later on. I'm also looking into
 speeding up large block checksums. But I think these extra features and
 improvements can evolve independently from the work we’re doing now.]


Cheers,
Baokun


