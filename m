Return-Path: <linux-ext4+bounces-11400-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E70C2A0A1
	for <lists+linux-ext4@lfdr.de>; Mon, 03 Nov 2025 06:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 810374E3235
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Nov 2025 05:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6E9B652;
	Mon,  3 Nov 2025 05:01:42 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AFC38D
	for <linux-ext4@vger.kernel.org>; Mon,  3 Nov 2025 05:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762146102; cv=none; b=HmO/ML2lyNZvcPuuSi1GKvOSGen8/fEwC9REWEWgg6tnIbLuMHVFJPrP+wt6NSqqWAVkrUC95A+YkMG6+IhcGre/NSClsnihl8sDiXH3RFnypMc4jRxenF2+PkffD7uV8ONHpyVAExkt7JE7aBxeDSlHeQ5zZg+qQSl8BFOSF/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762146102; c=relaxed/simple;
	bh=qr/qVIhWzHAH06ZQI1A1de9zlK+Tt4TVAetjgX02mM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OaCQAECLP7Z3CG8rDHGjLbxpVT2lsETGhn28r/twvC8N5VIRAdqplYv+0uwXavnzZMHJNsKc167CA9ugqKM26wVIbXP4e8lwrUQNv1G67QUgyEZ3+8Uvi6/XESOLXvBW6EsqEgB0lR24iSl6ErVpnioYgcOgoAMt58saheFDQIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d0KDr1cK8zKHMMB
	for <linux-ext4@vger.kernel.org>; Mon,  3 Nov 2025 13:01:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 168C41A0A3B
	for <linux-ext4@vger.kernel.org>; Mon,  3 Nov 2025 13:01:36 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgBHnEQuNwhprNclCg--.34005S3;
	Mon, 03 Nov 2025 13:01:35 +0800 (CST)
Message-ID: <b3ee16de-e04b-4e95-a839-f1563b292bfa@huaweicloud.com>
Date: Mon, 3 Nov 2025 13:01:34 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] ext4: rename EXT4_GET_BLOCKS_PRE_IO
To: Yang Erkun <yangerkun@huawei.com>, linux-ext4@vger.kernel.org,
 tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz
Cc: libaokun1@huawei.com, yangerkun@huaweicloud.com
References: <20251027122303.1146352-1-yangerkun@huawei.com>
 <20251027122303.1146352-2-yangerkun@huawei.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20251027122303.1146352-2-yangerkun@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBHnEQuNwhprNclCg--.34005S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar13CF4fXFWfJrWrCrWDCFg_yoWxJF47pr
	sFvF1xtF4vqa45u34xJF4jqr12vw1xGa1DCFyYg3yYka98tryrKF1YyFyFkFyYgr4rZFs0
	vrWF934DKas3GrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 10/27/2025 8:23 PM, Yang Erkun wrote:
> This flag has been generalized to split an unwritten extent when we do
> dio or dioread_nolock writeback, or to avoid merge new extents which was
> created by extents split. Update some related comments too.
> 
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>

Thanks for the patch! This overall looks good to me besides one nit
below.

> ---
>  fs/ext4/ext4.h              | 21 +++++++++++++++------
>  fs/ext4/extents.c           | 16 ++++++++--------
>  include/trace/events/ext4.h |  2 +-
>  3 files changed, 24 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 57087da6c7be..5a035d0e2761 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -694,13 +694,22 @@ enum {
>  	/* Caller is from the delayed allocation writeout path
>  	 * finally doing the actual allocation of delayed blocks */
>  #define EXT4_GET_BLOCKS_DELALLOC_RESERVE	0x0004
> -	/* caller is from the direct IO path, request to creation of an
> -	unwritten extents if not allocated, split the unwritten
> -	extent if blocks has been preallocated already*/
> -#define EXT4_GET_BLOCKS_PRE_IO			0x0008
> -#define EXT4_GET_BLOCKS_CONVERT			0x0010
> -#define EXT4_GET_BLOCKS_IO_CREATE_EXT		(EXT4_GET_BLOCKS_PRE_IO|\
> +	/*
> +	 * Means we cannot merge new allocated extent or split the unwritten
> +	 * extent if we found one
> +	 */

There is something wrong with this comment, it should be as follows.

This means that we cannot merge newly allocated extents, and if we
found an unwritten extent, we need to split it.

Thanks,
Yi.

> +#define EXT4_GET_BLOCKS_SPLIT_NOMERGE		0x0008
> +	/*
> +	 * Caller is from the dio or dioread_nolock buffer writeback,
> +	 * request to creation of an unwritten extent if not exist or split
> +	 * the found unwritten extent. Also do not merge the new create
> +	 * unwritten extent, io end will convert unwritten to written, and
> +	 * try to merge the written extent.
> +	 */
> +#define EXT4_GET_BLOCKS_IO_CREATE_EXT		(EXT4_GET_BLOCKS_SPLIT_NOMERGE|\
>  					 EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT)
> +	/* Convert unwritten extent to initialized. */
> +#define EXT4_GET_BLOCKS_CONVERT			0x0010
>  	/* Eventual metadata allocation (due to growing extent tree)
>  	 * should not fail, so try to use reserved blocks for that.*/
>  #define EXT4_GET_BLOCKS_METADATA_NOFAIL		0x0020
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index ca5499e9412b..241b5f5d29ad 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -333,7 +333,7 @@ ext4_force_split_extent_at(handle_t *handle, struct inode *inode,
>  			   int nofail)
>  {
>  	int unwritten = ext4_ext_is_unwritten(path[path->p_depth].p_ext);
> -	int flags = EXT4_EX_NOCACHE | EXT4_GET_BLOCKS_PRE_IO;
> +	int flags = EXT4_EX_NOCACHE | EXT4_GET_BLOCKS_SPLIT_NOMERGE;
>  
>  	if (nofail)
>  		flags |= EXT4_GET_BLOCKS_METADATA_NOFAIL | EXT4_EX_NOFAIL;
> @@ -2002,7 +2002,7 @@ ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
>  	}
>  
>  	/* try to insert block into found extent and return */
> -	if (ex && !(gb_flags & EXT4_GET_BLOCKS_PRE_IO)) {
> +	if (ex && !(gb_flags & EXT4_GET_BLOCKS_SPLIT_NOMERGE)) {
>  
>  		/*
>  		 * Try to see whether we should rather test the extent on
> @@ -2181,7 +2181,7 @@ ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
>  
>  merge:
>  	/* try to merge extents */
> -	if (!(gb_flags & EXT4_GET_BLOCKS_PRE_IO))
> +	if (!(gb_flags & EXT4_GET_BLOCKS_SPLIT_NOMERGE))
>  		ext4_ext_try_to_merge(handle, inode, path, nearex);
>  
>  	/* time to correct all indexes above */
> @@ -3224,7 +3224,7 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
>  		else
>  			ext4_ext_mark_initialized(ex);
>  
> -		if (!(flags & EXT4_GET_BLOCKS_PRE_IO))
> +		if (!(flags & EXT4_GET_BLOCKS_SPLIT_NOMERGE))
>  			ext4_ext_try_to_merge(handle, inode, path, ex);
>  
>  		err = ext4_ext_dirty(handle, inode, path + path->p_depth);
> @@ -3368,7 +3368,7 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
>  
>  	if (map->m_lblk + map->m_len < ee_block + ee_len) {
>  		split_flag1 = split_flag & EXT4_EXT_MAY_ZEROOUT;
> -		flags1 = flags | EXT4_GET_BLOCKS_PRE_IO;
> +		flags1 = flags | EXT4_GET_BLOCKS_SPLIT_NOMERGE;
>  		if (unwritten)
>  			split_flag1 |= EXT4_EXT_MARK_UNWRIT1 |
>  				       EXT4_EXT_MARK_UNWRIT2;
> @@ -3739,7 +3739,7 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
>  			      EXT4_EXT_MAY_ZEROOUT : 0;
>  		split_flag |= (EXT4_EXT_MARK_UNWRIT2 | EXT4_EXT_DATA_VALID2);
>  	}
> -	flags |= EXT4_GET_BLOCKS_PRE_IO;
> +	flags |= EXT4_GET_BLOCKS_SPLIT_NOMERGE;
>  	return ext4_split_extent(handle, inode, path, map, split_flag, flags,
>  				 allocated);
>  }
> @@ -3911,7 +3911,7 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  						*allocated, newblock);
>  
>  	/* get_block() before submitting IO, split the extent */
> -	if (flags & EXT4_GET_BLOCKS_PRE_IO) {
> +	if (flags & EXT4_GET_BLOCKS_SPLIT_NOMERGE) {
>  		path = ext4_split_convert_extents(handle, inode, map, path,
>  				flags | EXT4_GET_BLOCKS_CONVERT, allocated);
>  		if (IS_ERR(path))
> @@ -5618,7 +5618,7 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  			path = ext4_split_extent_at(handle, inode, path,
>  					start_lblk, split_flag,
>  					EXT4_EX_NOCACHE |
> -					EXT4_GET_BLOCKS_PRE_IO |
> +					EXT4_GET_BLOCKS_SPLIT_NOMERGE |
>  					EXT4_GET_BLOCKS_METADATA_NOFAIL);
>  		}
>  
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index a374e7ea7e57..ada2b9223df5 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -39,7 +39,7 @@ struct partial_cluster;
>  	{ EXT4_GET_BLOCKS_CREATE,		"CREATE" },		\
>  	{ EXT4_GET_BLOCKS_UNWRIT_EXT,		"UNWRIT" },		\
>  	{ EXT4_GET_BLOCKS_DELALLOC_RESERVE,	"DELALLOC" },		\
> -	{ EXT4_GET_BLOCKS_PRE_IO,		"PRE_IO" },		\
> +	{ EXT4_GET_BLOCKS_SPLIT_NOMERGE,	"SPLIT_NOMERGE" },	\
>  	{ EXT4_GET_BLOCKS_CONVERT,		"CONVERT" },		\
>  	{ EXT4_GET_BLOCKS_METADATA_NOFAIL,	"METADATA_NOFAIL" },	\
>  	{ EXT4_GET_BLOCKS_NO_NORMALIZE,		"NO_NORMALIZE" },	\


