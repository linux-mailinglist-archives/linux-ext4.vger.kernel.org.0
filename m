Return-Path: <linux-ext4+bounces-5712-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E27A9F49E3
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Dec 2024 12:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3D2188B953
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Dec 2024 11:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077771DED70;
	Tue, 17 Dec 2024 11:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="pRrF1WqV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C71ABA49;
	Tue, 17 Dec 2024 11:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734435089; cv=none; b=Q4XuJ9dNesjPgDIRvPGco4kzDN4oSsO83nGmIGPeXwOaY5hU6hRG+RKtix6UwWekHIRVUEwQqsF33Fr74YYTxH916+AWVPQuGR6P2q/FHxbXSTIU3g3Beaji6MyuAXmJs8tEVXLPnpwhvZV8MIvT0GaY6MFI4Ypb73//ABCHcZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734435089; c=relaxed/simple;
	bh=l+LGn+8unbb148ok86nvPZd939sgpRRVcu9C68KrDjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lF4qkB5bMhn30wUXgnxG0YRp+BjlXscCzeWz3qMBPIH3eZQ64iwAJeaJ79blgXZKbR067jY0xzblKY1l/WfUsFWJwCk+fyh2/WO9elUfW/ZLO4fNLelxG4/Vxad8kvff/RTrvtgjFZ9n88cbZO7DEzsKxxptp/2vPBK6DMifhBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=pRrF1WqV; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Gv8mG8QAZtzZByh4D+uNn+DxzjpQTSxW6LyHlmL4wnE=; b=pRrF1WqVHsQhfzPFUNl179EyFN
	7qPFo+clR7kHzPjSDUCJ6OHG8ZQAT49QBbKLO3eO5E/NNPIkE0KIc0Uf2sDomHlwoJkfafmOF5kEp
	MqzenUUUPqw+HRH5DjWEORw6+8dRYGAfVqQTUlURbkyecA2Fd1hIfU8Zl5OWEh+IBXE1JU5YAJ89t
	D2xZpKk7FiLHI7xEVKxZGTsjN1NM+KarujQhZXmmg80m6G43SyD+esa7AxrdRZHQCw6+v6c67kbyA
	f9ieGjge9ZZ5pgI6LeCh9zfDzyCB7x0pP5MxrnQq/8Qo5VMnbvybwO05oNOF7HHUnk9Mu2i/rPDWp
	ej/gVdnA==;
Received: from [128.185.11.26] (helo=[10.5.51.179])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tNVnO-004LPt-58; Tue, 17 Dec 2024 12:31:22 +0100
Message-ID: <1dddb237-1460-8122-7caf-f0acd7c91b5c@igalia.com>
Date: Tue, 17 Dec 2024 17:01:17 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/1] fs/ext4/xattr: Check for 'xattr_sem' inside
 'ext4_xattr_delete_inode'
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Bhupesh <bhupesh@igalia.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org, revest@google.com, adilger.kernel@dilger.ca,
 syzbot+b244bda78289b00204ed@syzkaller.appspotmail.com
References: <20241212065331.113465-1-bhupesh@igalia.com>
 <Z1se33JsSt/p4Wo2@quatroqueijos.cascardo.eti.br>
Content-Language: en-US
From: Bhupesh Sharma <bhsharma@igalia.com>
In-Reply-To: <Z1se33JsSt/p4Wo2@quatroqueijos.cascardo.eti.br>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Cascardo,

Thanks for looking at the patch.

On 12/12/24 11:05 PM, Thadeu Lima de Souza Cascardo wrote:
> On Thu, Dec 12, 2024 at 12:23:31PM +0530, Bhupesh wrote:
>> Once we are inside the 'ext4_xattr_delete_inode' function and trying
>> to delete the inode, the 'xattr_sem' should be unlocked.
>>
>> We need trylock here to avoid false-positive warning from lockdep
>> about reclaim circular dependency.
>>
>> This fixes the following KASAN reported issue:
>>
>> ==================================================================
>> BUG: KASAN: slab-use-after-free in ext4_xattr_inode_dec_ref_all+0xb8c/0xe90
>> Read of size 4 at addr ffff888012c120c4 by task repro/2065
>>
>> CPU: 1 UID: 0 PID: 2065 Comm: repro Not tainted 6.13.0-rc2+ #11
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>> Call Trace:
>>   <TASK>
>>   dump_stack_lvl+0x1fd/0x300
>>   ? tcp_gro_dev_warn+0x260/0x260
>>   ? _printk+0xc0/0x100
>>   ? read_lock_is_recursive+0x10/0x10
>>   ? irq_work_queue+0x72/0xf0
>>   ? __virt_addr_valid+0x17b/0x4b0
>>   print_address_description+0x78/0x390
>>   print_report+0x107/0x1f0
>>   ? __virt_addr_valid+0x17b/0x4b0
>>   ? __virt_addr_valid+0x3ff/0x4b0
>>   ? __phys_addr+0xb5/0x160
>>   ? ext4_xattr_inode_dec_ref_all+0xb8c/0xe90
>>   kasan_report+0xcc/0x100
>>   ? ext4_xattr_inode_dec_ref_all+0xb8c/0xe90
>>   ext4_xattr_inode_dec_ref_all+0xb8c/0xe90
>>   ? ext4_xattr_delete_inode+0xd30/0xd30
>>   ? __ext4_journal_ensure_credits+0x5f0/0x5f0
>>   ? __ext4_journal_ensure_credits+0x2b/0x5f0
>>   ? inode_update_timestamps+0x410/0x410
>>   ext4_xattr_delete_inode+0xb64/0xd30
>>   ? ext4_truncate+0xb70/0xdc0
>>   ? ext4_expand_extra_isize_ea+0x1d20/0x1d20
>>   ? __ext4_mark_inode_dirty+0x670/0x670
>>   ? ext4_journal_check_start+0x16f/0x240
>>   ? ext4_inode_is_fast_symlink+0x2f2/0x3a0
>>   ext4_evict_inode+0xc8c/0xff0
>>   ? ext4_inode_is_fast_symlink+0x3a0/0x3a0
>>   ? do_raw_spin_unlock+0x53/0x8a0
>>   ? ext4_inode_is_fast_symlink+0x3a0/0x3a0
>>   evict+0x4ac/0x950
>>   ? proc_nr_inodes+0x310/0x310
>>   ? trace_ext4_drop_inode+0xa2/0x220
>>   ? _raw_spin_unlock+0x1a/0x30
>>   ? iput+0x4cb/0x7e0
>>   do_unlinkat+0x495/0x7c0
>>   ? try_break_deleg+0x120/0x120
>>   ? 0xffffffff81000000
>>   ? __check_object_size+0x15a/0x210
>>   ? strncpy_from_user+0x13e/0x250
>>   ? getname_flags+0x1dc/0x530
>>   __x64_sys_unlinkat+0xc8/0xf0
>>   do_syscall_64+0x65/0x110
>>   entry_SYSCALL_64_after_hwframe+0x67/0x6f
>> RIP: 0033:0x434ffd
>> Code: 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 8
>> RSP: 002b:00007ffc50fa7b28 EFLAGS: 00000246 ORIG_RAX: 0000000000000107
>> RAX: ffffffffffffffda RBX: 00007ffc50fa7e18 RCX: 0000000000434ffd
>> RDX: 0000000000000000 RSI: 0000000020000240 RDI: 0000000000000005
>> RBP: 00007ffc50fa7be0 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
>> R13: 00007ffc50fa7e08 R14: 00000000004bbf30 R15: 0000000000000001
>>   </TASK>
>>
>> The buggy address belongs to the object at ffff888012c12000
>>   which belongs to the cache filp of size 360
>> The buggy address is located 196 bytes inside of
>>   freed 360-byte region [ffff888012c12000, ffff888012c12168)
>>
>> The buggy address belongs to the physical page:
>> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x12c12
>> head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
>> flags: 0x40(head|node=0|zone=0)
>> page_type: f5(slab)
>> raw: 0000000000000040 ffff888000ad7640 ffffea0000497a00 dead000000000004
>> raw: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
>> head: 0000000000000040 ffff888000ad7640 ffffea0000497a00 dead000000000004
>> head: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
>> head: 0000000000000001 ffffea00004b0481 ffffffffffffffff 0000000000000000
>> head: 0000000000000002 0000000000000000 00000000ffffffff 0000000000000000
>> page dumped because: kasan: bad access detected
>>
>> Memory state around the buggy address:
>>   ffff888012c11f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>   ffff888012c12000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>> ffff888012c12080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>                                             ^
>>   ffff888012c12100: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
>>   ffff888012c12180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> ==================================================================
>>
>> Reported-by: syzbot+b244bda78289b00204ed@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=b244bda78289b00204ed
>> Signed-off-by: Bhupesh <bhupesh@igalia.com>
>> ---
>>   fs/ext4/xattr.c | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
>> index 7647e9f6e190..e1d29aa76165 100644
>> --- a/fs/ext4/xattr.c
>> +++ b/fs/ext4/xattr.c
>> @@ -2926,7 +2926,20 @@ int ext4_xattr_delete_inode(handle_t *handle, struct inode *inode,
>>   	struct ext4_iloc iloc = { .bh = NULL };
>>   	struct ext4_xattr_entry *entry;
>>   	struct inode *ea_inode;
>> -	int error;
>> +	int error = 0;
>> +
>> +	/*
>> +	 * We are the only ones holding inode reference. The xattr_sem should
>> +	 * better be unlocked! We could as well just not acquire xattr_sem at
>> +	 * all but this makes the code more futureproof. OTOH we need trylock
>> +	 * here to avoid false-positive warning from lockdep about reclaim
>> +	 * circular dependency.
>> +	 */
>> +	if (WARN_ON_ONCE(!down_write_trylock(&EXT4_I(inode)->xattr_sem)))
>> +		return error;
>> +
>> +	if (!EXT4_I(inode)->i_file_acl)
>> +		goto cleanup;
>>   
> This is ignoring the case where attributes are all in the inode, not in the
> separate ACL block.
>
> That's why this apparently fixes the problem. ext4_xattr_inode_dec_ref_all
> is never called anymore.


Ok, I got your point, I will try to use existing inode checking 
functions instead, to check for the 'attributes present in inode' case.

However, as we were discussing on irc, I think it would make sense still 
to have the 'EXT4_I(inode)->xattr_sem' held while we delete the inode 
inside '

ext4_xattr_delete_inode'. Please let me know in case you have other ideas.

I will send two patches then - one fixing the inode attribute issue and the other for holding the xattr_sem while we are inside the critical region deleting the inode.

Thanks,
Bhupesh


