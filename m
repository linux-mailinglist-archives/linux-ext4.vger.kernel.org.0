Return-Path: <linux-ext4+bounces-4620-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 056689A3379
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Oct 2024 05:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36D961C22863
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Oct 2024 03:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB91157465;
	Fri, 18 Oct 2024 03:44:21 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8130154C00;
	Fri, 18 Oct 2024 03:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729223060; cv=none; b=or4HMJ4taBJuaQ+jDJnvNH6FapgvApMqvqjKAzF0DkXQGu6gu0smmgOALvxbrA2Rq6ZKykPSwpLw8+9nBiEMMbmtWB/K1EHbPl3PrN1TCNM1hzjnOQ4vffLn6oNH6/6N+17mrxshqZBmhkDVqwwgdyfoiZsRpMEx8cDU1ntzoWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729223060; c=relaxed/simple;
	bh=QZkw0hyKmTRYADg2Zmk0ARqL53eXfipXjETL2xk2L9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VgP8AvlsC/9WncCUVC69fa2iTI59nkT/TfN1pOLhi2j4uKs4y1bOcmLXz6YHxl9p/BjUHXLA8qb9ZtdX1QgjGqg5vSkClGloXc3rBPWp+xX5Qlm5fvWb82AIxLMTwWBEfP8U9pEL2YiVxaIyxiEChUEcnD+qvmRONX5YuOQNerE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XV9XT5PmDzQrwM;
	Fri, 18 Oct 2024 11:43:21 +0800 (CST)
Received: from dggpeml100021.china.huawei.com (unknown [7.185.36.148])
	by mail.maildlp.com (Postfix) with ESMTPS id 006361400D4;
	Fri, 18 Oct 2024 11:44:08 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpeml100021.china.huawei.com
 (7.185.36.148) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 18 Oct
 2024 11:44:07 +0800
Message-ID: <f74591de-72ce-48aa-94eb-b38e4f74cc5f@huawei.com>
Date: Fri, 18 Oct 2024 11:44:07 +0800
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
 <811eb084-55d4-4725-9388-05a6e8f489d9@huawei.com>
 <20241017144731.GA3254556@mit.edu>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20241017144731.GA3254556@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml100021.china.huawei.com (7.185.36.148)

On 2024/10/17 22:47, Theodore Ts'o wrote:
> On Thu, Oct 17, 2024 at 08:42:59PM +0800, Baokun Li wrote:
>> Indeed, our rough plan is to first implement isolation of abnormal file
>> system resources, so that the system can continue to run normally even
>> when there is an error; then implement online scanning, so that the
>> maintainer can see the health report at any time; and finally implement
>> the most difficult online repair.
> We have some of this already; if a block group has obvious
> inconsistencies --- for example, if there is an attempt to mark a
> block or inode as free, but it's already marked as free as the
> allocation bitmap, we can mark the block group as inconsistent, and
> then avoid allocating from the block group.  That's easy because it's
> the kind of inconsistency which can be detected locally.
Yes, there is now block group level isolation. Our goal is to further
reduce the scope of isolation to minimise the impact of isolation.

The rough idea is to isolate resources where errors are reported,
and throw errors when isolation is not possible. This may be a bit
crude, but after implementing inline scanning we can achieve precise
fine-grained isolation.
> The problem comes with those inconsistencies which require a global
> examination of the file system data structures.  For example, is the
> refcount of an inode correct?  Or is a block claimed by more than one
> inode?  The e2scrub approach requires creating a read-only snapshot
> (which is why we need LVM) and then running e2fsck in userspace,
> because it does a global examination of all file system data
> structures.
Indeed, consistency is a tricky issue, and we'll focus on that piece of
logic.
>> We do need to establish the mapping of physical blocks to inodes and
>> inodes to parent dir. By tree managed by jbd2 do you mean updating
>> the tree when committing to journal? Or are updates to the tree
>> logged to journal?
> When we allocate a block, we need to journal the changes to the
> allocation bitmap.  If we are going to also update the reverse mapping
> data structure, that needs to be journalled also, so that after a
> crash, the data structures are consistent.
>
> 						- Ted
>
Of course, we have to make sure that the metadata modification and the tree
update are in the same transaction, otherwise there is no guarantee that
the metadata is consistent.

Thank you for your input!

Regards,
Baokun


