Return-Path: <linux-ext4+bounces-6805-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D8DA627FC
	for <lists+linux-ext4@lfdr.de>; Sat, 15 Mar 2025 08:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A855917D6E7
	for <lists+linux-ext4@lfdr.de>; Sat, 15 Mar 2025 07:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2251B4234;
	Sat, 15 Mar 2025 07:20:09 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA0F178CF8;
	Sat, 15 Mar 2025 07:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742023209; cv=none; b=Axu7pBSXOG688Bmv8J62OLJLqbApMzgzYq28rEHxlIZPB72utALPOMBPRKoyaEuAqOhtTbTdJzFXaNvVPUPPqNaD3DXELTpQLbJE2ZhdCL7Ut2p/LLr8lZdbMQYLLdHMr6jpXxv7SXLz5w8AlmvubbMOpx2bKO1N5kTb4T1UPTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742023209; c=relaxed/simple;
	bh=bZVbzLzMwXRKq07V9dGxpI4b7wzaB4Yw3dvbBcPfBFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sGUBABz4CdiCxv5bSdpKoml8S4DsbNMYiJqYZGm2i9Mq5fpZ2qHMZ3MWEuKFzjGiDFlCNTazSfOv4ZeDOVo9BvnWP8uakUxzrQwhdAJsNdAxZI1WgIvkmvyS9MW9JpOX8ANl3eNuBqcXMIZ0KjCSSIgG6l6hn6fWeq6/Xlbyd44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZFCKk4S02z4f3jdp;
	Sat, 15 Mar 2025 15:19:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 239781A0F17;
	Sat, 15 Mar 2025 15:20:01 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgDXOl8fKtVnBbsxGg--.15547S3;
	Sat, 15 Mar 2025 15:20:00 +0800 (CST)
Message-ID: <134eed9d-7679-4c03-81c0-ec6588ad377b@huaweicloud.com>
Date: Sat, 15 Mar 2025 15:19:59 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: cache es->s_journal_inum in ext4_sb_info
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
 Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>
References: <d1a9328a41029f6210a1924b192a59afcd3c5cee.1741952406.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <d1a9328a41029f6210a1924b192a59afcd3c5cee.1741952406.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDXOl8fKtVnBbsxGg--.15547S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCr4ktr1xury3WFyrGr15urg_yoW7JFW7pr
	Z8CFyxZryUur1Uur4Iqr47ZFyY9ayIk3yjgrnI9r95trW3K342yFyrtF1DJF1DKrWUG3W8
	XF1UC3yUCw1UKrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/3/14 19:41, Ojaswin Mujoo wrote:
> Currently, we access journal ino through sbi->s_es->s_journal_inum,
> which directly reads from the ext4 sb buffer head. If someone modifies
> this underneath us then the s_journal_inum field might get corrupted.
> 
> Although direct block device modifications can be expected to cause
> issues in the FS, let's cache s_journal_inum in sbi->s_journal_ino so
> our checks can be more resillient.
> 
> Suggested-by: Baokun Li <libaokun1@huawei.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  fs/ext4/block_validity.c | 23 ++++++++++++++++-------
>  fs/ext4/ext4.h           |  1 +
>  fs/ext4/inode.c          | 19 +++++++++++++++----
>  fs/ext4/super.c          |  5 ++++-
>  4 files changed, 36 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
> index 87ee3a17bd29..54e6f3499263 100644
> --- a/fs/ext4/block_validity.c
> +++ b/fs/ext4/block_validity.c
> @@ -247,9 +247,9 @@ int ext4_setup_system_zone(struct super_block *sb)
>  		if (ret)
>  			goto err;
>  	}
> -	if (ext4_has_feature_journal(sb) && sbi->s_es->s_journal_inum) {
> +	if (ext4_has_feature_journal(sb) && sbi->s_journal_ino) {
>  		ret = ext4_protect_reserved_inode(sb, system_blks,
> -				le32_to_cpu(sbi->s_es->s_journal_inum));
> +						  sbi->s_journal_ino);
>  		if (ret)
>  			goto err;
>  	}
> @@ -351,11 +351,20 @@ int ext4_check_blockref(const char *function, unsigned int line,
>  {
>  	__le32 *bref = p;
>  	unsigned int blk;
> -
> -	if (ext4_has_feature_journal(inode->i_sb) &&
> -	    (inode->i_ino ==
> -	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
> -		return 0;
> +	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> +
> +	if (ext4_has_feature_journal(inode->i_sb)) {
> +		/* If we are called from journal init path then
> +		 * sbi->s_journal_ino would be 0
> +		 */
> +		u32 journal_ino = sbi->s_journal_ino ?
> +					  sbi->s_journal_ino :
> +					  sbi->s_es->s_journal_inum;
> +		WARN_ON_ONCE(journal_ino == 0);
> +
> +		if (inode->i_ino == journal_ino)
> +			return 0;
> +	}
>  

Hello Ojaswin,

I'd suggested to assign s_journal_ino in ext4_open_inode_journal(), so
that we can drop these two complex code snippets in ext4_check_blockref()
and __check_block_validity().

@@ -5856,6 +5856,7 @@ static journal_t *ext4_open_inode_journal(struct super_block *sb,
                return ERR_CAST(journal);
        }
        journal->j_private = sb;
+       EXT4_SB(sb)->s_journal_ino = journal_inum;
        journal->j_bmap = ext4_journal_bmap;
        ext4_init_journal_params(sb, journal);
        return journal;

Thanks,
Yi.

>  	while (bref < p+max) {
>  		blk = le32_to_cpu(*bref++);
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 2b7d781bfcad..648b0459e9fd 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1556,6 +1556,7 @@ struct ext4_sb_info {
>  	u32 s_max_batch_time;
>  	u32 s_min_batch_time;
>  	struct file *s_journal_bdev_file;
> +	u32 s_journal_ino;
>  #ifdef CONFIG_QUOTA
>  	/* Names of quota files with journalled quota */
>  	char __rcu *s_qf_names[EXT4_MAXQUOTAS];
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 365d31004bd0..50961bc0c94d 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -384,10 +384,21 @@ static int __check_block_validity(struct inode *inode, const char *func,
>  				unsigned int line,
>  				struct ext4_map_blocks *map)
>  {
> -	if (ext4_has_feature_journal(inode->i_sb) &&
> -	    (inode->i_ino ==
> -	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
> -		return 0;
> +	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> +
> +	if (ext4_has_feature_journal(inode->i_sb)) {
> +		/*
> +		 * If we are called from journal init path then
> +		 * sbi->s_journal_ino would be 0
> +		 */
> +		u32 journal_ino = sbi->s_journal_ino ?
> +					  sbi->s_journal_ino :
> +					  sbi->s_es->s_journal_inum;
> +		WARN_ON_ONCE(journal_ino == 0);
> +
> +		if (inode->i_ino == journal_ino)
> +			return 0;
> +	}
>  	if (!ext4_inode_block_valid(inode, map->m_pblk, map->m_len)) {
>  		ext4_error_inode(inode, func, line, map->m_pblk,
>  				 "lblock %lu mapped to illegal pblock %llu "
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index a963ffda692a..44e79db7f12a 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4162,7 +4162,8 @@ int ext4_calculate_overhead(struct super_block *sb)
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  	struct ext4_super_block *es = sbi->s_es;
>  	struct inode *j_inode;
> -	unsigned int j_blocks, j_inum = le32_to_cpu(es->s_journal_inum);
> +	unsigned int j_blocks;
> +	u32 j_inum = sbi->s_journal_ino;
>  	ext4_group_t i, ngroups = ext4_get_groups_count(sb);
>  	ext4_fsblk_t overhead = 0;
>  	char *buf = (char *) get_zeroed_page(GFP_NOFS);
> @@ -6091,6 +6092,8 @@ static int ext4_load_journal(struct super_block *sb,
>  		ext4_commit_super(sb);
>  	}
>  
> +	EXT4_SB(sb)->s_journal_ino = le32_to_cpu(es->s_journal_inum);
> +
>  	return 0;
>  
>  err_out:


