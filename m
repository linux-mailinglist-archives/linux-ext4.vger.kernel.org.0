Return-Path: <linux-ext4+bounces-6379-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E17A2BF5D
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Feb 2025 10:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 079433A9D28
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Feb 2025 09:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69762192D77;
	Fri,  7 Feb 2025 09:31:58 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0468A610D
	for <linux-ext4@vger.kernel.org>; Fri,  7 Feb 2025 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738920718; cv=none; b=FLlCCEXQTJy1KayjCC5kZATNWCTQnlPe65SILzCjtXbYqkRj9h3kny6774hESL4QN8WgjSPDAbf7r5vB+/r7ycc655G8znzVgi/ohyrLrYXWrpNh2IimYQfQZmzkwNqQ13ms7vvRLSYlK4EMSymTQN6kh6TqCiFjF1XaIre9AKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738920718; c=relaxed/simple;
	bh=8h6cMHF/yjNOH4OV+wcUjnk2tuUmblzXBrInxxuccdk=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=laQjKvHkhlt7yAgQXa7dAFzolxldVpvNYkjBwUaH2TABy9sj5v1wk93aQr+0PR2bFR6Yz5UEH6e5RYofxxnrAJ8MzH6jdUvvsS1F1hycXKGNzk0pWIRngC7gnzhJKcVI7D48O/02ic4aQRZb+NovVwr1ltGvm/tnFFcJHJMj/yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Yq7yV05rFz4f3jHv
	for <linux-ext4@vger.kernel.org>; Fri,  7 Feb 2025 17:31:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 32FA41A0E98
	for <linux-ext4@vger.kernel.org>; Fri,  7 Feb 2025 17:31:51 +0800 (CST)
Received: from [10.174.178.185] (unknown [10.174.178.185])
	by APP4 (Coremail) with SMTP id gCh0CgBHrGAF06VnNIuhDA--.51595S3;
	Fri, 07 Feb 2025 17:31:51 +0800 (CST)
Subject: Re: [RESEND PATCH 2/2] ext4: fix out-of-bound read in
 ext4_xattr_inode_dec_ref_all()
To: "Darrick J. Wong" <djwong@kernel.org>
References: <20250207032743.882949-1-yebin@huaweicloud.com>
 <20250207032743.882949-3-yebin@huaweicloud.com>
 <20250207041629.GE21787@frogsfrogsfrogs>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 jack@suse.cz
From: yebin <yebin@huaweicloud.com>
Message-ID: <67A5D305.9080605@huaweicloud.com>
Date: Fri, 7 Feb 2025 17:31:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250207041629.GE21787@frogsfrogsfrogs>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBHrGAF06VnNIuhDA--.51595S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuryUtr1DJFW3Cr4Dur4fAFb_yoWrtFW7p3
	4fJa48Cw40qryj9r4xtr45Zw1j93WxCa1UWrWxGr1UKFyDWwn7tFy8Krn8CFyqvrW8Jr9I
	qr1DJr4j93WrC3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UEQ6
	JUUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/



On 2025/2/7 12:16, Darrick J. Wong wrote:
> On Fri, Feb 07, 2025 at 11:27:43AM +0800, Ye Bin wrote:
>> From: Ye Bin <yebin10@huawei.com>
>>
>> There's issue as follows:
>> BUG: KASAN: use-after-free in ext4_xattr_inode_dec_ref_all+0x6ff/0x790
>> Read of size 4 at addr ffff88807b003000 by task syz-executor.0/15172
>>
>> CPU: 3 PID: 15172 Comm: syz-executor.0
>> Call Trace:
>>   __dump_stack lib/dump_stack.c:82 [inline]
>>   dump_stack+0xbe/0xfd lib/dump_stack.c:123
>>   print_address_description.constprop.0+0x1e/0x280 mm/kasan/report.c:400
>>   __kasan_report.cold+0x6c/0x84 mm/kasan/report.c:560
>>   kasan_report+0x3a/0x50 mm/kasan/report.c:585
>>   ext4_xattr_inode_dec_ref_all+0x6ff/0x790 fs/ext4/xattr.c:1137
>>   ext4_xattr_delete_inode+0x4c7/0xda0 fs/ext4/xattr.c:2896
>>   ext4_evict_inode+0xb3b/0x1670 fs/ext4/inode.c:323
>>   evict+0x39f/0x880 fs/inode.c:622
>>   iput_final fs/inode.c:1746 [inline]
>>   iput fs/inode.c:1772 [inline]
>>   iput+0x525/0x6c0 fs/inode.c:1758
>>   ext4_orphan_cleanup fs/ext4/super.c:3298 [inline]
>>   ext4_fill_super+0x8c57/0xba40 fs/ext4/super.c:5300
>>   mount_bdev+0x355/0x410 fs/super.c:1446
>>   legacy_get_tree+0xfe/0x220 fs/fs_context.c:611
>>   vfs_get_tree+0x8d/0x2f0 fs/super.c:1576
>>   do_new_mount fs/namespace.c:2983 [inline]
>>   path_mount+0x119a/0x1ad0 fs/namespace.c:3316
>>   do_mount+0xfc/0x110 fs/namespace.c:3329
>>   __do_sys_mount fs/namespace.c:3540 [inline]
>>   __se_sys_mount+0x219/0x2e0 fs/namespace.c:3514
>>   do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
>>   entry_SYSCALL_64_after_hwframe+0x67/0xd1
>>
>> Memory state around the buggy address:
>>   ffff88807b002f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>   ffff88807b002f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> ffff88807b003000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>                     ^
>>   ffff88807b003080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>   ffff88807b003100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>
>> Above issue happens as ext4_xattr_delete_inode() isn't check xattr
>> is valid if xattr is in inode.
>> To solve above issue call xattr_check_inode() check if xattr if valid
>> in inode.
>>
>> Fixes: e50e5129f384 ("ext4: xattr-in-inode support")
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> ---
>>   fs/ext4/xattr.c | 14 +++++++++++---
>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
>> index 0e4494863d15..cb724477f8da 100644
>> --- a/fs/ext4/xattr.c
>> +++ b/fs/ext4/xattr.c
>> @@ -2922,7 +2922,6 @@ int ext4_xattr_delete_inode(handle_t *handle, struct inode *inode,
>>   			    int extra_credits)
>>   {
>>   	struct buffer_head *bh = NULL;
>> -	struct ext4_xattr_ibody_header *header;
>>   	struct ext4_iloc iloc = { .bh = NULL };
>>   	struct ext4_xattr_entry *entry;
>>   	struct inode *ea_inode;
>> @@ -2937,6 +2936,9 @@ int ext4_xattr_delete_inode(handle_t *handle, struct inode *inode,
>>
>>   	if (ext4_has_feature_ea_inode(inode->i_sb) &&
>>   	    ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
>> +		struct ext4_xattr_ibody_header *header;
>> +		struct ext4_inode *raw_inode;
>> +		void *end;
>>
>>   		error = ext4_get_inode_loc(inode, &iloc);
>>   		if (error) {
>> @@ -2952,14 +2954,20 @@ int ext4_xattr_delete_inode(handle_t *handle, struct inode *inode,
>>   			goto cleanup;
>>   		}
>>
>> -		header = IHDR(inode, ext4_raw_inode(&iloc));
>> -		if (header->h_magic == cpu_to_le32(EXT4_XATTR_MAGIC))
>> +		raw_inode = ext4_raw_inode(&iloc);
>> +		header = IHDR(inode, raw_inode);
>> +		end = ITAIL(inode, raw_inode);
>> +		if (header->h_magic == cpu_to_le32(EXT4_XATTR_MAGIC)) {
>
> This needs to make sure that header + sizeof(h_magic) >= end before
> checking the magic number in header::h_magic, right?
>
> --D
Thank you for your reply.
There ' s no need to check "header + sizeof(h_magic) >= end" because it 
has been checked
when the EXT4_STATE_XATTR flag bit is set:
__ext4_iget
   ret = ext4_iget_extra_inode(inode, raw_inode, ei);
     if (EXT4_INODE_HAS_XATTR_SPACE(inode) && *magic == 
cpu_to_le32(EXT4_XATTR_MAGIC))
       ext4_set_inode_state(inode, EXT4_STATE_XATTR);
It seems that the judgment of "header->h_magic == 
cpu_to_le32(EXT4_XATTR_MAGIC)"
should be redundant here.
>
>> +			error = xattr_check_inode(inode, header, end);
>> +			if (error)
>> +				goto cleanup;
>>   			ext4_xattr_inode_dec_ref_all(handle, inode, iloc.bh,
>>   						     IFIRST(header),
>>   						     false /* block_csum */,
>>   						     ea_inode_array,
>>   						     extra_credits,
>>   						     false /* skip_quota */);
>> +		}
>>   	}
>>
>>   	if (EXT4_I(inode)->i_file_acl) {
>> --
>> 2.34.1
>>
>>
>


