Return-Path: <linux-ext4+bounces-2046-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7C18A2339
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Apr 2024 03:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 492A3B22AF3
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Apr 2024 01:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1564C96;
	Fri, 12 Apr 2024 01:28:02 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00EA525D;
	Fri, 12 Apr 2024 01:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712885282; cv=none; b=C4PQJqGhMF502VBgn/i4ZfCxc6YBNmVQyRQfnEdVuTCerHNjlcbuHlN/TnxpwGxOWgyb3Duri0l6V0F9g9Lw9qb42OAfgHxBDnGDqrUe1Sygit2VBYE1PR6TA1X/15krbzJwPX6kHKiXEM+ZzenMmi7wmgkv4K4W97ac/FlivGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712885282; c=relaxed/simple;
	bh=jO3iPycn4NxUDdWfskp4rnwTDGkxWybxbna4FnfUJR4=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=H/YHjYYeB0RGNDoc0IY6f4JCLgAZfvaobBmZP2Vhd9HG2Q9EVuDMhVk4QExLoRfWYv/aSeLeap8eAXVGN5yeZLrh2O6dkPHe8757qM12CP60fdc4lJC+Agmo8OZCbAYp5WMPzb6NRWevx0NcIXw6tg3U7HWlCUDMgW9E8RC1y5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VFzSX68wtz1S5LQ;
	Fri, 12 Apr 2024 09:27:08 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id B07ED1A0172;
	Fri, 12 Apr 2024 09:27:56 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 09:27:56 +0800
Subject: Re: [PATCH] jbd2: avoid mount failed when commit block is partial
 submitted
To: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>
References: <20240402090951.527619-1-yebin10@huawei.com>
 <20240402134240.5he4mxei3nvzolb3@quack3> <20240403033742.GE1189142@mit.edu>
 <20240403101122.rmffivvvf4a33qis@quack3> <6611F8D5.3030403@huawei.com>
 <20240411133718.tq74yorf6odpla4r@quack3> <20240411145559.GB187181@mit.edu>
CC: <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
From: "yebin (H)" <yebin10@huawei.com>
Message-ID: <66188E1B.6070209@huawei.com>
Date: Fri, 12 Apr 2024 09:27:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240411145559.GB187181@mit.edu>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)



On 2024/4/11 22:55, Theodore Ts'o wrote:
> On Thu, Apr 11, 2024 at 03:37:18PM +0200, Jan Kara wrote:
>>> The vendor
>>> has confirmed that only 512-byte atomicity can be ensured in the firmware.
>>> Although the valid data is only 60 bytes, the entire commit block is used
>>> for calculating
>>> the checksum.
>>> jbd2_commit_block_csum_verify:
>>> ...
>>> calculated = jbd2_chksum(j, j->j_csum_seed, buf, j->j_blocksize);
>>> ...
>> Ah, indeed. This is the bit I've missed. Thanks for explanation! Still I
>> think trying to somehow automatically deal with wrong commit block checksum
>> is too dangerous because it can result in fs corruption in some (unlikely)
>> cases. OTOH I understand journal replay failure after a power fail isn't
>> great either so we need to think how to fix this...
> Unfortunately, the only fix I can think of would require changing how
> we do the checksum to only include the portion of the jbd2 block which
> contains valid data, per the header field.  This would be a format
> change which means that if a new kernel writes the new jbd2 format
> (using a journal incompat flag, or a new checksum type), older kernels
> and older versions of e2fsprogs wouldn't be able to validate the
> journal.  So rollout of the fix would have to be carefully managed.
>
> 					- Ted
> .
I thought of a solution that when the commit block checksum is 
incorrect, retain the
first 512 bytes of data, clear the subsequent data, and then calculate 
the checksum
to see if it is correct. This solution can distinguish whether the 
commit is complete
for components that can ensure the atomicity of 512 bytes or more. But 
for HDD,
it may not be able to distinguish, but it should be alleviated to some 
extent.


