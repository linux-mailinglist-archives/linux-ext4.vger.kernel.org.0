Return-Path: <linux-ext4+bounces-4590-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F15D99FF01
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Oct 2024 04:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E249C1F2211F
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Oct 2024 02:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51286175D20;
	Wed, 16 Oct 2024 02:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="b8iCznUP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DAB5478E;
	Wed, 16 Oct 2024 02:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729046615; cv=none; b=QFwbzwScApnMdo41m06iQUMzzheLXuw8GBIGLrR0iizkC0oI1txUzXH59Y1KXqU7xZk25/B1X6kLviDLk+z+Ean0bhjv8KecLFYgXPfI2WPFJr6kxBWegbBGHXY5I/xTRXV3LQMBJgT9cVpzchSugs5j2qimieKny8qKPqpYmjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729046615; c=relaxed/simple;
	bh=3O/yElZjGAIi3ticrFTy30NfAsaqd+yg6h+CQfmzt9A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=h2M9vw6KRY7goMxSOAZc2I4TGtmlSRp83n5svUcyfhaIeRSYCEycjOhDZrzlleoX4fO3d6hDmigsUWVzjPzvtBpDLGFicUfzaRqt3ptQiQUC7WJlfvEzMp7FV8+3PXAC41du/orwulRLSRFT5TXt8YFViOnH+bdiD1jVVvU13Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=b8iCznUP; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=TfKVBfz07O451M9S6P2LRSSf7pBou61Po8+qv1LZHhQ=;
	b=b8iCznUPyOB6UurV9LepQjv4sKE2TR9JXrZfh1UQDagyhkj0npxYIskB/9yuc7
	wqmUeOdEO+REJxFwbHfyHHNA7Zc+m+hc5cJvSHAjM4Pd6Qoghz1PCpjtlS6VpXw/
	GI3U8O3aNjfLpxjjgi0GpMa7Vq0p/G0z8m+flPqNgIhgI=
Received: from [192.168.22.184] (unknown [223.70.253.255])
	by gzsmtp3 (Coremail) with SMTP id sigvCgA35jAqKA9nECUZAg--.41697S2;
	Wed, 16 Oct 2024 10:42:52 +0800 (CST)
Message-ID: <bd41c24b-7325-4584-a965-392a32e32c74@163.com>
Date: Wed, 16 Oct 2024 10:42:49 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ext4: fix a assertion failure due to ungranted bh
 dirting
From: liubaolin <liubaolin12138@163.com>
To: Jan Kara <jack@suse.cz>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, zhangshida@kylinos.cn,
 longzhi@sangfor.com.cn, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, Baolin Liu <liubaolin@kylinos.cn>
References: <20241010025855.2632516-1-liubaolin12138@163.com>
 <20241010092923.r53povuflevzhxrw@quack3>
 <2635f3f9-86e1-4d09-ad40-4e02ac4447c5@163.com>
In-Reply-To: <2635f3f9-86e1-4d09-ad40-4e02ac4447c5@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:sigvCgA35jAqKA9nECUZAg--.41697S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKr18CFW8Wr48Cr18tr1rCrg_yoWxKFy7pr
	y5KFyrKrZFgFyj9an2qa1jqFyj9w1kKrWUGFWfGryjv398WFn2qFW8tr98AF4qyrZ3Ww18
	Zr4UCr9I93WYv37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UsvttUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbBDhN6ymcPJDV2TQAAsv

> Greetings，
> Regarding this issue, 
> I was able to reproduce it quickly by injecting faults via module parameter passing in fsstest while testing simultaneously. 
> And we tested that neither get access nor clear new would reproduce the issue after injecting faults. 
> Could you please take a look at which approach, get access or clear new, is better? 
> 
> The fsstress testing and injection fault command are as follows:
> fsstress_arm -d "/fsstress_dir2/" -l 102400 -n 100 -p 128 -r -S -s 10 -c 
> watch -n 1 "echo  1  > /sys/module/ext4/parameters/inject_fault"
> 
> The injected fault test is modified as follows, 
> where the module parameter inject_fault injects the fault, 
> and the module parameter try_fix selects whether to handle the fault by getting access or clearing the new:
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index b231cd437..590f84391 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -50,6 +50,12 @@
>  
>  #define MPAGE_DA_EXTENT_TAIL 0x01
>  
> +static int ext4_inject_fault __read_mostly;
> +module_param_named(inject_fault, ext4_inject_fault, int, 0644);
> +static int ext4_try_fix __read_mostly;
> +module_param_named(try_fix, ext4_try_fix, int, 0644);
> +
> +
>  static void ext4_journalled_zero_new_buffers(handle_t *handle,
>  					     struct page *page,
>  					     unsigned int from, unsigned int to);
> @@ -1065,6 +1071,12 @@ int ext4_block_write_begin(handle_t *handle, struct page *page, loff_t pos, unsi
>  			clear_buffer_new(bh);
>  		if (!buffer_mapped(bh)) {
>  			WARN_ON(bh->b_size != blocksize);
> +			if (unlikely(ext4_inject_fault)) {
> +				ext4_inject_fault = 0;
> +				ext4_warning(inode->i_sb, "XXX inject fault get_block return -ENOSPC\n");
> +				err = -ENOSPC;
> +				break;
> +			}
>  			err = get_block(inode, block, bh, 1);
>  			if (err)
>  				break;
> @@ -1116,10 +1128,31 @@ int ext4_block_write_begin(handle_t *handle, struct page *page, loff_t pos, unsi
>  			err = -EIO;
>  	}
>  	if (unlikely(err))
> -		if (should_journal_data)
> +		if (should_journal_data) {
> +			if(bh != head || !block_start) {
> +				do {
> +					block_end = block_start + bh->b_size;
> +
> +					if (buffer_new(bh))
> +						if (block_end > from && block_start < to) {
> +							if (ext4_try_fix == 1) {
> +								ext4_warning(inode->i_sb, "XXX try fix 1\n");
> +								do_journal_get_write_access(handle,
> +											    bh);
> +							} else if (ext4_try_fix == 2) {
> +								ext4_warning(inode->i_sb, "XXX try fix 2\n");
> +								clear_buffer_new(bh);
> +							}
> +						}
> +
> +					block_start = block_end;
> +					bh = bh->b_this_page;
> +				} while (bh != head);
> +			}
> +
>  			ext4_journalled_zero_new_buffers(handle, page, from,
>  							 to);
> -		else
> +		} else
>  			page_zero_new_buffers(page, from, to);
>  	else if (decrypt)
>  		err = fscrypt_decrypt_page(page->mapping->host, page,


在 2024/10/11 14:18, liubaolin 写道:
>> Greetings，
>> This problem is reproduced by our customer using their own testing 
>> tool “run_bug”.
>> When I consulted with a client, the testing tool “run_bug” used a 
>> variety of background programs to benchmark (including memory 
>> pressure, cpu pressure, file cycle manipulation, fsstress Stress 
>> testing tool, postmark program，and so on).
>> The recurrence probability is relatively low.
>>
>> In response to your query, in ext4_block_write_begin, the new state 
>> will be clear before get block, and the bh that failed get_block will 
>> not be set to new.
>> However, when the page size is greater than the block size, a page 
>> will contain multiple bh. bh->b_this_page is a circular list for 
>> managing all bh on the same page.
>> After get_block jumps out of the for loop, then bh->b_this_page is not 
>> processed by clear new in the for loop.
>> So after calling ext4_journalled_zero_new_buffers,
>> The ext4_journalled_zero_new_buffers function will determine all bh of 
>> the same page and call write_end_fn if they are in new state,
>> get_block returns err's bh->b_this_page and circular list other 
>> unhandled bh if the state was previously set to new.
>> Because bh not get access, the corresponding transaction is not placed 
>> in jh->b_transaction, resulting in a crash.
>>
>> Therefore, the patch processing method I submit is to make unprocessed 
>> bh determines if it is in new state and get access.
>> There is another way to handle the remaining bh clear_buffer_new that 
>> is not processed.
>> I personally recommend get access this way, the impact is small. 
>> Please guide the two processing methods, which one do you recommend?
> 
> 
> 
> 在 2024/10/10 17:29, Jan Kara 写道:
>> On Thu 10-10-24 10:58:55, Baolin Liu wrote:
>>> From: Baolin Liu <liubaolin@kylinos.cn>
>>>
>>> Since the merge of commit 3910b513fcdf ("ext4: persist the new uptodate
>>> buffers in ext4_journalled_zero_new_buffers"), a new assertion failure
>>> occurred under a old kernel(ext3, data=journal, pagesize=64k) with
>>> corresponding ported patches:
>> ...
>>> which was caused by bh dirting without calling
>>> do_journal_get_write_access().
>>>
>>> In the loop for all bhs of a page in ext4_block_write_begin(),
>>> when a err occurred, it will jump out of loop.
>>> But that will leaves some bhs being processed and some not,
>>> which will lead to the asserion failure in calling write_end_fn().
>>
>> Thanks for the patch but I don't understand one thing here: For
>> ext4_journalled_zero_new_buffers() to call write_end_fn() the buffer must
>> have buffer_new flag set. That flag can get set only by ext4_get_block()
>> function when it succeeds in which case we also call
>> do_journal_get_write_access(). So how is it possible that buffer_new was
>> set on a buffer on which we didn't call do_journal_get_write_access()? 
>> This
>> indicates there may be some deeper problem hidden. How exactly did you
>> trigger this problem?
>>
>>                                 Honza
>>
>>>
>>> To fixed that, get write access for the rest unprocessed bhs, just
>>> as what write_end_fn do.
>>>
>>> Fixes: 3910b513fcdf ("ext4: persist the new uptodate buffers in 
>>> ext4_journalled_zero_new_buffers")
>>> Reported-and-tested-by: Zhi Long <longzhi@sangfor.com.cn>
>>> Suggested-by: Shida Zhang <zhangshida@kylinos.cn>
>>> Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
>>> ---
>>>   fs/ext4/inode.c | 17 ++++++++++++++++-
>>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>>> index 54bdd4884fe6..a72f951288e4 100644
>>> --- a/fs/ext4/inode.c
>>> +++ b/fs/ext4/inode.c
>>> @@ -1102,9 +1102,24 @@ int ext4_block_write_begin(handle_t *handle, 
>>> struct folio *folio,
>>>               err = -EIO;
>>>       }
>>>       if (unlikely(err)) {
>>> -        if (should_journal_data)
>>> +        if (should_journal_data) {
>>> +            if (bh != head || !block_start) {
>>> +                do {
>>> +                    block_end = block_start + bh->b_size;
>>> +
>>> +                    if (buffer_new(bh))
>>> +                        if (block_end > from && block_start < to)
>>> +                            do_journal_get_write_access(handle,
>>> +                                            inode, bh);
>>> +
>>> +                    block_start = block_end;
>>> +                    bh = bh->b_this_page;
>>> +                } while (bh != head);
>>> +            }
>>> +
>>>               ext4_journalled_zero_new_buffers(handle, inode, folio,
>>>                                from, to);
>>> +        }
>>>           else
>>>               folio_zero_new_buffers(folio, from, to);
>>>       } else if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
>>> -- 
>>> 2.39.2
>>>
> 


