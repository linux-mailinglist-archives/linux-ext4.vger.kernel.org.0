Return-Path: <linux-ext4+bounces-1057-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49368457E6
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Feb 2024 13:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00F301C2565D
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Feb 2024 12:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2430B8662E;
	Thu,  1 Feb 2024 12:35:03 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C4786626;
	Thu,  1 Feb 2024 12:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790902; cv=none; b=UWix29YnGXKNqJV6frEqcywWf8ABoR4JbeXCPBlf87SZWgxubrS8sxKpQqUx1LoByxHyE8cP+COR9TtFKgoiXqi7SM8iBb51BLl5P76GBiPtAlu39t4zF3jJdWksd/NbxK+R21mrQAQqJxHPhCelvFK3JIIMpO6kXhBO8zVoyXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790902; c=relaxed/simple;
	bh=pgvxh8iwZDY76Bk5zc0MOB5kIp6sgO3F/tNC3N2l0s0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ct17NNkebg9NlPFytLTEkH/vfgLOqD8n9NVm5uAJX2Ek+v7a2P9fXZ1dS8WB9e/QhHunD0U0PrYDfJxyTDwS1orCj//tzOhL7IhdQhCed+0bc0zmMYm4l14jM4oK9p8PfckgTq3YYJfM1MzHT0U/S7XpnkH8A1jPVYpLrTdl6eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TQddM3VsQz1vsxv;
	Thu,  1 Feb 2024 20:34:31 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 0F7E41400D4;
	Thu,  1 Feb 2024 20:34:57 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 20:34:56 +0800
Message-ID: <0ab855b2-e484-e571-d6d2-7f4789f4ef77@huawei.com>
Date: Thu, 1 Feb 2024 20:34:56 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] ext4: correct best extent lstart adjustment logic
Content-Language: en-US
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <yukuai3@huawei.com>,
	<stable@kernel.org>, Baokun Li <libaokun1@huawei.com>
References: <20240122123332.555370-1-libaokun1@huawei.com>
 <20240131124636.gmxaiex6yqrhvxcj@quack3>
 <3630fa7f-b432-7afd-5f79-781bc3b2c5ea@huawei.com>
 <Zbt7setS4c/Q4fyv@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <Zbt7setS4c/Q4fyv@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2024/2/1 19:08, Ojaswin Mujoo wrote:

Hi Ojaswin, Jan

> Hi Baokun, Jan
>
> Thanks for the CC, I somehow missed this patch.
>
> As described in the discussion Jan linked [1] , there is a known bug in the
> normalize code (which i should probably get back to now ) where we sometimes
> end up with a goal range which doesn't completely cover the original extent and
> this was causing issues when we tried to cover the complete original request in
> the PA window adjustment logic. That and to minimize fragmentation, we ended up
> going with the logic we have right now.
>
> In short, I agree that in the example Baokun pointed out, it is not optimal to
> have to make an allocation request twice when we can get it in one go.
>
> I also think Baokun is correct that if keeping the best extent at the end doesn't
> cover the original start, then any other case should not lead to it overflowing out
> of goal extent, including the case where original extent is overflowing goal extent.
>
> So, as mentioned, it boils down to a trade off between multiple allocations and slightly
> increased fragmentation. iiuc preallocations are anyways dropped when the file closes
> so I think it shouldn't hurt too much fragmentation wise to prioritize less
> allocations. What are your thoughts on this Jan, Baokun?
>
> Coming to the code, the only thing I think might cause an issue is the following line:
>
> -		BUG_ON(ac->ac_o_ex.fe_len > ac->ac_b_ex.fe_len);
> +		BUG_ON(o_ex_end > extent_logical_end(sbi, &ex));
>
> So as discussed towards the end here [1] we could have ac_o_ex that
> overflows the goal and hence would be beyond the best length. I'll try
> to look into the normalize logic to fix this however till then, I think
> we should not have this BUG_ON since it would crash the kernel if this
> happens.
>
> Rest of it looks good to me.
>
> Regards,
> Ojaswin
>
> [1]
> https://lore.kernel.org/all/Y+UzQJRIJEiAr4Z4@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com/
I will remove the problematic BUG_ON and add some comments in
the next version.

Thanks to Ojaswin and Jan for the review!
-- 
With Best Regards,
Baokun Li
.

