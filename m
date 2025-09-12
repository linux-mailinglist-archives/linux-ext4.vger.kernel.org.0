Return-Path: <linux-ext4+bounces-9943-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0774FB540DE
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Sep 2025 05:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B904A1790F2
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Sep 2025 03:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5C922FAFD;
	Fri, 12 Sep 2025 03:28:25 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE91756B81
	for <linux-ext4@vger.kernel.org>; Fri, 12 Sep 2025 03:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757647704; cv=none; b=STzZr/7Rl9wCorNVykiVPbmDoObaZkZOon3aDAgK4HuTdJvcf/DviFDOCv6D7QL/ewinznRzN/nr3sp04fn5AfmhdSkckHAWdfBYfcDz+HLeRpLZyCDPYT2dJlIHb+LB7xdVNt2qSZrAp6gS4/MB/swHDYV/I5RWZURq+WxtoYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757647704; c=relaxed/simple;
	bh=IEh6tp2krpYxomlz07Gv4W22uGcIgeXCDzuwrD1xh2o=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=G3uWdggqoxmrCskr9Afeg/RA1Vegwo0YbKlL/8wW84/R6TR4k10T2x48ivLvvbtzPMOMd+p6AiD3bwM2bx4iNvI48p1ImKG0l2XQLtJEt1+h/IsmBDmCsmiZRrIyb809SpXIkhsS8bFcxCW6Txdb882AwBl+mZ9pryFT3emcqf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cNKdH3GNjzYQv2N
	for <linux-ext4@vger.kernel.org>; Fri, 12 Sep 2025 11:28:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id F3ADA1A0EA8
	for <linux-ext4@vger.kernel.org>; Fri, 12 Sep 2025 11:28:17 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgCn8IxOk8NovnjeCA--.36276S3;
	Fri, 12 Sep 2025 11:28:15 +0800 (CST)
Message-ID: <a9417096-9549-4441-9878-b1955b899b4e@huaweicloud.com>
Date: Fri, 12 Sep 2025 11:28:13 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.cz>,
 Zhang Yi <yi.zhang@huawei.com>, yi.zhang@huaweicloud.com,
 "Li,Baokun" <libaokun1@huawei.com>, hsiangkao@linux.alibaba.com,
 yangerkun <yangerkun@huawei.com>
Subject: BUG report: an ext4 data corruption issue in nojournal mode
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCn8IxOk8NovnjeCA--.36276S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF47ZF47Ww47trWkCw15urg_yoW5tr45pr
	W5Ka17tr1DG3sa9an7ZF4UJFW0vw4fC345Gr1rKFn0v3y5Jry2vFZ2yrW0vFWUZFZ7CasI
	qr4jqrykCa4DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_Jw0_
	GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

Hi, all!

Gao Xiang recently discovered a data corruption issue in **nojournal**
mode. After analysis, we found that the problem is after a metadata
block is freed, it can be immediately reallocated as a data block.
However, the metadata on this block may still be in the process of being
written back, which means the new data in this block could potentially
be overwritten by the stale metadata.

When releasing a metadata block, ext4_forget() calls bforget() in
nojournal mode, which clears the dirty flag on the buffer_head. If the
metadata has not yet started to be written back at this point, there is
no issue. However, if the write-back has already begun but the I/O has
not yet completed, ext4_forget() will have no effect, and the subsequent
ext4_mb_clear_bb() will immediately return the block to the mb
allocator. This block can then be immediately reallocated, potentially
triggering a data loss issue.

This issue is somewhat related to this patch set[1] that have been
merged. Before this patch set, clean_bdev_aliases() and
clean_bdev_bh_alias() could ensure that the dirty flag of the block
device buffer was cleared and the write-back was completed before using
newly allocated blocks in most cases. However, this patch set have fixed
a similar issues in journal mode and removed this safeguard because it's
fragile and misses some corner cases[2], increasing the likelihood of
triggering this issue.

Furthermore, I found that this issue theoretically still appears to
persist even in **ordered** journal mode. In the final else branch of
jbd2_journal_forget(), if the metadata block to be released is also
undergoing a write-back, jbd2_journal_forget() will add this buffer to
the current transaction for forgetting. Once the current transaction is
committed, the block can then be reallocated. However, there is no
guarantee that the ongoing I/O will complete. Typically, the undergoing
metadata writeback I/O does not take this long to complete, but it might
be throttled by the block layer or delayed due to anomalies in some slow
I/O processes in the underlying devices. Therefore, although it is
difficult to trigger, it theoretically still exists.

Consider the fix for now. In the **ordered** journal mode, I suppose we
can add a wait_on_buffer() during the process of the freed buffer in
jbd2_journal_commit_transaction(). This should not significantly impact
performance. In **nojorunal** mode, I do not want to reintroduce
clean_bdev_aliases(). One approach is to add wait_on_buffer() in
__ext4_forget(), but I am concerned that this might impact performance.
However, it seems reasonable to wait for ongoing I/O to complete before
freeing the buffer. Otherwise, another solution is we may need to
implement an asynchronous release process that returns the block to the
buddy system only after the I/O operation has completed. However, since
the write-back is triggered by bdev, it appears to be hard to implement
this solution now. What do people think?

In the long run, I think metadata buffer and writeback should be managed
by ext4 and jbd2 themselves, rather than through bdev.

[1] https://lore.kernel.org/linux-ext4/1548830980-29482-1-git-send-email-yi.zhang@huawei.com/
[2] https://lore.kernel.org/linux-ext4/942a44fe-4350-2f59-9913-c47ee6ff9031@huawei.com/

Best Regards,
Yi.


