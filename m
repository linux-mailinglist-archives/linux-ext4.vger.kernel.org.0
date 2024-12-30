Return-Path: <linux-ext4+bounces-5858-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E40209FE338
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Dec 2024 08:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336D93A1BFE
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Dec 2024 07:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF95D19F422;
	Mon, 30 Dec 2024 07:27:57 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6FF19F13B;
	Mon, 30 Dec 2024 07:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735543677; cv=none; b=ObkwW/c+hJ4KVHztU4gFIS5CRVebmuKenvGrKHJ20pEHzkGt5cia9gpvQkJQQSD81em1e62y8/g5D8eY6sTIz2V8TAEE9htX8z+20QAi00pgvUoJgoMnjuEOx+mYy+37AAe00JbUIN8vW6qb/fgpjHQHlqgV2kmzg06L7JodCPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735543677; c=relaxed/simple;
	bh=3Qyo1LYEvOKIji4QCv9DYZM90Q/TRvs8ijEPti30AWs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=e1cO+PpOISx4d3SxsklsEMyhyfY/UZo0X/AETtr/HZNvKIVDffgI7DlNaXyPed217kMI1+bd4Wd00Fc4qt31iBwu7+YyK2F+j0IlvrkDvNPmLPOqQhZs/9f+UwNGOUorXXEbH3VBSR8ClLj8kOgr9Eq3zjOL/tbuUGWvqTFpQQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4YM7476z8hz20n5b;
	Mon, 30 Dec 2024 15:28:07 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 1AFF014022E;
	Mon, 30 Dec 2024 15:27:47 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 30 Dec
 2024 15:27:46 +0800
Message-ID: <cbbdac31-c63c-418e-ba00-bb82b96144ee@huawei.com>
Date: Mon, 30 Dec 2024 15:27:45 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Baokun Li <libaokun1@huawei.com>
Subject: Re: CVE-2024-50191: ext4: don't set SB_RDONLY after filesystem errors
To: <gregkh@linuxfoundation.org>
CC: <cve@kernel.org>, <linux-cve-announce@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.com>, Theodore Ts'o
	<tytso@mit.edu>, "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	Yang Erkun <yangerkun@huawei.com>
References: <2024110851-CVE-2024-50191-f31c@gregkh>
Content-Language: en-US
In-Reply-To: <2024110851-CVE-2024-50191-f31c@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg500008.china.huawei.com (7.202.181.45)

> Description
> ===========
>
> In the Linux kernel, the following vulnerability has been resolved:
>
> ext4: don't set SB_RDONLY after filesystem errors
>
> When the filesystem is mounted with errors=remount-ro, we were setting
> SB_RDONLY flag to stop all filesystem modifications. We knew this misses
> proper locking (sb->s_umount) and does not go through proper filesystem
> remount procedure but it has been the way this worked since early ext2
> days and it was good enough for catastrophic situation damage
> mitigation. Recently, syzbot has found a way (see link) to trigger
> warnings in filesystem freezing because the code got confused by
> SB_RDONLY changing under its hands. Since these days we set
> EXT4_FLAGS_SHUTDOWN on the superblock which is enough to stop all
> filesystem modifications, modifying SB_RDONLY shouldn't be needed. So
> stop doing that.
>
> The Linux kernel CVE team has assigned CVE-2024-50191 to this issue.
>
>
> Affected and fixed versions
> ===========================
>
>     Fixed in 5.15.168 with commit fbb177bc1d64
>     Fixed in 6.1.113 with commit 4061e07f040a

Since 6.1 and 5.15 don't have backport
     commit 95257987a638 ("ext4: drop EXT4_MF_FS_ABORTED flag"),
we won't set the EXT4_FLAGS_SHUTDOWN bit in ext4_handle_error() yet. So
here these two commits cause us to repeatedly get the following printout:

[   42.993195] EXT4-fs error (device sda): ext4_journal_check_start:83: 
comm fsstress: Detected aborted journal
[   42.993351] EXT4-fs error (device sda): ext4_journal_check_start:83: 
comm fsstress: Detected aborted journal
[   42.993483] EXT4-fs error (device sda): ext4_journal_check_start:83: 
comm fsstress: Detected aborted journal
[   42.993597] EXT4-fs error (device sda): ext4_journal_check_start:83: 
comm fsstress: Detected aborted journal
[   42.993638] EXT4-fs error (device sda): ext4_journal_check_start:83: 
comm fsstress: Detected aborted journal
[   42.993718] EXT4-fs error (device sda): ext4_journal_check_start:83: 
comm fsstress: Detected aborted journal
[   42.993866] EXT4-fs error (device sda): ext4_journal_check_start:83: 
comm fsstress: Detected aborted journal
[   42.993874] EXT4-fs error (device sda): ext4_journal_check_start:83: 
comm fsstress: Detected aborted journal
[   42.993874] EXT4-fs error (device sda) in __ext4_new_inode:1089: 
Journal has aborted
[   42.994059] EXT4-fs error (device sda): ext4_journal_check_start:83: 
comm fsstress: Detected aborted journal
[   42.999893] EXT4-fs: 58002 callbacks suppressed
[   42.999895] EXT4-fs (sda): Remounting filesystem read-only
[   43.000110] EXT4-fs (sda): Remounting filesystem read-only
[   43.000274] EXT4-fs (sda): Remounting filesystem read-only
[   43.000421] EXT4-fs (sda): Remounting filesystem read-only
[   43.000569] EXT4-fs (sda): Remounting filesystem read-only
[   43.000701] EXT4-fs (sda): Remounting filesystem read-only
[   43.000869] EXT4-fs (sda): Remounting filesystem read-only
[   43.001094] EXT4-fs (sda): Remounting filesystem read-only
[   43.001229] EXT4-fs (sda): Remounting filesystem read-only
[   43.001365] EXT4-fs (sda): Remounting filesystem read-only

Perhaps we should revert both commits.


Thanks,
Baokun

>     Fixed in 6.6.57 with commit 58c0648e4c77
>     Fixed in 6.11.4 with commit ee77c3884691
>     Fixed in 6.12-rc1 with commit d3476f3dad4a
>
> Please see https://www.kernel.org for a full list of currently supported
> kernel versions by the kernel community.
>
> Unaffected versions might change over time as fixes are backported to
> older supported kernel versions.  The official CVE entry at
> https://cve.org/CVERecord/?id=CVE-2024-50191
> will be updated if fixes are backported, please check that for the most
> up to date information about this issue.
>
>
> Affected files
> ==============
>
> The file(s) affected by this issue are:
>     fs/ext4/super.c
>
>
> Mitigation
> ==========
>
> The Linux kernel CVE team recommends that you update to the latest
> stable kernel version for this, and many other bugfixes. Individual
> changes are never tested alone, but rather are part of a larger kernel
> release.  Cherry-picking individual commits is not recommended or
> supported by the Linux kernel community at all.  If however, updating to
> the latest release is impossible, the individual changes to resolve this
> issue can be found at these commits:
> https://git.kernel.org/stable/c/fbb177bc1d6487cd3e9b50ae0be2781b7297980d
> https://git.kernel.org/stable/c/4061e07f040a091f694f461b86a26cf95ae66439
> https://git.kernel.org/stable/c/58c0648e4c773f5b54f0cb63bc8c7c6bf52719a9
> https://git.kernel.org/stable/c/ee77c388469116565e009eaa704a60bc78489e09
> https://git.kernel.org/stable/c/d3476f3dad4ad68ae5f6b008ea6591d1520da5d8


