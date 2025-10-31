Return-Path: <linux-ext4+bounces-11380-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB122C22E95
	for <lists+linux-ext4@lfdr.de>; Fri, 31 Oct 2025 02:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CECA189B0BC
	for <lists+linux-ext4@lfdr.de>; Fri, 31 Oct 2025 01:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C1E23371B;
	Fri, 31 Oct 2025 01:48:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08808219A8D
	for <linux-ext4@vger.kernel.org>; Fri, 31 Oct 2025 01:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761875285; cv=none; b=HVpSZhxon5jsBluxN901F1oJm8faNp4l+zbIDYI2q2PIL4zmlKG8c3aHQZ8PUUa/2vetbRrF7a11AM6/KwVE4Sg87X5vJahBDQfgXuQSG5zmJtWruddxBy/z8EZvRRdftpWJkFXKS3mKC3rYuQth/6zGkQOei5eeE5INwvo85Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761875285; c=relaxed/simple;
	bh=+tXMScd5N2A5pcTjoFFOBCqnpqr7h9oASzD3Tos1vK4=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mLdZYRRRQ/166GobYGyHbY+VcBbOkQi/DO0tupY0OM8nnqQ4+BiUgDZuW2V2pa0Yp6rVrBn1Dh3F/01lQUnUIQFAp5efEWeaUQ3+dNoTScLBWhavrEg67bZubOxl6SCsvsB/gPROZVNG+iMp44f8mVrFQ8EzpjY3sBmwQGZ2BPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cyP4l0t55zYQtgj
	for <linux-ext4@vger.kernel.org>; Fri, 31 Oct 2025 09:47:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id BC8BB1A06E6
	for <linux-ext4@vger.kernel.org>; Fri, 31 Oct 2025 09:47:58 +0800 (CST)
Received: from [10.174.178.185] (unknown [10.174.178.185])
	by APP2 (Coremail) with SMTP id Syh0CgAnfUVNFQRpOwXACA--.16361S3;
	Fri, 31 Oct 2025 09:47:58 +0800 (CST)
Subject: Re: [PATCH] jbd2: fix the inconsistency between checksum and data in
 memory for journal sb
To: Jan Kara <jack@suse.cz>
References: <20251028064728.91827-1-yebin@huaweicloud.com>
 <zxnvimnlpbimcdcanpfqggs5inyqwfykiibcqg6at54bbqmpwa@xyyxops25565>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
From: yebin <yebin@huaweicloud.com>
Message-ID: <6904154D.2000903@huaweicloud.com>
Date: Fri, 31 Oct 2025 09:47:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <zxnvimnlpbimcdcanpfqggs5inyqwfykiibcqg6at54bbqmpwa@xyyxops25565>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAnfUVNFQRpOwXACA--.16361S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFyDJF4UXF48GryUtr47Jwb_yoW5urW3pr
	y5AFy5ZryvvryUAw10qF4rJayFqry0ya4UKw4q9as7Ka43Jw12q34DKFn8KFWqvrW2ga4x
	GFyUGa9rCw12vaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/



On 2025/10/30 18:46, Jan Kara wrote:
> On Tue 28-10-25 14:47:28, Ye Bin wrote:
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
>>
>> Fixes: 4fd5ea43bc11 ("jbd2: checksum journal superblock")
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>
> Looks good but please add a short comment before the checksum update
> explaining why jbd2_superblock_csum() call in jbd2_write_superblock() isn't
> enough. Something like:
>
> 	/*
> 	 * Update the checksum now so that it is valid even for read-only
> 	 * filesystems where jbd2_write_superblock() doesn't get called.
> 	 */
>
Thank you for your suggestion. I will resend a new version.

> Otherwise feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> 								Honza
>
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
>> --
>> 2.34.1
>>


