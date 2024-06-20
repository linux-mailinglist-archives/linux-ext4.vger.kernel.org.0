Return-Path: <linux-ext4+bounces-2904-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2A290FCBB
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jun 2024 08:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1DFA1F2128E
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jun 2024 06:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5130364AE;
	Thu, 20 Jun 2024 06:32:52 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63261320F
	for <linux-ext4@vger.kernel.org>; Thu, 20 Jun 2024 06:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718865172; cv=none; b=PdEeiFczSYtqhaMi+mJXFqAcKEXWjjuuGfizok45csKmEQg1u73v+/K6vFzpOEEUmsAOHk8yDS54PZG8MSjOV52ov4suZQqAwYdXSKka78oCoHWVpy+etTbegjj5dWCq4AFqw3Nk1h64ASy8JH2qKnWuMN2uGrewU6N1IYw5piQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718865172; c=relaxed/simple;
	bh=Y6O2Zh18ni00QmuyNsQ3QXxbIvp6KwWys0tBBDoaX/o=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WFnVhXwJ/LkdpSUQ0TuZMlN4Iywok3oOx7zI/OBnMEORXEUc8W26mwDc3ramuEpWZPsrKj3m6IePkiqYpbRHDswZA4Kw+TKi6FYdjivTg718WTnT9OMd4uVEBTgO5vCTvukQr3NFVqmsY3gpcVG1uVJm8xWczcGm8WaS7ZC5Kxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W4VtR6LhCzwS4L;
	Thu, 20 Jun 2024 14:28:31 +0800 (CST)
Received: from kwepemd200022.china.huawei.com (unknown [7.221.188.232])
	by mail.maildlp.com (Postfix) with ESMTPS id 060A4180064;
	Thu, 20 Jun 2024 14:32:48 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 kwepemd200022.china.huawei.com (7.221.188.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Jun 2024 14:32:47 +0800
Subject: Re: [PATCH v3] jbd2: avoid mount failed when commit block is partial
 submitted
To: Theodore Ts'o <tytso@mit.edu>, Ye Bin <yebin@huaweicloud.com>
References: <20240425064515.836633-1-yebin@huaweicloud.com>
 <20240620025031.GA1553731@mit.edu>
CC: <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>, <jack@suse.cz>
From: "yebin (H)" <yebin10@huawei.com>
Message-ID: <6673CD0E.7070100@huawei.com>
Date: Thu, 20 Jun 2024 14:32:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240620025031.GA1553731@mit.edu>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200022.china.huawei.com (7.221.188.232)



On 2024/6/20 10:50, Theodore Ts'o wrote:
> Apologies for not getting back to this until now; I was focused on
> finalizing changes for the merge window, and then I was on vacation
> for the 3 or 4 weeks.
>
> On Thu, Apr 25, 2024 at 02:45:15PM +0800, Ye Bin wrote:
>> From: Ye Bin <yebin10@huawei.com>
>>
>> We encountered a problem that the file system could not be mounted in
>> the power-off scenario. The analysis of the file system mirror shows that
>> only part of the data is written to the last commit block.
>> The valid data of the commit block is concentrated in the first sector.
>> However, the data of the entire block is involved in the checksum calculation.
>> For different hardware, the minimum atomic unit may be different.
>> If the checksum of a committed block is incorrect, clear the data except the
>> 'commit_header' and then calculate the checksum. If the checkusm is correct,
>> it is considered that the block is partially committed.
> This makes a lot of sense; thanks for changing the patch to do this.
>
>> However, if there are valid description/revoke blocks, it is
>> considered that the data is abnormal and the log replay is stopped.
> I'm not sure I understand your thinking behind this part of the patch,
> though.  The description/revoke blocks will have their own checksum,
> and while I grant that it would be... highly unusual for the commit
> block to be partially written as the result of a torn write, and then
> for there to be subsequent valid descriptor or revoke blocks (which
> would presumably be part of the next transaction), I wonder if the
> extra complexity is worth it.
>
> I can't think of a situation where this might happen other than say, a
> bit flip in the portion of commit block where we don't care about its
> contents; but in that case, after zeroing out parts of the commit
> block that we don't care about, if the checksum is valid, presumably
> we would have managed to luckily recover from the bit flip.  So
> continuing shouldn't be risky.
We cannot fundamentally solve malicious data tampering by searching for 
valid logs
through scanning. My idea in doing this is that even if the kernel knows 
there is a
problem with the data and insists on replaying logs, it is not good. We 
should let the
user decide what to do. But when i think about it, doing log recovery 
based on what
we believe to be the correct scan results is actually a presumptuous 
claim. I agree with
your point of view that the problem should not be complicated.
I will delete these judgments and send another version.
> What am I missing?
>
> 						- Ted
> .
>


