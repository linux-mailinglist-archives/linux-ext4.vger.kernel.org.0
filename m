Return-Path: <linux-ext4+bounces-4566-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41825999A44
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Oct 2024 04:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E063B23974
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Oct 2024 02:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEED1E9066;
	Fri, 11 Oct 2024 02:18:12 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA38C1E7C35;
	Fri, 11 Oct 2024 02:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728613092; cv=none; b=ZGf7VSbiNiqplSWhOdQmR19adhLBprh2sc7w6qAUDM3P+qJZQINKH+Qgcm2+Rx5/YhjfjsZKjajC9g1JVpvQ5bygE+kxVlChfk3WMicAfRKIZp6xB1CndVHqwp/fifgUNBoRZzxUCXaMKzf1zonOygdSFsNQUumm3tiuMajYk4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728613092; c=relaxed/simple;
	bh=727jH2mK+NJYkVs2ldM13ZpvolG/NxCD8D+B/CcKDpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HCbgfGwtuRwM1KmPhS2Xn1imH0X4tRB3WPy8toCn7j+t2Yp2Ehh9upilWwDao3fcwQK4aLt/vN5JtD9uRb2u1pjT3e+TXqJogMbdeoeOT0hpigCY7dqyoValL82n2a6CoDc+2VOZbMvpCEHqsrEGTzO000hkJ0ACCuQ1nbLMyCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XPqxH4KK7z10McM;
	Fri, 11 Oct 2024 10:16:19 +0800 (CST)
Received: from dggpeml100021.china.huawei.com (unknown [7.185.36.148])
	by mail.maildlp.com (Postfix) with ESMTPS id 5E219180105;
	Fri, 11 Oct 2024 10:18:05 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpeml100021.china.huawei.com
 (7.185.36.148) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 11 Oct
 2024 10:18:04 +0800
Message-ID: <05f9c7c2-655a-4f5b-be8e-93f511a954bd@huawei.com>
Date: Fri, 11 Oct 2024 10:18:04 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: fix out-of-bounds issue in ext4_xattr_set_entry
To: Jan Kara <jack@suse.cz>
CC: Qianqiang Liu <qianqiang.liu@163.com>, <tytso@mit.edu>,
	<adilger.kernel@dilger.ca>, syzbot
	<syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com>,
	<linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<syzkaller-bugs@googlegroups.com>, Yang Erkun <yangerkun@huawei.com>
References: <Zu+vI3EipxSsPOMe@thinkpad.lan>
 <66efba95.050a0220.3195df.008c.GAE@google.com>
 <Zu+8aQBJgMn7xVws@thinkpad.lan>
 <d62a25e9-04de-4309-98d1-22a4f9b5bb49@huawei.com>
 <20241009155028.u7jpzrw6txldt43j@quack3>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20241009155028.u7jpzrw6txldt43j@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml100021.china.huawei.com (7.185.36.148)

On 2024/10/9 23:50, Jan Kara wrote:
> On Tue 08-10-24 15:40:39, Baokun Li wrote:
>> On 2024/9/22 14:42, Qianqiang Liu wrote:
>>> syzbot has found an out-of-bounds issue in ext4_xattr_set_entry:
>>>
>>> ==================================================================
>>> BUG: KASAN: out-of-bounds in ext4_xattr_set_entry+0x8ce/0x1f60 fs/ext4/xattr.c:1781
>>> Read of size 18446744073709551572 at addr ffff888036426850 by task syz-executor264/5095
>>>
>>> CPU: 0 UID: 0 PID: 5095 Comm: syz-executor264 Not tainted 6.11.0-syzkaller-03917-ga940d9a43e62 #0
>>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
>>> Call Trace:
>>>    <TASK>
>>>    __dump_stack lib/dump_stack.c:93 [inline]
>>>    dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
>>>    print_address_description mm/kasan/report.c:377 [inline]
>>>    print_report+0x169/0x550 mm/kasan/report.c:488
>>>    kasan_report+0x143/0x180 mm/kasan/report.c:601
>>>    kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
>>>    __asan_memmove+0x29/0x70 mm/kasan/shadow.c:94
>>>    ext4_xattr_set_entry+0x8ce/0x1f60 fs/ext4/xattr.c:1781
>>> [...]
>>> ==================================================================
>>>
>>> This issue is caused by a negative size in memmove.
>>> We need to check for this.
>>>
>>> Fixes: dec214d00e0d ("ext4: xattr inode deduplication")
>>> Reported-by: syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1
>>> Tested-by: syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com
>>> Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
>>> ---
>>>    fs/ext4/xattr.c | 9 ++++++++-
>>>    1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
>>> index 46ce2f21fef9..336badb46246 100644
>>> --- a/fs/ext4/xattr.c
>>> +++ b/fs/ext4/xattr.c
>>> @@ -1776,7 +1776,14 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
>>>    	} else if (s->not_found) {
>>>    		/* Insert new name. */
>>>    		size_t size = EXT4_XATTR_LEN(name_len);
>>> -		size_t rest = (void *)last - (void *)here + sizeof(__u32);
>>> +		size_t rest;
>>> +
>>> +		if (last < here) {
>>> +			ret = -ENOSPC;
>>> +			goto out;
>>> +		} else {
>>> +			rest = (void *)last - (void *)here + sizeof(__u32);
>>> +		}
>>>    		memmove((void *)here + size, here, rest);
>>>    		memset(here, 0, size);
>> This change just passes syzbot's test cases without fixing the real
>> problem.
>>
>> The root cause of the problem is that the inode's xattr block is marked as
>> free in the block bitmap, so that block is allocated to the ea inode
>> resulting in the data in the xattr block being overwritten, and the last of
>> the second lookups changing resulting in out-of-bounds access.
>>
>> The stack that triggers the problem is as follows:
>>
>> // An inode with an xattr block of 33.
>> __ext4_mark_inode_dirty
>>   __ext4_expand_extra_isize
>>    ext4_expand_extra_isize_ea
>>     ext4_xattr_make_inode_space
>>      // Move xattr from inode to block
>>      ext4_xattr_move_to_block
>>       // Find out if the xattr exists in the block
>>       ext4_xattr_block_find
>>        // If xattr does not exist, here == last
>>        xattr_find_entry
>>       // Add a new xattr to the block
>>       ext4_xattr_block_set
>>        |// xattr is too long, needs an ea inode
>>        |ext4_xattr_inode_lookup_create
>>        | ext4_xattr_inode_create
>>        | ext4_xattr_inode_write
>>        |  ext4_map_blocks
>>        |   // xattr block 33 is assigned to the new ea inode
>>        |  memcpy(bh->b_data, buf, csize)
>>        |   // The value of xattr overwrites the data in the xattr block.
>>        |ext4_xattr_set_entry
>>         // Since the contents of the xattr block have changed,
>>         // now here == last does not hold, so it is possible to
>>         // have last < here and trigger an out-of-bounds access.
>>
>> So I think we should probably add a helper function ext4_mb_block_inuse()
>> that checks if xattr block is free with the block bitmap in check_xattrs().
Hi Honza,

Thanks so much for your thoughts and feedback!
> Well, even that would be a relatively narrow fix. You could have e.g.
> file reference the xattr block as one of its data blocks and then corrupt
> xattr contents at unfortunate moment. That will not get fixed by checking
> whether the block is allocated. These multiply claimed blocks (as e2fsck
> calls it) are very hard to detect inside the kernel.
Yes, after locating the issue, the first thought was to just get the buffer
lock and check xattr magic and xattr block checksum. However, if the block
is allocated as an xattr block to another file, the issue may still occur.

Therefore we have to make sure that the block has been allocated to the
current file. With the block bitmap we can verify that the current block
is allocated, but as you pointed out we cannot verify that it is only
allocated to the current file.

That means we need some means to find the owner of the block by block,
and then I came up with xfs Reverse-Mapping.
>> Or go one step further and add a mechanism like xfs Reverse-Mapping, which
>> makes sure that allocated blocks do point to the target inode, which could
>> replace the current block_validity, and could also be used in future online
>> fscks.
> Well, that is a rather big change. It requires significant on-disk format
> change and also performance cost when to maintain. Furthermore for xattr
> blocks which can be shared by many inodes it is not even clear how to
> implement this... So I'm not sure we really want to do this either.
>
> 								Honza
Yes, there can be a lot of work involved.

  * Perhaps we could create an rmap file to store the rmap tree to avoid
    on-disk format changes.
  * The performance impact of maintaining rmap really needs to be evaluated,
    perhaps by writing a simple DEMO to test it.
  * XFS supports shared blocks(A.K.A. reflink.), so even if the physical
    blocks are the same, but the inodes are different or the logical blocks
    are different, they will be recorded multiple times in the tree. So the
    shared xattr block can be handled similarly.

We have plans to support online fsck in the future, and implementing rmap
is one of the steps. Perhaps one can wait until rmap is implemented to
assess whether it is worth a strict check here.

Implementing rmap may take some time, until then we can avoid the problem
as much as possible by checking the magic and xattr block csum.
Maybe something like this?

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 7647e9f6e190..cd3ae1e3371c 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1676,6 +1676,13 @@ static int ext4_xattr_set_entry(struct 
ext4_xattr_info *i,
                 }
         }

+       if (WARN_ON_ONCE(last < here)) {
+               EXT4_ERROR_INODE(inode, "corrupted xattr entries in %s",
+                                       is_block ? "block" : "ibody");
+               ret = -EFSCORRUPTED;
+               goto out;
+       }
+
         /* Check whether we have enough space. */
         if (i->value) {
                 size_t free;
@@ -1923,6 +1930,7 @@ ext4_xattr_block_set(handle_t *handle, struct 
inode *inode,
         }

         if (s->base) {
+               struct ext4_xattr_header *hdr;
                 int offset = (char *)s->here - bs->bh->b_data;

                 BUFFER_TRACE(bs->bh, "get_write_access");
@@ -1932,6 +1940,16 @@ ext4_xattr_block_set(handle_t *handle, struct 
inode *inode,
                         goto cleanup;

                 lock_buffer(bs->bh);
+               hdr = header(s->base);
+
+               if (hdr->h_magic != cpu_to_le32(EXT4_XATTR_MAGIC) ||
+                   (ext4_has_metadata_csum(inode->i_sb) &&
+                    (ext4_xattr_block_csum(inode, bs->bh->b_blocknr, 
hdr) !=
+                     hdr->h_checksum))) {
+                       unlock_buffer(bs->bh);
+                       error = -EFSCORRUPTED;
+                       goto bad_block;
+               }

                 if (header(s->base)->h_refcount == cpu_to_le32(1)) {
                         __u32 hash = le32_to_cpu(BHDR(bs->bh)->h_hash);

--
Thanks,
Baokun

