Return-Path: <linux-ext4+bounces-4828-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F649B2210
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Oct 2024 02:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B45028172E
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Oct 2024 01:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7DF25745;
	Mon, 28 Oct 2024 01:48:00 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1094EEA8
	for <linux-ext4@vger.kernel.org>; Mon, 28 Oct 2024 01:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730080080; cv=none; b=Cem0HD3CYOajKTVv3IRrXlosVgP5SkgoEUIzfoYJNKuXYZaDWDOFje70gu4KJFIOVw80kL+53A1LxJF377fCJN0r2WJ10juYYt3bPH8Po9A/3wo9ynNeT1H+uWXADAUhxK5rmZDqSDOc3kTTMBsjwEXelooHH4G+Nkxwh44nRXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730080080; c=relaxed/simple;
	bh=sSbqj9PaCWZYYxllSWsBshDvFlWydAEhCNTVLeMVSZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YjQET34JBK8qXqNhkmuctT89RiCfTKQX2Z4E9uxJJnNQtF/pVNvEZ1JxUG3OymsyKy6dunrGgMq1k1hRjgnlITusvJnlrnBB6tqu+O+CZQtb+qhEj7sacpCc45VeMHT/djktK/IDzi+nJl3k+f3ubwqN0xuDhnRY99+dRfvzMTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XcGSg5ZZ6zyTQt;
	Mon, 28 Oct 2024 09:46:11 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 4EF92180106;
	Mon, 28 Oct 2024 09:47:48 +0800 (CST)
Received: from [10.174.179.80] (10.174.179.80) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 28 Oct 2024 09:47:47 +0800
Message-ID: <6bb74ccc-25e2-45c1-8a88-cfd093a194c7@huawei.com>
Date: Mon, 28 Oct 2024 09:47:46 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: fix FS_IOC_GETFSMAP handling
To: Theodore Ts'o <tytso@mit.edu>
CC: "Darrick J. Wong" <djwong@kernel.org>, Ext4 Developers List
	<linux-ext4@vger.kernel.org>
References: <20241023135949.3745142-1-tytso@mit.edu>
 <cf776ce1-596f-4b04-a79b-2fe7b5b83f6e@huawei.com>
 <20241025154213.GD3307207@mit.edu>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huawei.com>
In-Reply-To: <20241025154213.GD3307207@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100017.china.huawei.com (7.202.181.16)

On 2024/10/25 23:42, Theodore Ts'o wrote:
> On Fri, Oct 25, 2024 at 03:06:07PM +0800, Zhang Yi wrote:
>>
>> Now it seems to be able to handle all the necessary metadata in the
>> query range here, can we remove the processing of info->gfi_meta_list
>> in ext4_getfsmap_datadev_helper() as well?
> 
> Not without further code refactoring; we still need it if there are
> metadata blocks in the middle of the block group.

IIRC, at the moment, fixed metadata does not appear in the middle of
the block group.

> My main emphasis
> was keeping the code changes as simple so it would be easy to
> backport, and so I didn't do further optimizations.

OK.

> 
> As a related observation, I'm not entirely sure the current set of
> abstractions, where we pass exactly one set of helper/callback
> functions down through multiple functions is the best match for ext4.
> It should be possible to significantly simplify the call stack by
> reworking the GETFSMAP support.

Yeah, I have the same feeling too.

> 
> On the other hand, the current, more complicated design might be
> useful if at some point in the future, we were to add support for
> reverse mapping for online fsck and/or if we add reflink support.
> (See how Darrick implemented GETFSMAP for xfs.)
> 

Yes, the current GETFSMAP implementation on ext4 is incomplete and
has many limitations. If we had reserved mapping, we could achieve
more; for example, we could accurately query the inode to which a
block belongs, and the query efficiency would improve. As Baokun
mentioned earlier, we will take the time to look into the reverse
mapping first to hope to support it and maybe online fsck in the
future.

Thanks,
Yi.


