Return-Path: <linux-ext4+bounces-8632-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDDCAE81FC
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Jun 2025 13:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313C317451A
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Jun 2025 11:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E40225DD0F;
	Wed, 25 Jun 2025 11:52:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AB8C8EB
	for <linux-ext4@vger.kernel.org>; Wed, 25 Jun 2025 11:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750852324; cv=none; b=JnppLV+JcNRe0eu4CucyGmiN4gNE+6ZRkXiDDFy9jn461BrtNrss+EG1AOKpYCodPXUNz/OtEdkOtea/SFEI78sk8BWKWAKjpNoTGetmLtDST7mG2l7xXdBQFbHsnyNlXBSTNSHhGb75tcVpXOzYbnbM5mE3m/0Wr67AoRWPnG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750852324; c=relaxed/simple;
	bh=LMdsYC5nURFOKm2NR4Ei6pD4/OxecHki4OVq/3kKQ3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cHKyLKIYRfsn6MdeLLMMLo3/9tIu1fVP/dcjlBRkhdJcdZL+PETiEwjELB8cRuv7Fg1c+h2uP2KI48d8Hx1bc8PX1d4MdENuBnZVx/f46zMKLOWgPQKpInDLE3S6kruXpC17Ow8veAwrSDj5syLPQf++SKkatA7D/YhmTFJ2naQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4bS0W04SgJz1Q6Ft;
	Wed, 25 Jun 2025 19:50:20 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id B4CC3180043;
	Wed, 25 Jun 2025 19:51:58 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 25 Jun
 2025 19:51:57 +0800
Message-ID: <dfad7391-e3fe-498d-8d33-55c00d8a3f46@huawei.com>
Date: Wed, 25 Jun 2025 19:51:56 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LBS support for EXT4
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
CC: Jan Kara <jack@suse.cz>, Luis Chamberlain <mcgrof@kernel.org>, Pankaj
 Raghav <p.raghav@samsung.com>, <linux-ext4@vger.kernel.org>, Zhang Yi
	<yi.zhang@huaweicloud.com>, Theodore Ts'o <tytso@mit.edu>
References: <6ac7ce67-b54b-437e-9409-7da9402c9de1@pankajraghav.com>
 <jcgnjl6txstun2hcimtz2zdayz7kxw4em6orafu5mfmcl2j5ik@ootfvveenf7j>
 <279f3612-ca02-46e0-a4ae-05052f2b1e50@pankajraghav.com>
 <20250623141753.GA33354@mit.edu>
 <c3ywjnnpfefledcl27qoqvwi4ew7fkrpmneddbxtquazraocrv@5e6l3t5oqap4>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <c3ywjnnpfefledcl27qoqvwi4ew7fkrpmneddbxtquazraocrv@5e6l3t5oqap4>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025/6/25 19:13, Pankaj Raghav (Samsung) wrote:
> Thanks for the reply, Ted.
>
> On Mon, Jun 23, 2025 at 10:17:53AM -0400, Theodore Ts'o wrote:
>> If you want to review and test the ext4/iomap changes, that would be
>> great.  Be aware, though, that there are some features of ext4
>> (example: data journalling, fscrypt, fsverity, etc.) that the current
>> iomap buffered I/O code may not support today.  The alternatives are
>> to keep the existing ext4 code paths for those file system features,
>> or to try to add that functionality into iomap.  There are of course
>> tradeoffs to both alternatives; one might result in more code that we
>> have to maintain; the other might require a lot more work.
>>
>> It _might_ be less effort to add LBS support to native ext4 code.  I
>> think the main thing is to make sure that we always we use a large
>> folio and not fall back to a sub-blocksize set of pages.  So again,
>> it's all about tradeoffs and what you consider to be the highest
>> priority.
> @Baokun are your LBS patches based on the native ext4 code or on top of
> Zhang's iomap patches.
Now that mainline ext4 supports buffer head large folios, we'll first
focus on LBS support based on buffer heads. The main work involves adapting
ext4's internal logic (e.g., block allocation, read/write operations,
defragmentation) and clean up the process related to buffer head.

This doesn't conflict with iomap buffer write support. The iomap framework
already supports LBS (as xfs is already using it), so once ext4's internal
logic is adapted, Zhang Yi's iomap buffer write patches should also support
LBS upon their merge.


Cheers,
Baokun


