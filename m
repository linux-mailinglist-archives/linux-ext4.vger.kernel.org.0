Return-Path: <linux-ext4+bounces-3809-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074A1959291
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Aug 2024 04:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41608B24BF2
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Aug 2024 02:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8563B7A8;
	Wed, 21 Aug 2024 02:01:08 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A602599
	for <linux-ext4@vger.kernel.org>; Wed, 21 Aug 2024 02:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724205668; cv=none; b=qmesGcYWkTQ5xYMiq6naNEe3k45Qpxb+VyARNtj2jVNuiimnNyp/nWFTYOFn284INSQnDrGtxF3XSEPsb1LMxPOQEXWytkwRXmvUOUNIF3ReTktyG8t8RijptHUb0IGkrilBOCrOPAmtdux7gY3IKzvDeXa4yJVcEdc6YH948/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724205668; c=relaxed/simple;
	bh=2Q+whA2JQv1gNskvqTn+/STDIjNkhe4ShOJDjICCfWA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=F3euhiq2xlD2vA7e6HwTzmxXYHvgVSXJVVrOoolM9R1t5EnF6R6nPnUksMfi/I/ddjtX6lDZKZ60WWxiGwl6cQVLVKWnTMfMVnI7lHK7sQ/mlrVRn7Bgn4sLowf5V7MP4Qp5RxC56rU5H3m0kh3A6aeKBOZEdBIIgah5pCZgSPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WpTY80DRCz20m2g;
	Wed, 21 Aug 2024 09:40:12 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 458AF14010C;
	Wed, 21 Aug 2024 09:44:53 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 09:44:52 +0800
Subject: Re: [PATCH 2/2] ext4: dax: keep orphan list before truncate overflow
 allocated blocks
To: yangerkun <yangerkun@huaweicloud.com>, <tytso@mit.edu>,
	<adilger.kernel@dilger.ca>, <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <yangerkun@huawei.com>
References: <20240820140657.3685287-1-yangerkun@huaweicloud.com>
 <20240820140657.3685287-2-yangerkun@huaweicloud.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <238e40d0-606f-bb9e-c18c-542df87c1e31@huawei.com>
Date: Wed, 21 Aug 2024 09:44:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240820140657.3685287-2-yangerkun@huaweicloud.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000013.china.huawei.com (7.193.23.81)

ÔÚ 2024/8/20 22:06, yangerkun Ð´µÀ:
> From: yangerkun <yangerkun@huawei.com>
> 
> Any extended write for ext4 requires the inode to be placed on the
> orphan list before the actual write. In addition, the inode can be
> actually removed from the orphan list only after all writes are
> completed. Otherwise, those overcommitted blocks (If the allocated
> blocks are not written due to certain reasons, the inode size does not
> exceed the offset of these blocks) The leak status is always retained,
> and fsck reports an alarm for this scenario.
> 
> Currently, the dio and buffer IO comply with this logic. However, the
> dax write will removed the inode from orphan list since
> ext4_handle_inode_extension is unconditionally called during extend
> write. Fix it with this patch. We open the code from
> ext4_handle_inode_extension since we want to keep the blocks valid
> has been allocated and write success.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> ---
>   fs/ext4/file.c | 35 +++++++++++++++++++++++++++++++----
>   1 file changed, 31 insertions(+), 4 deletions(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index be061bb64067..fd8597eef75e 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -628,11 +628,12 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   static ssize_t
>   ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   {
> -	ssize_t ret;
> +	ssize_t ret, written;
>   	size_t count;
>   	loff_t offset;
>   	handle_t *handle;
>   	bool extend = false;
> +	bool need_trunc = true;
>   	struct inode *inode = file_inode(iocb->ki_filp);
>   
>   	if (iocb->ki_flags & IOCB_NOWAIT) {
> @@ -668,10 +669,36 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   
>   	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
>   
> -	if (extend) {
> -		ret = ext4_handle_inode_extension(inode, offset, ret);
> -		ext4_inode_extension_cleanup(inode, ret < (ssize_t)count);
> +	if (!extend)
> +		goto out;
> +
> +	if (ret <= 0)
> +		goto err_trunc;
> +
> +	written = ret;
> +	handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> +	if (IS_ERR(handle)) {
> +		ret = PTR_ERR(handle);
> +		goto err_trunc;
>   	}
> +
> +	if (ext4_update_inode_size(inode, offset + written)) {
> +		ret = ext4_mark_inode_dirty(handle, inode);
> +		if (unlikely(ret)) {
> +			ext4_journal_stop(handle);
> +			goto err_trunc;
> +		}
> +	}
> +
> +	if (written == count)
> +		need_trunc = false;
> +
> +	if (inode->i_nlink)
> +		ext4_orphan_del(handle, inode);
> +	ext4_journal_stop(handle);
> +	ret = written;
> +err_trunc:
> +	ext4_inode_extension_cleanup(inode, need_trunc);
>   out:
>   	inode_unlock(inode);
>   	if (ret > 0)
> 


