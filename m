Return-Path: <linux-ext4+bounces-11692-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0578C42431
	for <lists+linux-ext4@lfdr.de>; Sat, 08 Nov 2025 02:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C41B3B7EE8
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Nov 2025 01:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E4A28935A;
	Sat,  8 Nov 2025 01:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="T/y2M/ie"
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2040F23C39A
	for <linux-ext4@vger.kernel.org>; Sat,  8 Nov 2025 01:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762566573; cv=none; b=o/3OorkQUL6CDNUBFlbzYADmfxmodcrXPIunF8aLezmIXbJOZU49l4NK7maA+TfFRrGiZRkHIGMwJdRrtZF/dmGLUtlUh6eKQZHvO4EVYfUcU+5W0KJ5SEjpTMkwwIABbyDozcGjwbBqs0UfQenmAXT1NJltZHZV7LUrbxo5aIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762566573; c=relaxed/simple;
	bh=NepWyXYjW9y1q5fMv9vun+EotbTMp22J4lpvz0lL8kI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sNNF1MsBHOAE9daVtQpzQC1flIHuBDa64ko6xxXy56FXNvIn06KlPoozMa6pP/5JLxB9K+fsCg/YkyjYzA5yIhIeIOuiNv8Art6Z5UEwVl29NRMG2vCP0VyjjDPWjpEndyuCLatMypSPRSLyfZ8x0fR1xnIDZYcRLDufoDWD078=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=T/y2M/ie; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from canpmsgout03.his.huawei.com (unknown [172.19.92.159])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4d3Jd75P35zCtZx
	for <linux-ext4@vger.kernel.org>; Sat,  8 Nov 2025 09:44:27 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=NOJ6rILtWCx2hRrmfDbWIsk1Xw2VkeFFpDmWuGe92mw=;
	b=T/y2M/iew9saMc5aeIA/usjjhslicrSYnnxAIt6xHG4elX23BXyfCe36m7huoKiU8Fk7idJuv
	gCFveAkgu0THY1ysNb8MQVuQSgcBHwTghPp8C9WPjgixfr4uVsga3LY+cNG0/2T2V096oZDGGoG
	B6eHX4RE+ZoLhhkHvoUIlXs=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4d3Jhv4LdzzpTL0;
	Sat,  8 Nov 2025 09:47:43 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id EFE2D1400C8;
	Sat,  8 Nov 2025 09:49:18 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 8 Nov
 2025 09:49:17 +0800
Message-ID: <b4808ce1-7b4f-4fc5-bbfd-92871ad89ab9@huawei.com>
Date: Sat, 8 Nov 2025 09:49:16 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] ext4: rename EXT4_GET_BLOCKS_PRE_IO
Content-Language: en-GB
To: Yang Erkun <yangerkun@huawei.com>
CC: <yi.zhang@huawei.com>, <yangerkun@huaweicloud.com>,
	<linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<jack@suse.cz>, Baokun Li <libaokun1@huawei.com>
References: <20251107115810.47199-1-yangerkun@huawei.com>
 <20251107115810.47199-2-yangerkun@huawei.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251107115810.47199-2-yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-11-07 19:58, Yang Erkun wrote:
> This flag has been generalized to split an unwritten extent when we do
> dio or dioread_nolock writeback, or to avoid merge new extents which was
> created by extents split. Update some related comments too.
>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Baokun Li <libaokun1@huawei.com>

> ---
>  fs/ext4/ext4.h              | 21 +++++++++++++++------
>  fs/ext4/extents.c           | 16 ++++++++--------
>  include/trace/events/ext4.h |  2 +-
>  3 files changed, 24 insertions(+), 15 deletions(-)
>
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 57087da6c7be..6ee0bc072589 100644
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
> +	 * This means that we cannot merge newly allocated extents, and if we
> +	 * found an unwritten extent, we need to split it.
> +	 */
> +#define EXT4_GET_BLOCKS_SPLIT_NOMERGE		0x0008
> +	/*
> +	 * Caller is from the dio or dioread_nolock buffered IO, reqest to
> +	 * create an unwritten extent if it does not exist or split the
> +	 * found unwritten extent. Also do not merge the newly created
> +	 * unwritten extent, io end will convert unwritten to written,
> +	 * and try to merge the written extent.
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



