Return-Path: <linux-ext4+bounces-5870-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B43EA006E9
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jan 2025 10:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 494693A3D9A
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jan 2025 09:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9C51C548A;
	Fri,  3 Jan 2025 09:27:13 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA411D5AA8
	for <linux-ext4@vger.kernel.org>; Fri,  3 Jan 2025 09:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735896432; cv=none; b=QvzVKIQ6yKt8T9dJi93lbzhNg7yqvvAn08PBo18qonrI6b8xKt+EHCg0TEueKuTq6j63TYbWlkIayuW1jRP7Hv33uXiveUQF38Qij8Ve7k47WcgNdYR0ZslXCWu++EAwtS8h/CqJEzT3extJssuE5D4mkmxTDuvIS5RVUYv0FSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735896432; c=relaxed/simple;
	bh=rudx6aYT+mqQIepR/IzVH3IhNK+klPABQ0m6Ld2Cofw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cHhQMqaPGZiG3ONBstU3mTHmT6/xwgLgfjpJFW16d449PeB0M6YCy/nHutxtuX6g9NgQo5+7GB5ZXbEnyaaQrTvXNj5PEWb5gxqP1re/nYwwLQvNvpJZEkQWalpXU8wLdQcA/KdMsZPSadSwYsLq6nLBaYsaFJZ2MPxxldJzfdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YPdTT3mlWzXp7C;
	Fri,  3 Jan 2025 17:25:17 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 139101800D1;
	Fri,  3 Jan 2025 17:27:00 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 3 Jan
 2025 17:26:59 +0800
Message-ID: <17108cad-efa8-46b4-a320-70d7b696f75b@huawei.com>
Date: Fri, 3 Jan 2025 17:26:58 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IFtCVUcgUkVQT1JUXSBleHQ0OiDigJxlcnJvcnM9cmVtb3VudC1y?=
 =?UTF-8?B?b+KAnSBoYXMgYmVjb21lIOKAnGVycm9ycz1zaHV0ZG93buKAnT8=?=
To: Jan Kara <jack@suse.cz>
CC: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, Theodore Ts'o
	<tytso@mit.edu>, Christian Brauner <brauner@kernel.org>,
	<sunyongjian1@huawei.com>, Yang Erkun <yangerkun@huawei.com>, Baokun Li
	<libaokun1@huawei.com>
References: <22d652f6-cb3c-43f5-b2fe-0a4bb6516a04@huawei.com>
 <z52ea53du2k66du24ju4yetqm72e6pvtcbwkrjf4oomw2feffq@355vymdndrxn>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <z52ea53du2k66du24ju4yetqm72e6pvtcbwkrjf4oomw2feffq@355vymdndrxn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg500008.china.huawei.com (7.202.181.45)

Hi Honza，

Happy New Year!

On 2025/1/2 23:58, Jan Kara wrote:
> On Mon 30-12-24 15:27:01, Baokun Li wrote:
>> After commit d3476f3dad4a (“ext4: don't set SB_RDONLY after filesystem
>> errors”) in v6.12-rc1, the “errors=remount-ro” mode no longer sets
>> SB_RDONLY on errors, which results in us seeing the filesystem is still
>> in rw state after errors. The issue fixed by this patch is reported as
>> CVE-2024-50191.
>>
>> https://lore.kernel.org/all/2024110851-CVE-2024-50191-f31c@gregkh/
>>
>> This has actually changed the remount-ro semantics. We have some fault
>> injection test cases where we unmount the filesystem after detecting
>> a ro state and then check for consistency. Our customer has a similar
>> scenario. In "errors=remount-ro" mode, some operations are performed
>> after the file system becomes read-only.
> I'm sorry to hear that your fault injection has been broken by my changes.
Never mind. Let's fix this!
>> We reported similar issues to the community in 2020,
>> https://lore.kernel.org/all/20210104160457.GG4018@quack2.suse.cz/
>> Jan Kara provides a simple and effective patch. This patch somehow
>> didn't end up merged into upstream, but this patch has been merged into
>> our internal version for a couple years now and it works fine, is it
>> possible to revert the patch that no longer sets SB_RDONLY and use
>> the patch in the link above?
> Well, the problem with filesystem freezing was just the immediate trigger
> for the changes. But the setting of SB_RDONLY bit by ext4 behind the VFS'
> back (as VFS is generally in charge of manipulating that bit and you must
> hold s_umount for that which we cannot get in ext4 when handling errors)
> was always problematic and I'm almost sure syzbot would find more problems
> with that than just fs freezing. As such I don't think we should really
> return to doing that in ext4 but we need to find other ways how to make
> your error injection to work...
I believe this is actually a bug in the evolution of the freeze
functionality. In v2.6.35-rc1 with commit 18e9e5104fcd ("Introduce
freeze_super and thaw_super for the fsfreeze ioctl"), the introduction
of freeze_super/thaw_super did not cause any problems when setting the
irreversible read-only (ro) bit without locking, because at that time
we used the flag in sb->s_frozen to determine the file system's state.
It was not until v4.3-rc1 with commit 8129ed29644b ("change sb_writers
to use percpu_rw_semaphore") introduced locking into
freeze_super/thaw_super that setting the irreversible ro without locking
caused thaw_super to fail to release the locks that should have been
released, eventually leading to hangs or other issues.

Therefore, I believe that the patch discussed in the previous link is
the correct one, and it has a smaller impact and does not introduce any
mechanism changes. Furthermore, after roughly reviewing the code using
SB_RDONLY, I did not find any logic where setting the irreversible ro
without locking could cause problems. If I have overlooked anything,
please let me know.
>> What's worse is that after commit
>>    95257987a638 ("ext4: drop EXT4_MF_FS_ABORTED flag")
>> was merged in v6.6-rc1, the EXT4_FLAGS_SHUTDOWN bit is set in
>> ext4_handle_error(). This causes the file system to not be read-only
>> when an error is triggered in "errors=remount-ro" mode, because
>> EXT4_FLAGS_SHUTDOWN prevents both writing and reading.
> Here I don't understand what is really the problem with EXT4_MF_FS_ABORTED
> removal. What do you exactly mean by "causes the file system to not be
> read-only"? We still return EROFS where we used to, we disallow writing as
> we used to. Can you perhaps give an example what changed with this commit?
Sorry for the lack of clarity in my previous explanation. The key point
is not about removing EXT4_MF_FS_ABORTED, but rather we will set
EXT4_FLAGS_SHUTDOWN bit, which not only prevents writes but also prevents
reads. Therefore, saying it's not read-only actually means it's completely
unreadable.
>> I'm not sure
>> if this is the intended behavior. But if the intention is to shut down
>> the file system upon an error, I feel it would be better to add an
>> "errors=shutdown" option.
> The point was not really to create new "errors=" mode but rather implement
> the "don't modify the filesystem after we spot error" behavior without
> touching the SB_RDONLY flag.
Yes, both remount-ro and shutdown can ensure that the file system is
not modified, but the former still allows reading the files in the file
system after an error occurs, which is also the literal meaning of
'errors=remount-ro'.
> So how does your framework detect that the filesystem has failed with
> errors=remount-ro? By parsing /proc/mounts or otherwise querying current
> filesystem mount options?
In most cases, run the mount command and filter related options.
> Would it be acceptable for you to look at some
> other mount option (e.g. "shutdown") to detect that state? We could easily
> implement that.
We do need to add a shutdown hint, but that's not the point.

We've discussed this internally, and now if the logs are flushed,
we have no way of knowing if the current filesystem is shutdown. We don't
know if the -EIO from the filesystem is a hardware problem or if the
filesystem is already shutdown. So even if there is no current problem,
we should add some kind of hint to let the user know that the current
filesystem is shutdown.

The changes to display shutdown are as follows, so that we can see if the
current filesystem has been shutdown in the mount command.

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 3955bec9245d..ba28ef0f662e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3157,6 +3157,9 @@ static int _ext4_show_options(struct seq_file 
*seq, struct super_block *sb,
         if (nodefs && !test_opt(sb, NO_PREFETCH_BLOCK_BITMAPS))
                 SEQ_OPTS_PUTS("prefetch_block_bitmaps");

+       if (!nodefs && ext4_forced_shutdown(sb))
+               SEQ_OPTS_PUTS("shutdown");
+
         ext4_show_quota_options(seq, sb);
         return 0;
  }
> I'm sorry again for causing you trouble.

Never mind, thank you for your reply!


Regards,
Baokun


