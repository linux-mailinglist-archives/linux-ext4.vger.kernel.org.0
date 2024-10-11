Return-Path: <linux-ext4+bounces-4567-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D59F999C7C
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Oct 2024 08:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92A1285819
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Oct 2024 06:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A401F9431;
	Fri, 11 Oct 2024 06:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mJm14Gq+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CB4328B6;
	Fri, 11 Oct 2024 06:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728627503; cv=none; b=Swqt3JcSpzKgrgdZQzeXJKWCF4Wp+zmVwPuoIbuKDJhHXw4XPcjiI82Y2RqOtLmaiGG5jjvcr5vX18Ul9IEDJERKHpTErTUiZjH3jjHRjr8bJrqtxB23Y79WnWHp05OakGYbLE81LrY+NJI6besxbmQkSW9Ns9ipT/BZQkw2iK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728627503; c=relaxed/simple;
	bh=eO3/CiHURI2AIuuoUgMs66MWLroRYMhaRhQD3hiw9CQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KOxyA42T+VTSLtuCyJFHiHRQqO/CjgQcY5oIcj6xsmaq2e/YiC3HXZW3qzpiNtU4r0hBdanW9vpn5Q81k1lXvpXz18blkUJeAA5SySVRzjy0HiEPHGnpI1EebGVusvlSv5kTZ7gxTeK71K1LqY+XkZJhAt+F7RfyhGS68Fj1E4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mJm14Gq+; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=RpJz4KKgLgp+St5K7RZyZ9YL3L6T8JAC/gWa6Q+sU1o=;
	b=mJm14Gq+alijs6afIQltJSEOdyyaxvQ8HQJwP9tNklbSBDGsiB64D1B6bnzj6t
	r4U4ehrUpmnGYlDhRQPPuQ0bJKD2q3WQomzkCAjroeB6ZjGfoC8zV1OhwGmbGzR4
	lsCJ7CbPqX7OXyBRFwRFcfvdx2AmDFEcoqyIyYjfCsXq4=
Received: from [192.168.22.184] (unknown [223.70.253.255])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDHr04awwhnriCrAQ--.44184S2;
	Fri, 11 Oct 2024 14:18:03 +0800 (CST)
Message-ID: <2635f3f9-86e1-4d09-ad40-4e02ac4447c5@163.com>
Date: Fri, 11 Oct 2024 14:18:01 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ext4: fix a assertion failure due to ungranted bh
 dirting
To: Jan Kara <jack@suse.cz>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, zhangshida@kylinos.cn,
 longzhi@sangfor.com.cn, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, Baolin Liu <liubaolin@kylinos.cn>
References: <20241010025855.2632516-1-liubaolin12138@163.com>
 <20241010092923.r53povuflevzhxrw@quack3>
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20241010092923.r53povuflevzhxrw@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHr04awwhnriCrAQ--.44184S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFy3WFWDXFy7GFWftFy3XFb_yoWrCF43pr
	W5K345KrWqgry29Fs2qF4fXFy0gw18GrW7GrWfKryFy3y5WFn2qryrtrn8AF1qyrZ3uwn5
	Zr4UAF9Fk3Wjv37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U3-BiUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/1tbiLgR1ymcIwv0ClgAAsR

> Greetings，
> This problem is reproduced by our customer using their own testing tool “run_bug”.
> When I consulted with a client, the testing tool “run_bug” used a variety of background programs to benchmark 
> (including memory pressure, cpu pressure, file cycle manipulation, fsstress Stress testing tool, postmark program，and so on).
> The recurrence probability is relatively low.
> 
> In response to your query, in ext4_block_write_begin, the new state will be clear before get block, 
> and the bh that failed get_block will not be set to new.
> However, when the page size is greater than the block size, a page will contain multiple bh. 
> bh->b_this_page is a circular list for managing all bh on the same page.
> After get_block jumps out of the for loop, then bh->b_this_page is not processed by clear new in the for loop.
> So after calling ext4_journalled_zero_new_buffers,
> The ext4_journalled_zero_new_buffers function will determine all bh of the same page and call write_end_fn if they are in new state,
> get_block returns err's bh->b_this_page and circular list other unhandled bh if the state was previously set to new.
> Because bh not get access, the corresponding transaction is not placed in jh->b_transaction, resulting in a crash.
> 
> Therefore, the patch processing method I submit is to make unprocessed bh determines if it is in new state and get access.
> There is another way to handle the remaining bh clear_buffer_new that is not processed.
> I personally recommend get access this way, the impact is small. 
> Please guide the two processing methods, which one do you recommend?



在 2024/10/10 17:29, Jan Kara 写道:
> On Thu 10-10-24 10:58:55, Baolin Liu wrote:
>> From: Baolin Liu <liubaolin@kylinos.cn>
>>
>> Since the merge of commit 3910b513fcdf ("ext4: persist the new uptodate
>> buffers in ext4_journalled_zero_new_buffers"), a new assertion failure
>> occurred under a old kernel(ext3, data=journal, pagesize=64k) with
>> corresponding ported patches:
> ...
>> which was caused by bh dirting without calling
>> do_journal_get_write_access().
>>
>> In the loop for all bhs of a page in ext4_block_write_begin(),
>> when a err occurred, it will jump out of loop.
>> But that will leaves some bhs being processed and some not,
>> which will lead to the asserion failure in calling write_end_fn().
> 
> Thanks for the patch but I don't understand one thing here: For
> ext4_journalled_zero_new_buffers() to call write_end_fn() the buffer must
> have buffer_new flag set. That flag can get set only by ext4_get_block()
> function when it succeeds in which case we also call
> do_journal_get_write_access(). So how is it possible that buffer_new was
> set on a buffer on which we didn't call do_journal_get_write_access()? This
> indicates there may be some deeper problem hidden. How exactly did you
> trigger this problem?
> 
> 								Honza
> 
>>
>> To fixed that, get write access for the rest unprocessed bhs, just
>> as what write_end_fn do.
>>
>> Fixes: 3910b513fcdf ("ext4: persist the new uptodate buffers in ext4_journalled_zero_new_buffers")
>> Reported-and-tested-by: Zhi Long <longzhi@sangfor.com.cn>
>> Suggested-by: Shida Zhang <zhangshida@kylinos.cn>
>> Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
>> ---
>>   fs/ext4/inode.c | 17 ++++++++++++++++-
>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 54bdd4884fe6..a72f951288e4 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -1102,9 +1102,24 @@ int ext4_block_write_begin(handle_t *handle, struct folio *folio,
>>   			err = -EIO;
>>   	}
>>   	if (unlikely(err)) {
>> -		if (should_journal_data)
>> +		if (should_journal_data) {
>> +			if (bh != head || !block_start) {
>> +				do {
>> +					block_end = block_start + bh->b_size;
>> +
>> +					if (buffer_new(bh))
>> +						if (block_end > from && block_start < to)
>> +							do_journal_get_write_access(handle,
>> +										    inode, bh);
>> +
>> +					block_start = block_end;
>> +					bh = bh->b_this_page;
>> +				} while (bh != head);
>> +			}
>> +
>>   			ext4_journalled_zero_new_buffers(handle, inode, folio,
>>   							 from, to);
>> +		}
>>   		else
>>   			folio_zero_new_buffers(folio, from, to);
>>   	} else if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
>> -- 
>> 2.39.2
>>


