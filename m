Return-Path: <linux-ext4+bounces-2171-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47238B03B2
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Apr 2024 10:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04AD11C231F6
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Apr 2024 08:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1737D158A04;
	Wed, 24 Apr 2024 07:59:42 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87A7158A35;
	Wed, 24 Apr 2024 07:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945581; cv=none; b=tWR23Wh5pW1Mqh+pUTPkfwFvf9N26vKal9bWdX9u8U2tVAyf9WECQVwCm0/Hsw7dKQU4quHzpMW1rEcvwUPxzOX+rY4jO0ltNt1nyPR3A02sfBv469L1bH9UXJ9HAqiGfrwaYBfOQvnw/YrGTVX1j1pLyic38ermQObg+fzJXZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945581; c=relaxed/simple;
	bh=WbWk4n31QeckdqgahpTtUAt10qf6aHsmn+QrC5ik3lE=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Vn0FQNyDwP3G9m6HmNBE3pTivIS0OTSuBl7D2MnE1RBsqT5YMP1zuAZ3A883Rp+dRUtTLe1Ghc9i390jSX/8olUB3sDWYDAl+HYBdOx+s9yKV/d9JeH/FWtdh6n6EjPrIS4TrV2Q40rwhLNcpDuWU15tx5bCptZannYMf4mYe2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VPWXq16YRzNtQC;
	Wed, 24 Apr 2024 15:56:59 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E77E18007D;
	Wed, 24 Apr 2024 15:59:30 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 15:59:30 +0800
Subject: Re: [PATCH v2] jbd2: avoid mount failed when commit block is partial
 submitted
To: Andreas Dilger <adilger@dilger.ca>
References: <20240413013056.1830515-1-yebin10@huawei.com>
 <F8B008EE-22F4-4A3C-A80D-545104520D7D@dilger.ca>
CC: Theodore Ts'o <tytso@mit.edu>, Ext4 Developers List
	<linux-ext4@vger.kernel.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
From: "yebin (H)" <yebin10@huawei.com>
Message-ID: <6628BBE1.7070002@huawei.com>
Date: Wed, 24 Apr 2024 15:59:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <F8B008EE-22F4-4A3C-A80D-545104520D7D@dilger.ca>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500010.china.huawei.com (7.192.105.118)



On 2024/4/14 7:27, Andreas Dilger wrote:
> On Apr 12, 2024, at 7:30 PM, Ye Bin <yebin10@huawei.com> wrote:
>> We encountered a problem that the file system could not be mounted in
>> the power-off scenario. The analysis of the file system mirror shows that
>> only part of the data is written to the last commit block.
>> The valid data of the commit block is concentrated in the first sector.
>> However, the data of the entire block is involved in the checksum calculation.
>> For different hardware, the minimum atomic unit may be different.
>> If the checksum of a committed block is incorrect, clear the data except the
>> 'commit_header' and then calculate the checksum. If the checkusm is correct,
>> it is considered that the block is partially committed.
> I think this is a clever solution to the problem, thanks for submitting
> the patch.
>
>> However, if there are valid description/revoke blocks, it is considered
>> that the data is abnormal and the log replay is stopped.
> It would be possible to use the r_count of records in the revoke block
> to determine how much of the revoke block is unused and could be zeroed
> out to recompute the partial checksum?  That should be relatively safe
> to try, as long as r_count is itself checked to fit within the block
> before the memory is zeroed, to avoid overflowing the temporary buffer size:
>
>         r_count <= journal_revoke_records_per_block(journal)
>
>
> It is open for discussion how much corruption should be allowed in the
> journal, since it can be very destructive to copy corrupted blocks from
> one place in the journal exactly into important metadata blocks across
> the whole filesystem.  That said, the checksums *should* avoid this kind
> of problem, and revoke blocks do not contain "metadata" that is copied
> into the filesystem but only block numbers to skip.  It is "less bad" if
> this was wrong, and having an incomplete journal replay due to minor
> corruption that is causing boot failure is also a problem that should be
> avoided if it can safely be done.
>
>
> Additional comments inline below:
>
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> ---
>> fs/jbd2/recovery.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 48 insertions(+)
>>
>> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
>> index 1f7664984d6e..eb0e026f3109 100644
>> --- a/fs/jbd2/recovery.c
>> +++ b/fs/jbd2/recovery.c
>> @@ -443,6 +443,27 @@ static int jbd2_commit_block_csum_verify(journal_t *j, void *buf)
>> 	return provided == cpu_to_be32(calculated);
>> }
>>
>> +static bool jbd2_commit_block_csum_partial_verify(journal_t *j, void *buf)
>> +{
> (style) if this is named jbd2_commit_block_csum_verify_partial() then
> it would sort together with jbd2_commit_block_csum_verify() and would
> be easier to find with tag completion and grep in the future.
>
>> +	struct commit_header *h;
>> +	__be32 provided;
>> +	__u32 calculated;
>> +	void *tmpbuf;
>> +
>> +	tmpbuf = kzalloc(j->j_blocksize, GFP_KERNEL);
>> +	if (!tmpbuf)
>> +		return false;
>> +
>> +	memcpy(tmpbuf, buf, sizeof(struct commit_header));
>> +	h = tmpbuf;
>> +	provided = h->h_chksum[0];
>> +	h->h_chksum[0] = 0;
>> +	calculated = jbd2_chksum(j, j->j_csum_seed, tmpbuf, j->j_blocksize);
>> +	kfree(tmpbuf);
>> +
>> +	return provided == cpu_to_be32(calculated);
>> +}
>> +
>> static int jbd2_block_tag_csum_verify(journal_t *j, journal_block_tag_t *tag,
>> 				      journal_block_tag3_t *tag3,
>> 				      void *buf, __u32 sequence)
>> @@ -479,6 +500,7 @@ static int do_one_pass(journal_t *journal,
>> 	int			descr_csum_size = 0;
>> 	int			block_error = 0;
>> 	bool			need_check_commit_time = false;
>> +	bool                    has_partial_commit = false;
>> 	__u64			last_trans_commit_time = 0, commit_time;
>>
>> 	/*
>> @@ -590,6 +612,14 @@ static int do_one_pass(journal_t *journal,
>> 					next_log_block);
>> 			}
>>
>> +			if (pass == PASS_SCAN && has_partial_commit) {
>> +				pr_err("JBD2: Detect validate descriptor block %lu after incomplete commit block\n",
> (minor) it isn't clear to me what this error message is trying to say?
> Should it be something like "detected invalid descriptor block ..."?
>
>> +				       next_log_block);
>> +				err = -EFSBADCRC;
>> +				brelse(bh);
>> +				goto failed;
>> +			}
>> +
>> 			/* If it is a valid descriptor block, replay it
>> 			 * in pass REPLAY; if journal_checksums enabled, then
>> 			 * calculate checksums in PASS_SCAN, otherwise,
>> @@ -810,6 +840,14 @@ static int do_one_pass(journal_t *journal,
>> 			if (pass == PASS_SCAN &&
>> 			    !jbd2_commit_block_csum_verify(journal,
>> 							   bh->b_data)) {
>> +				if (jbd2_commit_block_csum_partial_verify(
> If this function was restructured a bit then the code flow would not need
> to get more complex than it already is.  Something like:
>
> 			if (pass == PASS_SCAN &&
> 			    !(jbd2_commit_block_csum_verify(journal,
> 							    bh->b_data) ||
> 			      (has_partial_commit =
> 			       jbd2_commit_block_csum_verify_partial(journal,
> 							    bh->b_data))) {
>
> The pr_notice() can be printed by jbd2_commit_block_csum_partial_verify()
> if the partial checksum is valid, so no need for goto and chksum_ok label.
I modified it according to your idea, and found that the logic will be 
faulty when the checksum
is not enabled.
>
>> +					pr_notice("JBD2: Find incomplete commit block in transaction %u block %lu\n",
>> +						  next_commit_ID, next_log_block);
>> +					has_partial_commit = true;
>> +					goto chksum_ok;
>> +				}
>> 			chksum_error:
>> 				if (commit_time < last_trans_commit_time)
>> 					goto ignore_crc_mismatch;
>> @@ -824,6 +862,7 @@ static int do_one_pass(journal_t *journal,
>> 				}
>> 			}
>> 			if (pass == PASS_SCAN) {
>> +			chksum_ok:
>> 				last_trans_commit_time = commit_time;
>> 				head_block = next_log_block;
>> 			}
>> @@ -843,6 +882,15 @@ static int do_one_pass(journal_t *journal,
>> 					  next_log_block);
>> 				need_check_commit_time = true;
>> 			}
>> +
>> +			if (pass == PASS_SCAN && has_partial_commit) {
>> +				pr_err("JBD2: Detect validate revoke block %lu after incomplete commit block\n",
> Similarly, I find this error message hard to understand.  Maybe "detected invalid revoke block ..."?
>
>> +				       next_log_block);
>> +				err = -EFSBADCRC;
>> +				brelse(bh);
>> +				goto failed;
>> +			}
>> +
>> 			/* If we aren't in the REVOKE pass, then we can
>> 			 * just skip over this block. */
>> 			if (pass != PASS_REVOKE) {
>> --
>> 2.31.1
>>
>
> Cheers, Andreas
>
>
>
>
>


