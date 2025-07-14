Return-Path: <linux-ext4+bounces-8974-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53425B0377A
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 09:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90DC53BA7FE
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 07:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6392063F3;
	Mon, 14 Jul 2025 07:00:22 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820F84400;
	Mon, 14 Jul 2025 07:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752476422; cv=none; b=eQ7vsw0kXgORDe1RA9adgPbDqXlRK/5NjIKoX/rbE/TFittW3K32ybhGqrYUrtjo7iest37koCGi4vk5T3JVvy6QmTailwtbFxtW0xr/5owT6wN8WrTg2sw1HrJPeAiSYYYRZoGkvFVESSHOGb/Bi7Lvxa11qrRzBp9HMxxJg0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752476422; c=relaxed/simple;
	bh=RzVLwNAifMfV/xVhzy0eABZndME12w+aJ1DRmX29tCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j508pMW5eZxV7bp35Qklya3D5yXgOivysPsETlDxfK3euRhnfaDFkiUYMYElYKmAcVtwojSinPmbL8G/8nLG+0fKvOayxJxXZHQ+3GgEewk0mt49n+W522gUVxs9YedInUwxCdQ2EkCWApOanwq5jstrIjgmy5JLghTXWAq9Dco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bgY4n2mMnz2CfDq;
	Mon, 14 Jul 2025 14:56:09 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E5E8180042;
	Mon, 14 Jul 2025 15:00:15 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 14 Jul
 2025 15:00:14 +0800
Message-ID: <e7ca39ac-69b5-455b-af11-78a1a0b013f1@huawei.com>
Date: Mon, 14 Jul 2025 15:00:13 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] ext4: remove unnecessary s_md_lock on update
 s_mb_last_group
To: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>,
	<ojaswin@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>
References: <20250623073304.3275702-4-libaokun1@huawei.com>
 <xlzlyqudvp7a6ufdvc4rgsoe7ty425rrexuxgfbgwxoazfjd25@6eqbh66w7ayr>
 <1c2d7881-94bb-46ff-9cf6-ef1fbffc13e5@huawei.com>
 <mfybwoygcycblgaln2j4et4zmyzli2zibcgvixysanugjjhhh5@xyzoc4juy4wv>
 <db4b9d71-c34d-4315-a87d-2edf3bbaff2d@huawei.com>
 <e2dgjtqvqjapir5xizb5ixkilhzr7fm7m7ymxzk6ixzdbwxjjs@24n4nzolye77>
 <272e8673-36a9-4fef-a9f1-5be29a57c2dc@huawei.com>
 <kvgztznp6z2gwuujrw5vtklfbmq3arjg54bpiufmxdwmuwjliw@og7qkacbdtax>
 <9ecfe98f-b9d5-478a-b2a5-437b452dbd58@huawei.com>
 <6bf7irhdjrsvuodga344g2ulha52z65f2qf2l3tuldvwbb5pf6@cz7m2gypd4su>
 <20250714030113.GA23343@mit.edu>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20250714030113.GA23343@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500013.china.huawei.com (7.185.36.188)

Hello!

On 2025/7/14 11:01, Theodore Ts'o wrote:
> On Thu, Jul 10, 2025 at 04:38:33PM +0200, Jan Kara wrote:
>> Yes, apparently both approaches have their pros and cons. I'm actually
>> surprised the impact of additional barriers on ARM is so big for the
>> single container case. 10% gain for single container cases look nice OTOH
>> realistical workloads will have more container so maybe that's not worth
>> optimizing for. Ted, do you have any opinion?
> Let me try to summarize; regardless of whether we use
> {READ,WRITE})_ONCE or smp_load_acquire / smp_store_restore, both are
> signiicantly better than using a the spinlock.  The other thing about
> the "single-threaded perforance" is that there is the aditional cost
> of the CPU-to-CPU syncing is not free.  But CPU synchronization cost
> applies when that the single thread is bouncing between CPU's --- if
> we hada single threaded application which is pinned on a single CPU
> cost of smp_load_acquire would't be there since the cache line
> wouldn't be bouncing back and forth.  Is that correct, or am I missing
> something?
>
> In any case, so long as the single-threaded performance doesn't
> regress relative to the current spin_lock implementation, I'm inclined
> to prefer the use smp_load_acquire approach if it improves
> multi-threaded allocation performance on ARM64.
>
> Cheers,
>
> 							- Ted
>
Using {READ,WRITE}_ONCE yielded a very significant improvement in single
container scenarios (10%-16%). Although there was a slight decrease in
multi-container scenarios (-1% to -3%), subsequent optimizations
compensated for this.

To prevent regressions in single-container performance, we ultimately chose
{READ,WRITE}_ONCE for the v3 release last week.

Thank you for your suggestion!


Cheers,
Baokun


