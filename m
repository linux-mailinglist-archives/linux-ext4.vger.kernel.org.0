Return-Path: <linux-ext4+bounces-842-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EE1831217
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jan 2024 05:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8677D1F231A3
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jan 2024 04:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F0E6FBC;
	Thu, 18 Jan 2024 04:22:48 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA367481
	for <linux-ext4@vger.kernel.org>; Thu, 18 Jan 2024 04:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705551768; cv=none; b=lEHJEBJfJ1nIfGRcE0D+ivbya6RkyciGMGpklf/MKfnvt6O44wrOkZfzdaBbxzoceSAiYBtUUbx13B9WiahROXhOFn+J055OpNaBG/A0UCNCEkvff0DedaxqDGdc03Xv79tJCuMiSkqRPDkkRxvsVxnXuPTsxyAG2rX8rJLZzas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705551768; c=relaxed/simple;
	bh=NOqwB/W7IgR/vHvdvwBAGIaC3WlvlInmDgD/04Eougk=;
	h=Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:From:Subject:To:Cc:References:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo; b=D++HgAy9MEHjK6BJhnZLYBXgOAAWl8VFTI6rtSMye1/jHbpIX0dtWu+gWPL/faK62vS8BGG0bbNbTKL0Tbl5LzAAnMz5bA94bgtvBTTqhDbuUxQZQQ85WQ54jOf+B3UUKbwILpLRpnESFLuugfi50uaSuo6TVXoaaVCg11amo0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TFqNG61kZz4f3jq7
	for <linux-ext4@vger.kernel.org>; Thu, 18 Jan 2024 12:22:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0871A1A08CA
	for <linux-ext4@vger.kernel.org>; Thu, 18 Jan 2024 12:22:41 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxCHp6hlqJS4BA--.13283S3;
	Thu, 18 Jan 2024 12:22:40 +0800 (CST)
Message-ID: <b3d2acd5-8289-59fd-c7b4-9befecdc03f5@huaweicloud.com>
Date: Thu, 18 Jan 2024 12:22:31 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
From: yangerkun <yangerkun@huaweicloud.com>
Subject: Re: [PATCH 1/2] ext4: remove unused buddy_loaded in
 ext4_mb_seq_groups_show
To: Jan Kara <jack@suse.cz>, yangerkun <yangerkun@huawei.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
References: <20240117115223.80253-1-yangerkun@huawei.com>
 <20240117125647.4gyqfhngii2dxnlo@quack3>
In-Reply-To: <20240117125647.4gyqfhngii2dxnlo@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxCHp6hlqJS4BA--.13283S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1UCw4DKFWfJr1fJrykuFg_yoW8AFyxpF
	sxAF1jkr45Ww1DuF4j9a4qgFyFqw1I9a4fWry3Wr1FvFy7Gr93KF9FgF1Uur1UCFWxGF10
	v3W3uFnxur4SkaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzvtCDUUUU
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/



在 2024/1/17 20:56, Jan Kara 写道:
> On Wed 17-01-24 19:52:22, yangerkun wrote:
>> We can just first call ext4_mb_unload_buddy, then copy information from
>> ext4_group_info. So remove this unused value.
>>
>> Signed-off-by: yangerkun <yangerkun@huawei.com>
> 
> Looks good. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> Although I'd prefer if you add a comment before memcpy() like:
> 
> 	/*
> 	 * We care only about free space counters in the group info and
> 	 * these are safe to access even after the buddy has been unloaded
> 	 */
> 
> 								Honza
> 

Thanks a lot for your review! I will do it next version!

>> ---
>>   fs/ext4/mballoc.c | 9 ++-------
>>   1 file changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index f44f668e407f..139f232bdbb5 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -2990,8 +2990,7 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
>>   {
>>   	struct super_block *sb = pde_data(file_inode(seq->file));
>>   	ext4_group_t group = (ext4_group_t) ((unsigned long) v);
>> -	int i;
>> -	int err, buddy_loaded = 0;
>> +	int i, err;
>>   	struct ext4_buddy e4b;
>>   	struct ext4_group_info *grinfo;
>>   	unsigned char blocksize_bits = min_t(unsigned char,
>> @@ -3021,14 +3020,10 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
>>   			seq_printf(seq, "#%-5u: I/O error\n", group);
>>   			return 0;
>>   		}
>> -		buddy_loaded = 1;
>> +		ext4_mb_unload_buddy(&e4b);
>>   	}
>>   
>>   	memcpy(&sg, grinfo, i);
>> -
>> -	if (buddy_loaded)
>> -		ext4_mb_unload_buddy(&e4b);
>> -
>>   	seq_printf(seq, "#%-5u: %-5u %-5u %-5u [", group, sg.info.bb_free,
>>   			sg.info.bb_fragments, sg.info.bb_first_free);
>>   	for (i = 0; i <= 13; i++)
>> -- 
>> 2.39.2
>>


