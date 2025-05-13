Return-Path: <linux-ext4+bounces-7817-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 991DEAB4BC7
	for <lists+linux-ext4@lfdr.de>; Tue, 13 May 2025 08:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1121E19E1D65
	for <lists+linux-ext4@lfdr.de>; Tue, 13 May 2025 06:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67B01E8333;
	Tue, 13 May 2025 06:14:00 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43AE1E5B91
	for <linux-ext4@vger.kernel.org>; Tue, 13 May 2025 06:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747116840; cv=none; b=qHAnUrKWoeigt+vOm1/m9UZYDkbpmJdHIchPk6W5nRqBca9ao6IBK5L8GyJPraXdq14cElaY9RxvP2MgsOYwVIP/f4O6jw/F7jUe3/daSkF4qrlto1culuR496XxDTCq0AXoHxA42aT0vhYDim4b8KCgKxc8ciV3k1PgSPO8KBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747116840; c=relaxed/simple;
	bh=cHPtkZ/MT31uNpLIx8YUHNIE5jEaNjcITIlxPBp5jVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=GyoL7R+6s2yQIknBXxo8UcF63vtJrUt3wZkoMUTw13SWr7g2QBXOkNNrl/pO6rY+56hEUZiH6ChF64M/DncU6MGWO841HiVx1k+hDMNvAvrxMxiQukheqa+QHNUJmWlblnthO+hw2aNKdnedmv1T77aNWX4FcbJPvVgv/O+/tCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZxQzv14sPzQkSD;
	Tue, 13 May 2025 14:09:47 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 54AE818006C;
	Tue, 13 May 2025 14:13:47 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 13 May
 2025 14:13:46 +0800
Message-ID: <6034903c-4664-4f19-8292-64e344b1f7b5@huawei.com>
Date: Tue, 13 May 2025 14:13:46 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ext4: remove sbi argument from ext4_chksum()
To: Eric Biggers <ebiggers@kernel.org>
References: <20250513053809.699974-1-ebiggers@kernel.org>
 <20250513053809.699974-2-ebiggers@kernel.org>
Content-Language: en-US
CC: <linux-ext4@vger.kernel.org>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20250513053809.699974-2-ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/5/13 13:38, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
>
> Since ext4_chksum() no longer uses its sbi argument, remove it.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
Nice cleanup! Looks good to me.

Reviewed-by: Baokun Li <libaokun1@huawei.com>
> ---
>   fs/ext4/bitmap.c      |  8 ++++----
>   fs/ext4/ext4.h        |  3 +--
>   fs/ext4/extents.c     |  3 +--
>   fs/ext4/fast_commit.c | 10 +++++-----
>   fs/ext4/ialloc.c      |  5 ++---
>   fs/ext4/inode.c       | 19 ++++++++-----------
>   fs/ext4/ioctl.c       |  4 ++--
>   fs/ext4/mmp.c         |  2 +-
>   fs/ext4/namei.c       | 10 ++++------
>   fs/ext4/orphan.c      | 13 ++++++-------
>   fs/ext4/super.c       | 13 ++++++-------
>   fs/ext4/xattr.c       | 10 +++++-----
>   12 files changed, 45 insertions(+), 55 deletions(-)
>
> diff --git a/fs/ext4/bitmap.c b/fs/ext4/bitmap.c
> index a4dbaccee6e7..87760fabdd2e 100644
> --- a/fs/ext4/bitmap.c
> +++ b/fs/ext4/bitmap.c
> @@ -28,11 +28,11 @@ int ext4_inode_bitmap_csum_verify(struct super_block *sb,
>   	if (!ext4_has_feature_metadata_csum(sb))
>   		return 1;
>   
>   	sz = EXT4_INODES_PER_GROUP(sb) >> 3;
>   	provided = le16_to_cpu(gdp->bg_inode_bitmap_csum_lo);
> -	calculated = ext4_chksum(sbi, sbi->s_csum_seed, (__u8 *)bh->b_data, sz);
> +	calculated = ext4_chksum(sbi->s_csum_seed, (__u8 *)bh->b_data, sz);
>   	if (sbi->s_desc_size >= EXT4_BG_INODE_BITMAP_CSUM_HI_END) {
>   		hi = le16_to_cpu(gdp->bg_inode_bitmap_csum_hi);
>   		provided |= (hi << 16);
>   	} else
>   		calculated &= 0xFFFF;
> @@ -50,11 +50,11 @@ void ext4_inode_bitmap_csum_set(struct super_block *sb,
>   
>   	if (!ext4_has_feature_metadata_csum(sb))
>   		return;
>   
>   	sz = EXT4_INODES_PER_GROUP(sb) >> 3;
> -	csum = ext4_chksum(sbi, sbi->s_csum_seed, (__u8 *)bh->b_data, sz);
> +	csum = ext4_chksum(sbi->s_csum_seed, (__u8 *)bh->b_data, sz);
>   	gdp->bg_inode_bitmap_csum_lo = cpu_to_le16(csum & 0xFFFF);
>   	if (sbi->s_desc_size >= EXT4_BG_INODE_BITMAP_CSUM_HI_END)
>   		gdp->bg_inode_bitmap_csum_hi = cpu_to_le16(csum >> 16);
>   }
>   
> @@ -69,11 +69,11 @@ int ext4_block_bitmap_csum_verify(struct super_block *sb,
>   
>   	if (!ext4_has_feature_metadata_csum(sb))
>   		return 1;
>   
>   	provided = le16_to_cpu(gdp->bg_block_bitmap_csum_lo);
> -	calculated = ext4_chksum(sbi, sbi->s_csum_seed, (__u8 *)bh->b_data, sz);
> +	calculated = ext4_chksum(sbi->s_csum_seed, (__u8 *)bh->b_data, sz);
>   	if (sbi->s_desc_size >= EXT4_BG_BLOCK_BITMAP_CSUM_HI_END) {
>   		hi = le16_to_cpu(gdp->bg_block_bitmap_csum_hi);
>   		provided |= (hi << 16);
>   	} else
>   		calculated &= 0xFFFF;
> @@ -90,10 +90,10 @@ void ext4_block_bitmap_csum_set(struct super_block *sb,
>   	struct ext4_sb_info *sbi = EXT4_SB(sb);
>   
>   	if (!ext4_has_feature_metadata_csum(sb))
>   		return;
>   
> -	csum = ext4_chksum(sbi, sbi->s_csum_seed, (__u8 *)bh->b_data, sz);
> +	csum = ext4_chksum(sbi->s_csum_seed, (__u8 *)bh->b_data, sz);
>   	gdp->bg_block_bitmap_csum_lo = cpu_to_le16(csum & 0xFFFF);
>   	if (sbi->s_desc_size >= EXT4_BG_BLOCK_BITMAP_CSUM_HI_END)
>   		gdp->bg_block_bitmap_csum_hi = cpu_to_le16(csum >> 16);
>   }
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 5a20e9cd7184..5c7a86acbf79 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2485,12 +2485,11 @@ static inline __le16 ext4_rec_len_to_disk(unsigned len, unsigned blocksize)
>   #define DX_HASH_HALF_MD4_UNSIGNED	4
>   #define DX_HASH_TEA_UNSIGNED		5
>   #define DX_HASH_SIPHASH			6
>   #define DX_HASH_LAST 			DX_HASH_SIPHASH
>   
> -static inline u32 ext4_chksum(struct ext4_sb_info *sbi, u32 crc,
> -			      const void *address, unsigned int length)
> +static inline u32 ext4_chksum(u32 crc, const void *address, unsigned int length)
>   {
>   	return crc32c(crc, address, length);
>   }
>   
>   #ifdef __KERNEL__
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index c616a16a9f36..016ace18f2d1 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -48,14 +48,13 @@
>   
>   static __le32 ext4_extent_block_csum(struct inode *inode,
>   				     struct ext4_extent_header *eh)
>   {
>   	struct ext4_inode_info *ei = EXT4_I(inode);
> -	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>   	__u32 csum;
>   
> -	csum = ext4_chksum(sbi, ei->i_csum_seed, (__u8 *)eh,
> +	csum = ext4_chksum(ei->i_csum_seed, (__u8 *)eh,
>   			   EXT4_EXTENT_TAIL_OFFSET(eh));
>   	return cpu_to_le32(csum);
>   }
>   
>   static int ext4_extent_block_csum_verify(struct inode *inode,
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index da4263a14a20..7d045e630203 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -725,11 +725,11 @@ static u8 *ext4_fc_reserve_space(struct super_block *sb, int len, u32 *crc)
>   
>   	tl.fc_tag = cpu_to_le16(EXT4_FC_TAG_PAD);
>   	tl.fc_len = cpu_to_le16(remaining);
>   	memcpy(dst, &tl, EXT4_FC_TAG_BASE_LEN);
>   	memset(dst + EXT4_FC_TAG_BASE_LEN, 0, remaining);
> -	*crc = ext4_chksum(sbi, *crc, sbi->s_fc_bh->b_data, bsize);
> +	*crc = ext4_chksum(*crc, sbi->s_fc_bh->b_data, bsize);
>   
>   	ext4_fc_submit_bh(sb, false);
>   
>   	ret = jbd2_fc_get_buf(EXT4_SB(sb)->s_journal, &bh);
>   	if (ret)
> @@ -772,11 +772,11 @@ static int ext4_fc_write_tail(struct super_block *sb, u32 crc)
>   	memcpy(dst, &tl, EXT4_FC_TAG_BASE_LEN);
>   	dst += EXT4_FC_TAG_BASE_LEN;
>   	tail.fc_tid = cpu_to_le32(sbi->s_journal->j_running_transaction->t_tid);
>   	memcpy(dst, &tail.fc_tid, sizeof(tail.fc_tid));
>   	dst += sizeof(tail.fc_tid);
> -	crc = ext4_chksum(sbi, crc, sbi->s_fc_bh->b_data,
> +	crc = ext4_chksum(crc, sbi->s_fc_bh->b_data,
>   			  dst - (u8 *)sbi->s_fc_bh->b_data);
>   	tail.fc_crc = cpu_to_le32(crc);
>   	memcpy(dst, &tail.fc_crc, sizeof(tail.fc_crc));
>   	dst += sizeof(tail.fc_crc);
>   	memset(dst, 0, bsize - off); /* Don't leak uninitialized memory. */
> @@ -2103,17 +2103,17 @@ static int ext4_fc_replay_scan(journal_t *journal,
>   		case EXT4_FC_TAG_UNLINK:
>   		case EXT4_FC_TAG_CREAT:
>   		case EXT4_FC_TAG_INODE:
>   		case EXT4_FC_TAG_PAD:
>   			state->fc_cur_tag++;
> -			state->fc_crc = ext4_chksum(sbi, state->fc_crc, cur,
> +			state->fc_crc = ext4_chksum(state->fc_crc, cur,
>   				EXT4_FC_TAG_BASE_LEN + tl.fc_len);
>   			break;
>   		case EXT4_FC_TAG_TAIL:
>   			state->fc_cur_tag++;
>   			memcpy(&tail, val, sizeof(tail));
> -			state->fc_crc = ext4_chksum(sbi, state->fc_crc, cur,
> +			state->fc_crc = ext4_chksum(state->fc_crc, cur,
>   						EXT4_FC_TAG_BASE_LEN +
>   						offsetof(struct ext4_fc_tail,
>   						fc_crc));
>   			if (le32_to_cpu(tail.fc_tid) == expected_tid &&
>   				le32_to_cpu(tail.fc_crc) == state->fc_crc) {
> @@ -2136,11 +2136,11 @@ static int ext4_fc_replay_scan(journal_t *journal,
>   			if (le32_to_cpu(head.fc_tid) != expected_tid) {
>   				ret = JBD2_FC_REPLAY_STOP;
>   				break;
>   			}
>   			state->fc_cur_tag++;
> -			state->fc_crc = ext4_chksum(sbi, state->fc_crc, cur,
> +			state->fc_crc = ext4_chksum(state->fc_crc, cur,
>   				EXT4_FC_TAG_BASE_LEN + tl.fc_len);
>   			break;
>   		default:
>   			ret = state->fc_replay_num_tags ?
>   				JBD2_FC_REPLAY_STOP : -ECANCELED;
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index 38bc8d74f4cc..cfc5e2132996 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -1285,14 +1285,13 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
>   	/* Precompute checksum seed for inode metadata */
>   	if (ext4_has_feature_metadata_csum(sb)) {
>   		__u32 csum;
>   		__le32 inum = cpu_to_le32(inode->i_ino);
>   		__le32 gen = cpu_to_le32(inode->i_generation);
> -		csum = ext4_chksum(sbi, sbi->s_csum_seed, (__u8 *)&inum,
> +		csum = ext4_chksum(sbi->s_csum_seed, (__u8 *)&inum,
>   				   sizeof(inum));
> -		ei->i_csum_seed = ext4_chksum(sbi, csum, (__u8 *)&gen,
> -					      sizeof(gen));
> +		ei->i_csum_seed = ext4_chksum(csum, (__u8 *)&gen, sizeof(gen));
>   	}
>   
>   	ext4_clear_state_flags(ei); /* Only relevant on 32-bit archs */
>   	ext4_set_inode_state(inode, EXT4_STATE_NEW);
>   
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index f386de8c12f6..48c7f8a2d8ed 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -56,33 +56,31 @@ static void ext4_journalled_zero_new_buffers(handle_t *handle,
>   					    unsigned from, unsigned to);
>   
>   static __u32 ext4_inode_csum(struct inode *inode, struct ext4_inode *raw,
>   			      struct ext4_inode_info *ei)
>   {
> -	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>   	__u32 csum;
>   	__u16 dummy_csum = 0;
>   	int offset = offsetof(struct ext4_inode, i_checksum_lo);
>   	unsigned int csum_size = sizeof(dummy_csum);
>   
> -	csum = ext4_chksum(sbi, ei->i_csum_seed, (__u8 *)raw, offset);
> -	csum = ext4_chksum(sbi, csum, (__u8 *)&dummy_csum, csum_size);
> +	csum = ext4_chksum(ei->i_csum_seed, (__u8 *)raw, offset);
> +	csum = ext4_chksum(csum, (__u8 *)&dummy_csum, csum_size);
>   	offset += csum_size;
> -	csum = ext4_chksum(sbi, csum, (__u8 *)raw + offset,
> +	csum = ext4_chksum(csum, (__u8 *)raw + offset,
>   			   EXT4_GOOD_OLD_INODE_SIZE - offset);
>   
>   	if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE) {
>   		offset = offsetof(struct ext4_inode, i_checksum_hi);
> -		csum = ext4_chksum(sbi, csum, (__u8 *)raw +
> -				   EXT4_GOOD_OLD_INODE_SIZE,
> +		csum = ext4_chksum(csum, (__u8 *)raw + EXT4_GOOD_OLD_INODE_SIZE,
>   				   offset - EXT4_GOOD_OLD_INODE_SIZE);
>   		if (EXT4_FITS_IN_INODE(raw, ei, i_checksum_hi)) {
> -			csum = ext4_chksum(sbi, csum, (__u8 *)&dummy_csum,
> +			csum = ext4_chksum(csum, (__u8 *)&dummy_csum,
>   					   csum_size);
>   			offset += csum_size;
>   		}
> -		csum = ext4_chksum(sbi, csum, (__u8 *)raw + offset,
> +		csum = ext4_chksum(csum, (__u8 *)raw + offset,
>   				   EXT4_INODE_SIZE(inode->i_sb) - offset);
>   	}
>   
>   	return csum;
>   }
> @@ -4851,14 +4849,13 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>   	if (ext4_has_feature_metadata_csum(sb)) {
>   		struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>   		__u32 csum;
>   		__le32 inum = cpu_to_le32(inode->i_ino);
>   		__le32 gen = raw_inode->i_generation;
> -		csum = ext4_chksum(sbi, sbi->s_csum_seed, (__u8 *)&inum,
> +		csum = ext4_chksum(sbi->s_csum_seed, (__u8 *)&inum,
>   				   sizeof(inum));
> -		ei->i_csum_seed = ext4_chksum(sbi, csum, (__u8 *)&gen,
> -					      sizeof(gen));
> +		ei->i_csum_seed = ext4_chksum(csum, (__u8 *)&gen, sizeof(gen));
>   	}
>   
>   	if ((!ext4_inode_csum_verify(inode, raw_inode, ei) ||
>   	    ext4_simulate_fail(sb, EXT4_SIM_INODE_CRC)) &&
>   	     (!(EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY))) {
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index d17207386ead..6b99284095bf 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -352,12 +352,12 @@ void ext4_reset_inode_seed(struct inode *inode)
>   	__u32 csum;
>   
>   	if (!ext4_has_feature_metadata_csum(inode->i_sb))
>   		return;
>   
> -	csum = ext4_chksum(sbi, sbi->s_csum_seed, (__u8 *)&inum, sizeof(inum));
> -	ei->i_csum_seed = ext4_chksum(sbi, csum, (__u8 *)&gen, sizeof(gen));
> +	csum = ext4_chksum(sbi->s_csum_seed, (__u8 *)&inum, sizeof(inum));
> +	ei->i_csum_seed = ext4_chksum(csum, (__u8 *)&gen, sizeof(gen));
>   }
>   
>   /*
>    * Swap the information from the given @inode and the inode
>    * EXT4_BOOT_LOADER_INO. It will basically swap i_data and all other
> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
> index 3e26464b1425..51661570cf3b 100644
> --- a/fs/ext4/mmp.c
> +++ b/fs/ext4/mmp.c
> @@ -12,11 +12,11 @@ static __le32 ext4_mmp_csum(struct super_block *sb, struct mmp_struct *mmp)
>   {
>   	struct ext4_sb_info *sbi = EXT4_SB(sb);
>   	int offset = offsetof(struct mmp_struct, mmp_checksum);
>   	__u32 csum;
>   
> -	csum = ext4_chksum(sbi, sbi->s_csum_seed, (char *)mmp, offset);
> +	csum = ext4_chksum(sbi->s_csum_seed, (char *)mmp, offset);
>   
>   	return cpu_to_le32(csum);
>   }
>   
>   static int ext4_mmp_csum_verify(struct super_block *sb, struct mmp_struct *mmp)
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index dda1791e9e1a..5546189c918b 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -344,15 +344,14 @@ static struct ext4_dir_entry_tail *get_dirent_tail(struct inode *inode,
>   	return t;
>   }
>   
>   static __le32 ext4_dirblock_csum(struct inode *inode, void *dirent, int size)
>   {
> -	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>   	struct ext4_inode_info *ei = EXT4_I(inode);
>   	__u32 csum;
>   
> -	csum = ext4_chksum(sbi, ei->i_csum_seed, (__u8 *)dirent, size);
> +	csum = ext4_chksum(ei->i_csum_seed, (__u8 *)dirent, size);
>   	return cpu_to_le32(csum);
>   }
>   
>   #define warn_no_space_for_csum(inode)					\
>   	__warn_no_space_for_csum((inode), __func__, __LINE__)
> @@ -440,21 +439,20 @@ static struct dx_countlimit *get_dx_countlimit(struct inode *inode,
>   }
>   
>   static __le32 ext4_dx_csum(struct inode *inode, struct ext4_dir_entry *dirent,
>   			   int count_offset, int count, struct dx_tail *t)
>   {
> -	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>   	struct ext4_inode_info *ei = EXT4_I(inode);
>   	__u32 csum;
>   	int size;
>   	__u32 dummy_csum = 0;
>   	int offset = offsetof(struct dx_tail, dt_checksum);
>   
>   	size = count_offset + (count * sizeof(struct dx_entry));
> -	csum = ext4_chksum(sbi, ei->i_csum_seed, (__u8 *)dirent, size);
> -	csum = ext4_chksum(sbi, csum, (__u8 *)t, offset);
> -	csum = ext4_chksum(sbi, csum, (__u8 *)&dummy_csum, sizeof(dummy_csum));
> +	csum = ext4_chksum(ei->i_csum_seed, (__u8 *)dirent, size);
> +	csum = ext4_chksum(csum, (__u8 *)t, offset);
> +	csum = ext4_chksum(csum, (__u8 *)&dummy_csum, sizeof(dummy_csum));
>   
>   	return cpu_to_le32(csum);
>   }
>   
>   static int ext4_dx_csum_verify(struct inode *inode,
> diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
> index c66e0cb29bd4..7c7f792ad6ab 100644
> --- a/fs/ext4/orphan.c
> +++ b/fs/ext4/orphan.c
> @@ -539,13 +539,13 @@ static int ext4_orphan_file_block_csum_verify(struct super_block *sb,
>   
>   	if (!ext4_has_feature_metadata_csum(sb))
>   		return 1;
>   
>   	ot = ext4_orphan_block_tail(sb, bh);
> -	calculated = ext4_chksum(EXT4_SB(sb), oi->of_csum_seed,
> -				 (__u8 *)&dsk_block_nr, sizeof(dsk_block_nr));
> -	calculated = ext4_chksum(EXT4_SB(sb), calculated, (__u8 *)bh->b_data,
> +	calculated = ext4_chksum(oi->of_csum_seed, (__u8 *)&dsk_block_nr,
> +				 sizeof(dsk_block_nr));
> +	calculated = ext4_chksum(calculated, (__u8 *)bh->b_data,
>   				 inodes_per_ob * sizeof(__u32));
>   	return le32_to_cpu(ot->ob_checksum) == calculated;
>   }
>   
>   /* This gets called only when checksumming is enabled */
> @@ -558,14 +558,13 @@ void ext4_orphan_file_block_trigger(struct jbd2_buffer_trigger_type *triggers,
>   	int inodes_per_ob = ext4_inodes_per_orphan_block(sb);
>   	struct ext4_orphan_info *oi = &EXT4_SB(sb)->s_orphan_info;
>   	struct ext4_orphan_block_tail *ot;
>   	__le64 dsk_block_nr = cpu_to_le64(bh->b_blocknr);
>   
> -	csum = ext4_chksum(EXT4_SB(sb), oi->of_csum_seed,
> -			   (__u8 *)&dsk_block_nr, sizeof(dsk_block_nr));
> -	csum = ext4_chksum(EXT4_SB(sb), csum, (__u8 *)data,
> -			   inodes_per_ob * sizeof(__u32));
> +	csum = ext4_chksum(oi->of_csum_seed, (__u8 *)&dsk_block_nr,
> +			   sizeof(dsk_block_nr));
> +	csum = ext4_chksum(csum, (__u8 *)data, inodes_per_ob * sizeof(__u32));
>   	ot = ext4_orphan_block_tail(sb, bh);
>   	ot->ob_checksum = cpu_to_le32(csum);
>   }
>   
>   int ext4_init_orphan_info(struct super_block *sb)
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 8122d4ffb3b5..d7780269b455 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -287,15 +287,14 @@ static int ext4_verify_csum_type(struct super_block *sb,
>   }
>   
>   __le32 ext4_superblock_csum(struct super_block *sb,
>   			    struct ext4_super_block *es)
>   {
> -	struct ext4_sb_info *sbi = EXT4_SB(sb);
>   	int offset = offsetof(struct ext4_super_block, s_checksum);
>   	__u32 csum;
>   
> -	csum = ext4_chksum(sbi, ~0, (char *)es, offset);
> +	csum = ext4_chksum(~0, (char *)es, offset);
>   
>   	return cpu_to_le32(csum);
>   }
>   
>   static int ext4_superblock_csum_verify(struct super_block *sb,
> @@ -3207,18 +3206,18 @@ static __le16 ext4_group_desc_csum(struct super_block *sb, __u32 block_group,
>   	if (ext4_has_feature_metadata_csum(sbi->s_sb)) {
>   		/* Use new metadata_csum algorithm */
>   		__u32 csum32;
>   		__u16 dummy_csum = 0;
>   
> -		csum32 = ext4_chksum(sbi, sbi->s_csum_seed, (__u8 *)&le_group,
> +		csum32 = ext4_chksum(sbi->s_csum_seed, (__u8 *)&le_group,
>   				     sizeof(le_group));
> -		csum32 = ext4_chksum(sbi, csum32, (__u8 *)gdp, offset);
> -		csum32 = ext4_chksum(sbi, csum32, (__u8 *)&dummy_csum,
> +		csum32 = ext4_chksum(csum32, (__u8 *)gdp, offset);
> +		csum32 = ext4_chksum(csum32, (__u8 *)&dummy_csum,
>   				     sizeof(dummy_csum));
>   		offset += sizeof(dummy_csum);
>   		if (offset < sbi->s_desc_size)
> -			csum32 = ext4_chksum(sbi, csum32, (__u8 *)gdp + offset,
> +			csum32 = ext4_chksum(csum32, (__u8 *)gdp + offset,
>   					     sbi->s_desc_size - offset);
>   
>   		crc = csum32 & 0xFFFF;
>   		goto out;
>   	}
> @@ -4642,11 +4641,11 @@ static int ext4_init_metadata_csum(struct super_block *sb, struct ext4_super_blo
>   	/* Precompute checksum seed for all metadata */
>   	if (ext4_has_feature_csum_seed(sb))
>   		sbi->s_csum_seed = le32_to_cpu(es->s_checksum_seed);
>   	else if (ext4_has_feature_metadata_csum(sb) ||
>   		 ext4_has_feature_ea_inode(sb))
> -		sbi->s_csum_seed = ext4_chksum(sbi, ~0, es->s_uuid,
> +		sbi->s_csum_seed = ext4_chksum(~0, es->s_uuid,
>   					       sizeof(es->s_uuid));
>   	return 0;
>   }
>   
>   static int ext4_check_feature_compatibility(struct super_block *sb,
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 7ab8f2e8e815..8d15acbacc20 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -137,16 +137,16 @@ static __le32 ext4_xattr_block_csum(struct inode *inode,
>   	__u32 csum;
>   	__le64 dsk_block_nr = cpu_to_le64(block_nr);
>   	__u32 dummy_csum = 0;
>   	int offset = offsetof(struct ext4_xattr_header, h_checksum);
>   
> -	csum = ext4_chksum(sbi, sbi->s_csum_seed, (__u8 *)&dsk_block_nr,
> +	csum = ext4_chksum(sbi->s_csum_seed, (__u8 *)&dsk_block_nr,
>   			   sizeof(dsk_block_nr));
> -	csum = ext4_chksum(sbi, csum, (__u8 *)hdr, offset);
> -	csum = ext4_chksum(sbi, csum, (__u8 *)&dummy_csum, sizeof(dummy_csum));
> +	csum = ext4_chksum(csum, (__u8 *)hdr, offset);
> +	csum = ext4_chksum(csum, (__u8 *)&dummy_csum, sizeof(dummy_csum));
>   	offset += sizeof(dummy_csum);
> -	csum = ext4_chksum(sbi, csum, (__u8 *)hdr + offset,
> +	csum = ext4_chksum(csum, (__u8 *)hdr + offset,
>   			   EXT4_BLOCK_SIZE(inode->i_sb) - offset);
>   
>   	return cpu_to_le32(csum);
>   }
>   
> @@ -346,11 +346,11 @@ xattr_find_entry(struct inode *inode, struct ext4_xattr_entry **pentry,
>   }
>   
>   static u32
>   ext4_xattr_inode_hash(struct ext4_sb_info *sbi, const void *buffer, size_t size)
>   {
> -	return ext4_chksum(sbi, sbi->s_csum_seed, buffer, size);
> +	return ext4_chksum(sbi->s_csum_seed, buffer, size);
>   }
>   
>   static u64 ext4_xattr_inode_get_ref(struct inode *ea_inode)
>   {
>   	return ((u64) inode_get_ctime_sec(ea_inode) << 32) |



