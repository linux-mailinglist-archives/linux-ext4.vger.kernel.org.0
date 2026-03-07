Return-Path: <linux-ext4+bounces-14698-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEfkHltrq2nycwEAu9opvQ
	(envelope-from <linux-ext4+bounces-14698-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sat, 07 Mar 2026 01:03:39 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F97228E2A
	for <lists+linux-ext4@lfdr.de>; Sat, 07 Mar 2026 01:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F442304F23A
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Mar 2026 00:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA8412CDBE;
	Sat,  7 Mar 2026 00:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="IVf10wvc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B95E17D6
	for <linux-ext4@vger.kernel.org>; Sat,  7 Mar 2026 00:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772841787; cv=none; b=ZFqKOC6GuRyw3vAFiI8zheb7fjVWBolImJdKWzOyhn4dSFNdrwa+I0yH3hrQSVkjFhQGbkst0Rp5kXYdyD3R882P8bHPlKtjrkFeCmIxdxYpMf27RIV/1fto+SLS9epqfbfeajyH5FSOJ+uZNUI0sw+20VyHhexEkYR5IYDxrak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772841787; c=relaxed/simple;
	bh=ZVLoZpgAlw0ScJhMYKkGxbBxgzWdaD+QAyf9hVyizWw=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TAClVtqiDYkP9cYXuWrW2t/KVLo+hCVjEVRgtz+kpNizvCyqituWzQ4CIKk0cd+sqgmdHm8bq8LuI6deKogfHenYTabCBa6NGF1j0u+RlUHLo9cTZ/mbdXdjUc9vukStlof/veinUDjNV7ZZD9ffxxVFaTytagiK39R4f3Ex6/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=IVf10wvc; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ZVLoZpgAlw0ScJhMYKkGxbBxgzWdaD+QAyf9hVyizWw=;
	b=IVf10wvc05V0wrZqf3y2gTwZUaHv7UK0eizSWSNSlt8Oolw2UfG565Ljx0DUpzhMFvkQ4y0PY
	17w1IW4HEfaQ6RwLj0kJm6EB3GWoN+1BwG0PWTO7Q0y1jMNg+Y+umKvuEoMZ/qlOOrkQD/vf5ce
	FgiViKbrPRBUjZgsh18XyTg=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4fSNdT3MBRz1K9YC;
	Sat,  7 Mar 2026 07:58:05 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id D134D4055B;
	Sat,  7 Mar 2026 08:02:55 +0800 (CST)
Received: from kwepemq500016.china.huawei.com (7.202.194.202) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 7 Mar 2026 08:02:55 +0800
Received: from [10.174.178.185] (10.174.178.185) by
 kwepemq500016.china.huawei.com (7.202.194.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 7 Mar 2026 08:02:54 +0800
Subject: Re: [PATCH v3] ext4: fix mballoc-test.c is not compiled when
 EXT4_KUNIT_TESTS=M
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Ye Bin <yebin@huaweicloud.com>
References: <20260227065514.2365063-1-yebin@huaweicloud.com>
 <aaqkoSTFyYzxxYRI@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
	<jack@suse.cz>
From: "yebin (H)" <yebin10@huawei.com>
Message-ID: <69AB6B2D.6070006@huawei.com>
Date: Sat, 7 Mar 2026 08:02:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aaqkoSTFyYzxxYRI@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq500016.china.huawei.com (7.202.194.202)
X-Rspamd-Queue-Id: 36F97228E2A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-14698-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,huawei.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[yebin10@huawei.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.955];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 2026/3/6 17:55, Ojaswin Mujoo wrote:
> On Fri, Feb 27, 2026 at 02:55:14PM +0800, Ye Bin wrote:
>> From: Ye Bin <yebin10@huawei.com>
>>
>> Now, only EXT4_KUNIT_TESTS=Y testcase will be compiled in 'mballoc.c'.
>> To solve this issue, the ext4 test code needs to be decoupled. The ext4
>> test module is compiled into a separate module.
>>
>> Reported-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
>> Closes: https://patchwork.kernel.org/project/cifs-client/patch/20260118091313.1988168-2-chenxiaosong.chenxiaosong@linux.dev/
>> Fixes: 7c9fa399a369 ("ext4: add first unit test for ext4_mb_new_blocks_simple in mballoc")
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>
> Hi Ye,
>
>>From my testing I can see that EXPORT_SYMBOL_FOR_MODULE() doesn't
> resepect the namespace restriction if EXT4_KUNIT_TESTS=y but I think
> that should be okay.
>
> The patch otherwise looks good. Feel free to add:
>
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>
> One thing, recently added extents-test.c is also having the same issue where
> it doesn't work when compiled as module. Would you be willing to fix it
> as well?
>
No problem, I will fix this issue.
> Regards,
> ojaswin
>
>
>
> .
>

