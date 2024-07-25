Return-Path: <linux-ext4+bounces-3441-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 775D593BC10
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 07:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2CE61F22222
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 05:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D5D1CD11;
	Thu, 25 Jul 2024 05:35:25 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D073420DC4;
	Thu, 25 Jul 2024 05:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721885725; cv=none; b=rbLBofaIbivcr8VxBURLiCY78KjCZCm0FvA82YINDY2oGT5SJbgQll1qiyGSru6R+NEAVNYe5D0ATZ1F+RTm1iA4yETVZ8ZLt6YZSxR+Km9XJfvn7vslHN7g44ctrkVqqNoMjThhqo0Gy42sVjmeLrtTRjhNfx7refmOV3vR2+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721885725; c=relaxed/simple;
	bh=574NiufiSGXw1jkMN+aHqO8YHR7vQfMvd32oWN3mdpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kdOEpaM+uELrNJyNreFvdVm3pAypyFvuc5nb7j5oXT8LjLjEvKHVt7ttBOQtSCKttz9TPNCanSpH6hys41n/qfhGiSaAZqESaf39rNgkHhIfZ9Hj8ezzxWKV/A5b5PvuM4+CUKZs7k+MvLHOOqBzodbhXZ6CrMr/qrk5Q4JDaH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WV02X2f3Cz4f3jdb;
	Thu, 25 Jul 2024 13:35:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DBB741A1492;
	Thu, 25 Jul 2024 13:35:12 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP4 (Coremail) with SMTP id gCh0CgDXuTcO5KFmOsBqBA--.64208S3;
	Thu, 25 Jul 2024 13:35:12 +0800 (CST)
Message-ID: <6df79e24-df1a-43da-8d1d-6bd0f8dd2edf@huaweicloud.com>
Date: Thu, 25 Jul 2024 13:35:10 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/20] ext4: prevent partial update of the extents path
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>,
 zhanchengbin <zhanchengbin1@huawei.com>, Baokun Li <libaokun@huaweicloud.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-3-libaokun@huaweicloud.com>
 <ZpPx3kuO36lp9/Um@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <9fd554c7-dc0c-4969-9f2a-1c99356fccce@huaweicloud.com>
 <d33cfec3-4d72-41dc-b020-f17f726ba719@huaweicloud.com>
 <ZpZDSMFbziWq5xOK@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <9ef38162-2eeb-4cf6-aee4-02d6a5952757@huaweicloud.com>
 <ZpdR4pN8IJajB9xc@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <9fcb1d52-520f-425f-8b83-debeda423483@huaweicloud.com>
 <ZqCd0fjFzZt00h6N@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <ZqCd0fjFzZt00h6N@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXuTcO5KFmOsBqBA--.64208S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZrW3ZrW7XrW7GFWDWF15Arb_yoWrWrWxpF
	yvy3WDKFWDKF1vkFnrtr4jqa4jvw1fWw4UXryrGr9rJ390vr1Sgryxtr4j9FyDCrWrJ3WY
	yrW8Xa43ur1qyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAPBWagu5VP4QABsP

On 2024/7/24 14:23, Ojaswin Mujoo wrote:
> On Wed, Jul 17, 2024 at 02:11:27PM +0800, Baokun Li wrote:
>> On 2024/7/17 13:29, Ojaswin Mujoo wrote:
>>> On Tue, Jul 16, 2024 at 07:54:43PM +0800, Baokun Li wrote:
>>>> Hi Ojaswin,
>>>>
>>>> On 2024/7/16 17:54, Ojaswin Mujoo wrote:
>>>>>>> But the journal will ensure the consistency of the extents path after
>>>>>>> this patch.
>>>>>>>
>>>>>>> When ext4_ext_get_access() or ext4_ext_dirty() returns an error in
>>>>>>> ext4_ext_rm_idx() and ext4_ext_correct_indexes(), this may cause
>>>>>>> the extents tree to be inconsistent. But the inconsistency just
>>>>>>> exists in memory and doesn't land on disk.
>>>>>>>
>>>>>>> For ext4_ext_get_access(), the handle must have been aborted
>>>>>>> when it returned an error, as follows:
>>>>>> ext4_ext_get_access
>>>>>>     ext4_journal_get_write_access
>>>>>>      __ext4_journal_get_write_access
>>>>>>       err = jbd2_journal_get_write_access
>>>>>>       if (err)
>>>>>>         ext4_journal_abort_handle
>>>>>>> For ext4_ext_dirty(), since path->p_bh must not be null and handle
>>>>>>> must be valid, handle is aborted anyway when an error is returned:
>>>>>> ext4_ext_dirty
>>>>>>     __ext4_ext_dirty
>>>>>>      if (path->p_bh)
>>>>>>        __ext4_handle_dirty_metadata
>>>>>>         if (ext4_handle_valid(handle))
>>>>>>           err = jbd2_journal_dirty_metadata
>>>>>>            if (!is_handle_aborted(handle) && WARN_ON_ONCE(err))
>>>>>>              ext4_journal_abort_handle
>>>>>>> Thus the extents tree will only be inconsistent in memory, so only
>>>>>>> the verified bit of the modified buffer needs to be cleared to avoid
>>>>>>> these inconsistent data being used in memory.
>>>>>>>
>>>>>> Regards,
>>>>>> Baokun
>>>>> Thanks for the explanation Baokun, so basically we only have the
>>>>> inconsitency in the memory.
>>>>>
>>>>> I do have a followup questions:
>>>>>
>>>>> So in the above example, after we have the error, we'll have the buffer
>>>>> for depth=0 marked as valid but pointing to the wrong ei_block.
>>>> It looks wrong here. When there is an error, the ei_block of the
>>>> unmodified buffer with depth=0 is the correct one, it is indeed
>>>> 'valid' and it is consistent with the disk. Only buffers that were
>>> Hey Baokun,
>>>
>>> Ahh I see now, I was looking at it the wrong way. So basically since
>>> depth 1 to 4 is inconsistent to the disk we mark then non verified so
>>> then subsequent lookups can act accordingly.
>>>
>>> Thanks for the explanation! I am in the middle of testing this patchset
>>> with xfstests on a POWERPC system with 64k page size. I'll let you know
>>> how that goes!
>>>
>>> Regards,
>>> Ojaswin
>> Hi Ojaswin,
>>
>> Thank you for the test and feedback!
>>
>> Cheers,
>> Baokun
> Hey Baokun,

Hi Ojaswin,

Sorry for the slow reply, I'm currently on a business trip.

> The xfstests pass for sub page size as well as bs = page size for
> POWERPC with no new regressions.
Thank you very much for your test!
>
> Although for this particular patch I doubt if we would be able to
> exersice the error path using xfstests. We might need to artifically
> inject error in ext4_ext_get_access or ext4_ext_dirty.  Do you have any
> other way of testing this?
The issues in this patch set can all be triggered by injecting EIO or
ENOMEM into ext4_find_extent(). So not only did I test kvm-xftests
several times on x86 to make sure there weren't any regressions,
but I also tested that running kvm-xfstests while randomly injecting
faults into ext4_find_extent() didn't crash the system.
>
> Also, just curious whether you came across this bug during code reading
> or were you actually hitting it?
The initial issue was that e2fsck was always reporting some sort of
extents tree exception after testing, so the processes in question
were troubleshooting and hardening, i.e. the first two patches.
The other issues were discovered during fault injection testing of
the processes in question.


Regards,
Baokun


