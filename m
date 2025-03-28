Return-Path: <linux-ext4+bounces-7001-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5960A74226
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Mar 2025 02:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8997189F72F
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Mar 2025 01:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65FF1C7013;
	Fri, 28 Mar 2025 01:52:43 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2892E189B91;
	Fri, 28 Mar 2025 01:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743126763; cv=none; b=BoRoOsnVhIl0cByQW1bCpGM2w6nTvMhovZD1mSftnAQ/lIqS0aeNJqUPXuoi6eMSh5RSCo7hx+NBZDroBQ2oGn7pztbrEWeXOxhbOPPj+DeNnCLsp3RKhHd08Tgqs5V/WQAQ0aMlOC2fJPCLZjmlRiNlIUCxn4E48w2jXkyVveY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743126763; c=relaxed/simple;
	bh=QLD9RGfyd2zrbv8TRBfjCsGm8iBbrUYkfY1cB3ufAc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z27KofrTHzvmVbXYa8IdkQPtzSLOD9EKFnfu2SUgs3wE7ILBL8h0E5E6ilXcXo0T7n2fvmq794O16zsXTHHB5P3Dnh7ERqsJws5agYneh++w6tPuEfEPuiQas6RfSQv69UJBjKIZgocsc/Kzcx9nqsB6sQ6kW0HtlltfBnz32uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZP3Rn6zBrz4f3m7H;
	Fri, 28 Mar 2025 09:52:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 76CA51A0BBD;
	Fri, 28 Mar 2025 09:52:30 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBHrGDaAOZngr4aHw--.27227S3;
	Fri, 28 Mar 2025 09:52:28 +0800 (CST)
Message-ID: <6203563b-ff13-47b2-b630-d710eab47d62@huaweicloud.com>
Date: Fri, 28 Mar 2025 09:52:26 +0800
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
Cc: Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
 Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
 linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
References: <c434eb50ee5161e23036d58a6166a7e216f6d6a0.1743097281.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <c434eb50ee5161e23036d58a6166a7e216f6d6a0.1743097281.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBHrGDaAOZngr4aHw--.27227S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGr15XFyfCw18XFW5CF1UGFg_yoW5Aw4fp3
	9xCryUXry8uryj9rWIqF47ZFyY9ayxK3yj9rn8Cwn0q398X34xKryrtF4UX3WkKrW8Ga18
	XF1ru3y5CanFkrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Thanks for the inprovement! Besides the indentation that Jan pointed
out, it looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

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
>  fs/ext4/block_validity.c | 5 ++---
>  fs/ext4/inode.c          | 9 +++++----
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
> index 87ee3a17bd29..e8c5525afc67 100644
> --- a/fs/ext4/block_validity.c
> +++ b/fs/ext4/block_validity.c
> @@ -351,10 +351,9 @@ int ext4_check_blockref(const char *function, unsigned int line,
>  {
>  	__le32 *bref = p;
>  	unsigned int blk;
> +	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
>  
> -	if (ext4_has_feature_journal(inode->i_sb) &&
> -	    (inode->i_ino ==
> -	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
> +	if (journal && inode == journal->j_inode)
>  		return 0;
>  
>  	while (bref < p+max) {
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 365d31004bd0..8b048be14008 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -384,10 +384,11 @@ static int __check_block_validity(struct inode *inode, const char *func,
>  				unsigned int line,
>  				struct ext4_map_blocks *map)
>  {
> -	if (ext4_has_feature_journal(inode->i_sb) &&
> -	    (inode->i_ino ==
> -	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
> -		return 0;
> +	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
> +
> +	if (journal && inode == journal->j_inode)
> +			return 0;
> +
>  	if (!ext4_inode_block_valid(inode, map->m_pblk, map->m_len)) {
>  		ext4_error_inode(inode, func, line, map->m_pblk,
>  				 "lblock %lu mapped to illegal pblock %llu "


