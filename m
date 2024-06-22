Return-Path: <linux-ext4+bounces-2918-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A7A9131B1
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Jun 2024 04:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5A7C1C21B19
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Jun 2024 02:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D5779C0;
	Sat, 22 Jun 2024 02:51:48 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD72A5F;
	Sat, 22 Jun 2024 02:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719024708; cv=none; b=gsxRpmA3LnYp1IYjyHoI5+H4iqbivyfWMAULKssP5R0HZ91ybIh2fN0NXTUvxbKZ3w2hSM+tiFGPwUt3g/uW6tmqk/bBHCP5fAg9nwcygUYJ+ec5na4bXdLKBg3+SsOxM92acL4Le1odZXDXQURwpXivOm9o3Pq7LgqUOmunbX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719024708; c=relaxed/simple;
	bh=VQRBXI6E9DYD8sibQAHjyrNS2yNK/khO13SKwhLUhj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kR0dy/jX0Dxhlbh/tCM3BhPKQFPcpotnEMqRQACtzROkjBjUvdZlH/X1jnNlCOnps5seotaoVdu4QfyLYNmh4NVVl3AWiYnPDPv/CWke29mvXg6M50Wzg54KL1KgQs+Do5vv705IcYiNVZw9+HJ9f8/fWkrifTUmUwrR0vhhyHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4W5dS71ps8zPrbf;
	Sat, 22 Jun 2024 10:28:07 +0800 (CST)
Received: from dggpeml100021.china.huawei.com (unknown [7.185.36.148])
	by mail.maildlp.com (Postfix) with ESMTPS id E6C9E1402C8;
	Sat, 22 Jun 2024 10:31:42 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml100021.china.huawei.com (7.185.36.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 22 Jun 2024 10:31:42 +0800
Message-ID: <c26c4704-4f41-477d-a613-ec388536ea72@huawei.com>
Date: Sat, 22 Jun 2024 10:31:42 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4/059: disable block_validity checks when mounting a
 corrupted file system
To: Zorro Lang <zlang@kernel.org>
CC: Theodore Ts'o <tytso@mit.edu>, Ext4 Developers List
	<linux-ext4@vger.kernel.org>, <fstests@vger.kernel.org>,
	<yangerkun@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <20230823145621.3680601-1-tytso@mit.edu>
 <45251246-e24b-4ace-9b45-2efad65e8eb5@huawei.com>
 <20240621163603.mid7acwta2tnbhqk@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20240621163603.mid7acwta2tnbhqk@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml100021.china.huawei.com (7.185.36.148)

On 2024/6/22 0:36, Zorro Lang wrote:
> On Thu, Jun 13, 2024 at 10:09:44AM +0800, Baokun Li wrote:
>> Hi Zorro,
>>
>> Could you pick up this patch?
>> This test case has been failing in the mainline for a while now.
> Sorry I just noticed this patch, looks like it was not sent to fstests@.
> Sure, I'll merge it, thanks for CC me :)

Thanks for merging it!

Seeing your reply I just noticed that the address of the fstests mail
list was misspelled.

Cheers,
Baokun

>
> Thanks,
> Zorro
>
>> Thanks,
>> Baokun
>>
>> On 2023/8/23 22:56, Theodore Ts'o wrote:
>>> Kernels with the commit "ext4: add correct group descriptors and
>>> reserved GDT blocks to system zone" will refuse to mount the corrupted
>>> file system constructed by this test.  So in order to perform the
>>> test, we need to disable the block_validity checks.
>>>
>>> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>> Looks good to me, thanks for the patch!
>>
>> Reviewed-and-tested-by: Baokun Li <libaokun1@huawei.com>
>>
>>> ---
>>>    tests/ext4/059 | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/tests/ext4/059 b/tests/ext4/059
>>> index 4230bde92..e4af77f1e 100755
>>> --- a/tests/ext4/059
>>> +++ b/tests/ext4/059
>>> @@ -31,6 +31,11 @@ $DEBUGFS_PROG -w -R "set_super_value s_reserved_gdt_blocks 100" $SCRATCH_DEV \
>>>    $DEBUGFS_PROG -R "show_super_stats -h" $SCRATCH_DEV 2>/dev/null | \
>>>    	grep "Reserved GDT blocks"
>>> +# Kernels with the commit "ext4: add correct group descriptors and
>>> +# reserved GDT blocks to system zone" will refuse to mount the file
>>> +# system due to block_validity checks; so disable block_validity.
>>> +MOUNT_OPTIONS="$MOUNT_OPTIONS -o noblock_validity"
>>> +
>>>    _scratch_mount
>>>    # Expect no crash from this resize operation
>>>

