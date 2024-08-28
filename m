Return-Path: <linux-ext4+bounces-3927-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D7A961BC8
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Aug 2024 04:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E65D21C23294
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Aug 2024 02:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173963B1A4;
	Wed, 28 Aug 2024 02:07:00 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC69B49644
	for <linux-ext4@vger.kernel.org>; Wed, 28 Aug 2024 02:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724810819; cv=none; b=BNU8UU+B9KVrntnRNNtj/9QnxSEsWFLgB/1PD64iHv0AHIG9/6oCz/v+LYfka/bQzvf5wKXHXVJkvDZvu7wMbeCUeD4CuftDO/n3jiCPpGugJJOWj5KtvieEZRgd/jOo6Trt7q0SMMxs/Z67qAQo5rHpU3CUaUnBW5Cd5PmfKqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724810819; c=relaxed/simple;
	bh=gX57igARrwtMmurHNsP95+hlKliBJy6D1RTFgxhP6ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MCPPhdH7LsDCcPLSYlbV0UIywhJMw1DQ0HgBlAVcJAdtbIVLUqErMAekFsE4vNQYdc1QH/jQ+hXDlkKnhsQii+/kglKchybtSiVn+RqO0On8f4r6x+GzOyBPxWzGvtepll3CTwKbLzwHd35WPg+mrf9mA0sueJLCmM8YT7OonwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WtnpJ458sz4f3kw3
	for <linux-ext4@vger.kernel.org>; Wed, 28 Aug 2024 10:06:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0B4491A0359
	for <linux-ext4@vger.kernel.org>; Wed, 28 Aug 2024 10:06:48 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgAXPoQ2hs5mEo2rCw--.29549S3;
	Wed, 28 Aug 2024 10:06:47 +0800 (CST)
Message-ID: <3e7c14a1-3d9d-ab58-22a4-efc7eb525f23@huaweicloud.com>
Date: Wed, 28 Aug 2024 10:06:46 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/2] ext4: dax: keep orphan list before truncate overflow
 allocated blocks
To: Jan Kara <jack@suse.cz>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 yangerkun@huawei.com, chengzhihao1@huawei.com
References: <20240820140657.3685287-1-yangerkun@huaweicloud.com>
 <20240820140657.3685287-2-yangerkun@huaweicloud.com>
 <20240827170813.twxnsgkqp2vraavz@quack3>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <20240827170813.twxnsgkqp2vraavz@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXPoQ2hs5mEo2rCw--.29549S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4xuFW7AFWkWF47Xr1kXwb_yoWrCrW8pF
	9xGF15GF1vyasF9FZavF1UXF1Fka1xGr47GrWIga47Zr9xCr1ftF1UtFyF9F4YqrW8WF4j
	qF4jyryq9F1DA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2N
	tUUUUU=
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/



在 2024/8/28 1:08, Jan Kara 写道:
> On Tue 20-08-24 22:06:57, yangerkun wrote:
>> From: yangerkun <yangerkun@huawei.com>
> 
> Thanks for debugging this. Couple of spelling fixes first:

Hi,

Thank you for your patient review!

>   
>> Any extended write for ext4 requires the inode to be placed on the
>        ^^^ extending
> 
>> orphan list before the actual write. In addition, the inode can be
>> actually removed from the orphan list only after all writes are
>> completed. Otherwise, those overcommitted blocks (If the allocated
> 	     ^^ I'd phrase this: Otherwise we'd leave allocated blocks
> beyond i_disksize if we could not copy all the data into allocated block
> and e2fsck would complain.
> 
>> blocks are not written due to certain reasons, the inode size does not
>> exceed the offset of these blocks) The leak status is always retained,
>> and fsck reports an alarm for this scenario.
>>
>> Currently, the dio and buffer IO comply with this logic. However, the
> 			 ^^ buffered
> 
> BTW: The only reason why direct IO doesn't have this problem is because
> we don't do short writes for direct IO. We either submit all or we return
> error.

Yeah. In fact, the first version in my mind is same as this, don't do
short write for dax too. But thinking deeper, it seems better to keep
the blocks that has been successfully written...


> 
>> dax write will removed the inode from orphan list since
> 		  ^^^ remove           ^ the orphan ...
> 
>> ext4_handle_inode_extension is unconditionally called during extend
> 								^^ extending
> 
>> write. Fix it with this patch. We open the code from
>> ext4_handle_inode_extension since we want to keep the blocks valid
>> has been allocated and write success.
>>
>> Signed-off-by: yangerkun <yangerkun@huawei.com>
>> ---
>>   fs/ext4/file.c | 35 +++++++++++++++++++++++++++++++----
>>   1 file changed, 31 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
>> index be061bb64067..fd8597eef75e 100644
>> --- a/fs/ext4/file.c
>> +++ b/fs/ext4/file.c
>> @@ -628,11 +628,12 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>   static ssize_t
>>   ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>   {
>> -	ssize_t ret;
>> +	ssize_t ret, written;
>>   	size_t count;
>>   	loff_t offset;
>>   	handle_t *handle;
>>   	bool extend = false;
>> +	bool need_trunc = true;
>>   	struct inode *inode = file_inode(iocb->ki_filp);
>>   
>>   	if (iocb->ki_flags & IOCB_NOWAIT) {
>> @@ -668,10 +669,36 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>   
>>   	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
>>   
>> -	if (extend) {
>> -		ret = ext4_handle_inode_extension(inode, offset, ret);
>> -		ext4_inode_extension_cleanup(inode, ret < (ssize_t)count);
>> +	if (!extend)
>> +		goto out;
>> +
>> +	if (ret <= 0)
>> +		goto err_trunc;
>> +
>> +	written = ret;
>> +	handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
>> +	if (IS_ERR(handle)) {
>> +		ret = PTR_ERR(handle);
>> +		goto err_trunc;
>>   	}
>> +
>> +	if (ext4_update_inode_size(inode, offset + written)) {
>> +		ret = ext4_mark_inode_dirty(handle, inode);
>> +		if (unlikely(ret)) {
>> +			ext4_journal_stop(handle);
>> +			goto err_trunc;
>> +		}
>> +	}
>> +
>> +	if (written == count)
>> +		need_trunc = false;
>> +
>> +	if (inode->i_nlink)
>> +		ext4_orphan_del(handle, inode);
> 
> Why did you keep ext4_orphan_del() here? I thought the whole point of this

Sorry, I make a mistake here, there should be a truncate before. Thanks
for point out this!

> patch is to avoid it? In fact, rather then opencoding
> ext4_handle_inode_extension() I'd add argument to
> ext4_handle_inode_extension() like:
> 
> ext4_handle_inode_extension(inode, pos, written, allocated)
> 
> and remove inode from the orphan list only if written == allocated. The
> call site in ext4_dio_write_end_io() would call:
> 
> 	/*
> 	 * For DIO we don't do partial writes so we must have submitted all
> 	 * that was allocated.
> 	 */
> 	return ext4_handle_inode_extension(inode, pos, size, size);
> 
> and the call site in ext4_dax_write_iter() would call:
> 
> 	ret = ext4_handle_inode_extension(inode, offset, ret, count);
> 
> What do you think?

Great! This seems more clearly and I think it should works too. Whould I
send a v2 patch for this?

Thanks,
Erkun.

> 
> 								Honza


