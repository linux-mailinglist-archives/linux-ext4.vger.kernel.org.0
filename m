Return-Path: <linux-ext4+bounces-7759-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B965AADDDC
	for <lists+linux-ext4@lfdr.de>; Wed,  7 May 2025 13:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346E41B6857D
	for <lists+linux-ext4@lfdr.de>; Wed,  7 May 2025 11:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0718F2580C2;
	Wed,  7 May 2025 11:57:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4042586D5
	for <linux-ext4@vger.kernel.org>; Wed,  7 May 2025 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619049; cv=none; b=FR9TgWb5kHWzfiA+lAktDI7m1PNaYcfwcWRua9b+kk8i6bVLE9k+MFt1rb2yysN4c8xij0QDDeyiQurByc0EssniK2aR8eVj79lk6Nc4KMhpic2Ysj6mDgfPq6MQ7xFsxS7EvSpRNPCE6cBD/C4h96xtn1qB49IIYEK44QPKO6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619049; c=relaxed/simple;
	bh=xCGdZjPK86tIa6ZsNQi7JykhoToN2ZVGVey87SCI6ZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ac2T3dugE+PfcKkSx5j5ROvrI2/wAC3DOaVyhk2AoCnCrwG7+IlnDzgslIKWlEt8tlg9cSWzXTSDiACKvLRUwmFoVUpkEbwIR80t3H/P/u5+F4xZpMXAvt13tkp4NR77v1EzfLVa0Aa7SXMK+d+fjMZrWC/Kn1eZZJGq9EXiWIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZstvZ5JxTz2CdcN;
	Wed,  7 May 2025 19:53:46 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 646F01A0188;
	Wed,  7 May 2025 19:57:22 +0800 (CST)
Received: from [10.174.179.80] (10.174.179.80) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 May 2025 19:57:21 +0800
Message-ID: <fb9f3524-6940-4649-9d10-5cfed10fca48@huawei.com>
Date: Wed, 7 May 2025 19:57:20 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: Fix calculation of credits for extent tree
 modification
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Luis
 Chamberlain <mcgrof@kernel.org>, <kdevops@lists.linux.dev>, Ted Tso
	<tytso@mit.edu>
References: <20250429175535.23125-2-jack@suse.cz>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huawei.com>
In-Reply-To: <20250429175535.23125-2-jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf100017.china.huawei.com (7.202.181.16)

Hi, Jan!

On 2025/4/30 1:55, Jan Kara wrote:
> Luis and David are reporting that after running generic/750 test for 90+
> hours on 2k ext4 filesystem, they are able to trigger a warning in
> jbd2_journal_dirty_metadata() complaining that there are not enough
> credits in the running transaction started in ext4_do_writepages().
> 
> Indeed the code in ext4_do_writepages() is racy and the extent tree can
> change between the time we compute credits necessary for extent tree
> computation and the time we actually modify the extent tree. Thus it may
> happen that the number of credits actually needed is higher. Modify
> ext4_ext_index_trans_blocks() to count with the worst case of maximum
> tree depth. This can reduce the possible number of writers that can
> operate in the system in parallel (because the credit estimates now won't
> fit in one transaction) but for reasonably sized journals this shouldn't
> really be an issue. So just go with a safe and simple fix.
> 
> Link: https://lore.kernel.org/all/20250415013641.f2ppw6wov4kn4wq2@offworld
> Reported-by: Davidlohr Bueso <dave@stgolabs.net>
> Reported-by: Luis Chamberlain <mcgrof@kernel.org>
> Tested-by: kdevops@lists.linux.dev
> Signed-off-by: Jan Kara <jack@suse.cz>

This overall looks good to me now. However, the credit calculation in
ext4_ext_index_trans_blocks() seems still appears to be incorrect
because it does not include the leaf extent blocks. I discovered this
problem while attempting to enable large folios for ext4. It can easily
trigger problems when writing back a 2MB folio with a 1K block size,
and each block is discontinuous.

  https://lore.kernel.org/linux-ext4/20241125114419.903270-7-yi.zhang@huaweicloud.com/

Fortunately, this problem can only triggered after we support large
folio.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/extents.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index c616a16a9f36..43286632e650 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -2396,18 +2396,19 @@ int ext4_ext_calc_credits_for_single_extent(struct inode *inode, int nrblocks,
>  int ext4_ext_index_trans_blocks(struct inode *inode, int extents)
>  {
>  	int index;
> -	int depth;
>  
>  	/* If we are converting the inline data, only one is needed here. */
>  	if (ext4_has_inline_data(inode))
>  		return 1;
>  
> -	depth = ext_depth(inode);
> -
> +	/*
> +	 * Extent tree can change between the time we estimate credits and
> +	 * the time we actually modify the tree. Assume the worst case.
> +	 */
>  	if (extents <= 1)
> -		index = depth * 2;
> +		index = EXT4_MAX_EXTENT_DEPTH * 2;
>  	else
> -		index = depth * 3;
> +		index = EXT4_MAX_EXTENT_DEPTH * 3;
>  
>  	return index;
>  }


