Return-Path: <linux-ext4+bounces-7002-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D439AA74299
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Mar 2025 03:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269ED3BFEDF
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Mar 2025 02:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D45020F069;
	Fri, 28 Mar 2025 02:49:24 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7E320E323;
	Fri, 28 Mar 2025 02:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743130163; cv=none; b=MPwq9eVML2WGSmc1HyBy8dKQn10qKElUXhttDunpthUTf4b/D3m0y6Cb6nEcn5JYtyh5X3gkLFTgw//rbI743oRC39QFZ6tPI/M3iGU4knCsfxPV4A2gRYb6zuA10vd2bPKJ2+H213u2SZ1Vw3OUDRZ0sMq1mvfhIAIIfd8JoZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743130163; c=relaxed/simple;
	bh=iJWNsJTPADMcOZPLDPY9tsRmwNLUSzR7d2gKrOxG/ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h54FNHlM37m9hhMIU9ZmRDJvzWd2uCjXzeTWbvfGRRdUtm5Vttzzu0f2PjOeTdsxBcSsiF0v6FZON2fIHr5kzYaJ3cKfhR1pis/MGPyo1R5ptnPUrr1ZPdYV8XDEvrw5+DA+L+plj/iu19hA5HInNY7i2FXUS6CHhu8j36wZ87o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZP4jJ4dybz13LNq;
	Fri, 28 Mar 2025 10:48:52 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 941ED1800E4;
	Fri, 28 Mar 2025 10:49:17 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 28 Mar
 2025 10:49:16 +0800
Message-ID: <2ee12dc5-8170-46ec-a78c-ce0950b9704d@huawei.com>
Date: Fri, 28 Mar 2025 10:49:16 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ext4: Make block validity check resistent to sb bh
 corruption
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
CC: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, Ritesh Harjani
	<ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linux-ext4@vger.kernel.org>, Yang Erkun
	<yangerkun@huawei.com>
References: <c434eb50ee5161e23036d58a6166a7e216f6d6a0.1743097281.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <c434eb50ee5161e23036d58a6166a7e216f6d6a0.1743097281.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/3/28 1:48, Ojaswin Mujoo wrote:
> Block validity checks need to be skipped in case they are called
> for journal blocks since they are part of system's protected
> zone.
>
> Currently, this is done by checking inode->ino against
> sbi->s_es->s_journal_inum, which is a direct read from the ext4 sb
> buffer head. If someone modifies this underneath us then the
> s_journal_inum field might get corrupted. To prevent against this,
> change the check to directly compare the inode with journal->j_inode.
>
> **Slight change in behavior**: During journal init path,
> check_block_validity etc might be called for journal inode when
> sbi->s_journal is not set yet. In this case we now proceed with
> ext4_inode_block_valid() instead of returning early. Since systems zones
> have not been set yet, it is okay to proceed so we can perform basic
> checks on the blocks.
>
> Suggested-by: Baokun Li <libaokun1@huawei.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Thanks for the patch！Looks good to me, except for the extra indentation
pointed out by Honza. With that fixed feel free to add:

Reviewed-by: Baokun Li <libaokun1@huawei.com>


Cheers,
Baokun
> ---
>
> ** Changes since v1 [1] **
>
> - instead of using an sbi field direction check against jorunal->j_inode
> - let block validity perform basic checks on journal blocks as well
> 	during init path
> - kvm-xfstests quick tests are passing
>
> [1] https://lore.kernel.org/linux-ext4/d1a9328a41029f6210a1924b192a59afcd3c5cee.1741952406.git.ojaswin@linux.ibm.com/
>
>   fs/ext4/block_validity.c | 5 ++---
>   fs/ext4/inode.c          | 9 +++++----
>   2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
> index 87ee3a17bd29..e8c5525afc67 100644
> --- a/fs/ext4/block_validity.c
> +++ b/fs/ext4/block_validity.c
> @@ -351,10 +351,9 @@ int ext4_check_blockref(const char *function, unsigned int line,
>   {
>   	__le32 *bref = p;
>   	unsigned int blk;
> +	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
>   
> -	if (ext4_has_feature_journal(inode->i_sb) &&
> -	    (inode->i_ino ==
> -	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
> +	if (journal && inode == journal->j_inode)
>   		return 0;
>   
>   	while (bref < p+max) {
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 365d31004bd0..8b048be14008 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -384,10 +384,11 @@ static int __check_block_validity(struct inode *inode, const char *func,
>   				unsigned int line,
>   				struct ext4_map_blocks *map)
>   {
> -	if (ext4_has_feature_journal(inode->i_sb) &&
> -	    (inode->i_ino ==
> -	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
> -		return 0;
> +	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
> +
> +	if (journal && inode == journal->j_inode)
> +			return 0;
> +
>   	if (!ext4_inode_block_valid(inode, map->m_pblk, map->m_len)) {
>   		ext4_error_inode(inode, func, line, map->m_pblk,
>   				 "lblock %lu mapped to illegal pblock %llu "



