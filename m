Return-Path: <linux-ext4+bounces-7819-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 916C7AB4BD6
	for <lists+linux-ext4@lfdr.de>; Tue, 13 May 2025 08:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B92D07ABEB4
	for <lists+linux-ext4@lfdr.de>; Tue, 13 May 2025 06:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE331E5B9C;
	Tue, 13 May 2025 06:19:54 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6A01EA7CD
	for <linux-ext4@vger.kernel.org>; Tue, 13 May 2025 06:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747117193; cv=none; b=VzPa1hkddlcnqH4fMtkWnxqoEfVTt034qjDdBnTmStVkRvUawYdQUpmo5d2YLEsfcsQxVqqHITAep2Dl713HAzo3dp4L4yBInC2Np1IYMJ3SF4be3eMtAxsoExix7FVf4DpXGEQxgBKi8VOgxXY45GxOvg1b9ktiQNWjWRaD5Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747117193; c=relaxed/simple;
	bh=hW9rM1H+C9rGj8BwRQzLvcc00+cZUx84VbsN2V86gdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=ATUY6hRrsqrPTJ8nMUQ1K66d1zgA1cFBfZrY4G+HNHP+XL6K1u/7YjYUXD5+AdZhLYIFMpPSunUwgBukQl6eeUTqMWa2IlshRu5xQPsR9EVB3bFDS3k5lmAt3DKETr6En8f/xrO9nIBz3BILvuGU196+fjxh2dHpKS00KkrhBVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZxR9006b3z1R7mS;
	Tue, 13 May 2025 14:17:40 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 91AFA180042;
	Tue, 13 May 2025 14:19:48 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 13 May
 2025 14:19:48 +0800
Message-ID: <12da1e74-84bc-4fba-a40d-49ce39d48e26@huawei.com>
Date: Tue, 13 May 2025 14:19:47 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] jbd2: remove journal_t argument from jbd2_chksum()
To: Eric Biggers <ebiggers@kernel.org>
References: <20250513053809.699974-1-ebiggers@kernel.org>
 <20250513053809.699974-4-ebiggers@kernel.org>
Content-Language: en-US
CC: <linux-ext4@vger.kernel.org>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20250513053809.699974-4-ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/5/13 13:38, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
>
> Since jbd2_chksum() no longer uses its journal_t argument, remove it.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
Looks good, thanks for the patch!

Reviewed-by: Baokun Li <libaokun1@huawei.com>
> ---
>   fs/jbd2/commit.c     |  6 +++---
>   fs/jbd2/journal.c    |  8 ++++----
>   fs/jbd2/recovery.c   | 10 +++++-----
>   include/linux/jbd2.h |  3 +--
>   4 files changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 1c7c49356878..7203d2d2624d 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -97,11 +97,11 @@ static void jbd2_commit_block_csum_set(journal_t *j, struct buffer_head *bh)
>   
>   	h = (struct commit_header *)(bh->b_data);
>   	h->h_chksum_type = 0;
>   	h->h_chksum_size = 0;
>   	h->h_chksum[0] = 0;
> -	csum = jbd2_chksum(j, j->j_csum_seed, bh->b_data, j->j_blocksize);
> +	csum = jbd2_chksum(j->j_csum_seed, bh->b_data, j->j_blocksize);
>   	h->h_chksum[0] = cpu_to_be32(csum);
>   }
>   
>   /*
>    * Done it all: now submit the commit record.  We should have
> @@ -328,12 +328,12 @@ static void jbd2_block_tag_csum_set(journal_t *j, journal_block_tag_t *tag,
>   	if (!jbd2_journal_has_csum_v2or3(j))
>   		return;
>   
>   	seq = cpu_to_be32(sequence);
>   	addr = kmap_local_folio(bh->b_folio, bh_offset(bh));
> -	csum32 = jbd2_chksum(j, j->j_csum_seed, (__u8 *)&seq, sizeof(seq));
> -	csum32 = jbd2_chksum(j, csum32, addr, bh->b_size);
> +	csum32 = jbd2_chksum(j->j_csum_seed, (__u8 *)&seq, sizeof(seq));
> +	csum32 = jbd2_chksum(csum32, addr, bh->b_size);
>   	kunmap_local(addr);
>   
>   	if (jbd2_has_feature_csum3(j))
>   		tag3->t_checksum = cpu_to_be32(csum32);
>   	else
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index a5ccba25ff47..255fa03031d8 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -120,11 +120,11 @@ static __be32 jbd2_superblock_csum(journal_t *j, journal_superblock_t *sb)
>   	__u32 csum;
>   	__be32 old_csum;
>   
>   	old_csum = sb->s_checksum;
>   	sb->s_checksum = 0;
> -	csum = jbd2_chksum(j, ~0, (char *)sb, sizeof(journal_superblock_t));
> +	csum = jbd2_chksum(~0, (char *)sb, sizeof(journal_superblock_t));
>   	sb->s_checksum = old_csum;
>   
>   	return cpu_to_be32(csum);
>   }
>   
> @@ -1000,11 +1000,11 @@ void jbd2_descriptor_block_csum_set(journal_t *j, struct buffer_head *bh)
>   		return;
>   
>   	tail = (struct jbd2_journal_block_tail *)(bh->b_data + j->j_blocksize -
>   			sizeof(struct jbd2_journal_block_tail));
>   	tail->t_checksum = 0;
> -	csum = jbd2_chksum(j, j->j_csum_seed, bh->b_data, j->j_blocksize);
> +	csum = jbd2_chksum(j->j_csum_seed, bh->b_data, j->j_blocksize);
>   	tail->t_checksum = cpu_to_be32(csum);
>   }
>   
>   /*
>    * Return tid of the oldest transaction in the journal and block in the journal
> @@ -1490,11 +1490,11 @@ static int journal_load_superblock(journal_t *journal)
>   
>   	if (be32_to_cpu(sb->s_maxlen) < journal->j_total_len)
>   		journal->j_total_len = be32_to_cpu(sb->s_maxlen);
>   	/* Precompute checksum seed for all metadata */
>   	if (jbd2_journal_has_csum_v2or3(journal))
> -		journal->j_csum_seed = jbd2_chksum(journal, ~0, sb->s_uuid,
> +		journal->j_csum_seed = jbd2_chksum(~0, sb->s_uuid,
>   						   sizeof(sb->s_uuid));
>   	/* After journal features are set, we can compute transaction limits */
>   	jbd2_journal_init_transaction_limits(journal);
>   
>   	if (jbd2_has_feature_fast_commit(journal)) {
> @@ -2336,11 +2336,11 @@ int jbd2_journal_set_features(journal_t *journal, unsigned long compat,
>   	/* If enabling v3 checksums, update superblock and precompute seed */
>   	if (INCOMPAT_FEATURE_ON(JBD2_FEATURE_INCOMPAT_CSUM_V3)) {
>   		sb->s_checksum_type = JBD2_CRC32C_CHKSUM;
>   		sb->s_feature_compat &=
>   			~cpu_to_be32(JBD2_FEATURE_COMPAT_CHECKSUM);
> -		journal->j_csum_seed = jbd2_chksum(journal, ~0, sb->s_uuid,
> +		journal->j_csum_seed = jbd2_chksum(~0, sb->s_uuid,
>   						   sizeof(sb->s_uuid));
>   	}
>   
>   	/* If enabling v1 checksums, downgrade superblock */
>   	if (COMPAT_FEATURE_ON(JBD2_FEATURE_COMPAT_CHECKSUM))
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index c271a050b7e6..cac8c2cd4a92 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -183,11 +183,11 @@ static int jbd2_descriptor_block_csum_verify(journal_t *j, void *buf)
>   
>   	tail = (struct jbd2_journal_block_tail *)((char *)buf +
>   		j->j_blocksize - sizeof(struct jbd2_journal_block_tail));
>   	provided = tail->t_checksum;
>   	tail->t_checksum = 0;
> -	calculated = jbd2_chksum(j, j->j_csum_seed, buf, j->j_blocksize);
> +	calculated = jbd2_chksum(j->j_csum_seed, buf, j->j_blocksize);
>   	tail->t_checksum = provided;
>   
>   	return provided == cpu_to_be32(calculated);
>   }
>   
> @@ -438,11 +438,11 @@ static int jbd2_commit_block_csum_verify(journal_t *j, void *buf)
>   		return 1;
>   
>   	h = buf;
>   	provided = h->h_chksum[0];
>   	h->h_chksum[0] = 0;
> -	calculated = jbd2_chksum(j, j->j_csum_seed, buf, j->j_blocksize);
> +	calculated = jbd2_chksum(j->j_csum_seed, buf, j->j_blocksize);
>   	h->h_chksum[0] = provided;
>   
>   	return provided == cpu_to_be32(calculated);
>   }
>   
> @@ -459,11 +459,11 @@ static bool jbd2_commit_block_csum_verify_partial(journal_t *j, void *buf)
>   
>   	memcpy(tmpbuf, buf, sizeof(struct commit_header));
>   	h = tmpbuf;
>   	provided = h->h_chksum[0];
>   	h->h_chksum[0] = 0;
> -	calculated = jbd2_chksum(j, j->j_csum_seed, tmpbuf, j->j_blocksize);
> +	calculated = jbd2_chksum(j->j_csum_seed, tmpbuf, j->j_blocksize);
>   	kfree(tmpbuf);
>   
>   	return provided == cpu_to_be32(calculated);
>   }
>   
> @@ -476,12 +476,12 @@ static int jbd2_block_tag_csum_verify(journal_t *j, journal_block_tag_t *tag,
>   
>   	if (!jbd2_journal_has_csum_v2or3(j))
>   		return 1;
>   
>   	seq = cpu_to_be32(sequence);
> -	csum32 = jbd2_chksum(j, j->j_csum_seed, (__u8 *)&seq, sizeof(seq));
> -	csum32 = jbd2_chksum(j, csum32, buf, j->j_blocksize);
> +	csum32 = jbd2_chksum(j->j_csum_seed, (__u8 *)&seq, sizeof(seq));
> +	csum32 = jbd2_chksum(csum32, buf, j->j_blocksize);
>   
>   	if (jbd2_has_feature_csum3(j))
>   		return tag3->t_checksum == cpu_to_be32(csum32);
>   	else
>   		return tag->t_checksum == cpu_to_be16(csum32);
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 023e8abdb99a..b04d554e0992 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1764,12 +1764,11 @@ static inline unsigned long jbd2_log_space_left(journal_t *journal)
>   #define BJ_Forget	2	/* Buffer superseded by this transaction */
>   #define BJ_Shadow	3	/* Buffer contents being shadowed to the log */
>   #define BJ_Reserved	4	/* Buffer is reserved for access by journal */
>   #define BJ_Types	5
>   
> -static inline u32 jbd2_chksum(journal_t *journal, u32 crc,
> -			      const void *address, unsigned int length)
> +static inline u32 jbd2_chksum(u32 crc, const void *address, unsigned int length)
>   {
>   	return crc32c(crc, address, length);
>   }
>   
>   /* Return most recent uncommitted transaction */



