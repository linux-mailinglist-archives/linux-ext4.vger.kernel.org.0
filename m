Return-Path: <linux-ext4+bounces-4599-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DE29A229F
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Oct 2024 14:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731EB1C21251
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Oct 2024 12:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB7D1DD55F;
	Thu, 17 Oct 2024 12:43:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAF21D357B;
	Thu, 17 Oct 2024 12:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729168986; cv=none; b=l/rI7TefFWG9QgYsBWfvOzQDSK10vkFF6yOJ+MKR3YTx0uV0RJYHTiEPD1w5/r8fh9Hg3fMBfANL8spymMLt7Dyjylvx3+OI4OTkD1msn9nW/gMqTO8zRjAu8HsETD0fjraISYZOVlIiUgZODy13ORg0q4JP/ZAENHaHoRR2E+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729168986; c=relaxed/simple;
	bh=rx/LOMzs1iX8GUHxDF2M09WYjulzlkNX622H4gN8KIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Hnl82Z0sz3bk2YHvJCP/9F50wUSWnv8KiUdCTiJ2uYMvt558uvHeQNtC0s9CcN0HSSa6seQ8CJslXY8Y06/NcZzaOlBVyTIboSq/zAS1gGQ0X6STBYf2AVDHyWEIqWRqo3euFB84ei/742Fmjn6go96XHHJp91OPdtBMCRzNvcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XTnXk65XLzQrSl;
	Thu, 17 Oct 2024 20:42:14 +0800 (CST)
Received: from dggpeml100021.china.huawei.com (unknown [7.185.36.148])
	by mail.maildlp.com (Postfix) with ESMTPS id 65F6B18007C;
	Thu, 17 Oct 2024 20:43:00 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpeml100021.china.huawei.com
 (7.185.36.148) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 20:42:59 +0800
Message-ID: <811eb084-55d4-4725-9388-05a6e8f489d9@huawei.com>
Date: Thu, 17 Oct 2024 20:42:59 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: fix out-of-bounds issue in ext4_xattr_set_entry
To: Theodore Ts'o <tytso@mit.edu>
CC: Jan Kara <jack@suse.cz>, Qianqiang Liu <qianqiang.liu@163.com>,
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
 <3930aad6-174d-4422-944e-6c90a3ea065a@huawei.com>
 <20241016204741.GA3204734@mit.edu>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20241016204741.GA3204734@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml100021.china.huawei.com (7.185.36.148)

On 2024/10/17 4:47, Theodore Ts'o wrote:
> On Wed, Oct 16, 2024 at 04:02:40PM +0800, Baokun Li wrote:
>> As server clusters get larger and larger, server maintenance becomes very
>> difficult. Therefore, timely detection of problems (i.e. online scanning,
>> similar to e2fsck -fn) and timely and non-stop fixing of problems (i.e.
>> online fsck, similar to e2fsck -a) have always been the requirements of
>> our customers. Thus online fsck has been on our TODO list, and it's really
>> time to start doing it. 😀
> As far as online scaning is concerned, if you are using LVM, we can
> use a combination of dm-snapshot and e2fsck -fn --- that is what the
> e2scrub command automates.
Yes, e2scrub is very nice, but it has too many limitations. We have some
customers who don't use lvm.
> Online fsck is much harder, since it would require back pointers to do
> this efficienctly.
Indeed, our rough plan is to first implement isolation of abnormal file
system resources, so that the system can continue to run normally even
when there is an error; then implement online scanning, so that the
maintainer can see the health report at any time; and finally implement
the most difficult online repair.
>   To do this, a general way of solving this would
> involve a generalized some kind of b-tree or b+tree where changes are
> managed via jbd2.  This could be used so that (for example) if we had
> a tree which maps block ranges to an inode number, then given a block
> number, we can figure out which inode "owns" that block.  The harder
> part is those objects that have multiple forward pointers --- for
> example an inode might have multiple hard links to multiple
> directories, so we need to handle this somehow.
We do need to establish the mapping of physical blocks to inodes and inodes
to parent dir. By tree managed by jbd2 do you mean updating the tree when
committing to journal? Or are updates to the tree logged to journal?
>
> If we had the jbd2-aware b+tree, we could also use this add support
> for reflink/clone, which would also be cool.
Yeah, reflink is pretty cool, we can try it out when the others are done.
>
> If this is something that your team really weants to work on, what I'd
> suggest is to create a rough design of what the journaled b+tree would
> look like, and then implement it first, since this is the prerequisite
> for a huge number of advanced file system features.  Implementation
> should be done in a way that makes it easy for the code to be usable
> both in the kernel and in e2fsprogs, since life will be much easier if
> we have e2fsck and debugfs support for the new file system data
> structures from the very beginning of the development.
Thank you for your suggestion! This is really key to the development. We'll
discuss the overall design internally before consulting the community.
> If your company is willing to invest in the engineering effort to do
> this, great!  But I have to point out that an alternative approach
> that you should consider is whether XFS might be a closer match for
> some of your customers' needs.  The advantage of ext4 is that it is
> much simpler and easier to understand that XFS.
The XFS maintainability enhancement is something my colleague is working
on. But we have a fair number of downstream customers who prefer ext4, so
it's worth investing the time to do that.
> But as we add these
> new features, ext4 will get more complex.  And so one of the design
> considerations we should keep in mind is to keep ext4 as simple and
> miantainable as possible, even as we add new functionality.
>
> Cheers,
>
> 						- Ted
Of course! we will keep the code as simple and maintainable as possible.

Thanks again for your input! 😉

Cheers,
Baokun

