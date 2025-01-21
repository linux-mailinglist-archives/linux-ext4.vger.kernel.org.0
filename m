Return-Path: <linux-ext4+bounces-6170-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9938CA17D33
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 12:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CC611889E5B
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 11:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3031F1503;
	Tue, 21 Jan 2025 11:43:29 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8BE1F12E9;
	Tue, 21 Jan 2025 11:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737459808; cv=none; b=O8wF60lZ+toOnn4hcAZg54+MzMa2A6HzYaq5n1uAaMFs2JhHnBgr1DDMO8CnZPgFW81zcAPxmrVq4KThu5SvTRj0m4Iq3lg4IejQAS3jn1ZCog4GhrwBjgeNUbvcDTfF2bkuzMb68K8IA78HZ5El+nlXGTuYcY7s5F2Gl34DXUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737459808; c=relaxed/simple;
	bh=ak4hxFfLrYd/ZcqUOkp8Q8bt8vx9/RPARIJY9BEHhBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KyREU3l+wtNkEC12+THL2SByFozVJgxINUXK+Z4Mdp0rJk7pXckG73wIo0L79/BcI9ZXQ/F0ahC4NPHiEuuycZn23vlW3kcDEwL/MK/9JlBcVkIivBjXfavtVxIayrobceZASdiYyi1zIXbZA6cLQ0VZzfkN3ZlqBKfwjJkFc5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Yclj03Thmz20pGh;
	Tue, 21 Jan 2025 19:43:48 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C7871400D5;
	Tue, 21 Jan 2025 19:43:23 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 21 Jan
 2025 19:43:22 +0800
Message-ID: <094e349d-57c1-4450-b813-a774b6dad1cc@huawei.com>
Date: Tue, 21 Jan 2025 19:43:21 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] ext4: abort journal on data writeback failure if
 in data_err=abort mode
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, Baokun Li <libaokun1@huawei.com>, Baokun Li
	<libaokun@huaweicloud.com>
References: <20250121071050.3991249-1-libaokun@huaweicloud.com>
 <20250121071050.3991249-6-libaokun@huaweicloud.com>
 <cuanusobp4oiptmmyruiimehe25zizbgdxgx5a7oudvo6repox@drpwkdfp7hpw>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <cuanusobp4oiptmmyruiimehe25zizbgdxgx5a7oudvo6repox@drpwkdfp7hpw>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/1/21 19:13, Jan Kara wrote:
> On Tue 21-01-25 15:10:47, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> The data_err=abort was initially introduced to address users' worries
>> about data corruption spreading unnoticed. With direct writes, we can
>> rely on return values to confirm successful writes to disk. But with
>> buffered writes, a successful return only means the data has been written
>> to memory. Users have no way of knowing if the data has actually written
>> it to disk unless they use fsync (which impacts performance and can
>> sometimes miss errors).
>>
>> The current data_err=abort implementation relies on the ordered data list,
>> but past changes have inadvertently altered its behavior. For example, if
>> an extent is unwritten, we do not add the inode to the ordered data list.
>> Therefore, jbd2 will not wait for the data write-back of that inode to
>> complete and check for errors in the inode mapping. Moreover, the checks
>> performed by jbd2 can also miss errors.
>>
>> Now, all buffered writes eventually call ext4_end_bio(), where I/O errors
>> are checked. Therefore, we can check for the data_err=abort mode at this
>> point and abort the journal in a kworker (due to the interrupt context).
>>
>> Therefore, when data_err=abort is enabled, the journal is aborted in
>> ext4_end_io_end() when an I/O error is detected in ext4_end_bio() to make
>> users who are concerned about the contents of the file happy.
>>
>> Suggested-by: Jan Kara <jack@suse.cz>
>> Link: https://patch.msgid.link/c7ab26f3-85ad-4b31-b132-0afb0e07bf79@huawei.com
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
> Looks good. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> Just one naming suggestion below:
Thank you for your review!
>
>> +#define EXT4_IO_END_NEED_COMPLETION (EXT4_IO_END_UNWRITTEN | EXT4_IO_END_FAILED)
> I'd call this EXT4_IO_END_DEFER_COMPLETION
>
>> +static bool ext4_io_end_need_completion(ext4_io_end_t *io_end)
> And this would then be ext4_io_end_defer_completion().
>
> 								Honza
Okay, I'll replace need_completion with defer_completion
in the next version.

Thanks,
Baokun


