Return-Path: <linux-ext4+bounces-4591-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC6F9A0380
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Oct 2024 10:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33EED1F216D9
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Oct 2024 08:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260081D2B35;
	Wed, 16 Oct 2024 08:02:49 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FD11D131B;
	Wed, 16 Oct 2024 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065768; cv=none; b=OkYeJTg1d7mRexyc1AB6rxE4/688t0hJaCgQ2vOX+OIFzTO72/KqdmIBKRTO0blQC7pajX9+aZBD6mZIRHjV5wKrfSEoxDYYotXiR4sBaTV2QyUJ9BysSrCZt5iARu/yOl5M0Zrf94MylmgqDn98p18DCvEpGDtl3t6JnEksIZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065768; c=relaxed/simple;
	bh=lYVoOhBmBv2Oe1O7WtpFdmC6UcsaAGmc/QEnV7hVXz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fabU0RhQfyQNF7w8BkEdxQuqOI0LQfjTrlysiW51VpU0z2HdHEJq7kq1AeAx8uQXZ5tYR8hfPvUBkACV5g9RJEb86vJp25ofErtyACAWFfJdkn99FpX+dsWOcenmw108dJT7C5uaOe8bc7QF+F0E6JZovsx4t2E9tfPUVEkC6Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XT3MC2Y9dz2DdVd;
	Wed, 16 Oct 2024 16:01:27 +0800 (CST)
Received: from dggpeml100021.china.huawei.com (unknown [7.185.36.148])
	by mail.maildlp.com (Postfix) with ESMTPS id 629D6140391;
	Wed, 16 Oct 2024 16:02:41 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpeml100021.china.huawei.com
 (7.185.36.148) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 16 Oct
 2024 16:02:40 +0800
Message-ID: <3930aad6-174d-4422-944e-6c90a3ea065a@huawei.com>
Date: Wed, 16 Oct 2024 16:02:40 +0800
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
	<syzkaller-bugs@googlegroups.com>, Yang Erkun <yangerkun@huawei.com>, Baokun
 Li <libaokun1@huawei.com>
References: <Zu+vI3EipxSsPOMe@thinkpad.lan>
 <66efba95.050a0220.3195df.008c.GAE@google.com>
 <Zu+8aQBJgMn7xVws@thinkpad.lan>
 <d62a25e9-04de-4309-98d1-22a4f9b5bb49@huawei.com>
 <20241009155028.u7jpzrw6txldt43j@quack3>
 <05f9c7c2-655a-4f5b-be8e-93f511a954bd@huawei.com>
 <20241014163120.hinbd5jc6mp4vev7@quack3>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20241014163120.hinbd5jc6mp4vev7@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml100021.china.huawei.com (7.185.36.148)

On 2024/10/15 0:31, Jan Kara wrote:
> On Fri 11-10-24 10:18:04, Baokun Li wrote:
>> On 2024/10/9 23:50, Jan Kara wrote:
>>>> Or go one step further and add a mechanism like xfs Reverse-Mapping, which
>>>> makes sure that allocated blocks do point to the target inode, which could
>>>> replace the current block_validity, and could also be used in future online
>>>> fscks.
>>> Well, that is a rather big change. It requires significant on-disk format
>>> change and also performance cost when to maintain. Furthermore for xattr
>>> blocks which can be shared by many inodes it is not even clear how to
>>> implement this... So I'm not sure we really want to do this either.
>> Yes, there can be a lot of work involved.
>>
>>   * Perhaps we could create an rmap file to store the rmap tree to avoid
>>     on-disk format changes.
>>   * The performance impact of maintaining rmap really needs to be evaluated,
>>     perhaps by writing a simple DEMO to test it.
>>   * XFS supports shared blocks(A.K.A. reflink.), so even if the physical
>>     blocks are the same, but the inodes are different or the logical blocks
>>     are different, they will be recorded multiple times in the tree. So the
>>     shared xattr block can be handled similarly.
>>
>> We have plans to support online fsck in the future, and implementing rmap
>> is one of the steps. Perhaps one can wait until rmap is implemented to
>> assess whether it is worth a strict check here.
> Yes, we could implement something like this be as you wrote, it's going to
> be a lot of work. We've briefly discussed this with Ted on ext4 call and we
> came to a conclusion that this is a type of corruption ext4 may never
> protect agaist. You simply should not mount arbitrarily corrupted
> filesystems...

Thank you for discussing this with Ted.

This kind of problem is really tricky.

>   But if you want to try, sure go ahead :)
As server clusters get larger and larger, server maintenance becomes very
difficult. Therefore, timely detection of problems (i.e. online scanning,
similar to e2fsck -fn) and timely and non-stop fixing of problems (i.e.
online fsck, similar to e2fsck -a) have always been the requirements of
our customers. Thus online fsck has been on our TODO list, and it's really
time to start doing it. 😀
> One relatively easy solution to similar class of problems would be to store
> the type of metadata buffer inside the buffer_head when we are verifying
> checksum, clear the info when freeing the block in __ext4_forget(), and
> fail with EFSCORRUPTED error when one type -> another type transition would
> happen.
This solution looks great. If we save checksum further, we can sense not
only the change of block type, but also the change of block data.

But now journal_head takes up bh->b_private, so to record information,
we need to add new fields to buffer_head (e.g. b_info), or modify the logic
of journal_head (e.g. make bh->b_private hold ext4_bufdata, and include the
journal_head in ext4_bufdata. ocfs2 needs a similar adaptation).
>> Implementing rmap may take some time, until then we can avoid the problem
>> as much as possible by checking the magic and xattr block csum.
>> Maybe something like this?
>>
>> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
>> index 7647e9f6e190..cd3ae1e3371c 100644
>> --- a/fs/ext4/xattr.c
>> +++ b/fs/ext4/xattr.c
>> @@ -1676,6 +1676,13 @@ static int ext4_xattr_set_entry(struct
>> ext4_xattr_info *i,
>>                  }
>>          }
>>
>> +       if (WARN_ON_ONCE(last < here)) {
>> +               EXT4_ERROR_INODE(inode, "corrupted xattr entries in %s",
>> +                                       is_block ? "block" : "ibody");
>> +               ret = -EFSCORRUPTED;
>> +               goto out;
>> +       }
>> +
>>          /* Check whether we have enough space. */
>>          if (i->value) {
>>                  size_t free;
>> @@ -1923,6 +1930,7 @@ ext4_xattr_block_set(handle_t *handle, struct inode
>> *inode,
>>          }
>>
>>          if (s->base) {
>> +               struct ext4_xattr_header *hdr;
>>                  int offset = (char *)s->here - bs->bh->b_data;
>>
>>                  BUFFER_TRACE(bs->bh, "get_write_access");
>> @@ -1932,6 +1940,16 @@ ext4_xattr_block_set(handle_t *handle, struct inode
>> *inode,
>>                          goto cleanup;
>>
>>                  lock_buffer(bs->bh);
>> +               hdr = header(s->base);
>> +
>> +               if (hdr->h_magic != cpu_to_le32(EXT4_XATTR_MAGIC) ||
>> +                   (ext4_has_metadata_csum(inode->i_sb) &&
>> +                    (ext4_xattr_block_csum(inode, bs->bh->b_blocknr, hdr)
>> !=
>> +                     hdr->h_checksum))) {
>> +                       unlock_buffer(bs->bh);
>> +                       error = -EFSCORRUPTED;
>> +                       goto bad_block;
>> +               }
>>
>>                  if (header(s->base)->h_refcount == cpu_to_le32(1)) {
>>                          __u32 hash = le32_to_cpu(BHDR(bs->bh)->h_hash);
> Hum, there are more places in xattr code that access a buffer that could
> have been modified. So why do you add check into this place? Is it somehow
> special?
>
> 								Honza

The out-of-bounds access occurs here because the last dentry obtained
in ext4_xattr_set_entry() is not the same as the last dentry obtained
in ext4_xattr_block_find().

When we modify an xattr, we always hold the inode lock, so the ibody
case is not considered. Check_xattrs() is called to do a full check
when looking up an xattr, so it's not necessary to consider that either.

When inserting an xattr into an xattr block, there are three cases:

  * xattr block is newly allocated, and the block is allocated only
    after the entry is set in memory.
  * xattr block is unshared, insert the new xattr directly.
  * xattr block is shared, copy the xattr block and insert the new xattr.

Only in the last two cases can a multiply claimed xattr block result in
out-of-bounds access, so the buffer lock is held to verify that the data
is correct.
(It looks like kmemdup should be moved to the buffer lock here as well.🤔)

Thanks again!

Regards,
Baokun


