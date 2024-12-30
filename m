Return-Path: <linux-ext4+bounces-5862-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC62F9FE40D
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Dec 2024 10:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0BEA1882293
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Dec 2024 09:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8FC1A239B;
	Mon, 30 Dec 2024 09:06:34 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01259199254;
	Mon, 30 Dec 2024 09:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735549594; cv=none; b=Z+zE6UfqHIeN3QF5EZK6oNDTGFVjef49xKByh39GmpwBpXKCGT/L3r20/FS3Qo56fvKML+j76Evl7M9cnNg0DTyUiNy7Mhp5cKldzoMN3e6PX2vGUnPbuZ3ThwggW8iZnid4mFFkwsWCvpFqW3TlfzSUzXklBtHUz5J4dk/RBzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735549594; c=relaxed/simple;
	bh=czanaBfAdqHdJm41BOBEpyb5aTPRSqLmxhRpwG3HZ8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qtEsAn2TTzPEc22xLXOgw5Z1mMzJeezCYgGOqxh05aiBiah5B1gXWA13TYc0Ksm/i2gHM97+Z2ASrtaO+tja5t7qDVHYgizIn5L9byBTxW011+Jm1cFOa+5nnwlBePyV0wHgtyXIas0bbqaNOYZEIJpB3lt0vNX0OcWhRIU2E0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YM99y5mQczgb3W;
	Mon, 30 Dec 2024 17:03:18 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 39BA9180AED;
	Mon, 30 Dec 2024 17:06:20 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 30 Dec
 2024 17:06:19 +0800
Message-ID: <7569fe06-12ff-4c55-a9a7-a3c6c4f9e1a6@huawei.com>
Date: Mon, 30 Dec 2024 17:06:18 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2024-50191: ext4: don't set SB_RDONLY after filesystem errors
To: Greg KH <gregkh@linuxfoundation.org>
CC: <linux-cve-announce@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jan
 Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, Yang Erkun
	<yangerkun@huawei.com>
References: <2024110851-CVE-2024-50191-f31c@gregkh>
 <cbbdac31-c63c-418e-ba00-bb82b96144ee@huawei.com>
 <2024123021-goatskin-mushroom-208e@gregkh>
 <8222b5dd-5ee5-4ee6-9763-d1c21b9804db@huawei.com>
 <2024123032-sarcasm-properly-b955@gregkh>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <2024123032-sarcasm-properly-b955@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2024/12/30 16:33, Greg KH wrote:
> On Mon, Dec 30, 2024 at 04:21:00PM +0800, Baokun Li wrote:
>> On 2024/12/30 15:54, Greg KH wrote:
>>> On Mon, Dec 30, 2024 at 03:27:45PM +0800, Baokun Li wrote:
>>>>> Description
>>>>> ===========
>>>>>
>>>>> In the Linux kernel, the following vulnerability has been resolved:
>>>>>
>>>>> ext4: don't set SB_RDONLY after filesystem errors
>>>>>
>>>>> When the filesystem is mounted with errors=remount-ro, we were setting
>>>>> SB_RDONLY flag to stop all filesystem modifications. We knew this misses
>>>>> proper locking (sb->s_umount) and does not go through proper filesystem
>>>>> remount procedure but it has been the way this worked since early ext2
>>>>> days and it was good enough for catastrophic situation damage
>>>>> mitigation. Recently, syzbot has found a way (see link) to trigger
>>>>> warnings in filesystem freezing because the code got confused by
>>>>> SB_RDONLY changing under its hands. Since these days we set
>>>>> EXT4_FLAGS_SHUTDOWN on the superblock which is enough to stop all
>>>>> filesystem modifications, modifying SB_RDONLY shouldn't be needed. So
>>>>> stop doing that.
>>>>>
>>>>> The Linux kernel CVE team has assigned CVE-2024-50191 to this issue.
>>>>>
>>>>>
>>>>> Affected and fixed versions
>>>>> ===========================
>>>>>
>>>>>       Fixed in 5.15.168 with commit fbb177bc1d64
>>>>>       Fixed in 6.1.113 with commit 4061e07f040a
>>>> Since 6.1 and 5.15 don't have backport
>>>>       commit 95257987a638 ("ext4: drop EXT4_MF_FS_ABORTED flag"),
>>>> we won't set the EXT4_FLAGS_SHUTDOWN bit in ext4_handle_error() yet. So
>>>> here these two commits cause us to repeatedly get the following printout:
>>>>
>>>> [   42.993195] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
>>>> fsstress: Detected aborted journal
>>>> [   42.993351] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
>>>> fsstress: Detected aborted journal
>>>> [   42.993483] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
>>>> fsstress: Detected aborted journal
>>>> [   42.993597] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
>>>> fsstress: Detected aborted journal
>>>> [   42.993638] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
>>>> fsstress: Detected aborted journal
>>>> [   42.993718] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
>>>> fsstress: Detected aborted journal
>>>> [   42.993866] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
>>>> fsstress: Detected aborted journal
>>>> [   42.993874] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
>>>> fsstress: Detected aborted journal
>>>> [   42.993874] EXT4-fs error (device sda) in __ext4_new_inode:1089: Journal
>>>> has aborted
>>>> [   42.994059] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
>>>> fsstress: Detected aborted journal
>>>> [   42.999893] EXT4-fs: 58002 callbacks suppressed
>>>> [   42.999895] EXT4-fs (sda): Remounting filesystem read-only
>>>> [   43.000110] EXT4-fs (sda): Remounting filesystem read-only
>>>> [   43.000274] EXT4-fs (sda): Remounting filesystem read-only
>>>> [   43.000421] EXT4-fs (sda): Remounting filesystem read-only
>>>> [   43.000569] EXT4-fs (sda): Remounting filesystem read-only
>>>> [   43.000701] EXT4-fs (sda): Remounting filesystem read-only
>>>> [   43.000869] EXT4-fs (sda): Remounting filesystem read-only
>>>> [   43.001094] EXT4-fs (sda): Remounting filesystem read-only
>>>> [   43.001229] EXT4-fs (sda): Remounting filesystem read-only
>>>> [   43.001365] EXT4-fs (sda): Remounting filesystem read-only
>>>>
>>>> Perhaps we should revert both commits.
>>> Maybe, if so, please send the needed info to the stable list with the
>>> backports that have been tested.  cve@kernel.org isn't the place for
>>> this :)
>> I replied to this thread on lore, which automatically CC's cve@kernel.org.
> Yes, which is fine, but you are responding to a CVE report, NOT to a
> stable kernel patch that has been backported, which is what I think you
> want to respond to, right?
Actually, we discovered the mechanism change introduced by its fix patch
while analyzing CVE-2024-50191.
https://lore.kernel.org/linux-ext4/22d652f6-cb3c-43f5-b2fe-0a4bb6516a04@huawei.com/T/#u

However, the situation is worse for 5.15 and 6.1, as the patch upon which
the fix depends has not even been merged yet. Therefore, I am replying here
to prevent the erroneous information from further propagating with the CVE.
>
>> We don't use these two versions, we just happened to find the issue.
>> If you feel that reporting issue is bothering you, then I won't do it.🙂
> It's fine, I'm just trying to get you to route it to a group of people
> that can do something about it.  Again, try responding to the stable
> patch that was merged there, that would be better, along with perhaps
> providing a patch showing what you feel should be done.
The problem I've reported to the ext4 mail list, and perhaps some patches
will be synchronized to stable if anything comes of the discussion in the
link above.
> If patches that are assigned CVEs later get reverted, the CVEs should
> semi-automatically be rejected (I swept the CVE tree for this last
> week), so you don't need to worry about that happening.
>
Thank you for your maintenance!

This CVE is indeed a problem, so it's not necessary to reject it.
What I can say for sure now is that the 5.15 and 6.1 fixes are problematic.
The final solution needs some more discussion.


Regards,
Baokun


