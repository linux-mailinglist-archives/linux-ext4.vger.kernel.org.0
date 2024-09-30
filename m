Return-Path: <linux-ext4+bounces-4380-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8884989947
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 04:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ACB31F2191E
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 02:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019091CD2B;
	Mon, 30 Sep 2024 02:41:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49202904
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 02:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727664064; cv=none; b=MJglizMw5LVtGtKw03cC/yj+clJnyHTNEfo8LKK9s1/dmyuvCK1FjWln+dwXGvf9/+GRtA2NxRrAVP1ws7sWOrdb5M4l+0kH5NoBNi+AxEozpZwJFhKSsQZOeIlfNf2xjvT9A9f+rONtvI2QPvlecEoY+CanbvUzuEDyabzjL8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727664064; c=relaxed/simple;
	bh=lV1SPVa0k+qyz1CqVowIhUj1AtNE3PeW6zZF5ojE9R4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMJfombE9VM4jcs2Hak664qCEjxlmeIoeObQ440cq62DA+aICMuHkxUvrq7CGITFN0/7gfRu9JobcqCDzelytZLWeAH3wHHTyiFmQP+RrUBPIHgqzm4Xh7D4cuKPiEsHE8EXrcqAfnO7jB0SPfJdwusWXYy+GfyH5MLQwUJ1dDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XH50b4qtBz4f3jjy
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 10:40:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1857B1A058E
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 10:40:59 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAXTMi6D_pmaW_zCg--.57521S3;
	Mon, 30 Sep 2024 10:40:58 +0800 (CST)
Message-ID: <5f0ec932-d7b3-4384-b5ed-20f7e116396a@huaweicloud.com>
Date: Mon, 30 Sep 2024 10:40:58 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] jbd2: factor out jbd2_do_replay()
To: Ye Bin <yebin@huaweicloud.com>
Cc: jack@suse.cz, zhangxiaoxu5@huawei.com, tytso@mit.edu,
 adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
References: <20240930005942.626942-1-yebin@huaweicloud.com>
 <20240930005942.626942-5-yebin@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20240930005942.626942-5-yebin@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAXTMi6D_pmaW_zCg--.57521S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GFykCw1UCFyUtr1UCrWxJFb_yoW3JF4fpF
	y5K3s0kryq9r12vF12qFs8XrWI93W0yFyUW3WDuwn3tayqyrnIgw1ktrn8trWYyr9Fv395
	WF4rC34kGwn2yrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1aZX5UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/9/30 8:59, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Factor out jbd2_do_replay() no funtional change.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/recovery.c | 219 +++++++++++++++++++++++----------------------
>  1 file changed, 110 insertions(+), 109 deletions(-)
> 
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index 0d697979d83e..046744d6239c 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -485,6 +485,105 @@ static int jbd2_block_tag_csum_verify(journal_t *j, journal_block_tag_t *tag,
>  		return tag->t_checksum == cpu_to_be16(csum32);
>  }
>  
> +static __always_inline int jbd2_do_replay(journal_t *journal,
> +					  struct recovery_info *info,
> +					  struct buffer_head *bh,
> +					  unsigned long *next_log_block,
> +					  unsigned int next_commit_ID,
> +					  int *success, int *block_error)
> +{
> +	char *tagp;
> +	int flags;
> +	int err;
> +	int tag_bytes = journal_tag_bytes(journal);
> +	int descr_csum_size = 0;
> +	unsigned long io_block;
> +	journal_block_tag_t tag;
> +	struct buffer_head *obh;
> +	struct buffer_head *nbh;
> +
> +	if (jbd2_journal_has_csum_v2or3(journal))
> +		descr_csum_size = sizeof(struct jbd2_journal_block_tail);
> +
> +	tagp = &bh->b_data[sizeof(journal_header_t)];
> +	while (tagp - bh->b_data + tag_bytes <=
> +	       journal->j_blocksize - descr_csum_size) {
> +
> +		memcpy(&tag, tagp, sizeof(tag));
> +		flags = be16_to_cpu(tag.t_flags);
> +
> +		io_block = (*next_log_block)++;
> +		wrap(journal, *next_log_block);
> +		err = jread(&obh, journal, io_block);
> +		if (err) {
> +			/* Recover what we can, but report failure at the end. */
> +			*success = err;
> +			pr_err("JBD2: IO error %d recovering block %lu in log\n",
> +			      err, io_block);
> +		} else {
> +			unsigned long long blocknr;
> +
> +			J_ASSERT(obh != NULL);
> +			blocknr = read_tag_block(journal, &tag);
> +
> +			/* If the block has been revoked, then we're all done here. */
> +			if (jbd2_journal_test_revoke(journal, blocknr,
> +						     next_commit_ID)) {
> +				brelse(obh);
> +				++info->nr_revoke_hits;
> +				goto skip_write;
> +			}
> +
> +			/* Look for block corruption */
> +			if (!jbd2_block_tag_csum_verify(journal, &tag,
> +					(journal_block_tag3_t *)tagp,
> +					obh->b_data, next_commit_ID)) {
> +				brelse(obh);
> +				*success = -EFSBADCRC;
> +				pr_err("JBD2: Invalid checksum recovering data block %llu in journal block %lu\n",
> +				      blocknr, io_block);
> +				*block_error = 1;
> +				goto skip_write;
> +			}
> +
> +			/* Find a buffer for the new data being restored */
> +			nbh = __getblk(journal->j_fs_dev, blocknr,
> +				       journal->j_blocksize);
> +			if (nbh == NULL) {
> +				pr_err("JBD2: Out of memory during recovery.\n");
> +				brelse(obh);
> +				return -ENOMEM;
> +			}
> +
> +			lock_buffer(nbh);
> +			memcpy(nbh->b_data, obh->b_data, journal->j_blocksize);
> +			if (flags & JBD2_FLAG_ESCAPE) {
> +				*((__be32 *)nbh->b_data) =
> +				cpu_to_be32(JBD2_MAGIC_NUMBER);
> +			}
> +
> +			BUFFER_TRACE(nbh, "marking dirty");
> +			set_buffer_uptodate(nbh);
> +			mark_buffer_dirty(nbh);
> +			BUFFER_TRACE(nbh, "marking uptodate");
> +			++info->nr_replays;
> +			unlock_buffer(nbh);
> +			brelse(obh);
> +			brelse(nbh);
> +		}
> +
> +skip_write:
> +		tagp += tag_bytes;
> +		if (!(flags & JBD2_FLAG_SAME_UUID))
> +			tagp += 16;
> +
> +		if (flags & JBD2_FLAG_LAST_TAG)
> +			break;
> +	}
> +
> +	return 0;
> +}
> +
>  static int do_one_pass(journal_t *journal,
>  			struct recovery_info *info, enum passtype pass)
>  {
> @@ -496,9 +595,7 @@ static int do_one_pass(journal_t *journal,
>  	struct buffer_head	*bh = NULL;
>  	unsigned int		sequence;
>  	int			blocktype;
> -	int			tag_bytes = journal_tag_bytes(journal);
>  	__u32			crc32_sum = ~0; /* Transactional Checksums */
> -	int			descr_csum_size = 0;
>  	int			block_error = 0;
>  	bool			need_check_commit_time = false;
>  	__u64			last_trans_commit_time = 0, commit_time;
> @@ -528,12 +625,6 @@ static int do_one_pass(journal_t *journal,
>  	 */
>  
>  	while (1) {
> -		int			flags;
> -		char *			tagp;
> -		journal_block_tag_t	tag;
> -		struct buffer_head *	obh;
> -		struct buffer_head *	nbh;
> -
>  		cond_resched();
>  
>  		/* If we already know where to stop the log traversal,
> @@ -587,11 +678,7 @@ static int do_one_pass(journal_t *journal,
>  		switch(blocktype) {
>  		case JBD2_DESCRIPTOR_BLOCK:
>  			/* Verify checksum first */
> -			if (jbd2_journal_has_csum_v2or3(journal))
> -				descr_csum_size =
> -					sizeof(struct jbd2_journal_block_tail);
> -			if (descr_csum_size > 0 &&
> -			    !jbd2_descriptor_block_csum_verify(journal,
> +			if (!jbd2_descriptor_block_csum_verify(journal,
>  							       bh->b_data)) {
>  				/*
>  				 * PASS_SCAN can see stale blocks due to lazy
> @@ -628,102 +715,16 @@ static int do_one_pass(journal_t *journal,
>  				continue;
>  			}
>  
> -			/* A descriptor block: we can now write all of
> -			 * the data blocks.  Yay, useful work is finally
> -			 * getting done here! */
> -
> -			tagp = &bh->b_data[sizeof(journal_header_t)];
> -			while ((tagp - bh->b_data + tag_bytes)
> -			       <= journal->j_blocksize - descr_csum_size) {
> -				unsigned long io_block;
> -
> -				memcpy(&tag, tagp, sizeof(tag));
> -				flags = be16_to_cpu(tag.t_flags);
> -
> -				io_block = next_log_block++;
> -				wrap(journal, next_log_block);
> -				err = jread(&obh, journal, io_block);
> -				if (err) {
> -					/* Recover what we can, but
> -					 * report failure at the end. */
> -					success = err;
> -					printk(KERN_ERR
> -						"JBD2: IO error %d recovering "
> -						"block %lu in log\n",
> -						err, io_block);
> -				} else {
> -					unsigned long long blocknr;
> -
> -					J_ASSERT(obh != NULL);
> -					blocknr = read_tag_block(journal,
> -								 &tag);
> -
> -					/* If the block has been
> -					 * revoked, then we're all done
> -					 * here. */
> -					if (jbd2_journal_test_revoke
> -					    (journal, blocknr,
> -					     next_commit_ID)) {
> -						brelse(obh);
> -						++info->nr_revoke_hits;
> -						goto skip_write;
> -					}
> -
> -					/* Look for block corruption */
> -					if (!jbd2_block_tag_csum_verify(
> -			journal, &tag, (journal_block_tag3_t *)tagp,
> -			obh->b_data, be32_to_cpu(tmp->h_sequence))) {
> -						brelse(obh);
> -						success = -EFSBADCRC;
> -						printk(KERN_ERR "JBD2: Invalid "
> -						       "checksum recovering "
> -						       "data block %llu in "
> -						       "journal block %lu\n",
> -						       blocknr, io_block);
> -						block_error = 1;
> -						goto skip_write;
> -					}
> -
> -					/* Find a buffer for the new
> -					 * data being restored */
> -					nbh = __getblk(journal->j_fs_dev,
> -							blocknr,
> -							journal->j_blocksize);
> -					if (nbh == NULL) {
> -						printk(KERN_ERR
> -						       "JBD2: Out of memory "
> -						       "during recovery.\n");
> -						err = -ENOMEM;
> -						brelse(obh);
> -						goto failed;
> -					}
> -
> -					lock_buffer(nbh);
> -					memcpy(nbh->b_data, obh->b_data,
> -							journal->j_blocksize);
> -					if (flags & JBD2_FLAG_ESCAPE) {
> -						*((__be32 *)nbh->b_data) =
> -						cpu_to_be32(JBD2_MAGIC_NUMBER);
> -					}
> -
> -					BUFFER_TRACE(nbh, "marking dirty");
> -					set_buffer_uptodate(nbh);
> -					mark_buffer_dirty(nbh);
> -					BUFFER_TRACE(nbh, "marking uptodate");
> -					++info->nr_replays;
> -					unlock_buffer(nbh);
> -					brelse(obh);
> -					brelse(nbh);
> -				}
> -
> -			skip_write:
> -				tagp += tag_bytes;
> -				if (!(flags & JBD2_FLAG_SAME_UUID))
> -					tagp += 16;
> -
> -				if (flags & JBD2_FLAG_LAST_TAG)
> -					break;
> -			}
> +			/*
> +			 * A descriptor block: we can now write all of the
> +			 * data blocks. Yay, useful work is finally getting
> +			 * done here!
> +			 */
> +			err = jbd2_do_replay(journal, info, bh, &next_log_block,
> +					     next_commit_ID, &success,
> +					     &block_error);
> +			if (err)
> +				goto failed;
>  
>  			continue;
>  


