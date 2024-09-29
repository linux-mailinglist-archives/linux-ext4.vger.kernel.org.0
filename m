Return-Path: <linux-ext4+bounces-4367-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B721F98926E
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Sep 2024 03:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30D97B23CE4
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Sep 2024 01:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B2EBE4E;
	Sun, 29 Sep 2024 01:29:21 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594D4B65C;
	Sun, 29 Sep 2024 01:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727573361; cv=none; b=LxIYBuS3kJzYBZjmuGvqX7KiNI8SKzmbSX2g4pWO+U1j6yCdMFtm0k9nACvigF7povhi3eDchlvA8myCq0C/thzhyJSt++/596AnJGrhBjLoMHs079ZUL7HGULIXmVZQJOmQyJjpgN3YQxmaStvdU5OrjWFIb8nUQkDy2GXt84k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727573361; c=relaxed/simple;
	bh=ZQxcWdjFQ+Mn5MIS0vO1/UMUtpAiKVNnMUEPDQOTCow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SaR47aGriQ8NBkO0jVeAseNEqftofO5k+oAboXoWuQXmMY+RH5Ya5jjWqDy3ZjZyggN2Bh3wj1B8DR/mWsSptZy0MjPtrm3U2ehgwBcrfzI1WMie8eKExRczYpPrCtCW6e7Q3KwN91QqHSoL4VbNWID8eMIvYKh2779lswOlg5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XGRSH3ggtz4f3jkd;
	Sun, 29 Sep 2024 09:29:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D81FD1A0359;
	Sun, 29 Sep 2024 09:29:14 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP4 (Coremail) with SMTP id gCh0CgDH+sZkrfhmMpyPCg--.4259S3;
	Sun, 29 Sep 2024 09:29:12 +0800 (CST)
Message-ID: <330ed547-aeab-46d9-84b1-0d0dc0095943@huaweicloud.com>
Date: Sun, 29 Sep 2024 09:29:08 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ext4: fix off by one issue in alloc_flex_gd()
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>,
 Wesley Hershberger <wesley.hershberger@canonical.com>,
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
 stable@vger.kernel.org, Yang Erkun <yangerkun@huawei.com>
References: <20240927133329.1015041-1-libaokun@huaweicloud.com>
 <fbe9ed47-b3cc-4c51-8d25-f44838327f89@redhat.com>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <fbe9ed47-b3cc-4c51-8d25-f44838327f89@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDH+sZkrfhmMpyPCg--.4259S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWxtw1fKr1DGryrKrykZrb_yoW8GF1UpF
	y3Ka15KFyqgw4xAr9xG3s29ry3XFW8C3WYqrWrX34UZFnrCrnxKr1Ig398WF1DZrnagryY
	yFZagFyIk3srJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgABBWb3vpwm2gABsI

On 2024/9/27 22:14, Eric Sandeen wrote:
> On 9/27/24 8:33 AM, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
> ...
>
>> Delete the problematic plus 1 to fix the issue, and add a WARN_ON_ONCE()
>> to prevent the issue from happening again.
>>
>> Reported-by: Wesley Hershberger <wesley.hershberger@canonical.com>
>> Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2081231
>> Reported-by: Stéphane Graber <stgraber@stgraber.org>
>> Closes: https://lore.kernel.org/all/20240925143325.518508-1-aleksandr.mikhalitsyn@canonical.com/
>> Tested-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
>> Tested-by: Eric Sandeen <sandeen@redhat.com>
> The patch has changed a little since I tested, but it still passes my testcase
> (as expected, no WARN ON etc) so looks good from that POV, thanks!
> -Eric

Hi Eric,

Thanks for testing it again!

The core modification logic remains unchanged from before.
Just added a max_resize_bg variable for exception fixing.

It is necessary to ensure that flex_gd->resize_bg does not exceed the
smaller of flexbg_size and MAX_RESIZE_BG before it is used. So we need
to record max_resize_bg, warn on resize_bg adjustment logic exceptions,
and use max_resize_bg to avoid subsequent resize complaints.


-- 
With Best Regards,
Baokun Li


