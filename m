Return-Path: <linux-ext4+bounces-11402-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FC9C2A2B9
	for <lists+linux-ext4@lfdr.de>; Mon, 03 Nov 2025 07:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FF9A188E963
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Nov 2025 06:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D79028D8D9;
	Mon,  3 Nov 2025 06:24:17 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E8528EA56
	for <linux-ext4@vger.kernel.org>; Mon,  3 Nov 2025 06:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762151057; cv=none; b=e0KRIthZOvcXAMlH2aCkgcpYYkjFOqGuEnsacoE+vDHxYNwceWBooajsdD2xh9CGtPJhCasmmxxWjJbgup8ueMMCLYtZTNncSIj3o+AtDvTRohSeuKH+NiSz5S8f2/MRwoCco4gZIW1tWKfwp9UW1NCau31fh8XCPAfESaBYBuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762151057; c=relaxed/simple;
	bh=ztPw6kNMVyWROBMZDq6n9UcnkSvgvvUPOSC7zjBLz7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lrzBoT4TOf8P7vM2XZBqeeFYkOiFIwHACyDfTUUelmxP3MczGza/mSaY+APFe3lG5SouubtJ1e9gSznMTZCrk0tdIOxAy9OBc9FITXdocTZttCja5TD5q8sRv/qCckG3qMvPfWKXVjh4Gv9DSWuzEaf0qt6Mw+NniniaLJ/7B4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d0M3z1FL8zYQttT
	for <linux-ext4@vger.kernel.org>; Mon,  3 Nov 2025 14:23:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id C5FF01A1A9B
	for <linux-ext4@vger.kernel.org>; Mon,  3 Nov 2025 14:24:11 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgCHK0SLSghpdmUsCg--.13602S3;
	Mon, 03 Nov 2025 14:24:11 +0800 (CST)
Message-ID: <84bbd3c4-032a-4480-8e84-eec06c92cd93@huaweicloud.com>
Date: Mon, 3 Nov 2025 14:24:10 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ext4: order mode should not take effect for DIO
To: Yang Erkun <yangerkun@huawei.com>, linux-ext4@vger.kernel.org,
 tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz
Cc: libaokun1@huawei.com, yangerkun@huaweicloud.com
References: <20251027122303.1146352-1-yangerkun@huawei.com>
 <20251027122303.1146352-4-yangerkun@huawei.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20251027122303.1146352-4-yangerkun@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgCHK0SLSghpdmUsCg--.13602S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw18GFW5ur15tr47KFWDCFg_yoW5XF4DpF
	srAFyxWr40qa15u3yxJF1jqr1xtw1Ika1Dua4Fgw45u345tr1rtF1q9FyrCay5KrWkAws0
	vF1Uu340krs5CrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbiF4tUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 10/27/2025 8:23 PM, Yang Erkun wrote:
> Since the size will be updated after the DIO completes, the data
> will not be shown to userspace before that.
> 
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/ext4.h              | 2 ++
>  fs/ext4/inode.c             | 5 +++--
>  include/trace/events/ext4.h | 1 +
>  3 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 5a035d0e2761..bad43d047224 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -715,6 +715,8 @@ enum {
>  #define EXT4_GET_BLOCKS_METADATA_NOFAIL		0x0020
>  	/* Don't normalize allocation size (used for fallocate) */
>  #define EXT4_GET_BLOCKS_NO_NORMALIZE		0x0040
> +	/* Get blocks from DIO */
> +#define EXT4_GET_BLOCKS_DIO			0x0080
>  	/* Convert written extents to unwritten */
>  #define EXT4_GET_BLOCKS_CONVERT_UNWRITTEN	0x0100
>  	/* Write zeros to newly created written extents */
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 3d8ada26d5cd..168dbcc9e921 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -818,6 +818,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  		if (map->m_flags & EXT4_MAP_NEW &&
>  		    !(map->m_flags & EXT4_MAP_UNWRITTEN) &&
>  		    !(flags & EXT4_GET_BLOCKS_ZERO) &&
> +		    !(flags & EXT4_GET_BLOCKS_DIO) &&
>  		    !ext4_is_quota_file(inode) &&
>  		    ext4_should_order_data(inode)) {
>  			loff_t start_byte =
> @@ -3729,9 +3730,9 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
>  	 * happening and thus expose allocated blocks to direct I/O reads.
>  	 */
>  	else if (((loff_t)map->m_lblk << blkbits) >= i_size_read(inode))
> -		m_flags = EXT4_GET_BLOCKS_CREATE;
> +		m_flags = EXT4_GET_BLOCKS_CREATE | EXT4_GET_BLOCKS_DIO;
>  	else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> -		m_flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;
> +		m_flags = EXT4_GET_BLOCKS_IO_CREATE_EXT | EXT4_GET_BLOCKS_DIO;
>  
>  	if (flags & IOMAP_ATOMIC)
>  		ret = ext4_map_blocks_atomic_write(handle, inode, map, m_flags,
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index ada2b9223df5..de6d848f2e37 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -43,6 +43,7 @@ struct partial_cluster;
>  	{ EXT4_GET_BLOCKS_CONVERT,		"CONVERT" },		\
>  	{ EXT4_GET_BLOCKS_METADATA_NOFAIL,	"METADATA_NOFAIL" },	\
>  	{ EXT4_GET_BLOCKS_NO_NORMALIZE,		"NO_NORMALIZE" },	\
> +	{ EXT4_GET_BLOCKS_DIO,			"DIO" },		\
>  	{ EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,	"CONVERT_UNWRITTEN" },  \
>  	{ EXT4_GET_BLOCKS_ZERO,			"ZERO" },		\
>  	{ EXT4_GET_BLOCKS_IO_SUBMIT,		"IO_SUBMIT" },		\


