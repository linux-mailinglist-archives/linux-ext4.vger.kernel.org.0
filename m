Return-Path: <linux-ext4+bounces-5860-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 057DB9FE3A5
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Dec 2024 09:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6B71160358
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Dec 2024 08:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CA1198E6F;
	Mon, 30 Dec 2024 08:21:14 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB413EAD2;
	Mon, 30 Dec 2024 08:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735546874; cv=none; b=MOHY4y5JA0HVLfN/3x6CrnwQtbjNCaBq7BpX8dFKqdP1k3WIc5LakYTBrWiKGrYPOw81m7p+yVcO337MxRKd4JHYQoGv65YrihbfX50fXtZksDahdgseSi0MyeT/tmnQkm5bLckMJI04grOz9En+xTjclfZoLy1coiWTupIh1yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735546874; c=relaxed/simple;
	bh=dXF0DHKMbRd4Udtyj2vjpqtSpyzXdEezYI89GOl2H7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lePbSKs4apy1GIQTU9TQzFwG71QSMANOfs9XvYB7SOmVH60T6Zkz3Z5c+34imVv8/yk0UyQyow2JO/mUvvOfZKQv/ShoVjklrgAuTKE1UwzExKByZthpWrHz8jlLuFgjDkOLoLyKl2LDeK+FgiQWaWKsnH18vcmtoQsHuJu15aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YM89w6vG8z1kxNG;
	Mon, 30 Dec 2024 16:18:12 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 9768C1A0188;
	Mon, 30 Dec 2024 16:21:02 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 30 Dec
 2024 16:21:01 +0800
Message-ID: <8222b5dd-5ee5-4ee6-9763-d1c21b9804db@huawei.com>
Date: Mon, 30 Dec 2024 16:21:00 +0800
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
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <2024123021-goatskin-mushroom-208e@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2024/12/30 15:54, Greg KH wrote:
> On Mon, Dec 30, 2024 at 03:27:45PM +0800, Baokun Li wrote:
>>> Description
>>> ===========
>>>
>>> In the Linux kernel, the following vulnerability has been resolved:
>>>
>>> ext4: don't set SB_RDONLY after filesystem errors
>>>
>>> When the filesystem is mounted with errors=remount-ro, we were setting
>>> SB_RDONLY flag to stop all filesystem modifications. We knew this misses
>>> proper locking (sb->s_umount) and does not go through proper filesystem
>>> remount procedure but it has been the way this worked since early ext2
>>> days and it was good enough for catastrophic situation damage
>>> mitigation. Recently, syzbot has found a way (see link) to trigger
>>> warnings in filesystem freezing because the code got confused by
>>> SB_RDONLY changing under its hands. Since these days we set
>>> EXT4_FLAGS_SHUTDOWN on the superblock which is enough to stop all
>>> filesystem modifications, modifying SB_RDONLY shouldn't be needed. So
>>> stop doing that.
>>>
>>> The Linux kernel CVE team has assigned CVE-2024-50191 to this issue.
>>>
>>>
>>> Affected and fixed versions
>>> ===========================
>>>
>>>      Fixed in 5.15.168 with commit fbb177bc1d64
>>>      Fixed in 6.1.113 with commit 4061e07f040a
>> Since 6.1 and 5.15 don't have backport
>>      commit 95257987a638 ("ext4: drop EXT4_MF_FS_ABORTED flag"),
>> we won't set the EXT4_FLAGS_SHUTDOWN bit in ext4_handle_error() yet. So
>> here these two commits cause us to repeatedly get the following printout:
>>
>> [   42.993195] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
>> fsstress: Detected aborted journal
>> [   42.993351] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
>> fsstress: Detected aborted journal
>> [   42.993483] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
>> fsstress: Detected aborted journal
>> [   42.993597] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
>> fsstress: Detected aborted journal
>> [   42.993638] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
>> fsstress: Detected aborted journal
>> [   42.993718] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
>> fsstress: Detected aborted journal
>> [   42.993866] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
>> fsstress: Detected aborted journal
>> [   42.993874] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
>> fsstress: Detected aborted journal
>> [   42.993874] EXT4-fs error (device sda) in __ext4_new_inode:1089: Journal
>> has aborted
>> [   42.994059] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
>> fsstress: Detected aborted journal
>> [   42.999893] EXT4-fs: 58002 callbacks suppressed
>> [   42.999895] EXT4-fs (sda): Remounting filesystem read-only
>> [   43.000110] EXT4-fs (sda): Remounting filesystem read-only
>> [   43.000274] EXT4-fs (sda): Remounting filesystem read-only
>> [   43.000421] EXT4-fs (sda): Remounting filesystem read-only
>> [   43.000569] EXT4-fs (sda): Remounting filesystem read-only
>> [   43.000701] EXT4-fs (sda): Remounting filesystem read-only
>> [   43.000869] EXT4-fs (sda): Remounting filesystem read-only
>> [   43.001094] EXT4-fs (sda): Remounting filesystem read-only
>> [   43.001229] EXT4-fs (sda): Remounting filesystem read-only
>> [   43.001365] EXT4-fs (sda): Remounting filesystem read-only
>>
>> Perhaps we should revert both commits.
> Maybe, if so, please send the needed info to the stable list with the
> backports that have been tested.  cve@kernel.org isn't the place for
> this :)

I replied to this thread on lore, which automatically CC's cve@kernel.org.

We don't use these two versions, we just happened to find the issue.
If you feel that reporting issue is bothering you, then I won't do it.🙂


Regards,
Baokun


