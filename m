Return-Path: <linux-ext4+bounces-11706-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03150C45120
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 07:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA18C188E9BE
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 06:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F621227B9F;
	Mon, 10 Nov 2025 06:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="EAsxVgkE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CFF14D283;
	Mon, 10 Nov 2025 06:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762755536; cv=none; b=h/r5ekw8XnBGWplWAnKw3PevZPNh/iZiQQ2f8dej+SRaIjaLW+/KPUQ2kB1gf8ljMMwOI1u7cWnw9dxbQNf3UhfPusmFspHB/4mZ4O0MKABry3e/6Ng76AU0bXJ0ITe1IXMz8Uwbk9aW7Lxi/W4V5KMu31jgGc5v1IINZ6u2ki8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762755536; c=relaxed/simple;
	bh=PL8zB/p5Utl9T7P/bqyzQ+BJ4D1se8aHDQ/9RhrXrp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R5JV5nWnjH4tJ/fov13+AEqkB298NB60HSy6TwSNZP2b3XTVLxgw/THpGX9fJr052uyRPR6EciOAfh6aMIbZMSiGG0CHeqaQ17d9Te4X4lbhJ6K4a9lhJBs6OO4269rexe3LDZp6zELlqxVZvH/jpoDB0kjLjC1zyVmN6WNnnMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=EAsxVgkE; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xDNON/pyA4w9sSn5npGbkSra1PS7hPcDGXPKn7rpI6Q=;
	b=EAsxVgkE0Wa/EpknZDXWMCXq+epH7UAa9adI/VeaaUfC5x/5KPMJGf03jRcDk9Yj279k2hQJi
	tbJiq1Yx0nUkL2TOM5ptcxw2ElrxO1BpOtq+cDKMKmuVg4ryKvt7gNdsjx8L05VCq9UgcXIac9I
	X5uKbjWLc4IUPJkP2MRWy8M=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4d4fZf1vHWzcb04;
	Mon, 10 Nov 2025 14:16:58 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id D34DF180B65;
	Mon, 10 Nov 2025 14:18:43 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 10 Nov
 2025 14:18:42 +0800
Message-ID: <6d6945a4-6672-45d1-a7fc-0736df452895@huawei.com>
Date: Mon, 10 Nov 2025 14:18:41 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/24] ext4: enable block size larger than page size
To: Theodore Ts'o <tytso@mit.edu>
CC: <linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<linux-kernel@vger.kernel.org>, <kernel@pankajraghav.com>,
	<mcgrof@kernel.org>, <ebiggers@kernel.org>, <willy@infradead.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
	<libaokun1@huawei.com>, Baokun Li <libaokun@huaweicloud.com>
References: <20251107144249.435029-1-libaokun@huaweicloud.com>
 <20251110043226.GD2988753@mit.edu>
Content-Language: en-GB
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251110043226.GD2988753@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-11-10 12:32, Theodore Ts'o wrote:
> I've started looking at this patch series and playing with it, and one
> thing which is worth noting is that CONFIG_TRANSPARENT_HUGEPAGE needs
> to be enabled, or else sb_set_blocksize() will fail for block size >
> page size.  This isn't specific to ext4, and maybe I'm missing
> something, but apparently this isn't documented.  I had to go digging
> through the source code to figure out what was needed.
>
> I wonder if we should have some kind of warning in sb_set_blocksize()
> where if there is an attempt to set a blocksize > page size and
> transparent hugepages is not configured, we issue a printk_once()
> giving a hint to the user that the reason that the mount failed was
> because transparent hugepages wasn't enabled at compile time.
>
> It **really** isn't obvious that large block size support and
> transparent hugepages are linked.
>
Thank you for the review!

Yes, supporting block sizes larger than the page size requires large
folios, so it is indeed necessary to enable CONFIG_TRANSPARENT_HUGEPAGE
to support large folios. Because the code is wrapped in multiple layers,
the connection between the two is somewhat hidden, and users may not
notice it or know how to enable LBS.

I will add some hints in sb_set_blocksize to make users aware of this
relationship. Thanks for the suggestion!


Cheers,
Baokun



