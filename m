Return-Path: <linux-ext4+bounces-11796-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE70BC5030E
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 02:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A0234E2E72
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 01:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37136226D18;
	Wed, 12 Nov 2025 01:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="rsb8QHDT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA3ADF72;
	Wed, 12 Nov 2025 01:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762910439; cv=none; b=feeTjAx2k7lKxsBGL8P97Kbiz0fO+bfvZ71grjoYQB2wHFM9cecjojzbklwRtFbsqroU+2ARnhXmsmlZyJF+ljnYkQ+mXCDiqDPW1YgYICUIgwlfP496Lha4rBJ95L/CgMeSZ/tQ+I7cfghKbuRcUBX01KwRMkssZaDi1u3cZWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762910439; c=relaxed/simple;
	bh=i/kJ9FzcUzzJbN+8egCrW+P9oVxUgXOunl/yOHbhvEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LihjbfnMCUrCr2+jNEXf1U0zWaXB/Yv2qm6rRGZtHkuc200AnU1ooi//6rk66yLGxdXkSAUBXk29HgNFqH0QH+HjSKD4dYvH7BteSHE6E1iPFsHxauYF4tFIjxVrGU79nKhBLJ+J3wg6MoJjPVJVrnyTwVg2x2bcc3iNjSJFc0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=rsb8QHDT; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3foWcY4mqyY24vhktD3T8660J0H3J/4ohG+XUqORjVo=;
	b=rsb8QHDT2jx28W2WOoLFAoV2bBM1NPZ5i6SXuE890zAiKLcvonBIHfgjKWS1gr6L3zxaNzD5+
	SW/dMAMYsAu1WWisoQHIRWXRKFHJK11M+PRV/IYpZLK9QG+P8IQ3TU4I6XyF8Oyw7hIVEagg5ut
	t/Ry2AzU64cBYwezvwSkunA=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4d5lsn2SqrzLlrc;
	Wed, 12 Nov 2025 09:18:53 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 4966F1A0188;
	Wed, 12 Nov 2025 09:20:32 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 12 Nov
 2025 09:20:31 +0800
Message-ID: <fd63cace-a4fe-4f4b-9ad0-72201db9e6e6@huawei.com>
Date: Wed, 12 Nov 2025 09:20:30 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/24] ext4: enable block size larger than page size
Content-Language: en-GB
To: Theodore Ts'o <tytso@mit.edu>, Pankaj Raghav <kernel@pankajraghav.com>
CC: <linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<linux-kernel@vger.kernel.org>, <mcgrof@kernel.org>, <ebiggers@kernel.org>,
	<willy@infradead.org>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<chengzhihao1@huawei.com>, <libaokun1@huawei.com>, Baokun Li
	<libaokun@huaweicloud.com>
References: <20251111142634.3301616-1-libaokun@huaweicloud.com>
 <20251111142634.3301616-25-libaokun@huaweicloud.com>
 <880280be-1cd0-41b6-bc89-9168f374a9b9@pankajraghav.com>
 <20251111211148.GL2988753@mit.edu>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251111211148.GL2988753@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-11-12 05:11, Theodore Ts'o wrote:
> On Tue, Nov 11, 2025 at 07:01:20PM +0100, Pankaj Raghav wrote:
>> If you are planning to send another revision, then it would be nice to include
>> the corresponding patch to mke2fs as well? I don't know how ext4 process works but
>> just a suggestion.
> It's actually more convenient for me not to mix userspace and kernel
> patches, because b4 doesn't know the difference.  For that matter
> replying with an unrelated patch can also confuse b4, so it's a bit
> easier for people using b4 to send unrelated patches as a separate
> mail thread, using git format-patch / git send-email.
>
> In this case, the corresponding patch to mke2fs is pretty simple, and
> I've already pushed it to the e2fsprogs git repo:
>
>    https://github.com/tytso/e2fsprogs/commit/6d9033ff854eb346746176f43aa063137275d4b1
>
> :-)
>
> Cheers,
>
> 					- Ted

Thank you for the adaptation in mke2fs!


Cheers,
Baokun


