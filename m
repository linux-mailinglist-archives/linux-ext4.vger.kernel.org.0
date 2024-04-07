Return-Path: <linux-ext4+bounces-1908-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BAC89ADE5
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Apr 2024 03:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55F7C1F21F00
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Apr 2024 01:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038B2139B;
	Sun,  7 Apr 2024 01:37:39 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C464A3D;
	Sun,  7 Apr 2024 01:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712453858; cv=none; b=EZflgd4QANDVUSfR9GQmSG7dhDeXq9AKfp4lBTo3sIvYVKFvjXSTSRVC0vMG8B4zX7pQeUaFVRyYQn7kS6aQgvg6/2NAep0YwHhWhUlG87/lmohi2Ex5JXnEfoaSTvlgkWLJOPQAHZNuBXeReulQbEXw52bBdTb8yz2xHF58Fug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712453858; c=relaxed/simple;
	bh=c1enYxmckCFSDF0gcBrMDou3Ryj6fP6EGhPtfOBUhiQ=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PXbXWrV90rumcvl6pv4IosHo4CfWdlx+/8qlLz3SR5FBal/i223C5x7dBlk3qctq/wRsROrBOTiAwR2+VN5rITYvy0gwbZRZ01zEoo63azvTHPyTgOJh/fqoHVT27SbRDWTVDuS4RAa1Ov6mtmN76aQ3NfNemZ4RVKLOAODNvKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VBvt94KdbzNmxs;
	Sun,  7 Apr 2024 09:35:13 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 10403140158;
	Sun,  7 Apr 2024 09:37:26 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 09:37:25 +0800
Subject: Re: [PATCH] jbd2: avoid mount failed when commit block is partial
 submitted
To: Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>
References: <20240402090951.527619-1-yebin10@huawei.com>
 <20240402134240.5he4mxei3nvzolb3@quack3> <20240403033742.GE1189142@mit.edu>
 <20240403101122.rmffivvvf4a33qis@quack3>
CC: <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
From: "yebin (H)" <yebin10@huawei.com>
Message-ID: <6611F8D5.3030403@huawei.com>
Date: Sun, 7 Apr 2024 09:37:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240403101122.rmffivvvf4a33qis@quack3>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)



On 2024/4/3 18:11, Jan Kara wrote:
> On Tue 02-04-24 23:37:42, Theodore Ts'o wrote:
>> On Tue, Apr 02, 2024 at 03:42:40PM +0200, Jan Kara wrote:
>>> On Tue 02-04-24 17:09:51, Ye Bin wrote:
>>>> We encountered a problem that the file system could not be mounted in
>>>> the power-off scenario. The analysis of the file system mirror shows that
>>>> only part of the data is written to the last commit block.
>>>> To solve above issue, if commit block checksum is incorrect, check the next
>>>> block if has valid magic and transaction ID. If next block hasn't valid
>>>> magic or transaction ID then just drop the last transaction ignore checksum
>>>> error. Theoretically, the transaction ID maybe occur loopback, which may cause
>>>> the mounting failure.
>>>>
>>>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>>> So this is curious. The commit block data is fully within one sector and
>>> the expectation of the journaling is that either full sector or nothing is
>>> written. So what kind of storage were you using that it breaks these
>>> expectations?
>> I suppose if the physical sector size is 512 bytes, and the file
>> system block is 4k, I suppose it's possible that on a crash, that part
>> of the 4k commit block could be written.
> I was thinking about that as well but the commit block looks like:
>
> truct commit_header {
>          __be32          h_magic;
>          __be32          h_blocktype;
>          __be32          h_sequence;
>          unsigned char   h_chksum_type;
>          unsigned char   h_chksum_size;
>          unsigned char   h_padding[2];
>          __be32          h_chksum[JBD2_CHECKSUM_BYTES];
>          __be64          h_commit_sec;
>          __be32          h_commit_nsec;
> };
>
> where JBD2_CHECKSUM_BYTES is 8. So all the data in the commit block
> including the checksum is in the first 60 bytes. Hence I would be really
> surprised if some storage can tear that...
This issue has been encountered a few times in the context of eMMC 
devices. The vendor
has confirmed that only 512-byte atomicity can be ensured in the firmware.
Although the valid data is only 60 bytes, the entire commit block is 
used for calculating
the checksum.
jbd2_commit_block_csum_verify:
...
calculated = jbd2_chksum(j, j->j_csum_seed, buf, j->j_blocksize);
...
>
> Hence either Ye Bin is running on some really exotic storage or the storage
> / CPU in fact flipped bits somewhere so that the checksum didn't match or
> the commit block was in fact not written now but it was a leftover from
> previous journal use and h_sequence happened to match. Very unlikely but
> depending on how exactly they do their powerfail testing I can imagine it
> would be possible with enough tries...
>
>> In *practice* though, this
>> is super rare.  That's because on many modern HDD's, the physical
>> sector size is 4k (because the ECC overhead is much lower), even if
>> the logical sector size is 512 byte (for Windows 98 compatibility).
>> And even on HDD's where the physical sector size is really 512 bytes,
>> the way the sectors are laid out in a serpentine fashion, it is
>> *highly* likely that 4k write won't get torn.
>>
>> And while this is *possible*, it's also possible that some kind of I/O
>> transfer error --- such as some bit flips which breaks the checksum on
>> the commit block, but also trashes the tid of the subsequent block,
>> such that your patch gets tricked into thinking that this is the
>> partial last commit, when in fact it's not the last commit, thus
>> causing the journal replay abort early.  If that's case, it's much
>> safer to force fsck to be run to detect any inconsistency that might
>> result.
> Yeah, I agree in these cases of a corrupted journal it seems dangerous to
> just try to continue without fsck based on some heuristics.
>
> 								Honza


