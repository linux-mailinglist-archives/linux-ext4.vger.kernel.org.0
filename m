Return-Path: <linux-ext4+bounces-6814-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 677F3A63D9A
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Mar 2025 04:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B9A83AD264
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Mar 2025 03:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBEF1547EE;
	Mon, 17 Mar 2025 03:54:44 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFF62E3377;
	Mon, 17 Mar 2025 03:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742183684; cv=none; b=dZ+f1+ML0k3jmH5isWpfh2UQC2RIteSuAdOi3HMR7lOkm79Zs/jQvU5LPUk+Xrfr1aE6+YXc014nBl1ORJ4VfJmHujPTdk4S1lZ5aZfeef+0tKX0FTySQ4eqwz62HIQkuYdmaNBco1terWsOZSTY4r5qH2RjCnz8ShYzPegdDoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742183684; c=relaxed/simple;
	bh=iUhvGFnR3579yzYc8UKBeT1GUyAe08TqpSJoAigJTic=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l1396tKhvty4noL5QhAZvmHM0kTEjWWp/+LskAo7y52ELEUN9PHbHOAig7vLkmgk3IykCoM7VKnZwAgwDk/8GUKKm3SJDE9btQqqmaHcysixziXmtRdTPHDpDS0ufFrNYA3vmexQ0+PW7mha+oQFFhYGtoqRKUXwdiYfO1Vv4qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZGLcS6YvLz2Ccpy;
	Mon, 17 Mar 2025 11:51:20 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id CA2CA1401F1;
	Mon, 17 Mar 2025 11:54:33 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 17 Mar
 2025 11:54:32 +0800
Message-ID: <4918d461-e507-451e-beee-a7de2884c45b@huawei.com>
Date: Mon, 17 Mar 2025 11:54:32 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: cache es->s_journal_inum in ext4_sb_info
To: Theodore Ts'o <tytso@mit.edu>, Ojaswin Mujoo <ojaswin@linux.ibm.com>
CC: <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>, Ritesh Harjani
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>, Yang Erkun
	<yangerkun@huawei.com>
References: <d1a9328a41029f6210a1924b192a59afcd3c5cee.1741952406.git.ojaswin@linux.ibm.com>
 <20250316014128.GA787758@mit.edu>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20250316014128.GA787758@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/3/16 9:41, Theodore Ts'o wrote:
> On Fri, Mar 14, 2025 at 05:11:43PM +0530, Ojaswin Mujoo wrote:
>> Currently, we access journal ino through sbi->s_es->s_journal_inum,
>> which directly reads from the ext4 sb buffer head. If someone modifies
>> this underneath us then the s_journal_inum field might get corrupted.
>>
>> Although direct block device modifications can be expected to cause
>> issues in the FS, let's cache s_journal_inum in sbi->s_journal_ino so
>> our checks can be more resillient.
> The reason why the block validity checks need to check against
> s_journal_ino is to exempt the lookups done by ext4_journal_bmap()
> from running afoul of the system zone checks, since the journal's data
> blocks are considered part of the system zone.
>
> So this is something we need to do if the journal is actived, and if
> it's active, then sbi->s_journal will be non-NULL, and so we can just
> check to see if inode == sbi->s_journal instead.  This will simplify
> the code, without needing to expand the ext4_sb_info structure.
>
> Cheers,
>
> 						- Ted
>
This looks good!

It's a much more direct approach, avoiding extra field and complex code.


Cheers,
Baokun


