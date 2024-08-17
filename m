Return-Path: <linux-ext4+bounces-3751-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED85C955499
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Aug 2024 03:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C7BF1C21ADD
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Aug 2024 01:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277B3B66C;
	Sat, 17 Aug 2024 01:29:33 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807F5AD52;
	Sat, 17 Aug 2024 01:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723858172; cv=none; b=bLlVcPR93IqM4d88EdNAKH6JbrkQiKABGXe+ivNBIsMzWNE6nKVhjIkp5nUml8LhDHoDXnz+J7v6fRLXjtQx/vcC/W+TDGvJ11SyGdbAbkZ9useTHa4mrRzPUnitZEOFTG1Ed02s1xDNfGJyXxwNNEHBhtw1XBhJldgt9QpP1FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723858172; c=relaxed/simple;
	bh=B5BkuD8o6Mx3dm4hQm3aSwfgvwqiy1n28NaUq5o/2CU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t0eFWci0AexqPnOVWQOA1z36ShPTFFvq3LARmO0wSHJys7GbghHLvCpP3d1psFBgLp0gUiYgaNEeu8jaBd97plKsgy+SLhn01aMo4mG1ujYuNTCAbyB6pO7L3+WrcM9MxFhW2w7PNct95cWVEcPG6O90wtAECoBX9Dsyrv/1W9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wm1VH0yHxz4f3l1y;
	Sat, 17 Aug 2024 09:29:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 002721A058E;
	Sat, 17 Aug 2024 09:29:25 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgB37ILz_L9mc4edBw--.25760S3;
	Sat, 17 Aug 2024 09:29:25 +0800 (CST)
Message-ID: <ee50fce8-d931-eb10-78eb-7157a2c9020b@huaweicloud.com>
Date: Sat, 17 Aug 2024 09:29:23 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] ext4: disambiguate the return value of
 ext4_dio_write_end_io()
To: alexjlzheng@gmail.com, yangerkun@huaweicloud.com,
 "Darrick J. Wong" <djwong@kernel.org>
Cc: adilger.kernel@dilger.ca, alexjlzheng@tencent.com,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu
References: <9de82d23-902f-cb18-7688-f5e687e86d14@huaweicloud.com>
 <20240816165731.1007238-1-alexjlzheng@tencent.com>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <20240816165731.1007238-1-alexjlzheng@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB37ILz_L9mc4edBw--.25760S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4DAr1DAw47uw4fZw1rXrb_yoW5WF1kpr
	s8uF9FkrWqv347Cw4xKFn5Zr10ka1UGrWUXryqgw1xZryqvwn7KF48ta4Y9F18CrZ7Gw4F
	qF4vqrZxZw18A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
	73UjIFyTuYvjfUYCJmUUUUU
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/



在 2024/8/17 0:57, alexjlzheng@gmail.com 写道:
> On Fri, 16 Aug 2024 20:21:22 +0800, yangerkun@huaweicloud.com wrote:
>> 在 2024/8/15 19:27, alexjlzheng@gmail.com 写道:
>>> From: Jinliang Zheng <alexjlzheng@tencent.com>
>>>
>>> The commit 91562895f803 ("ext4: properly sync file size update after O_SYNC
>>> direct IO") causes confusion about the meaning of the return value of
>>> ext4_dio_write_end_io().
>>>
>>> Specifically, when the ext4_handle_inode_extension() operation succeeds,
>>> ext4_dio_write_end_io() directly returns count instead of 0.
>>>
>>> This does not cause a bug in the current kernel, but the semantics of the
>>> return value of the ext4_dio_write_end_io() function are wrong, which is
>>> likely to introduce bugs in the future code evolution.
>>>
>>> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
>>> ---
>>>    fs/ext4/file.c | 5 +++--
>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
>>> index c89e434db6b7..6df5a92cec2b 100644
>>> --- a/fs/ext4/file.c
>>> +++ b/fs/ext4/file.c
>>> @@ -392,8 +392,9 @@ static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
>>>    	 */
>>>    	if (pos + size <= READ_ONCE(EXT4_I(inode)->i_disksize) &&
>>>    	    pos + size <= i_size_read(inode))
>>> -		return size;
>>> -	return ext4_handle_inode_extension(inode, pos, size);
>>> +		return 0;
>>> +	error = ext4_handle_inode_extension(inode, pos, size);
>>> +	return error < 0 ? error : 0;
>>
>> Why?
> 
> Before commit 91562895f803 ("ext4: properly sync file size update after O_SYNC
> direct IO"), all filesystems' iomap_dio_ops.end_io() return 0 on success and
> negative value on failure.
> 
> Moreover, this confusion of return value semantics caused data corruption when
> this above patch was merged to the stable branch. See
> https://lwn.net/Articles/954285/ for details.

Yeah, I know this problem, you should backport 936e114a245b("iomap:
update ki_pos a little later in iomap_dio_complete") too to help update
iocb->ki_pos since ext4_dio_write_end_io now return > 0.

> 
>>
>> iomap_dio_complete can use the return value directly without any bug.
>> And I think the code now seems more clearly...
>>
> 
> In my opinion, clean code should be clearly defined code, especially the

Agree.

> interface functions connecting various modules. So, what is the return value
> definition of iomap_dio_ops.end_io()? What is the return value definition of
> ext4_dio_write_end_io()?

I have not seen the definition of return value for
iomap_dio_ops.end_io(), so I think the code is ok now. If we give a
definition for the return value like Darrick describe, this patch looks
good to me.

> 
> Thanks,
> Jinliang Zheng
> 
>>>    }
>>>    
>>>    static const struct iomap_dio_ops ext4_dio_write_ops = {
> 


