Return-Path: <linux-ext4+bounces-2091-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F688A52AB
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Apr 2024 16:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0394284852
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Apr 2024 14:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F16674433;
	Mon, 15 Apr 2024 14:07:51 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771081BF2A;
	Mon, 15 Apr 2024 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190071; cv=none; b=Kzz+pEGr2pcjA0gBGAYpaY+gxfciGibvsPfl7YiVcCrqnGQHbGYeDCA2LBefrsLx/y2d+10Perjs3+dFNAPp/a8RFDBVfxD5VijOy9I2TKp4hEV3W7dhcrAVYuwaYMUyLHJjvE1haVEMbxvVKW03NZ6ud5K28XxRoKWHQcRa+mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190071; c=relaxed/simple;
	bh=rVw3WR3vnvoKRUGWlATN6GtsCo5hNU+A41jtTzBfEC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LPvCcrwsb9oaQQGvr1WBJzXk3vyEerIdT7GRlMmNIUdnHQ9CS+h+uvebyJ91y2KqDfu9PKddNRLRybLP3tyhNUGAIeea5kQEEsPf/QfnJJBH98isOzKDoytxzlFxJWVFFAJn+A9llsVDc6ZpZWmkYMiFqbW95LvNYvKtrSWyqLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VJ87M3fxSz2CcMm;
	Mon, 15 Apr 2024 22:04:47 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id ECC361A016C;
	Mon, 15 Apr 2024 22:07:43 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 22:07:43 +0800
Message-ID: <96557c0e-7db4-856c-40eb-e51ca138883b@huawei.com>
Date: Mon, 15 Apr 2024 22:07:42 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2] ext4: fix race condition between buffer write and
 page_mkwrite
Content-Language: en-US
To: Jan Kara <jack@suse.cz>
CC: Matthew Wilcox <willy@infradead.org>, Theodore Ts'o <tytso@mit.edu>,
	<linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<jun.nie@linaro.org>, <ebiggers@kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <yukuai3@huawei.com>,
	<syzbot+a158d886ca08a3fecca4@syzkaller.appspotmail.com>, Baokun Li
	<libaokun1@huawei.com>
References: <20230530134405.322194-1-libaokun1@huawei.com>
 <20230604030445.GF1128744@mit.edu> <20230604210821.GA1257572@mit.edu>
 <ZH1BN+H1/Sa4eLQ4@casper.infradead.org>
 <20230605091655.24vl5fjesfskt3o5@quack3>
 <20230605122141.4njwwx3mrapqhvt4@quack3>
 <ZH33ZzwyLFY48tfA@casper.infradead.org>
 <20230605150855.7oaiplp7r57dcww3@quack3>
 <49d5b109-7cc3-6717-b3c6-6858310aa3ba@huawei.com>
 <20240415123405.htw6vqbzsb3speor@quack3>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20240415123405.htw6vqbzsb3speor@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2024/4/15 20:34, Jan Kara wrote:
> On Mon 15-04-24 12:28:01, Baokun Li wrote:
>> On 2023/6/5 23:08, Jan Kara wrote:
>>> On Mon 05-06-23 15:55:35, Matthew Wilcox wrote:
>>>> On Mon, Jun 05, 2023 at 02:21:41PM +0200, Jan Kara wrote:
>>>>> On Mon 05-06-23 11:16:55, Jan Kara wrote:
>>>>>> Yeah, I agree, that is also the conclusion I have arrived at when thinking
>>>>>> about this problem now. We should be able to just remove the conversion
>>>>>> from ext4_page_mkwrite() and rely on write(2) or truncate(2) doing it when
>>>>>> growing i_size.
>>>>> OK, thinking more about this and searching through the history, I've
>>>>> realized why the conversion is originally in ext4_page_mkwrite(). The
>>>>> problem is described in commit 7b4cc9787fe35b ("ext4: evict inline data
>>>>> when writing to memory map") but essentially it boils down to the fact that
>>>>> ext4 writeback code does not expect dirty page for a file with inline data
>>>>> because ext4_write_inline_data_end() should have copied the data into the
>>>>> inode and cleared the folio's dirty flag.
>>>>>
>>>>> Indeed messing with xattrs from the writeback path to copy page contents
>>>>> into inline data xattr would be ... interesting. Hum, out of good ideas for
>>>>> now :-|.
>>>> Is it so bad?  Now that we don't have writepage in ext4, only
>>>> writepages, it seems like we have a considerably more benign locking
>>>> environment to work in.
>>> Well, yes, without ->writepage() it might be *possible*. But still rather
>>> ugly. The problem is that in ->writepages() i_size is not stable. Thus also
>>> whether the inode data is inline or not is not stable. We'd need inode_lock
>>> for that but that is not easily doable in the writeback path - inode lock
>>> would then become fs_reclaim unsafe...
>>>
>>> 								Honza
>> Hi Honza!
>> Hi Ted!
>> Hi Matthew!
>>
>> Long time later came back to this, because while discussing another similar
>> ABBA problem with Hou Tao, he mentioned VM_FAULT_RETRY, and then I
>> thought that this could be used to solve this problem as well.
>>
>> The general idea is that if we see a file with inline data in
>> ext4_page_mkwrite(),
>> we release the mmap_lock and grab the inode_lock to convert the inline data,
>> and then return VM_FAULT_RETRY to retry to get the mmap_lock.
>>
>> The code implementation is as follows, do you have any thoughts?
> So the problem with this is that VM_FAULT_RETRY is not always an option -
> in particular the caller has to set FAULT_FLAG_ALLOW_RETRY to indicate it
> is prepared to handle VM_FAULT_RETRY return. See how
> maybe_unlock_mmap_for_io() is carefully checking this.
Yes, at least we need to check for FAULT_FLAG_RETRY_NOWAIT.
> There are callers
> (most notably some get_user_pages() users) that don't set
> FAULT_FLAG_ALLOW_RETRY so the escape through VM_FAULT_RETRY is sadly not a
> reliable solution.
It is indeed sad.  I'm going to go learn more about the code for
FAULT_FLAG_ALLOW_RETRY.
> My long-term wish is we were always allowed to use VM_FAULT_RETRY and that
> was actually what motivated some get_user_pages() cleanups I did couple
> years ago. But dealing with all the cases in various drivers was too
> difficult and I've run out of time. Now maybe it would be worth it to
> revisit this since things have changed noticeably and maybe now it would be
> easier to achive the goal...
>
> 								Honza
That sounds like a great idea. I will try to get the history on it and
then come back.

Thank you very much for your patient explanation!
-- 
With Best Regards,
Baokun Li
.

