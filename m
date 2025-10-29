Return-Path: <linux-ext4+bounces-11336-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAD8C1A18F
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Oct 2025 12:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38B941B25FE0
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Oct 2025 11:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D51334C14;
	Wed, 29 Oct 2025 11:45:04 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2706E2F690E
	for <linux-ext4@vger.kernel.org>; Wed, 29 Oct 2025 11:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761738303; cv=none; b=AVXyXYF+sKLDR8Ct4OdgPOTyLYmDGlHSIu27r5tkhJzXgy1IVZHcVq6RjK+SMS1kk66SLsObbRK13FXSE9B72EF1imvfA8eEhWITXveJzaRas2ie8YAo672htdbm7ZA+5ZuPLHU/vIKb91rKWtgzd7+IGSq2wjjMRlipfLhD91k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761738303; c=relaxed/simple;
	bh=9ncdF5VmzcdhSX8LP973yX+6PXZh6AXOAF619W9DndM=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fXJ84raYHvX5UMDfboGVkWoRbnReLAXbdw0QUvblefPtTLONCZdne/BFC5tmjyOhrQCqzHBMuHhKnZsjcm/4FQMlJZdrFSGALuwB2gPpotpuqzPeyQEsuaTDK5oLVrVi6+Ej2cNxXLMKEf91p4EaRtCu5o+7mXm/JOXuJebsRwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cxQPV13mCzKHMLG
	for <linux-ext4@vger.kernel.org>; Wed, 29 Oct 2025 19:43:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 3914A1A018D
	for <linux-ext4@vger.kernel.org>; Wed, 29 Oct 2025 19:44:56 +0800 (CST)
Received: from [10.174.178.185] (unknown [10.174.178.185])
	by APP2 (Coremail) with SMTP id Syh0CgBnvUU2_gFpu0sLCA--.50986S3;
	Wed, 29 Oct 2025 19:44:56 +0800 (CST)
Subject: Re: [PATCH] jbd2: fix the inconsistency between checksum and data in
 memory for journal sb
To: Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org
References: <20251028064728.91827-1-yebin@huaweicloud.com>
 <cf167bfa-fb1e-40fa-81e6-071dab2442c0@huaweicloud.com>
Cc: jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca
From: yebin <yebin@huaweicloud.com>
Message-ID: <6901FE36.6030404@huaweicloud.com>
Date: Wed, 29 Oct 2025 19:44:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cf167bfa-fb1e-40fa-81e6-071dab2442c0@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBnvUU2_gFpu0sLCA--.50986S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCw4fJry8XF1xKryUCw48WFg_yoW5KrW7pr
	y5CFW5uryv9ryUAw1IgF4rJFWFqry0yFWDKr4q9F97Kay5Gw12v34UtFn0kFyqv3yYga4x
	GF1UG39rCw12vaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
	73UjIFyTuYvjfUehL0UUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/



On 2025/10/29 16:45, Zhang Yi wrote:
> Hi Bin!
>
> On 10/28/2025 2:47 PM, Ye Bin wrote:
>> From: Ye Bin <yebin10@huawei.com>
>>
>> Copying the file system while it is mounted as read-only results in
>> a mount failure:
>> [~]# mkfs.ext4 -F /dev/sdc
>> [~]# mount /dev/sdc -o ro /mnt/test
>> [~]# dd if=/dev/sdc of=/dev/sda bs=1M
>> [~]# mount /dev/sda /mnt/test1
>> [ 1094.849826] JBD2: journal checksum error
>> [ 1094.850927] EXT4-fs (sda): Could not load journal inode
>> mount: mount /dev/sda on /mnt/test1 failed: Bad message
>>
>
> I suppose we need to explain why we have this particular use case.
>
The process described above is just an abstracted way I came up with to 
reproduce the issue. In the actual scenario, the file system was mounted 
read-only and then copied while it was still mounted. It was found that 
the mount operation failed. The user intended to verify the data or use 
it as a backup, and this action was performed during a version upgrade.

>> Above issue may happen as follows:
>> ext4_fill_super
>>   set_journal_csum_feature_set(sb)
>>    if (ext4_has_metadata_csum(sb))
>>     incompat = JBD2_FEATURE_INCOMPAT_CSUM_V3;
>>    if (test_opt(sb, JOURNAL_CHECKSUM)
>>     jbd2_journal_set_features(sbi->s_journal, compat, 0, incompat);
>>      lock_buffer(journal->j_sb_buffer);
>>      sb->s_feature_incompat  |= cpu_to_be32(incompat);
>>      //The data in the journal sb was modified, but the checksum was not
>>        updated, so the data remaining in memory has a mismatch between the
>>        data and the checksum.
>>      unlock_buffer(journal->j_sb_buffer);
>>
>> In this case, the journal sb copied over is in a state where the checksum
>> and data are inconsistent, so mounting fails.
>> To solve the above issue, update the checksum in memory after modifying
>> the journal sb.
>
> What about checking sb_rdonly(sb) before setting the journal feature, and
> skipping the setting if the filesystem is mounted as read-only?

Yes, I've thought about doing that too, but that would require us to set 
the journal's features again when remounting as rw.

>
> Regards,
> Yi.
>
>>
>> Fixes: 4fd5ea43bc11 ("jbd2: checksum journal superblock")
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> ---
>>   fs/jbd2/journal.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
>> index d480b94117cd..5b6e8c1a5e6a 100644
>> --- a/fs/jbd2/journal.c
>> +++ b/fs/jbd2/journal.c
>> @@ -2349,6 +2349,8 @@ int jbd2_journal_set_features(journal_t *journal, unsigned long compat,
>>   	sb->s_feature_compat    |= cpu_to_be32(compat);
>>   	sb->s_feature_ro_compat |= cpu_to_be32(ro);
>>   	sb->s_feature_incompat  |= cpu_to_be32(incompat);
>> +	if (jbd2_journal_has_csum_v2or3(journal))
>> +		sb->s_checksum = jbd2_superblock_csum(sb);
>>   	unlock_buffer(journal->j_sb_buffer);
>>   	jbd2_journal_init_transaction_limits(journal);
>>
>> @@ -2378,9 +2380,13 @@ void jbd2_journal_clear_features(journal_t *journal, unsigned long compat,
>>
>>   	sb = journal->j_superblock;
>>
>> +	lock_buffer(journal->j_sb_buffer);
>>   	sb->s_feature_compat    &= ~cpu_to_be32(compat);
>>   	sb->s_feature_ro_compat &= ~cpu_to_be32(ro);
>>   	sb->s_feature_incompat  &= ~cpu_to_be32(incompat);
>> +	if (jbd2_journal_has_csum_v2or3(journal))
>> +		sb->s_checksum = jbd2_superblock_csum(sb);
>> +	unlock_buffer(journal->j_sb_buffer);
>>   	jbd2_journal_init_transaction_limits(journal);
>>   }
>>   EXPORT_SYMBOL(jbd2_journal_clear_features);
>


