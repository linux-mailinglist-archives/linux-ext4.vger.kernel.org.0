Return-Path: <linux-ext4+bounces-11843-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F97CC557B9
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Nov 2025 03:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1ABD64E1910
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Nov 2025 02:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC4825A321;
	Thu, 13 Nov 2025 02:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="dLGRU0E3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0268A1D5ADE
	for <linux-ext4@vger.kernel.org>; Thu, 13 Nov 2025 02:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763002561; cv=none; b=gK8VYGn4GRIgalRzn3s8cJZQ1nuxrXXt+v95Bkh4+m6WINdC2B5nmwBshY9sld46qvGVHGfLPek8ehuR1HtfsBATVTj/OolV9d1rTRrEFpowNW84WB5TmxvKjHqn0P6HBy3UIBc5tcPn7OO4hSN2wKtU9rLe6W4Mp6/VjuX/fzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763002561; c=relaxed/simple;
	bh=fEVXFUS9yhktyaSOwGe+oi8DW8sT/eekHnHSYErvdqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LisAQd45bIhkpXmBvhWTyxLxoept5nHqZMsnxszvyVb+Kg3BPXiCPOuyWCqk5YL7YePytSFVG95LLWhl4Fn+gIUmnlMKKuo+JcKomo52WWxXrbTXfC3ClVjGhmSRVdOUm96XENpQTRgSm/HzB4+wSAa02PFqIubAnIOgSwW/KWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=dLGRU0E3; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wSSxEyvajw65U+JY9stQSpRefW6ZI44MXlk0pqrXnIU=;
	b=dLGRU0E3p9d3K5LL25Jndfdgtk8P7D236y1a0j6lEX7nhEAWQgKqqFRW4K/0XtrmUeJLnAZJZ
	t++YWTtMFm4mL/DRpRpXWYMxggEYmEg0P9h2LkHU84oRSQuUdnhtcu7HQItb5R0CQ5tvjndhvgx
	LDy41lFIk7cBjW/g26DW640=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4d6PxK5Kqkz1prKm;
	Thu, 13 Nov 2025 10:54:13 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 510BF140258;
	Thu, 13 Nov 2025 10:55:54 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 13 Nov
 2025 10:55:53 +0800
Message-ID: <dddc77d2-0942-45f7-b24c-995a6c749288@huawei.com>
Date: Thu, 13 Nov 2025 10:55:52 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH e2fsprogs] libext2fs: fix orphan file size > kernel limit
 with large blocksize
Content-Language: en-GB
To: "Darrick J. Wong" <djwong@kernel.org>, <libaokun@huaweicloud.com>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<jack@suse.cz>, <yangerkun@huawei.com>
References: <20251112122157.1990595-1-libaokun@huaweicloud.com>
 <20251112183609.GN196358@frogsfrogsfrogs>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251112183609.GN196358@frogsfrogsfrogs>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-11-13 02:36, Darrick J. Wong wrote:
> On Wed, Nov 12, 2025 at 08:21:57PM +0800, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> Kernel commit 0a6ce20c1564 ("ext4: verify orphan file size is not too big")
>> limits the maximum supported orphan file size to 8 << 20.
>>
>> However, in e2fsprogs, the orphan file size is set to 32–512 filesystem
>> blocks when creating a filesystem.
>>
>> With 64k block size, formatting an ext4 fs >32G gives an orphan file bigger
>> than the kernel allows, so mount prints an error and fails:
>>
>>     EXT4-fs (vdb): orphan file too big: 8650752
>>     EXT4-fs (vdb): mount failed
>>
>> Therefore, synchronize the kernel change to e2fsprogs to avoid creating
>> orphan files larger than the kernel limit.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>  lib/ext2fs/ext2fs.h |  2 ++
>>  lib/ext2fs/orphan.c | 12 +++++++-----
>>  2 files changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
>> index bb2170b7..d9df007c 100644
>> --- a/lib/ext2fs/ext2fs.h
>> +++ b/lib/ext2fs/ext2fs.h
>> @@ -1819,6 +1819,8 @@ errcode_t ext2fs_set_data_io(ext2_filsys fs, io_channel new_io);
>>  errcode_t ext2fs_rewrite_to_io(ext2_filsys fs, io_channel new_io);
>>  
>>  /* orphan.c */
>> +#define EXT4_MAX_ORPHAN_FILE_SIZE	8 << 20
>> +#define EXT4_DEFAULT_ORPHAN_FILE_SIZE	2 << 20
> These #defines ought to have parentheses guarding the expression for
> good hygiene.  

Okay, the next version will add it.

> Also, if this is an artifact of the ondisk format, then
> shouldn't it be in ext2_fs.h?  and fs/ext4/ext4.h?

Since it is only used in the two functions ext2fs_create_orphan_file
and ext2fs_default_orphan_file_blocks, I defined it here.

>
>>  extern errcode_t ext2fs_create_orphan_file(ext2_filsys fs, blk_t num_blocks);
>>  extern errcode_t ext2fs_truncate_orphan_file(ext2_filsys fs);
>>  extern e2_blkcnt_t ext2fs_default_orphan_file_blocks(ext2_filsys fs);
>> diff --git a/lib/ext2fs/orphan.c b/lib/ext2fs/orphan.c
>> index 14ac3569..40b1c5c7 100644
>> --- a/lib/ext2fs/orphan.c
>> +++ b/lib/ext2fs/orphan.c
>> @@ -164,6 +164,8 @@ errcode_t ext2fs_create_orphan_file(ext2_filsys fs, blk_t num_blocks)
>>  	memset(zerobuf, 0, fs->blocksize);
>>  	ob_tail = ext2fs_orphan_block_tail(fs, buf);
>>  	ob_tail->ob_magic = ext2fs_cpu_to_le32(EXT4_ORPHAN_BLOCK_MAGIC);
>> +	if (num_blocks * fs->blocksize > EXT4_MAX_ORPHAN_FILE_SIZE)
>> +		num_blocks = EXT4_MAX_ORPHAN_FILE_SIZE / fs->blocksize;
>>  	oi.num_blocks = num_blocks;
>>  	oi.alloc_blocks = 0;
>>  	oi.last_blk = 0;
>> @@ -216,18 +218,18 @@ out:
>>  
>>  /*
>>   * Find reasonable size for orphan file. We choose orphan file size to be
>> - * between 32 and 512 filesystem blocks and not more than 1/4096 of the
>> - * filesystem unless it is really small.
>> + * between 32 filesystem blocks and EXT4_DEFAULT_ORPHAN_FILE_SIZE, and not
>> + * more than 1/fs->blocksize of the filesystem unless it is really small.
>>   */
>>  e2_blkcnt_t ext2fs_default_orphan_file_blocks(ext2_filsys fs)
>>  {
>>  	__u64 num_blocks = ext2fs_blocks_count(fs->super);
>> -	e2_blkcnt_t blks = 512;
>> +	e2_blkcnt_t blks = EXT4_DEFAULT_ORPHAN_FILE_SIZE / fs->blocksize;
>>  
>>  	if (num_blocks < 128 * 1024)
>>  		blks = 32;
>> -	else if (num_blocks < 2 * 1024 * 1024)
>> -		blks = num_blocks / 4096;
>> +	else if (num_blocks < EXT4_DEFAULT_ORPHAN_FILE_SIZE)
>> +		blks = num_blocks / fs->blocksize;
> If the number of blocks in the filesystem is less than the default
> orphan file size in bytes?  I don't understand that logic, particularly
> because EXT4_DEFAULT_ORPHAN_FILE_SIZE == 2<<20 == 2097152 == 2 * 1024 *
> 1024.

If the number of blocks in the filesystem is less than the default
orphan file size in bytes, mke2fs will fail.

However, this situation never actually occurs, because when the filesystem
has fewer than 2048 blocks, mke2fs does not enable the journal, and the
orphan file is only supported once the journal is enabled.


Cheers,
Baokun

>
> --D
>
>>  	return (blks + EXT2FS_CLUSTER_MASK(fs)) & ~EXT2FS_CLUSTER_MASK(fs);
>>  }
>>  
>> -- 
>> 2.46.1
>>
>>


