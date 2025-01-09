Return-Path: <linux-ext4+bounces-5993-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12BFA06BA3
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Jan 2025 03:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F8F3A4E9A
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Jan 2025 02:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C04824A3;
	Thu,  9 Jan 2025 02:45:47 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFDF847C;
	Thu,  9 Jan 2025 02:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736390747; cv=none; b=gEr7MLh5V1pwWe3lb9NbPbOCkkBaYdi+UgpDmxlQSjIW56juRwIyLlsaZBtUKt5kbDZZ0QRR4zjUS7ntgAb1wa8ZwPG+EXLC9sQI4cYhsQIZRdkx20NfGy6leaDr6GZPG323l5pgdjKXSy7vN61c8AtaMcvV6yWR95ti+ochDT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736390747; c=relaxed/simple;
	bh=KHEvyGB6C+CGdCmku1GM8CJK6TgAO5t5K5B0TAwyhEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nfvVwDOgFduWKcGfu9mY8EWfKGD1UL51zzyNaVzRKrduGpFZSO6MaIlDouOr0cNYLlAe8SeNi0WCcm4Or5DZMjUOcIWv1NmlupnJVap+l6Q/g0rwGgObgoshOzSvRsVHOhsdAa7Vvv46Afz/aA2rB3I+inef1dM/cmgw1ytA2lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YT8Hb0TPGzpZN7;
	Thu,  9 Jan 2025 10:43:55 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 7BF93140382;
	Thu,  9 Jan 2025 10:45:36 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 9 Jan
 2025 10:45:35 +0800
Message-ID: <c7ab26f3-85ad-4b31-b132-0afb0e07bf79@huawei.com>
Date: Thu, 9 Jan 2025 10:45:34 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] ext4: abort journal on data writeback failure if in
 data_err=abort mode
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <libaokun@huaweicloud.com>
References: <20241220060757.1781418-1-libaokun@huaweicloud.com>
 <20241220060757.1781418-4-libaokun@huaweicloud.com>
 <20241220103617.xkqmwkmk5inlq3dz@quack3>
 <47a46888-064f-4c7d-a554-30ba49c45bab@huawei.com>
 <zdn3gam6vhbbo2abj2n4ij6mpflqlrkon6ho67md6aze5ycfhk@in5hdqq2n3ic>
 <cbbce761-4f58-492f-a5b0-dee22391d24a@huawei.com>
 <dfoxg4aaolu6wknvh4644acbo3pvbtacwiztianjaol7zuf7vb@hbb7x2zitvwf>
 <0820379d-7ed2-4aff-a243-0c92957331a6@huawei.com>
 <dxjefcbxm2essvlxvheecpmeit56qdh6trruhxicho7qcs3kjk@s7mhqwhuej7m>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <dxjefcbxm2essvlxvheecpmeit56qdh6trruhxicho7qcs3kjk@s7mhqwhuej7m>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/1/8 23:28, Jan Kara wrote:
> On Wed 08-01-25 22:44:42, Baokun Li wrote:
>> On 2025/1/8 21:43, Jan Kara wrote:
>>> On Wed 08-01-25 11:43:08, Baokun Li wrote:
>>>> On 2025/1/6 22:32, Jan Kara wrote:
>>>>>> But as you said, we don't track overwrite writes for performance reasons.
>>>>>> But compared to the poor performance of journal_data and the risk of the
>>>>>> drop cache exposing stale, not being able to sense data errors on overwrite
>>>>>> writes is acceptable.
>>>>>>
>>>>>> After enabling ‘data_err=abort’ in dioread_nolock mode, after drop_cache
>>>>>> or remount, the user will not see the unexpected all-zero data in the
>>>>>> unwritten area, but rather the earlier consistent data, and the data in
>>>>>> the file is trustworthy, at the cost of some trailing data.
>>>>>>
>>>>>> On the other hand, adding a new written extents and converting an
>>>>>> unwritten extents to written both expose the data to the user, so the user
>>>>>> is concerned about whether the data is correct at that point.
>>>>>>
>>>>>> In general, I think we can update the semantics of “data_err=abort” to,
>>>>>> “Abort the journal if the file fails to write back data on extended writes
>>>>>> in ORDERED mode”. Do you have any thoughts on this?
>>>>> I agree it makes sense to make the semantics of data_err=abort more
>>>>> obvious. Based on the usecase you've described - i.e., rather take the
>>>>> filesystem down on write IO error than risk returning old data later - it
>>>>> would make sense to me to also do this on direct IO writes.
>>>> Okay, I will update the semantics of data_err=abort in the next version.
>>>> For direct I/O writes, I think we don't need it because users can
>>>> perceive errors in time.
>>> So I agree that direct IO users will generally notice the IO error so the
>>> chances for bugs due to missing the IO error is low. But I think the
>>> question is really the other way around: Is there a good reason to make
>>> direct IO writes different? Because if I as a sysadmin want to secure a
>>> system from IO error handling bugs, then having to think whether some
>>> application uses direct IO or not is another nuissance. Why should I be
>>> bothered?
>> This is not quite right. Regardless of whether it is a BIO write or a DIO
>> write, users will check the return value of the write operation, because
>> errors can occur not only when data is written to disk.
> Yes, they *should* check the return value of write(2) and take appropriate
> action. But do all of them check and mainly do they do something meaningful
> with the error? That's what I'm not so sure about :).
Indeed, we cannot confirm that all users will check the return value.

However, we cannot give a commitment that data will not be lost even if
users do not check return values. Giving such a commitment requires us
to intercept all errors returned to users by write operations and abort
the journal. However, write operations may also fail before the data is
written to disk (e.g., -ENOMEM, -EPERM, etc.), therefore checks need to
be added in ext4_file_write_iter() or even VFS... -- We cannot provide
such a guarantee.
>
>> It's just that when a DIO write returns successfully, users can be sure
>> that the data has been written to the disk.
>>
>> However, when a BIO write returns successfully, it only means that the
>> data has been copied into the buffer. Whether it has been successfully
>> written back to the disk is unknown to the user.
>>
>> That's why we need data_err=abort to ensure that users are aware when the
>> page writeback fails and to prevent data corruption from spreading.
> I understand including DIO need not be interesting for your usecase but I
> still think it may be more consistent overall decision. But perhaps I'll
> ask Ted what he thinks about it.
Okay, thanks for asking ted for his opinion on this.
>
>>>>>     Also I would do
>>>>> this regardless of data=writeback/ordered/journalled mode because although
>>>>> users wanting data_err=abort behavior will also likely want the guarantees
>>>>> of data=ordered mode, these are two different things
>>>> For data=journal mode, the journal itself will abort when data is abnormal.
>>>> However, as you pointed out, the above bug may cause errors to be missed.
>>>> Therefore, we can perform this check by default for journaled files.
>>>>> and I can imagine use
>>>>> cases for setups with data=writeback and data_err=abort as well (e.g. for
>>>>> scratch filesystems which get recreated on each system startup).
>>>> Users using data=writeback often do not care about data consistency.
>>>> I did not understand your example. Could you please explain it in detail?
>>> Well, they don't care about data consistency after a crash. But they
>>> usually do care about data consistency while the system is running. And
>>> unhandled IO errors can lead to data consistency problems without crashing
>>> the system (for example if writeback fails and page gets evicted from
>>> memory later, you have lost the new data and may see old version of it).
>> I see your point. I concur that it is indeed meaningful for
>> data_err=abort to be supported in data=writeback mode.
>>
>> Thank you for your explanation!
>>> And I see data_err=abort as a way to say: "I don't trust my applications to
>>> handle IO errors well. Rather take the filesystem down in that case than
>>> risk data consistency issues".
>>>
>>> 								Honza
>> I still prefer to think of this as a supplement for users not being able
>> to perceive page writeback in a timely manner. The fsync operation is
>> complex, requires frequent waiting, and may have omissions.
> I agree properly checking for errors from buffered writes is much more
> painful.
Yeah, indeed.
>> In addition, because ext4_end_bio() runs in interrupt context, we can't
>> abort the journal directly there due to potential locking issues.
>>
>> Instead, we now add write-back error checks and journal abortion logic
>> to ext4_end_io_end(), which is called by a kworker during unwritten
>> extent conversion.
>>
>> Consequently, for modes that don't support unwritten extents (e.g.,
>> nodelalloc, journal_data, see ext4_should_dioread_nolock()), only the
>> check in journal_submit_data_buffers() will be effective. Should we
>> call the kworker for all files in ext4_end_bio()?
> So how I imagined this would work is that if we get error in ext4_end_bio()
> and data_err=abort is set, we will queue work (probably stored in the
> superblock) to abort the filesystem. Alternatively, a bit more generic
> approach might be to store the error state in the io_end and implement
> something like:
>
> static bool ext4_io_end_need_defered_completion(ext4_io_end_t *io_end)
> {
> 	return io_end->flag & (EXT4_IO_END_UNWRITTEN | EXT4_IO_END_ERROR);
> }
>
> and use it in ext4_end_bio() and ext4_put_io_end_defer() to determine
> whether the io_end needs processing in the workqueue or not. And
> ext4_put_io_end() can then abort the filesystem if EXT4_IO_END_ERROR is
> set.
>
> 								Honza

This idea looks great.
Thanks so much for the suggestion!


Regards,
Baokun


