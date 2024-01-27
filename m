Return-Path: <linux-ext4+bounces-978-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D49183E9A7
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Jan 2024 03:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E9BAB2971A
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Jan 2024 02:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42161219E5;
	Sat, 27 Jan 2024 02:11:07 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB00D2206B;
	Sat, 27 Jan 2024 02:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706321467; cv=none; b=P0MpOMgMMLwndOGuRLeA/0zmgNdymmcGZX9crwWYVckYMzhM1wsjuae8EDEI92Sd37X3isWY3ejKhssmWUWC181szRupbPoqk6HiZ4rnYsgd573blf0AbJv7mCjo1hI7ax4KuTAoZTpYvvvnIdPUAhW7wB04lXVSscWDxtvAh2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706321467; c=relaxed/simple;
	bh=haMXrFElMZVtyiLv9sT0+tRXS90AelViRudJvzm/QnY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Brg9dXsetjaiJKwlcQQXfOp/VYJabqhKqWHydn65Qvqi1VAjZxJDVrf6QYvNBuRmQ+NJJ2pwz6qSPVtp0smJ78ZfpSQONHutgrfnwi8qFJrbkGTxHro0QSCMiregBqqWXqafnOGz27C77CnkNQxoMHThOdwIuM/czgv2b1hGitM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TMJ143rV2zNlgV;
	Sat, 27 Jan 2024 10:10:00 +0800 (CST)
Received: from canpemm500005.china.huawei.com (unknown [7.192.104.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 3DA6118006C;
	Sat, 27 Jan 2024 10:10:56 +0800 (CST)
Received: from [10.174.176.34] (10.174.176.34) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 27 Jan 2024 10:10:55 +0800
Subject: Re: [PATCH 6/7] ext4: set type of ac_groups_linear_remaining to __u32
 to avoid overflow
To: Baokun Li <libaokun1@huawei.com>, <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yangerkun@huawei.com>, <chengzhihao1@huawei.com>, <yukuai3@huawei.com>,
	<stable@kernel.org>
References: <20240126085716.1363019-1-libaokun1@huawei.com>
 <20240126085716.1363019-7-libaokun1@huawei.com>
From: Zhang Yi <yi.zhang@huawei.com>
Message-ID: <fad39d52-1d82-27ed-b074-f002a9cc2d48@huawei.com>
Date: Sat, 27 Jan 2024 10:10:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240126085716.1363019-7-libaokun1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500005.china.huawei.com (7.192.104.229)

On 2024/1/26 16:57, Baokun Li wrote:
> Now ac_groups_linear_remaining is of type __u16 and s_mb_max_linear_groups
> is of type unsigned int, so an overflow occurs when setting a value above
> 65535 through the mb_max_linear_groups sysfs interface. Therefore, the
> type of ac_groups_linear_remaining is set to __u32 to avoid overflow.
> 
> Fixes: 196e402adf2e ("ext4: improve cr 0 / cr 1 group scanning")
> CC: stable@kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/mballoc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> index d7aeb5da7d86..498af2abc5d8 100644
> --- a/fs/ext4/mballoc.h
> +++ b/fs/ext4/mballoc.h
> @@ -194,8 +194,8 @@ struct ext4_allocation_context {
>  
>  	__u32 ac_groups_considered;
>  	__u32 ac_flags;		/* allocation hints */
> +	__u32 ac_groups_linear_remaining;
>  	__u16 ac_groups_scanned;
> -	__u16 ac_groups_linear_remaining;
>  	__u16 ac_found;
>  	__u16 ac_cX_found[EXT4_MB_NUM_CRS];
>  	__u16 ac_tail;
> 

