Return-Path: <linux-ext4+bounces-3331-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E44937EC8
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Jul 2024 04:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5671F21D71
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Jul 2024 02:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DABB664;
	Sat, 20 Jul 2024 02:57:52 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227568830;
	Sat, 20 Jul 2024 02:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721444272; cv=none; b=KQ+RPo6gG5h2MlXHS+spQq7j55LOESpyCwYqDWL+gR/G3LFdKDit10NPBP42Cx2KRu8YlnrYO7qQ8shgAdM/pmZDC4MBz62FDFxz3wKf0DVrz4Q5x5Ndj63yxPOnKoOvoWLkpfShdtQFqseam+JJvpA9uwRMXoWWoKeiplVEAJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721444272; c=relaxed/simple;
	bh=MC4bMLPFkaOEMEV4qvxoaeENxoAtQaY147/btmWjftQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ezCE3X7D3XzBvWSzvqeM0W19u5kvMyD9NRjK63p2bPc9WMwU+r/bez4dpg8uvN+BMD+nEjgHVaKsmV1/r5BQ4KwojRuXBPEkV4dsAnsM9oi3wzWg+A+NzTZFSDx0jeWI/kS7663zDQoORuH745RNtNiuQ9dVC3+dn4+lVEwvvOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WQrhh5g74zQm0h;
	Sat, 20 Jul 2024 10:53:40 +0800 (CST)
Received: from dggpeml100021.china.huawei.com (unknown [7.185.36.148])
	by mail.maildlp.com (Postfix) with ESMTPS id 4063D140121;
	Sat, 20 Jul 2024 10:57:47 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.174) by dggpeml100021.china.huawei.com
 (7.185.36.148) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 20 Jul
 2024 10:57:46 +0800
Message-ID: <3dfcb3d0-0461-42c8-a60d-5bfa4b65026a@huawei.com>
Date: Sat, 20 Jul 2024 10:57:46 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] kernel BUG in ext4_do_writepages
To: syzbot <syzbot+d1da16f03614058fdc48@syzkaller.appspotmail.com>,
	<adilger.kernel@dilger.ca>, <jack@suse.cz>, <linux-ext4@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>,
	<tytso@mit.edu>, Baokun Li <libaokun1@huawei.com>
References: <00000000000038105d061d9bf215@google.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <00000000000038105d061d9bf215@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml100021.china.huawei.com (7.185.36.148)

On 2024/7/20 0:11, syzbot wrote:
> This bug is marked as fixed by commit:
> ext4: fix race condition between buffer write and page_mkwrite
>
> But I can't find it in the tested trees[1] for more than 90 days.
> Is it a correct commit?
Sorry for the confusion！

This issue does not have an available solution so far, so as Honza
mentioned before, mark it as unfixed.

#syz unfix

Regards,
Baokun
> Please update it by replying:
>
> #syz fix: exact-commit-title
>
> Until then the bug is still considered open and new crashes with
> the same signature are ignored.
>
> Kernel: Linux
> Dashboard link: https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48
>
> ---
> [1] I expect the commit to be present in:
>
> 1. for-kernelci branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
>
> 2. master branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
>
> 3. master branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
>
> 4. main branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
>
> The full list of 10 trees can be found at
> https://syzkaller.appspot.com/upstream/repos
>

