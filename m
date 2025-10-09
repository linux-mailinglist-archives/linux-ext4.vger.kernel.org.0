Return-Path: <linux-ext4+bounces-10715-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA34DBC7EEB
	for <lists+linux-ext4@lfdr.de>; Thu, 09 Oct 2025 10:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B17E74211A3
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Oct 2025 08:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E169F26F29F;
	Thu,  9 Oct 2025 08:07:22 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803EB260565
	for <linux-ext4@vger.kernel.org>; Thu,  9 Oct 2025 08:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759997242; cv=none; b=AzrJMKrHRpjroOU6KzQ10eYUo8o3XsdEvbVhvA2YvvyqCIeegJ5X7F7HChHuo94QRfOhREFrV5r465yKMFaijSXi6Sale3gL370B3/2s7zaione1aciD6O9JLfAAURmVE6zJm0WfxcLFaKrDpq+QnKgRI5ZRFZYQAj8xTLOLYj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759997242; c=relaxed/simple;
	bh=utrrpxxf7t1CuUzB6xsJLdoWf7fraSzwhtq1xRuxEhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBCUwOb8tXvXnoGhZhYJHlN949iKD4qxLJccbKCCNfD9dGrW7+h4ea4QOubBOxz60IXkdiEN9345cDOri0DyOHC1wnhROYsEZFvEsjVZW3cmr+tF94xaavPPeZqWQbhDiKpxQHQtMhnlqVS+2Jf8o+Z50+jghus8vbwichwuC4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cj2X83ftRzKHMYF
	for <linux-ext4@vger.kernel.org>; Thu,  9 Oct 2025 16:06:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 130E81A018D
	for <linux-ext4@vger.kernel.org>; Thu,  9 Oct 2025 16:07:17 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP3 (Coremail) with SMTP id _Ch0CgD3jz4zbedov1UQCQ--.11887S3;
	Thu, 09 Oct 2025 16:07:16 +0800 (CST)
Message-ID: <69b42833-87ce-4a16-8f1b-7130fdfd23dc@huaweicloud.com>
Date: Thu, 9 Oct 2025 16:07:15 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LBS support for ext4
To: Pankaj Raghav <me@pankajraghav.com>
Cc: Baokun Li <libaokun1@huawei.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Swarna Prabhu <s.prabhu@samsung.com>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 Zhang Yi <yi.zhang@huawei.com>
References: <c0ea5334-6439-4ec9-a1eb-a9eb0863c3b7@pankajraghav.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <c0ea5334-6439-4ec9-a1eb-a9eb0863c3b7@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgD3jz4zbedov1UQCQ--.11887S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr4rur48Aw4UArWxtw1DZFb_yoWkZFb_Wa
	s0qryDC3W0vF1av3y7KF1qkFZaqw4Uu34Ut34DWw1UK342vr4DG3WkGFn0vr1xGFZ5Cr15
	urnrAF12934a9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbz8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

[added ext4 list to CC]

Hi, Pankaj! Thank you for your letter.

On 10/7/2025 7:21 PM, Pankaj Raghav wrote:
> Hi Baokun and Zhang,
> 
>   I hope you both are doing well.
> 
> I was wondering recently about LBS support for ext4. You said you were working on them and have some
> local patches that enabled them [1]. Is there any update on that and when do you plan to post them
> on the mailing list? :)
> 

The current development work for ext4 LBS is essentially complete, and
testing is underway using various configurations of xfstests-bld.
However, since many test cases in the existing xfstests have
dependencies, such as rely on a 4KB block size image. So numerous cases
have failed. It is now necessary to analyze each failed case
individually and establish a new testing baseline.

> We are very interested in adding this support to ext4, so please let us know if you need some help
> with the review or testing.
> 

Baokun has been working on this, but the failure cases have not yet been
fully analyzed and he is currently on an urgent business trip. We can
send out an RFC series by mid to late this month after he returns.
Testing, analysis and review are welcome!

Best Regards,
Yi.


