Return-Path: <linux-ext4+bounces-12603-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CC6CFC306
	for <lists+linux-ext4@lfdr.de>; Wed, 07 Jan 2026 07:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF0103020399
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Jan 2026 06:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B492676F4;
	Wed,  7 Jan 2026 06:33:46 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9E617993;
	Wed,  7 Jan 2026 06:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767767626; cv=none; b=EHq9t4tMRo/NwtlL07iUnMqIYfspHZrB9xGgQLrSznMRmZTLtbkOUj0LXPNb5FU9K1u7jp03b2MAZSmgx9c92voGkRX3M5F1K9CBiWwyKNkJXqiCqidhJiFN1DQPj99oSkRBeopOZmDUbmZw/BSBoouuMfMOEf36jhj6BktSH88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767767626; c=relaxed/simple;
	bh=U3tcWrxfimJv1VAWa8ojEZjYyFceAh8v8iKnrkzY+bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mHRQc00ZnA0UM2r1/RCEjjRNbuD2A0OkEBbbUgmsnllmVQxCacTTGJbRUAUVX9OGP8ALVK2G/RG3fTnti8XWUeWcmUa4bVhsAnCItwHWx+ASEpNlkLVnkv2GCtHBH4QHJtItSW3I/0BZ0nVPJuZFxvgcfGpi58yugFrMYhEqHqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dmJBK72k8zKHMgD;
	Wed,  7 Jan 2026 14:32:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DB6794058D;
	Wed,  7 Jan 2026 14:33:38 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP4 (Coremail) with SMTP id gCh0CgDXOPlB_l1pQw+zCw--.25488S3;
	Wed, 07 Jan 2026 14:33:38 +0800 (CST)
Message-ID: <a80035df-1c83-4602-b831-317bc00d1ed6@huaweicloud.com>
Date: Wed, 7 Jan 2026 14:33:36 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] ext4: propagate flags to
 ext4_convert_unwritten_extents_endio()
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Ritesh Harjani <ritesh.list@gmail.com>,
 Jan Kara <jack@suse.cz>, libaokun1@huawei.com, linux-kernel@vger.kernel.org
References: <cover.1767528171.git.ojaswin@linux.ibm.com>
 <25edb28eeba7bea4610b765001d562cf402f1aba.1767528171.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <25edb28eeba7bea4610b765001d562cf402f1aba.1767528171.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDXOPlB_l1pQw+zCw--.25488S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uryrJw1fuFWfJr1UAF1xAFb_yoW8tw45pF
	ZFyF1rCr4Uta4j9ayxAF4UWry2v3W8G3y7ArZ7t34YkasFqr95XF18Ka4FyF1rtay8XF42
	vF4FyryUJ3Z8ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

Hi, Ojaswin!

On 1/4/2026 8:19 PM, Ojaswin Mujoo wrote:
> Currently, callers like ext4_convert_unwritten_extents() pass
> EXT4_EX_NOCACHE flag to avoid caching extents however this is not
> respected by ext4_convert_unwritten_extents_endio(). Hence, modify it to
> accept flags from the caller and to pass the flags on to other extent
> manipulation functions it calls. This makes sure the NOCACHE flag is
> respected throughout the code path.
> 
> Also, since the caller already passes METADATA_NOFAIL and CONVERT flags
> we don't need to explicitly pass it anymore.

Thank you for the refactor! One comment below.

> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  fs/ext4/extents.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 5228196f5ad4..460a70e6dae0 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3785,7 +3785,7 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
>  static struct ext4_ext_path *
>  ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
>  				     struct ext4_map_blocks *map,
> -				     struct ext4_ext_path *path)
> +				     struct ext4_ext_path *path, int flags)
>  {
>  	struct ext4_extent *ex;
>  	ext4_lblk_t ee_block;
> @@ -3802,9 +3802,6 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
>  		  (unsigned long long)ee_block, ee_len);
>  
>  	if (ee_block != map->m_lblk || ee_len > map->m_len) {
> -		int flags = EXT4_GET_BLOCKS_CONVERT |
> -			    EXT4_GET_BLOCKS_METADATA_NOFAIL;
> -
>  		path = ext4_split_convert_extents(handle, inode, map, path,
>  						  flags, NULL);
>  		if (IS_ERR(path))

There is another instance of ext4_find_extent() below that does not respect
the EXT4_EX_NOCACHE flag. I think we should pass the flag as well.

Thanks,
Yi.

> @@ -3943,7 +3940,7 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  	/* IO end_io complete, convert the filled extent to written */
>  	if (flags & EXT4_GET_BLOCKS_CONVERT) {
>  		path = ext4_convert_unwritten_extents_endio(handle, inode,
> -							    map, path);
> +							    map, path, flags);
>  		if (IS_ERR(path))
>  			return path;
>  		ext4_update_inode_fsync_trans(handle, inode, 1);


