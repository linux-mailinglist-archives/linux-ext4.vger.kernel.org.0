Return-Path: <linux-ext4+bounces-12365-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B6BCBDE04
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Dec 2025 13:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 424FD30852F2
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Dec 2025 12:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B392DCF4C;
	Mon, 15 Dec 2025 12:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="OMrqIk1m"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3860027E077;
	Mon, 15 Dec 2025 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765802535; cv=none; b=hV+TzYd3UdR4yqp4gurKG4xrPT2RFdnRbWmxjn4Oh7Tfb3KjzfTU6+dj1CJAR5967dysyGo+yrJ448Z+xmRWR0DtaZFXnNvYLa6egXho9nfjmitilSl5cEcjot4SEUxFoAIlo37/SSxKC+gysNfaL1HswzTZ6V7eV3j1ufrpsJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765802535; c=relaxed/simple;
	bh=VoHamF7GtZxpN6PD6PnCnVW8wFOcB6e8n24dSKMRbt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bNINgFxGRhooAX+0WiRWkJHA9gQavG1b/qpon0UBxPaIYRIyjnYU1irmgnUMpEXyFkn6lgtx4mFVcAwEqCX32Qe4DVduBH6npfCbFTAww4mrkwF7xYwIaZWsM6BPFgZ+OcIRINlWvXOUwtwKld25OlPIwlgRJ6mbX/kMcOWMm3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=OMrqIk1m; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=VoHamF7GtZxpN6PD6PnCnVW8wFOcB6e8n24dSKMRbt0=;
	b=OMrqIk1mDJjH6zXbG3PNhE0X0YeGcEObWy2/DMfO64jzgJQFNlSItMKzyH9yagiRhVPK98zq1
	e5YAujaAfLso02JyUvP+D/fY7V/pw1zuqH9jcLtHHU0Re+RdwiuVEd6LyJRK9EZBg+6Xblr8ckk
	4fYgZDcBsYMi1Ho0a4pGJAk=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dVKQc2cZYzLlSw;
	Mon, 15 Dec 2025 20:40:08 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 908551402C6;
	Mon, 15 Dec 2025 20:42:07 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 15 Dec
 2025 20:42:06 +0800
Message-ID: <3f5ec6d7-d291-4b37-8914-3b4347564e98@huawei.com>
Date: Mon, 15 Dec 2025 20:42:05 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: Fix KASAN use-after-free in ext4_find_extent
Content-Language: en-GB
To: =?UTF-8?B?5L2Z5piK6ZOW?= <3230100410@zju.edu.cn>
CC: <security@kernel.org>, <linux-ext4@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <2edd9a0c.3e90f.19b0314cfc8.Coremail.3230100410@zju.edu.cn>
 <19b5b9b3-5243-459b-a264-257f9c8324ec@huawei.com>
 <3c54df5e.436a9.19b21b55d21.Coremail.3230100410@zju.edu.cn>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <3c54df5e.436a9.19b21b55d21.Coremail.3230100410@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-12-15 19:11, 余昊铖 wrote:
> Hi,
>
> I have disabled CONFIG_BLK_DEV_WRITE_MOUNTED and spent some time trying to trigger the reported KASAN issues. And I found neither of the two bugs has been observed since. Is this issue still worth investigating?

That essentially confirms the issue is caused by bypassing the
filesystem to write directly to the raw disk. This is a known
issue and is quite tricky to solve.

You can work around this specific class of issues in your fuzz
testing by enabling CONFIG_BLK_DEV_WRITE_MOUNTED. Syzbot runs
with this configuration enabled by default.


Cheers,
Baokun

> Thanks,
> Haocheng Yu
>
>
>> Hi,
>>
>> On 2025-12-09 20:27, 余昊铖 wrote:
>>> Hello,
>>>
>>>
>>> I would like to report a potential security issue in the Linux kernel ext4 filesystem, which I found using a modified syzkaller-based kernel fuzzing tool that I developed.
>>>
>> I noticed that your configuration has CONFIG_BLK_DEV_WRITE_MOUNTED enabled.
>>
>> This setting allows bare writes to an already mounted ext4 filesystem,
>> meaning certain ext4 metadata (like extent tree blocks) can be modified
>> without the filesystem being aware of the changes.
>>
>> Could you please try disabling CONFIG_BLK_DEV_WRITE_MOUNTED and see
>> if the issue is still reproducible?
>>
>>
>> Cheers,
>> Baokun



