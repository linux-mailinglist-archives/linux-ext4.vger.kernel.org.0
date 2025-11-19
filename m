Return-Path: <linux-ext4+bounces-11907-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CD7C6C4CE
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Nov 2025 02:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 3EB9C2B96E
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Nov 2025 01:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5141B22AE7A;
	Wed, 19 Nov 2025 01:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="avwUYLSC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6538086353
	for <linux-ext4@vger.kernel.org>; Wed, 19 Nov 2025 01:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763517152; cv=none; b=AfwxFbiK+qzPEuYB4IefU4vg7b78iWRbE5AxMahMZIYpHjuqF9/rR5+d84FrJiHJoMCsaP8NRZZ/k7dJsuY0LlAHWeSCImvBbRt0b9Wm7y9Rc32X3OlbL/O49+LHk+MpqC4roQkVZ2AV8iLHQpzibb0M9q9/JXFvTelK0qhmoF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763517152; c=relaxed/simple;
	bh=nVbdWVPRpTEjBYI9KNrUGBb4aeZ0G3FGNNc0kqqhqUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YkIwuVMlk9mCkldKkqhd+hgIBmxZX5aJffQqFh7yoinhbFYP2dFHcrNINq9kplfmOe0jRlkX4UDwk0O7rVTeA9xCnF3jEsBzyuZ9S6TtXnkl5nns3zbfhnUaw37BL8O/LzsSxHMK0Tidrlg+JZUqPqHQnuZJ2lW44D9oxbrvYsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=avwUYLSC; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=quD8ngtIuwmSdITOvmjuQeSvvzwiEasFx/j9e9qIoeQ=;
	b=avwUYLSC9Tzqb4OfG5nDNYsCVhYFhhwH8g7GoA/5RQJTPdI6SOcTCQxjNjbevR2kcCXW2xAKQ
	XRZkCZl9kU9VxfsOjthO2UnCUr+16BnMknxk+7crViyHcqeh/VcnJPInJhKtMQm2KbhdN3UycWG
	5huIq3kv0yGBHJJ2ssez5mM=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dB4Dp2ytZzcZxv;
	Wed, 19 Nov 2025 09:50:18 +0800 (CST)
Received: from kwepemj500016.china.huawei.com (unknown [7.202.194.46])
	by mail.maildlp.com (Postfix) with ESMTPS id 19B1C1402C1;
	Wed, 19 Nov 2025 09:52:20 +0800 (CST)
Received: from [10.174.187.148] (10.174.187.148) by
 kwepemj500016.china.huawei.com (7.202.194.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 19 Nov 2025 09:52:19 +0800
Message-ID: <b77146eb-f2cf-f2eb-b0c2-561879c23475@huawei.com>
Date: Wed, 19 Nov 2025 09:52:19 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 2/2] resize: fix memory leak when exiting normally
To: "Darrick J. Wong" <djwong@kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
	<yangyun50@huawei.com>
References: <20251118132601.2756185-1-wuguanghao3@huawei.com>
 <20251118132601.2756185-3-wuguanghao3@huawei.com>
 <20251118182919.GP196358@frogsfrogsfrogs>
From: Wu Guanghao <wuguanghao3@huawei.com>
In-Reply-To: <20251118182919.GP196358@frogsfrogsfrogs>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemj500016.china.huawei.com (7.202.194.46)



在 2025/11/19 2:29, Darrick J. Wong 写道:
> On Tue, Nov 18, 2025 at 09:26:01PM +0800, Wu Guanghao wrote:
>> The main() function only releases fs when it exits through the errout or
>> success_exit labels. When completes normally, it does not release fs.
>>
>> Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
>> ---
>>  resize/main.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/resize/main.c b/resize/main.c
>> index 08a4bbaf..71711229 100644
>> --- a/resize/main.c
>> +++ b/resize/main.c
>> @@ -702,6 +702,8 @@ int main (int argc, char ** argv)
>>  	}
>>  	if (fd > 0)
>>  		close(fd);
>> +
>> +	(void) ext2fs_close_free(&fs);
> 
> You might want to capture and print an error if one is returned, because
> ext2fs_close_free will also flush the new metadata to disk.
> 
> --D
> 
This is not an error, but a normal process exit. If there is an error, it will follow the errout tag.

>>  	remove_error_table(&et_ext2_error_table);
>>  	return 0;
>>  errout:
>> -- 
>> 2.27.0
>>
>>
> 
> 
> .

