Return-Path: <linux-ext4+bounces-10034-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19555B579C7
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 14:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFD1446751
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 12:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8106A302CD8;
	Mon, 15 Sep 2025 12:03:57 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F222F0C58
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937837; cv=none; b=baXM7YAABMCGtAfhW0faFuOHw57YeamDAga+PBmsUFEmmt6ooGpl+6i88K0JfwWXDGN2DCyiS9/9h7e7VAH+SX+xU+v/xvtgByqIGZtAZHzDPmi5ZnwxwVLmzOKljMxz4FTWyuT+PYuECKKo6efXGctsPYJ1lpjqlguuurUBz78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937837; c=relaxed/simple;
	bh=QRsOtuqMOOBHDflwq4TSn9yNvwmGvGHy5B4jemnEFDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RVB5xNblyHSdqrfmmbykm9Ckgcygbnw26Y/UzxZmP4JszyZL0vttRboXzawXPHxtk8QYDleQMfnW/8iXRDMHLpZa/W77xjRgq3MzAleIv3uJW1SCRid1Ig8Q6E9Rxm3GOrVF/RDdu6fCpOkIYGE9zaUQAtGihrBl7QnSsxfLy3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cQNwk5L9QzYQvjL
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 20:03:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 52AD51A0D24
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 20:03:49 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgB3wY2jAMhoVvNcCg--.112S3;
	Mon, 15 Sep 2025 20:03:49 +0800 (CST)
Message-ID: <36785255-3f1c-46aa-9df3-f43f3b042e40@huaweicloud.com>
Date: Mon, 15 Sep 2025 20:03:47 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG report: an ext4 data corruption issue in nojournal mode
To: Jan Kara <jack@suse.cz>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>,
 "Theodore Y. Ts'o" <tytso@mit.edu>, Andreas Dilger
 <adilger.kernel@dilger.ca>, Zhang Yi <yi.zhang@huawei.com>,
 "Li,Baokun" <libaokun1@huawei.com>, hsiangkao@linux.alibaba.com,
 yangerkun <yangerkun@huawei.com>
References: <a9417096-9549-4441-9878-b1955b899b4e@huaweicloud.com>
 <4uv5ybqymydldxobeiwo2hnbvmoby3fo63rcrl6troy2sefycg@5el5wr6ajjyl>
 <7b0ccbbc-edc1-4123-94b9-fa19f79ea968@huaweicloud.com>
 <mugnb73mvlvclccatavdd2rwczz3wl3gs7rh4kwcnejkdh4t6b@na743yuuidlj>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <mugnb73mvlvclccatavdd2rwczz3wl3gs7rh4kwcnejkdh4t6b@na743yuuidlj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgB3wY2jAMhoVvNcCg--.112S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw1xKw4UtFyUtFyUXr43Wrg_yoW7ZFW7pr
	W5Kay7tr4qy342vrnFqr48tr10vayxuryUGrn8GFnay3y5tr1SgFW7trW09FWqvFs3W3ZI
	qr4UGrykCFn0yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 9/15/2025 6:56 PM, Jan Kara wrote:
> On Sat 13-09-25 11:36:27, Zhang Yi wrote:
>> On 9/12/2025 10:42 PM, Jan Kara wrote:
>>> Hello!
>>>
>>> On Fri 12-09-25 11:28:13, Zhang Yi wrote:
>>>> Gao Xiang recently discovered a data corruption issue in **nojournal**
>>>> mode. After analysis, we found that the problem is after a metadata
>>>> block is freed, it can be immediately reallocated as a data block.
>>>> However, the metadata on this block may still be in the process of being
>>>> written back, which means the new data in this block could potentially
>>>> be overwritten by the stale metadata.
>>>>
>>>> When releasing a metadata block, ext4_forget() calls bforget() in
>>>> nojournal mode, which clears the dirty flag on the buffer_head. If the
>>>> metadata has not yet started to be written back at this point, there is
>>>> no issue. However, if the write-back has already begun but the I/O has
>>>> not yet completed, ext4_forget() will have no effect, and the subsequent
>>>> ext4_mb_clear_bb() will immediately return the block to the mb
>>>> allocator. This block can then be immediately reallocated, potentially
>>>> triggering a data loss issue.
>>>
>>> Yes, I agree this can be a problem.
>>>
>>>> This issue is somewhat related to this patch set[1] that have been
>>>> merged. Before this patch set, clean_bdev_aliases() and
>>>> clean_bdev_bh_alias() could ensure that the dirty flag of the block
>>>> device buffer was cleared and the write-back was completed before using
>>>> newly allocated blocks in most cases. However, this patch set have fixed
>>>> a similar issues in journal mode and removed this safeguard because it's
>>>> fragile and misses some corner cases[2], increasing the likelihood of
>>>> triggering this issue.
>>>
>>> Right.
>>>
>>>> Furthermore, I found that this issue theoretically still appears to
>>>> persist even in **ordered** journal mode. In the final else branch of
>>>> jbd2_journal_forget(), if the metadata block to be released is also
>>>> undergoing a write-back, jbd2_journal_forget() will add this buffer to
>>>> the current transaction for forgetting. Once the current transaction is
>>>> committed, the block can then be reallocated. However, there is no
>>>> guarantee that the ongoing I/O will complete. Typically, the undergoing
>>>> metadata writeback I/O does not take this long to complete, but it might
>>>> be throttled by the block layer or delayed due to anomalies in some slow
>>>> I/O processes in the underlying devices. Therefore, although it is
>>>> difficult to trigger, it theoretically still exists.
>>>
>>> I don't think this can actually happen. For writeback to be happening on a
>>> buffer it still has to be part of a checkpoint list of some transaction.
>>> That means we'll call jbd2_journal_try_remove_checkpoint() which will lock
>>> the buffer and that's enough to make sure the buffer writeback has either
>>> completed or not yet started. If I missed some case, please tell me.
>>>
>>
>> Yes, jbd2_journal_try_remove_checkpoint() does lock the buffer and check
>> the buffer's dirty status under the buffer lock. However. First, it returns
>> immediately if the buffer is locked by the write-back process, which means
>> that it does not wait the write-back to complete, thus, until the current
>> transaction is committed, there is still no guarantee that the I/O will be
>> completed.
> 
> Right, it will return with EBUSY for a buffer under IO, file the buffer to
> BJ_forget list of the running transaction and in principle we're not
> guaranteed IO completes before that transaction commits (although in
> practice that's always true).
> 
>> Second, it unlocks the buffer once it finds the buffer is still
>> dirty, if a concurrent write-back happens just after this unlocking and
>> before clear_buffer_dirty() in jbd2_journal_forget(), the issue can still
>> theoretically happen, right?
> 
> Hum, that as well.
> 
>> It seems that only the follow changes can make sure the buffer writeback has
>> either completed or not yet started (and will never start again). What do
>> you think?
>>
>> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
>> index c7867139af69..e4691e445106 100644
>> --- a/fs/jbd2/transaction.c
>> +++ b/fs/jbd2/transaction.c
>> @@ -1772,23 +1772,26 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
>>  			goto drop;
>>  		}
>>
>> -		/*
>> -		 * Otherwise, if the buffer has been written to disk,
>> -		 * it is safe to remove the checkpoint and drop it.
>> -		 */
>> -		if (jbd2_journal_try_remove_checkpoint(jh) >= 0) {
>> -			spin_unlock(&journal->j_list_lock);
>> -			goto drop;
>> +		lock_buffer(bh);
> 
> We hold j_list_lock and b_state_lock here so you cannot lock the buffer...
> I think we rather need something like:
> 
>                 /*
>                  * Otherwise, if the buffer has been written to disk,
>                  * it is safe to remove the checkpoint and drop it.
>                  */     
>                 if (jbd2_journal_try_remove_checkpoint(jh) >= 0) {
>                         spin_unlock(&journal->j_list_lock);
>                         goto drop;
>                 }
> 
>                 /*
>                  * The buffer is still not written to disk, we should
>                  * attach this buffer to current transaction so that the
>                  * buffer can be checkpointed only after the current
>                  * transaction commits.
>                  */
>                 clear_buffer_dirty(bh);
> +		wait_for_writeback = 1;
> 		__jbd2_journal_file_buffer(jh, transaction, BJ_Forget);
> 		spin_unlock(&journal->j_list_lock);
> 	}
> drop:
> 	__brelse(bh);
> 	spin_unlock(&jh->b_state_lock);
> +	if (wait_for_writeback)
> +		wait_on_buffer(bh);
> 	jbd2_journal_put_journal_head(jh);
> 	if (drop_reserve) {
> ...
> 

Yes, I agree. This is the simplest way to provide a guarantee.

Thanks,
Yi.


