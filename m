Return-Path: <linux-ext4+bounces-5977-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7771A051B2
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jan 2025 04:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE20F166C62
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jan 2025 03:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9EE19CC02;
	Wed,  8 Jan 2025 03:43:17 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919122B9B9;
	Wed,  8 Jan 2025 03:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736307797; cv=none; b=BJsCAVn3tXthQWTcUL5kA7YBeuIOEjGD2fWnuz4zivdG7U9w+nKQutD2AMbGIWOQe9RPge986D51JxjPW806Bl3YwnO/gJZVXhtN+f6yC0TCgmeELqYZfHTjNGfiwp666SGUuym864vL43hxrNiyGEu6wW6oJYICuRjfAzaS1fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736307797; c=relaxed/simple;
	bh=5Ot2khS2QeTgao7tEXv76dUMZ8/xn98OGlDNRLMAok4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VHH2ShogSfsfDHVkT02PtpA5ID3xOo6e4U3ODMe+aW4wUrvhXkZlTtjoD6M1nYm1DmVkKFRoqyOO5qKrAhTpAC3b8ty1o9odov8dlNeWCfYEINMXrket7dGBgFFEj6oge0j3BOSic531/8k/Q4Dltdw6RfSloWVgaUzBATshHpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YSYZw5Rykz2Dk59;
	Wed,  8 Jan 2025 11:40:08 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id C581E1A016C;
	Wed,  8 Jan 2025 11:43:09 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 8 Jan
 2025 11:43:08 +0800
Message-ID: <cbbce761-4f58-492f-a5b0-dee22391d24a@huawei.com>
Date: Wed, 8 Jan 2025 11:43:08 +0800
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
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <zdn3gam6vhbbo2abj2n4ij6mpflqlrkon6ho67md6aze5ycfhk@in5hdqq2n3ic>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/1/6 22:32, Jan Kara wrote:
> Hello!
>
> On Fri 20-12-24 21:39:39, Baokun Li wrote:
>> On 2024/12/20 18:36, Jan Kara wrote:
>>> On Fri 20-12-24 14:07:55, libaokun@huaweicloud.com wrote:
>>>> From: Baokun Li <libaokun1@huawei.com>
>>>>
>>>> If we mount an ext4 fs with data_err=abort option, it should abort on
>>>> file data write error. But if the extent is unwritten, we won't add a
>>>> JI_WAIT_DATA bit to the inode, so jbd2 won't wait for the inode's data
>>>> to be written back and check the inode mapping for errors. The data
>>>> writeback failures are not sensed unless the log is watched or fsync
>>>> is called.
>>>>
>>>> Therefore, when data_err=abort is enabled, the journal is aborted when
>>>> an I/O error is detected in ext4_end_io_end() to make users who are
>>>> concerned about the contents of the file happy.
>>>>
>>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> Thank you for your review and feedback!
>>> I'm not opposed to this change but I think we should better define the
>>> expectations around data_err=abort.
>> Totally agree, the definition of this option is a bit vague right now.
>> It's semantics have changed implicitly with iterations of the version.
>>
>> Originally in v2.6.28-rc1 commit 5bf5683a33f3 (“ext4: add an option to
>> control error handling on file data”) introduced “data_err=abort”, the
>> implementation of this mount option relies on JBD2_ABORT_ON_ SYNCDATA_ERR,
>> and this flag takes effect when the journal_finish_inode_data_buffers()
>> function returns an error. At this point in ext4_write_end(), in ordered
>> mode, we add the inode to the ordered data list, whether it is an append
>> write or an overwrite write. Therefore all write failures in ordered mode
>> will abort the journal. This is also the semantics in the documentation
>> - “Abort the journal if an error occurs in a file data buffer in ordered
>> mode.”.
> Well, that is not quite true. Normally, we run in delalloc mode and use
> ext4_da_write_end() to finish writes. Thus normally inode was not added to
> the transaction's list of inodes to flush (since 3.8 where this behavior
> got implemented by commit f3b59291a69d ("ext4: remove calls to
> ext4_jbd2_file_inode() from delalloc write path")). Then the commit
> 06bd3c36a733 (“ext4: fix data exposure after a crash”) in 4.7 realized this
> is broken and fixed things to properly flush blocks when needed.
Yes, we inadvertently changed the behavior of "data_err=abort" when
fixing the bug. The implicit dependency between "data_err=abort" and
ext4_jbd2_file_inode() makes it hard to spot this.
> Actually the data=ordered mode always guaranteed we will not expose stale
> data but never guaranteed all the written data will be flushed.
Yes, compared to the data=writeback mode, the semantics of data=ordered can
guarantee that stale data will not be exposed.
> Thus
> data_err=abort always controlled "what should jbd2 do when it spots error
> when flushing data" rather than any kind of guarantee that IO error on any
> data writeback results in filesystem abort.
I think this is the initial design problem of data_err=abort. The
description in its commit is to abort the journal when file data
corruption is detected, because not all applications frequently
check for errors in files through fsync.

As for why it is only in data=ordered mode, I personally guess that
in data=journal mode, file data is added to the journal, and the
journal itself will be aborted when data is abnormal; and people who
care about file data often do not use data=writeback mode, which may
expose stale data.
>   After all page writeback can
> easily try to flush the data before a transaction commit and hit IO error
> and jbd2 then won't notice the problem (the page will be clean already) and
> it was always like that.
Good point! "data_err=abort" did have this problem before. If the
relevant metadata cache has been cleaned, we will not be able to
perceive any errors, and fsync will not work either. This also
shows that checking at IO completion is a better choice.
>>> For example the dependency on
>>> data=ordered is kind of strange and the current semantics of data_err=abort
>>> are hard to understand for admins (since they are mostly implementation
>>> defined). For example if IO error happens on data overwrites, the
>>> filesystem will not be aborted because we don't bother tracking such data
>>> as ordered (for performance reasons). Since you've apparently talked to people
>>> using this option: What are their expectations about the option?
>> As was the original intent of introducing "data_err=abort", users who
>> use this option are concerned about corruption of critical data spreading
>> silently, that is, they are concerned that the data actually read does
>> not match the data written.
> OK, so you really want any write IO error to result in filesystem abort?
> Both page writeback and direct IO writes?
Direct I/O writes are okay because the inode size is updated after all
work is completed, and users will know immediately whether the write has
actually landed on disk and take corresponding actions.

Buffered I/O writes return success after copying data to memory, and users
cannot perceive whether the writeback is successful unless using fsync, so
they may not perceive when there is an abnormality in the data on the disk.
Therefore, IMO, data_err=abort only cares about page writeback.
>> But as you said, we don't track overwrite writes for performance reasons.
>> But compared to the poor performance of journal_data and the risk of the
>> drop cache exposing stale, not being able to sense data errors on overwrite
>> writes is acceptable.
>>
>> After enabling ‘data_err=abort’ in dioread_nolock mode, after drop_cache
>> or remount, the user will not see the unexpected all-zero data in the
>> unwritten area, but rather the earlier consistent data, and the data in
>> the file is trustworthy, at the cost of some trailing data.
>>
>> On the other hand, adding a new written extents and converting an
>> unwritten extents to written both expose the data to the user, so the user
>> is concerned about whether the data is correct at that point.
>>
>> In general, I think we can update the semantics of “data_err=abort” to,
>> “Abort the journal if the file fails to write back data on extended writes
>> in ORDERED mode”. Do you have any thoughts on this?
> I agree it makes sense to make the semantics of data_err=abort more
> obvious. Based on the usecase you've described - i.e., rather take the
> filesystem down on write IO error than risk returning old data later - it
> would make sense to me to also do this on direct IO writes.

Okay, I will update the semantics of data_err=abort in the next version.
For direct I/O writes, I think we don't need it because users can
perceive errors in time.

>   Also I would do
> this regardless of data=writeback/ordered/journalled mode because although
> users wanting data_err=abort behavior will also likely want the guarantees
> of data=ordered mode, these are two different things
For data=journal mode, the journal itself will abort when data is abnormal.
However, as you pointed out, the above bug may cause errors to be missed.
Therefore, we can perform this check by default for journaled files.
> and I can imagine use
> cases for setups with data=writeback and data_err=abort as well (e.g. for
> scratch filesystems which get recreated on each system startup).
>
> 								Honza

Users using data=writeback often do not care about data consistency.
I did not understand your example. Could you please explain it in detail?
Thank you in advance.


Cheers,
Baokun


