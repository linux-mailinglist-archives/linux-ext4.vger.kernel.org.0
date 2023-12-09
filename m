Return-Path: <linux-ext4+bounces-351-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7686B80B382
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Dec 2023 11:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112AC281009
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Dec 2023 10:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83BF11C8E;
	Sat,  9 Dec 2023 10:05:22 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2415210EF;
	Sat,  9 Dec 2023 02:05:18 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SnNt20MXjzYcmL;
	Sat,  9 Dec 2023 18:05:14 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 9 Dec 2023 18:05:15 +0800
Message-ID: <e39845b3-e9b4-6ad3-4c53-402628471bcc@huawei.com>
Date: Sat, 9 Dec 2023 18:05:15 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: divide error in mb_update_avg_fragment_size
Content-Language: en-US
To: xingwei lee <xrivendell7@gmail.com>, <harperchen1110@gmail.com>
CC: <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>,
	<syzkaller@googlegroups.com>, <tytso@mit.edu>, Baokun Li
	<libaokun1@huawei.com>, yangerkun <yangerkun@huawei.com>
References: <CABOYnLwVDrhLB6yqqDgS7xixzo-OA=ZcJwBDoMPeQDMiFR7scA@mail.gmail.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <CABOYnLwVDrhLB6yqqDgS7xixzo-OA=ZcJwBDoMPeQDMiFR7scA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected

On 2023/12/8 22:12, xingwei lee wrote:
> Hello I saw you can't reproduce this bug and I reproduce it with
> repro.c and repro.txt
> I test the repro.c in the lastest HEAD: 5e3f5b81de80c98338bcb47c233aebefee5a4801
> kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=6ae1a4ee971a7305
> and the bug also existed.

Hello xingwei!

Thanks for the reproducer!

The problem is that the same range of physical blocks are freed in
ext4_mb_release_inode_pa() and ext4_process_freed_data() successively.
Thus in mb_free_blocks() bb_free is added twice, while bb_fragments
is added only once, the second time exiting early due to checking
for release of already freed blocks. So when fstrim marks all the
blocks in the group as already used, bb_free not being 0 and
bb_fragments being 0 triggers a divide-by-zero problem in
mb_update_avg_fragment_size().

We should avoid freeing blocks in ext4_mb_release_inode_pa() that
are about to be freed in ext4_process_freed_data().  I will send out
a patch after doing some tests.

Cheers!
-- 
With Best Regards,
Baokun Li
.

