Return-Path: <linux-ext4+bounces-7818-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B576AB4BD2
	for <lists+linux-ext4@lfdr.de>; Tue, 13 May 2025 08:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7C219E26A9
	for <lists+linux-ext4@lfdr.de>; Tue, 13 May 2025 06:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF70E1C173C;
	Tue, 13 May 2025 06:17:15 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CBB28FD
	for <linux-ext4@vger.kernel.org>; Tue, 13 May 2025 06:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747117035; cv=none; b=MOK5iokB8IIj6A1A53OHi6MfqDgCsjEMZBSzmkY7xu8lZLMUUXDANjNrS/JlsT3E36IM14h2ZeKubHHuUnxcWo2/QNq0zf5dnPK0Sixb1PXlfO3C1WWevLBwWLm7yByZPJ7eHvNDkSi5/oiZixEzr2wIKLhu8hPzu53lShsEuBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747117035; c=relaxed/simple;
	bh=YnXjIoTn1AyLMOO/UFiP5vQPvMlsxwNQ+Esj/jZmlqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:CC:
	 In-Reply-To:Content-Type; b=DnGIJQuhvkP6BB7xcMdHKDC+Dv3PxbRDIL40kTSfO9cb6c/740r4CtXhshSU9HfEPIS+MJLtrjoLMj8bCT5DJia/uLdMeFQKgjvG3RTD8/d/iHD3xMZ8iBESL0ytTlwHEadQdCf00jw1mpNWnmmULErgJThddY+07PKguylkCp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZxR7b2ZDTzsTP0;
	Tue, 13 May 2025 14:16:27 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id EF4E81402C7;
	Tue, 13 May 2025 14:17:09 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 13 May
 2025 14:17:09 +0800
Message-ID: <b66d0e99-5b59-4a91-9b32-3bad3ffc471a@huawei.com>
Date: Tue, 13 May 2025 14:17:08 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] ext4: remove sb argument from ext4_superblock_csum()
To: Eric Biggers <ebiggers@kernel.org>
References: <20250513053809.699974-1-ebiggers@kernel.org>
 <20250513053809.699974-3-ebiggers@kernel.org>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
CC: <linux-ext4@vger.kernel.org>
In-Reply-To: <20250513053809.699974-3-ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/5/13 13:38, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
>
> Since ext4_superblock_csum() no longer uses its sb argument, remove it.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
Good spotting!

Reviewed-by: Baokun Li <libaokun1@huawei.com>
> ---
>   fs/ext4/ext4.h   | 3 +--
>   fs/ext4/ioctl.c  | 4 ++--
>   fs/ext4/resize.c | 2 +-
>   fs/ext4/super.c  | 9 ++++-----
>   4 files changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 5c7a86acbf79..25221c6693b0 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3116,12 +3116,11 @@ extern int ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags,
>   			bh_end_io_t *end_io, bool simu_fail);
>   extern int ext4_read_bh_lock(struct buffer_head *bh, blk_opf_t op_flags, bool wait);
>   extern void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block);
>   extern int ext4_seq_options_show(struct seq_file *seq, void *offset);
>   extern int ext4_calculate_overhead(struct super_block *sb);
> -extern __le32 ext4_superblock_csum(struct super_block *sb,
> -				   struct ext4_super_block *es);
> +extern __le32 ext4_superblock_csum(struct ext4_super_block *es);
>   extern void ext4_superblock_csum_set(struct super_block *sb);
>   extern int ext4_alloc_flex_bg_array(struct super_block *sb,
>   				    ext4_group_t ngroup);
>   extern const char *ext4_decode_error(struct super_block *sb, int errno,
>   				     char nbuf[16]);
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 6b99284095bf..c05eb0efbb95 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -141,19 +141,19 @@ static int ext4_update_backup_sb(struct super_block *sb,
>   	}
>   
>   	es = (struct ext4_super_block *) (bh->b_data + offset);
>   	lock_buffer(bh);
>   	if (ext4_has_feature_metadata_csum(sb) &&
> -	    es->s_checksum != ext4_superblock_csum(sb, es)) {
> +	    es->s_checksum != ext4_superblock_csum(es)) {
>   		ext4_msg(sb, KERN_ERR, "Invalid checksum for backup "
>   		"superblock %llu", sb_block);
>   		unlock_buffer(bh);
>   		goto out_bh;
>   	}
>   	func(es, arg);
>   	if (ext4_has_feature_metadata_csum(sb))
> -		es->s_checksum = ext4_superblock_csum(sb, es);
> +		es->s_checksum = ext4_superblock_csum(es);
>   	set_buffer_uptodate(bh);
>   	unlock_buffer(bh);
>   
>   	if (handle) {
>   		err = ext4_handle_dirty_metadata(handle, NULL, bh);
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index b7ff0d955f0d..050f26168d97 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -1117,11 +1117,11 @@ static inline void ext4_set_block_group_nr(struct super_block *sb, char *data,
>   {
>   	struct ext4_super_block *es = (struct ext4_super_block *) data;
>   
>   	es->s_block_group_nr = cpu_to_le16(group);
>   	if (ext4_has_feature_metadata_csum(sb))
> -		es->s_checksum = ext4_superblock_csum(sb, es);
> +		es->s_checksum = ext4_superblock_csum(es);
>   }
>   
>   /*
>    * Update the backup copies of the ext4 metadata.  These don't need to be part
>    * of the main resize transaction, because e2fsck will re-write them if there
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index d7780269b455..14e47cc2a5a3 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -284,12 +284,11 @@ static int ext4_verify_csum_type(struct super_block *sb,
>   		return 1;
>   
>   	return es->s_checksum_type == EXT4_CRC32C_CHKSUM;
>   }
>   
> -__le32 ext4_superblock_csum(struct super_block *sb,
> -			    struct ext4_super_block *es)
> +__le32 ext4_superblock_csum(struct ext4_super_block *es)
>   {
>   	int offset = offsetof(struct ext4_super_block, s_checksum);
>   	__u32 csum;
>   
>   	csum = ext4_chksum(~0, (char *)es, offset);
> @@ -301,21 +300,21 @@ static int ext4_superblock_csum_verify(struct super_block *sb,
>   				       struct ext4_super_block *es)
>   {
>   	if (!ext4_has_feature_metadata_csum(sb))
>   		return 1;
>   
> -	return es->s_checksum == ext4_superblock_csum(sb, es);
> +	return es->s_checksum == ext4_superblock_csum(es);
>   }
>   
>   void ext4_superblock_csum_set(struct super_block *sb)
>   {
>   	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
>   
>   	if (!ext4_has_feature_metadata_csum(sb))
>   		return;
>   
> -	es->s_checksum = ext4_superblock_csum(sb, es);
> +	es->s_checksum = ext4_superblock_csum(es);
>   }
>   
>   ext4_fsblk_t ext4_block_bitmap(struct super_block *sb,
>   			       struct ext4_group_desc *bg)
>   {
> @@ -5913,11 +5912,11 @@ static struct file *ext4_get_journal_blkdev(struct super_block *sb,
>   		goto out_bh;
>   	}
>   
>   	if ((le32_to_cpu(es->s_feature_ro_compat) &
>   	     EXT4_FEATURE_RO_COMPAT_METADATA_CSUM) &&
> -	    es->s_checksum != ext4_superblock_csum(sb, es)) {
> +	    es->s_checksum != ext4_superblock_csum(es)) {
>   		ext4_msg(sb, KERN_ERR, "external journal has corrupt superblock");
>   		errno = -EFSCORRUPTED;
>   		goto out_bh;
>   	}
>   



