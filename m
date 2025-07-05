Return-Path: <linux-ext4+bounces-8825-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343D7AF9CF6
	for <lists+linux-ext4@lfdr.de>; Sat,  5 Jul 2025 02:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98EF4A66B7
	for <lists+linux-ext4@lfdr.de>; Sat,  5 Jul 2025 00:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EF33594E;
	Sat,  5 Jul 2025 00:39:59 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DC45383
	for <linux-ext4@vger.kernel.org>; Sat,  5 Jul 2025 00:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751675998; cv=none; b=CR0AYIEfk/OTLgyL7DsiYnAZZ5kQu7bvbZdzjwpOAIv1O5cZdMoeOUpsyzVQsZr6cJaDYmMPC6nbiXXtP46tGzq0RdLrmSh4MEbDbBbQ1FQF4/sNhbOsSzjBaQYGt4spXWELi/UDgXfjUEQVO8C+N240/YEPFGsqQWtGUc9O7qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751675998; c=relaxed/simple;
	bh=cxQqAtm+sBf5Nb+8GDpOaMDtCgd6sZJTAIxVoX7R0Fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a5xomNDuhT3q/zxaeT4ASr0CRMilLE8h6Wu/tMGVqzNuS/zB28l94LK6QkDS50jMq00NCNEwUnGZrakjNlafL/hyUZzU7LCIy5nIJPlQWlUl2ghZFse40+oG5tkB/qx7kFra0kff8KBBDnI7hGzs92W1uxYSqFyZi80HALIvfXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bYs3L5yM8z14Lnd;
	Sat,  5 Jul 2025 08:35:10 +0800 (CST)
Received: from kwepemo100017.china.huawei.com (unknown [7.202.195.215])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B2F51402FC;
	Sat,  5 Jul 2025 08:39:52 +0800 (CST)
Received: from [10.174.187.231] (10.174.187.231) by
 kwepemo100017.china.huawei.com (7.202.195.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 5 Jul 2025 08:39:51 +0800
Message-ID: <20cb25f6-add9-8944-3138-92f95c8b0d45@huawei.com>
Date: Sat, 5 Jul 2025 08:39:51 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v4] debugfs/logdump.c: Add parameter t to dump sequence
 commit timestamps
To: "Darrick J. Wong" <djwong@kernel.org>
CC: Theodore Ts'o <tytso@mit.edu>, <linux-ext4@vger.kernel.org>,
	<qiangxiaojun@huawei.com>, <hejie3@huawei.com>
References: <f5445a3b-f278-6440-91f3-08e5ca5b93cf@huawei.com>
 <20250703153907.GA2672022@frogsfrogsfrogs>
 <55e2c4b2-5ceb-7aa9-772b-a2dc1f2fdbaf@huawei.com>
 <20250704033354.GA2672070@frogsfrogsfrogs>
From: zhanchengbin <zhanchengbin1@huawei.com>
In-Reply-To: <20250704033354.GA2672070@frogsfrogsfrogs>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo100017.china.huawei.com (7.202.195.215)

On 2025/7/4 11:33, Darrick J. Wong worte:
> On Fri, Jul 04, 2025 at 10:11:09AM +0800, zhanchengbin wrote:
>> On 2025/7/3 23:39, Darrick J. Wong wrote:
>>> On Thu, Jul 03, 2025 at 08:07:53PM +0800, zhanchengbin wrote:
>>>>
>>>> +static void dump_commit_time(FILE *out_file, char *buf)
>>>> +{
>>>> +	struct commit_header	*header;
>>>> +	uint64_t	commit_sec;
>>>> +	time_t		timestamp;
>>>> +	char		time_buffer[26];
>>>> +	char		*result;
>>>> +
>>>> +	header = (struct commit_header *)buf;
>>>> +	commit_sec = be64_to_cpu(header->h_commit_sec);
>>>> +
>>>> +	timestamp = commit_sec;
>>>> +	result = ctime_r(&timestamp, time_buffer);
>>>> +	if (result)
>>>> +		fprintf(out_file, ", commit at: %s", time_buffer);
>>>
>>> Nit: missing newline in this fprintf... or you could delete the newline
>>> below and change the callsite to:
>>>
>>> 	if (dump_time)
>>> 		dump_commit_time(out_file, buf);
>>> 	fprintf(out_file, "\n");
>>>
>>
>> In my test environment, the string generated by ctime_r comes with a
>> newline character at the end.
> 
> Oh, I guess that /is/ in the manpage:
> 
> 	Broken-down time is stored in the structure tm, described in
> 	tm(3type).
> 
> 	The call ctime(t) is equivalent to asctime(localtime(t)).  It
> 	converts the calendar time t into a null-terminated string of
> 	the form
> 
>             "Wed Jun 30 21:49:08 1993\n"
> 
> and then POSIX has this to say about asctime():
> 
> 	The asctime() function shall convert the broken-down time in the
> 	structure pointed to by timeptr into a string in the form:
> 
> 	Sun Sep 16 01:03:52 1973\n\0
> 
> which is also in ISO C23:
> 
> 	The asctime function converts the broken-down time in the
> 	structure pointed to by timeptr into a string in the form:
> 
> 	Sun Sep 16 01:03:52 1973\n\0
> 
> 	using the equivalent of the following algorithm.

Get it.

> 
> Sigh.
> 
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Thanks,
  - bin.

>>>
>>> .
>>>
> 
> .
> 

