Return-Path: <linux-ext4+bounces-5813-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC9A9F9365
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 14:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3FCA18871A8
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 13:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F922156E6;
	Fri, 20 Dec 2024 13:39:53 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2131C5F08;
	Fri, 20 Dec 2024 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734701993; cv=none; b=qQ/EpSpADvdh0VKLnGmUefQxPfOApFfsa38NGifTYUwS5mHA25gZxJjV2otjYTg2iGvk5D8TrYePbmJmoQaYQoUD3FyD+snYg01iecyD18VXmjpKAmKlcQDNf/3awsjP60Lez8olcSPStRW2ivAKfcdIC+fhaZ4/4QzarWAlXUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734701993; c=relaxed/simple;
	bh=6VhAjpgvaUBoS2n35I+RYl7VIkSGgbbtfErmoeSeBZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FfYBvhZ29FDnfW8tPEXWsOMnoIntAa+iTnY3Tm/Dlf0xUZehY0PNymmbB0rWMKoANeOTkc47Ycut+avOp4zVeNJ/Nju0FiMPU/45n9dbU5nBZcOFaE59aVNYBjKDzLp77tTwJPSJpCTRLwkneu+kN+x8iaXfjrUO/ipHdI+MRGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4YF7lG08kQzRjvY;
	Fri, 20 Dec 2024 21:37:46 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id E66FA180104;
	Fri, 20 Dec 2024 21:39:40 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 20 Dec
 2024 21:39:40 +0800
Message-ID: <47a46888-064f-4c7d-a554-30ba49c45bab@huawei.com>
Date: Fri, 20 Dec 2024 21:39:39 +0800
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
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20241220103617.xkqmwkmk5inlq3dz@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2024/12/20 18:36, Jan Kara wrote:
> On Fri 20-12-24 14:07:55, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> If we mount an ext4 fs with data_err=abort option, it should abort on
>> file data write error. But if the extent is unwritten, we won't add a
>> JI_WAIT_DATA bit to the inode, so jbd2 won't wait for the inode's data
>> to be written back and check the inode mapping for errors. The data
>> writeback failures are not sensed unless the log is watched or fsync
>> is called.
>>
>> Therefore, when data_err=abort is enabled, the journal is aborted when
>> an I/O error is detected in ext4_end_io_end() to make users who are
>> concerned about the contents of the file happy.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
Hi Honza,

Thank you for your review and feedback!
> I'm not opposed to this change but I think we should better define the
> expectations around data_err=abort.
Totally agree, the definition of this option is a bit vague right now.
It's semantics have changed implicitly with iterations of the version.

Originally in v2.6.28-rc1 commit 5bf5683a33f3 (“ext4: add an option to
control error handling on file data”) introduced “data_err=abort”, the
implementation of this mount option relies on JBD2_ABORT_ON_ SYNCDATA_ERR,
and this flag takes effect when the journal_finish_inode_data_buffers()
function returns an error. At this point in ext4_write_end(), in ordered
mode, we add the inode to the ordered data list, whether it is an append
write or an overwrite write. Therefore all write failures in ordered mode
will abort the journal. This is also the semantics in the documentation
- “Abort the journal if an error occurs in a file data buffer in ordered
mode.”.

Until commit 06bd3c36a733 (“ext4: fix data exposure after a crash”) in
v4.7-rc1, in order to avoid stale data, we will only add inodes to the
ordered data list when attaching freshly allocated blocks to inode
using a written extent. Since then, only written write (aka dioread_lock)
failures in ordered mode will abort the journal, and “data_err=abort” in
unwritten mode will no longer take effect.

There are more historical changes to the relevant logic, so please
correct me if I'm missing something.
> For example the dependency on
> data=ordered is kind of strange and the current semantics of data_err=abort
> are hard to understand for admins (since they are mostly implementation
> defined). For example if IO error happens on data overwrites, the
> filesystem will not be aborted because we don't bother tracking such data
> as ordered (for performance reasons). Since you've apparently talked to people
> using this option: What are their expectations about the option?
>
> 								Honza
As was the original intent of introducing "data_err=abort", users who
use this option are concerned about corruption of critical data spreading
silently, that is, they are concerned that the data actually read does
not match the data written.

But as you said, we don't track overwrite writes for performance reasons.
But compared to the poor performance of journal_data and the risk of the
drop cache exposing stale, not being able to sense data errors on overwrite
writes is acceptable.

After enabling ‘data_err=abort’ in dioread_nolock mode, after drop_cache
or remount, the user will not see the unexpected all-zero data in the
unwritten area, but rather the earlier consistent data, and the data in
the file is trustworthy, at the cost of some trailing data.

On the other hand, adding a new written extents and converting an
unwritten extents to written both expose the data to the user, so the user
is concerned about whether the data is correct at that point.

In general, I think we can update the semantics of “data_err=abort” to,
“Abort the journal if the file fails to write back data on extended writes
in ORDERED mode”. Do you have any thoughts on this?


Thanks,
Baokun


