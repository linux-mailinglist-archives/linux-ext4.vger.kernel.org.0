Return-Path: <linux-ext4+bounces-7018-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 133EFA75DB5
	for <lists+linux-ext4@lfdr.de>; Mon, 31 Mar 2025 03:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7683168531
	for <lists+linux-ext4@lfdr.de>; Mon, 31 Mar 2025 01:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BB029D0B;
	Mon, 31 Mar 2025 01:52:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16DFBA42
	for <linux-ext4@vger.kernel.org>; Mon, 31 Mar 2025 01:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743385926; cv=none; b=eoJNyumH1h1oK+nTG52s3DcsE6esvMQVI15X7lR+6J6pUHaCE4tlaZ0Q2qzM9MGpDdsCfrE5cWrtjsomEp3gxe7g5JSxEMlVLIKayplM2F/z2J6Gvvc7q8DRNMsh/F3TDNGw/WV3I8IS+qQABQguPgLutjNPA9W/Iq9IGd0tCUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743385926; c=relaxed/simple;
	bh=DtTTv98miIAjzkyo6BMWnzeEvVnov0FUNADCxa0AtBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l6z5eHxgzhPFEf2er49HMjPDRoL0CfWcTehB0YSmlBB9v46Mtsv+a+DpN8YP/jtcdoZZjcZBU+mINp0WZdi8LOaeaKtht0MOwQjI27LtavAoyFOVoInoJHRxgVNYcCJbvihXow92TAHTW3guRFykao1mNaKx+eN68iKpM3/v1VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZQvDN66dZz2CdSR;
	Mon, 31 Mar 2025 09:48:36 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id E0599140156;
	Mon, 31 Mar 2025 09:51:55 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 31 Mar
 2025 09:51:55 +0800
Message-ID: <f7dbbe6c-3341-4709-868c-9e8fabdb9af6@huawei.com>
Date: Mon, 31 Mar 2025 09:51:54 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: Fix the issue of missing lock in ext4_page_mkwrite
To: Penglei Jiang <superman.xpt@gmail.com>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
	<linux-kernel@vger.kernel.or>,
	<syzbot+d14b2bea87fe2aaffa3b@syzkaller.appspotmail.com>, Yang Erkun
	<yangerkun@huawei.com>
References: <20250330075515.37699-1-superman.xpt@gmail.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20250330075515.37699-1-superman.xpt@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg500008.china.huawei.com (7.202.181.45)

Hi Penglei,

On 2025/3/30 15:55, Penglei Jiang wrote:
> In ext4_page_mkwrite, it calls ext4_convert_inline_data, but it does
> not use inode_lock to hold i_rwsem.
>
> Fixes: 7b4cc9787fe35 ("ext4: evict inline data when writing to memory map")
> Reported-by: syzbot+d14b2bea87fe2aaffa3b@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67e57c6c.050a0220.2f068f.0037.GAE@google.com
> Signed-off-by: Penglei Jiang <superman.xpt@gmail.com>
> ---
>   fs/ext4/inode.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index bcb96caf77c0..4e726c86377a 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -6203,6 +6203,8 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
>   	sb_start_pagefault(inode->i_sb);
>   	file_update_time(vma->vm_file);
>   
> +	inode_lock(inode);
> +
>   	filemap_invalidate_lock_shared(mapping);
>   
>   	err = ext4_convert_inline_data(inode);
We cannot directly add inode_lock here, otherwise it may cause ABBA
deadlock. The inline data conversion here does lack inode_lock, but
there is no good way to fix it now. For details, please see:

https://lore.kernel.org/all/d704ce55-321a-9c1d-1f8b-3360a0fdf978@huawei.com/
> @@ -6308,6 +6310,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
>   	ret = vmf_fs_error(err);
>   out:
>   	filemap_invalidate_unlock_shared(mapping);
> +	inode_unlock(inode);
>   	sb_end_pagefault(inode->i_sb);
>   	return ret;
>   out_error:

