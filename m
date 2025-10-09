Return-Path: <linux-ext4+bounces-10716-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 641BFBC812D
	for <lists+linux-ext4@lfdr.de>; Thu, 09 Oct 2025 10:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F4EA34E887
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Oct 2025 08:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3192BE7AD;
	Thu,  9 Oct 2025 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="A3rprOKG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F26434BA3F
	for <linux-ext4@vger.kernel.org>; Thu,  9 Oct 2025 08:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759999138; cv=none; b=TmRMvc87ClQPGNwSGJANXpY3TTBaSZ04FmILIjR3/TI58aUQA3NPS3skL+pykCUl9/mJbFs6tEz90yMZt5Jaft+FD8fJD9aVoqES23q2Sas00wV0TUCrlM+LlQaGHJ+0ZHTgNRLAPM9/0oe5+ZBaoq/gcyQ5yqEyPZ2XTTmpDTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759999138; c=relaxed/simple;
	bh=qhhKwgudoRE9wV/4NXn2yDOWRmKWDI5xqflwdVd6u6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vAlTFeB7VLvsSCVBbsuI8om03qoOBJyQB+W/1YFXA83O9PCEkqC/5yzO0VZhr3MGEuxk+St51g4mejyIW57AUQM73Y9mgMs4fCE9MYh/L10djg38PAWrVyR8CKckrK7fP0zP3CLCOCZpWm9dyLOxZ1eMpLWPfDbPh3c6k91Q+bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=A3rprOKG; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cj3F84zRqz9tJf;
	Thu,  9 Oct 2025 10:38:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1759999132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eCEzNY6Q2L5RQfSo6QPJSEiF5DxS6FHWs3pg4zy65m0=;
	b=A3rprOKGaJoI2ZzaMYYY8ag8xKrhSgP6MOqlQZc8BBCiL28DbQzOnMCbptA6n6J3L8TUdN
	hV3LGFmGukzutm3I7+0o2mZ4+yx4B2qSd3gv5S1WOCZXxVlxKx1p2PK8dKs5H6TN6Pgwu8
	n6YWvyKwV7E/lpY31fvyStiTHGqplWrCWmNcqqmdIRHsvYweRz+TLlvylZ/UR4I/xDxmQK
	w+pQb2rmOyHP7Njut7Uuh0ulBylOQVef6wn50ygKUXyMmyDkYsorETQgGNAp8ANQ7bjyJW
	UnLKNN0ugvNglDF1aLfbo/tF3ysR1ZB0qjVFuQmQXuioi6udn3nbBNqSFWaXOw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
Message-ID: <29ae1a6f-64da-4fdd-bd30-24c715f6faf0@pankajraghav.com>
Date: Thu, 9 Oct 2025 10:38:48 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: LBS support for ext4
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Baokun Li <libaokun1@huawei.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Swarna Prabhu <s.prabhu@samsung.com>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 Zhang Yi <yi.zhang@huawei.com>
References: <c0ea5334-6439-4ec9-a1eb-a9eb0863c3b7@pankajraghav.com>
 <69b42833-87ce-4a16-8f1b-7130fdfd23dc@huaweicloud.com>
Content-Language: en-US
From: Pankaj Raghav <kernel@pankajraghav.com>
In-Reply-To: <69b42833-87ce-4a16-8f1b-7130fdfd23dc@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4cj3F84zRqz9tJf

On 10/9/25 10:07, Zhang Yi wrote:
> [added ext4 list to CC]
> 
> Hi, Pankaj! Thank you for your letter.
> 
> On 10/7/2025 7:21 PM, Pankaj Raghav wrote:
>> Hi Baokun and Zhang,
>>
>>   I hope you both are doing well.
>>
>> I was wondering recently about LBS support for ext4. You said you were working on them and have some
>> local patches that enabled them [1]. Is there any update on that and when do you plan to post them
>> on the mailing list? :)
>>
> 
> The current development work for ext4 LBS is essentially complete, and
> testing is underway using various configurations of xfstests-bld.
> However, since many test cases in the existing xfstests have
> dependencies, such as rely on a 4KB block size image. So numerous cases
> have failed. It is now necessary to analyze each failed case
> individually and establish a new testing baseline.
> 

Yes, we had similar issues with XFS where the test assumed the block size
can never be > PS. I fixed most of the issues in generic but I am not sure
about ext4 specific test cases.

>> We are very interested in adding this support to ext4, so please let us know if you need some help
>> with the review or testing.
>>
> 
> Baokun has been working on this, but the failure cases have not yet been
> fully analyzed and he is currently on an urgent business trip. We can
> send out an RFC series by mid to late this month after he returns.
> Testing, analysis and review are welcome!
> 

Perfect. Thanks a lot for the update and including the list in the conversation :)

--
Pankaj


