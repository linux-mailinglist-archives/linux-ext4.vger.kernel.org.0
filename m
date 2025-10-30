Return-Path: <linux-ext4+bounces-11351-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D85C1E1AD
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 03:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48DAD189932B
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 02:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B892FE563;
	Thu, 30 Oct 2025 02:13:41 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC45167272
	for <linux-ext4@vger.kernel.org>; Thu, 30 Oct 2025 02:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761790421; cv=none; b=Swl2jUjrHtcV4PBsEUqBsVLt/bSo/HeXuAj1LdMgZKVBu7ijt+y7GAtRJ7BNhfbT5Pa2jZqKQ1sjEvoAfR9McnVzhkynI/a/QPF9uU502s2ZAGkKXofWri7nsu/bSAPEcOHJAk3sHj1e71mA/nuug4m9LnxbBknf2tMwJIWufEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761790421; c=relaxed/simple;
	bh=TOf3BMrTm07fEyNyisoz0NFkElgtlGdggVGR2s86Ykc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GBhRfKjyKU7d1iUSIIAttdFWEboRIWxzIqQGP9Wofh2z+CFjQSQjsbj1QuRmBFt1YPplNWQE7lqpBYCq3aILvLosrljAIBNThTZpfCwIfxPyMVCsW5u4vQ7Ae9VTJiqUmn6DKimqusG90H56G8AhgL/CByrqpg2Zc+RZRnp8ZOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cxngl0P47zKHMK6
	for <linux-ext4@vger.kernel.org>; Thu, 30 Oct 2025 10:12:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 05BCA1A07BD
	for <linux-ext4@vger.kernel.org>; Thu, 30 Oct 2025 10:13:34 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgBHnETMyQJpjdhPCA--.5508S3;
	Thu, 30 Oct 2025 10:13:33 +0800 (CST)
Message-ID: <81d572c2-8c30-481e-86ca-9b99eeba2025@huaweicloud.com>
Date: Thu, 30 Oct 2025 10:13:31 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jbd2: fix the inconsistency between checksum and data in
 memory for journal sb
To: "Darrick J. Wong" <djwong@kernel.org>, Ye Bin <yebin@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 jack@suse.cz
References: <20251028064728.91827-1-yebin@huaweicloud.com>
 <20251029145539.GU6170@frogsfrogsfrogs>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20251029145539.GU6170@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBHnETMyQJpjdhPCA--.5508S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGry3Cw4xXrWrCF4rZFy8AFb_yoWrXw13pr
	yYyFZ8uryq9ryUZw10gF4rJayFqry0yFyjgrWqkas2ya43Xw12v34UJFn8KFyqvrW2gayx
	CF1UG39rCwnFyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUBVbkUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 10/29/2025 10:55 PM, Darrick J. Wong wrote:
> On Tue, Oct 28, 2025 at 02:47:28PM +0800, Ye Bin wrote:
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
> 
> I was about to say "Well don't do that, freeze the fs first..."
> 

Yeah, this step is indeed necessary! However, it does not work for
the current case because there is a check for read-only mode in
freeze_super(), which assumes that no modifications to the file
system will occur in read-only mode, thus skipping the freezing of
the file system.

Thanks,
Yi.

>> Above issue may happen as follows:
>> ext4_fill_super
>>  set_journal_csum_feature_set(sb)
>>   if (ext4_has_metadata_csum(sb))
>>    incompat = JBD2_FEATURE_INCOMPAT_CSUM_V3;
>>   if (test_opt(sb, JOURNAL_CHECKSUM)
>>    jbd2_journal_set_features(sbi->s_journal, compat, 0, incompat);
>>     lock_buffer(journal->j_sb_buffer);
>>     sb->s_feature_incompat  |= cpu_to_be32(incompat);
>>     //The data in the journal sb was modified, but the checksum was not
>>       updated, so the data remaining in memory has a mismatch between the
>>       data and the checksum.
>>     unlock_buffer(journal->j_sb_buffer);
>>
>> In this case, the journal sb copied over is in a state where the checksum
>> and data are inconsistent, so mounting fails.
>> To solve the above issue, update the checksum in memory after modifying
>> the journal sb.
> 
> ...but I think the actual change is correct because (a) we shouldn't
> unlock the bh with an incorrect checksum because userspace can see that;
> and (b) if the bh ever gets marked dirty, then writeback can push the
> inconsistent buffer to disk at any time.
> 
> I think it's the case that j_sb_buffer is only ever written out
> explicitly with submit_bh rather than going through the dirty -> flush
> machinery, but I guess syzbot could read and write the same value from
> userspace to dirty the buffer and flush it out while racing to shut down
> the journal, and now the ondisk journal is inconsistent.
> 
> Anyway, the "set csum before unlock_buffer" paradigm is all over the
> ext4 code so
> 
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> --D
> 
>> Fixes: 4fd5ea43bc11 ("jbd2: checksum journal superblock")
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> ---
>>  fs/jbd2/journal.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
>> index d480b94117cd..5b6e8c1a5e6a 100644
>> --- a/fs/jbd2/journal.c
>> +++ b/fs/jbd2/journal.c
>> @@ -2349,6 +2349,8 @@ int jbd2_journal_set_features(journal_t *journal, unsigned long compat,
>>  	sb->s_feature_compat    |= cpu_to_be32(compat);
>>  	sb->s_feature_ro_compat |= cpu_to_be32(ro);
>>  	sb->s_feature_incompat  |= cpu_to_be32(incompat);
>> +	if (jbd2_journal_has_csum_v2or3(journal))
>> +		sb->s_checksum = jbd2_superblock_csum(sb);
>>  	unlock_buffer(journal->j_sb_buffer);
>>  	jbd2_journal_init_transaction_limits(journal);
>>  
>> @@ -2378,9 +2380,13 @@ void jbd2_journal_clear_features(journal_t *journal, unsigned long compat,
>>  
>>  	sb = journal->j_superblock;
>>  
>> +	lock_buffer(journal->j_sb_buffer);
>>  	sb->s_feature_compat    &= ~cpu_to_be32(compat);
>>  	sb->s_feature_ro_compat &= ~cpu_to_be32(ro);
>>  	sb->s_feature_incompat  &= ~cpu_to_be32(incompat);
>> +	if (jbd2_journal_has_csum_v2or3(journal))
>> +		sb->s_checksum = jbd2_superblock_csum(sb);
>> +	unlock_buffer(journal->j_sb_buffer);
>>  	jbd2_journal_init_transaction_limits(journal);
>>  }
>>  EXPORT_SYMBOL(jbd2_journal_clear_features);
>> -- 
>> 2.34.1
>>
>>
> 


