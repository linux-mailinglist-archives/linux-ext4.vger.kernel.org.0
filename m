Return-Path: <linux-ext4+bounces-9991-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F36CCB55E1A
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Sep 2025 05:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A169A0868E
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Sep 2025 03:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D4E1D63C7;
	Sat, 13 Sep 2025 03:36:41 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09528A935
	for <linux-ext4@vger.kernel.org>; Sat, 13 Sep 2025 03:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757734601; cv=none; b=MC0JNofN84xzOGz456nSeXOZdvaV8lMRaF7vKPz5SVx3u9ZjwylI0d3fHEJ+c2E5e/YTXYgHuUkfD87kyQbJuaX3uF395EzfWpUmCelZ5IttcGm/gpAHZEIYzI/QRF/bG78dEyXVd+/1+hv3g68B+H/FDnG+FH8dWfwlsIMm2EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757734601; c=relaxed/simple;
	bh=ur4/kVBdGW/gAlZEazQvqzIBn5/rZv0kAbu/z9eylhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bi+2EgTKE7PhfM9ZWphTypKIxFFKUgRYwlSfij10fFNqI4gf40pw1G6sx1zK4Ogl7op7C92fsXbKioz9gYyqJZ5kSw5cmLDqgPww+FKhR9p7z1nM4fG7GVyellLoqkaWt7apWyf0CHuCAmJEIQhlOHKb0VtXMxmjBB/58HN7Xvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cNxmF25VrzKHMSK
	for <linux-ext4@vger.kernel.org>; Sat, 13 Sep 2025 11:36:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AF65B1A0A24
	for <linux-ext4@vger.kernel.org>; Sat, 13 Sep 2025 11:36:29 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgDXIY675sRof0dRCQ--.63531S3;
	Sat, 13 Sep 2025 11:36:29 +0800 (CST)
Message-ID: <7b0ccbbc-edc1-4123-94b9-fa19f79ea968@huaweicloud.com>
Date: Sat, 13 Sep 2025 11:36:27 +0800
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
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <4uv5ybqymydldxobeiwo2hnbvmoby3fo63rcrl6troy2sefycg@5el5wr6ajjyl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDXIY675sRof0dRCQ--.63531S3
X-Coremail-Antispam: 1UD129KBjvJXoW3XFWruFW8XFyktr48GrWUtwb_yoWxGFWrpr
	WYgF47tr4DG342vwnrXF48Jry0vaykuryUGrW5K3Zay3y5Jr1IqFWxtrWj9FWDZrsagasI
	qr4UKrykCayDAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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

On 9/12/2025 10:42 PM, Jan Kara wrote:
> Hello!
> 
> On Fri 12-09-25 11:28:13, Zhang Yi wrote:
>> Gao Xiang recently discovered a data corruption issue in **nojournal**
>> mode. After analysis, we found that the problem is after a metadata
>> block is freed, it can be immediately reallocated as a data block.
>> However, the metadata on this block may still be in the process of being
>> written back, which means the new data in this block could potentially
>> be overwritten by the stale metadata.
>>
>> When releasing a metadata block, ext4_forget() calls bforget() in
>> nojournal mode, which clears the dirty flag on the buffer_head. If the
>> metadata has not yet started to be written back at this point, there is
>> no issue. However, if the write-back has already begun but the I/O has
>> not yet completed, ext4_forget() will have no effect, and the subsequent
>> ext4_mb_clear_bb() will immediately return the block to the mb
>> allocator. This block can then be immediately reallocated, potentially
>> triggering a data loss issue.
> 
> Yes, I agree this can be a problem.
> 
>> This issue is somewhat related to this patch set[1] that have been
>> merged. Before this patch set, clean_bdev_aliases() and
>> clean_bdev_bh_alias() could ensure that the dirty flag of the block
>> device buffer was cleared and the write-back was completed before using
>> newly allocated blocks in most cases. However, this patch set have fixed
>> a similar issues in journal mode and removed this safeguard because it's
>> fragile and misses some corner cases[2], increasing the likelihood of
>> triggering this issue.
> 
> Right.
> 
>> Furthermore, I found that this issue theoretically still appears to
>> persist even in **ordered** journal mode. In the final else branch of
>> jbd2_journal_forget(), if the metadata block to be released is also
>> undergoing a write-back, jbd2_journal_forget() will add this buffer to
>> the current transaction for forgetting. Once the current transaction is
>> committed, the block can then be reallocated. However, there is no
>> guarantee that the ongoing I/O will complete. Typically, the undergoing
>> metadata writeback I/O does not take this long to complete, but it might
>> be throttled by the block layer or delayed due to anomalies in some slow
>> I/O processes in the underlying devices. Therefore, although it is
>> difficult to trigger, it theoretically still exists.
> 
> I don't think this can actually happen. For writeback to be happening on a
> buffer it still has to be part of a checkpoint list of some transaction.
> That means we'll call jbd2_journal_try_remove_checkpoint() which will lock
> the buffer and that's enough to make sure the buffer writeback has either
> completed or not yet started. If I missed some case, please tell me.
> 

Yes, jbd2_journal_try_remove_checkpoint() does lock the buffer and check
the buffer's dirty status under the buffer lock. However. First, it returns
immediately if the buffer is locked by the write-back process, which means
that it does not wait the write-back to complete, thus, until the current
transaction is committed, there is still no guarantee that the I/O will be
completed. Second, it unlocks the buffer once it finds the buffer is still
dirty, if a concurrent write-back happens just after this unlocking and
before clear_buffer_dirty() in jbd2_journal_forget(), the issue can still
theoretically happen, right?

It seems that only the follow changes can make sure the buffer writeback has
either completed or not yet started (and will never start again). What do
you think?

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index c7867139af69..e4691e445106 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1772,23 +1772,26 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
 			goto drop;
 		}

-		/*
-		 * Otherwise, if the buffer has been written to disk,
-		 * it is safe to remove the checkpoint and drop it.
-		 */
-		if (jbd2_journal_try_remove_checkpoint(jh) >= 0) {
-			spin_unlock(&journal->j_list_lock);
-			goto drop;
+		lock_buffer(bh);
+		if (!buffer_dirty(bh)) {
+			/*
+			 * If the buffer has been written to disk, it is safe
+			 * to remove the checkpoint and drop it.
+			 */
+			unlock_buffer(bh);
+			JBUFFER_TRACE(jh, "remove from checkpoint list");
+			__jbd2_journal_remove_checkpoint(jh);
+		} else {
+			/*
+			 * Otherwise, the buffer is still not written to disk,
+			 * we should attach this buffer to current transaction
+			 * so that the buffer can be checkpointed only after
+			 * the current transaction commits.
+			 */
+			clear_buffer_dirty(bh);
+			unlock_buffer(bh);
+			__jbd2_journal_file_buffer(jh, transaction, BJ_Forget);
 		}
-
-		/*
-		 * The buffer is still not written to disk, we should
-		 * attach this buffer to current transaction so that the
-		 * buffer can be checkpointed only after the current
-		 * transaction commits.
-		 */
-		clear_buffer_dirty(bh);
-		__jbd2_journal_file_buffer(jh, transaction, BJ_Forget);
 		spin_unlock(&journal->j_list_lock);
 	}
 drop:


>> Consider the fix for now. In the **ordered** journal mode, I suppose we
>> can add a wait_on_buffer() during the process of the freed buffer in
>> jbd2_journal_commit_transaction(). This should not significantly impact
>> performance. In **nojorunal** mode, I do not want to reintroduce
>> clean_bdev_aliases(). One approach is to add wait_on_buffer() in
>> __ext4_forget(), but I am concerned that this might impact performance.
>> However, it seems reasonable to wait for ongoing I/O to complete before
>> freeing the buffer.
> 
> I agree calling wait_on_buffer() before calling __bforget() is the best fix
> for the problem in nojournal mode. Yes, it can slow down some cases where
> we free metadata blocks that we recently modified but I think it should be
> relatively rare.
> 

Sure, I will fix it in this way.

Thanks,
Yi.

>> Otherwise, another solution is we may need to
>> implement an asynchronous release process that returns the block to the
>> buddy system only after the I/O operation has completed. However, since
>> the write-back is triggered by bdev, it appears to be hard to implement
>> this solution now. What do people think?
> 
> Yes, that will get rather complicated.
> 
> 								Honza


