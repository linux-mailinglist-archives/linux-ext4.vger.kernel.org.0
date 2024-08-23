Return-Path: <linux-ext4+bounces-3875-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2363695C32F
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Aug 2024 04:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D31252848EE
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Aug 2024 02:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159DB1F956;
	Fri, 23 Aug 2024 02:22:32 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4675E1C694;
	Fri, 23 Aug 2024 02:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724379751; cv=none; b=jhSM85t1JdL9zsppfYtsSXbc0BtEag3Br5zrV9ckEGQhOUqRIOwXkoNa9KhD2XUvRaK8g+SYl0OfcsIaDsLo5dCBml5PzPBrRX7hKjtO/TixdXt65Kc8FsW9beMVqMuZ6kSXWAC+WaRHvVF7UpSlUIfYlrIYpegf+wONMBzqBXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724379751; c=relaxed/simple;
	bh=nOrZuPeyf18ibAl5wa652ja7uIfj/AZd/RJZ40Y0MEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YXyK8ZPN1rGgWjYceEMS9GzEi4dKzWC/w343voJx8qOiqFsiCIgXxHkOZ+O753kPv2i4sqrNC0cfOgNyzQ5rJEZho4sJlkiUnyFNJXxy2DzY3cjD2wY47LrLicVyXNZKJleG0IRj3tCc899MuIwTvgt1bN3T+HAsHpSOAdQb3kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WqkHN1zYxzQqMs;
	Fri, 23 Aug 2024 10:17:36 +0800 (CST)
Received: from dggpeml100021.china.huawei.com (unknown [7.185.36.148])
	by mail.maildlp.com (Postfix) with ESMTPS id 313241800D2;
	Fri, 23 Aug 2024 10:22:20 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.174) by dggpeml100021.china.huawei.com
 (7.185.36.148) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 10:22:19 +0800
Message-ID: <6ba9afc8-fa95-478c-8ed2-a4ad10b3c520@huawei.com>
Date: Fri, 23 Aug 2024 10:22:19 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: No need to continue when the number of entries is 1
To: Theodore Ts'o <tytso@mit.edu>, Edward Adam Davis <eadavis@qq.com>
CC: <syzbot+ae688d469e36fb5138d0@syzkaller.appspotmail.com>,
	<adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
References: <00000000000075a135061c0480d0@google.com>
 <tencent_BE7AEE6C7C2D216CB8949CE8E6EE7ECC2C0A@qq.com>
 <172433877725.370733.2330809797744892142.b4-ty@mit.edu>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <172433877725.370733.2330809797744892142.b4-ty@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml100021.china.huawei.com (7.185.36.148)

On 2024/8/22 23:00, Theodore Ts'o wrote:
> On Mon, 01 Jul 2024 22:25:03 +0800, Edward Adam Davis wrote:
>> When the number of entries mapped is 1, there is no need to split it.
>>
>>
> Applied, thanks!
>
> [1/1] ext4: No need to continue when the number of entries is 1
>        commit: b2b81e122b5616890ba6657adeb8aa5ca1f05fe2
>
> Best regards,

Hi Ted,

I think this patch is wrong and it will hide the real problem.

The maximum length of a filename is 255 and the minimum block size is 1024,
so it is always guaranteed that the number of entries is greater than or
equal to 2 when do_split() is called.

The problem reported by syzbot was actually caused by a missing check in
make_indexed_dir(). The issue has been fixed:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=50ea741def58

So unless ext4_dx_add_entry() and make_indexed_dir(), or some other function
has a bug, 'split == 0' will not occur.

If we want to defend against future changes that introduce bugs, I think
it's better to add a WARN_ON_ONCE to make sure that the problem isn't hidden
and that it doesn't trigger serious bugs like out-of-bounds access.

continued = WARN_ON_ONCE(split == 0) ? 0 : hash2 == map[split - 1].hash;

-- 
With Best Regards,
Baokun Li


