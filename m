Return-Path: <linux-ext4+bounces-12123-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F4EC9AA65
	for <lists+linux-ext4@lfdr.de>; Tue, 02 Dec 2025 09:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 93929344FB1
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Dec 2025 08:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3658B2F6189;
	Tue,  2 Dec 2025 08:18:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04387221FD0;
	Tue,  2 Dec 2025 08:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764663510; cv=none; b=TQjLVQYsq+6ceeHWzZakfooeCGfHPME+54uQsTo1psLQdlqpWWXijDqFQ7gi85ODYM6FRwQAxq3OQqU1tfjbS7VpH2eFMztzqJ7RA0WL7Y0G2qsf53vfzSDbqDrySwA5UyT+WbB4ABpL0esCD7eeg0Q3vRizHNz+ndjeebr31F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764663510; c=relaxed/simple;
	bh=06omhx8m0zTD+SdVBA9LnBPAKSG4XfaJeHX/46S4xkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IBxmiUIY2IJ9/4l9JQLwwCGVioNYFgiYfJgviAHuHk3wkmYwcmbfuivOgDTh5YtCilXq3CZ7g/78eS+0xPuhJT9foleNE/4Sjoc0CJA1+TLhM6lsBVY2nij/nw+Rjx2VXin7EpCiuDHHZWVomA8WXTIyfvGaE9S6RsFzOk/jvMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dLDCb30gNzKHM0f;
	Tue,  2 Dec 2025 16:17:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 05CD11A018D;
	Tue,  2 Dec 2025 16:18:19 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgBnR1HHoC5pjaBLAQ--.21230S3;
	Tue, 02 Dec 2025 16:18:16 +0800 (CST)
Message-ID: <f06069a9-6ea6-4ca4-96c0-c78a4006cb27@huaweicloud.com>
Date: Tue, 2 Dec 2025 16:18:15 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: Fix KASAN slab-use-after-free in ext4_find_extent
 due to corrupted eh_entries
To: =?UTF-8?B?5L2Z5piK6ZOW?= <3230100410@zju.edu.cn>,
 Theodore Tso <tytso@mit.edu>
Cc: security@kernel.org, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1975626f.37736.19ada7d3de4.Coremail.haochengyu@zju.edu.cn>
 <20251202032423.GC29113@macsyma.lan>
 <22942473.381f6.19ade05fca6.Coremail.3230100410@zju.edu.cn>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <22942473.381f6.19ade05fca6.Coremail.3230100410@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBnR1HHoC5pjaBLAQ--.21230S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw17Ar48Kr47urW3ZFWUurg_yoW7CF13pa
	yfKa4DKF4kJ34rCFZ2vr4vva4jvw48tF45Gr1DWr9xAasY9w1xtF1Skr1agF1DuF4fAF4I
	va18XwnFk3WUAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU80fO7UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

Hello!

On 12/2/2025 3:45 PM, 余昊铖 wrote:
> Hi,
> 
> Thank you for your advice. For the reproduction, I can trigger 'BUG: KASAN: slab-use-after-free in ext4_find_extent' on my computer stably using the original reproducer. And I only modified a few options in the kernel config(the exact kernel config is in the attachments):
> 
> 
> CONFIG_KCOV=y
>  
> CONFIG_DEBUG_INFO_DWARF4=y
>  
> CONFIG_KASAN=y
> CONFIG_KASAN_INLINE=y
>  
> CONFIG_CONFIGFS_FS=y
> CONFIG_SECURITYFS=y
> 
> CONFIG_VIRTIO_NET=y
> CONFIG_E1000=y
> CONFIG_E1000E=y
>  
> CONFIG_CMDLINE_BOOL=y
> CONFIG_CMDLINE="net.ifnames=0"
> 
> 
> And I run the reproducer in qemu with command:
> 
> 
> sudo qemu-system-x86_64 \
>   -m 2G \
>   -smp 2 \
>   -kernel /mushome/lizao/patch/linux-6.12.51/arch/x86/boot/bzImage \
>   -append "console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0 panic_on_warn=1 panic_on_oops=1" \
>   -drive file=/mushome/lizao/patch/image/bullseye.img,format=raw \
>   -net user,host=10.0.2.10,hostfwd=tcp:127.0.0.1:10021-:22 \
>   -net nic,model=e1000 \
>   -enable-kvm \
>   -nographic \
>   -pidfile vm.pid \
>   2>&1 | tee vm.log
> 
> 
> So I think something went wrong when I simplified the reproducer. Sorry for my mistake.
> 
> And for the deeper analysis, in ext4_iget() (fs/ext4/inode.c), we only call ext4_ext_check_inode() if the inode does not have inline 
> data. But the malicious image sets both EXT4_INODE_EXTENTS and EXT4_INLINE_DATA on inode #15. This combination is normally contradictory, but ext4 accepts it, so the inline-data guard short-circuits the extent sanity check entirely. Because of that, the extent root stored inside i_block is never validated even though this inode is later treated as an extent-based regular file. When ext4_find_extent() runs, it trusts the forged header (eh_entries >> eh_max) and calls ext4_ext_binsearch(), which in turn uses EXT_LAST_EXTENT() and walks well past the inline i_block area. The pointers land in unrelated slab objects and trigger the KASAN slab-UAF you saw.
> 
> The core bug is that ext4 permits EXT4_INLINE_DATA and EXT4_INODE_EXTENTS to coexist without revalidating the inline extent tree. A crafted inode can therefore bypass __ext4_ext_check(), poison eh_entries, and later crash the kernel as soon as any extent traversal occurs.
> 
> Hope this clarifies the root cause and why my patch is validate. Thanks.

Thank you for your thorough and detailed analysis. I suppose this bug
have been fix by Deepanshu in commit 1d3ad183943b3 ("ext4: detect
invalid INLINE_DATA + EXTENTS flag combination"). Please try this
commit.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=1d3ad183943b3

Regard,
Yi.

> 
> 
>> On Mon, Dec 01, 2025 at 11:17:12PM +0800, ????????? wrote:
>>> Hello,
>>>
>>> I would like to report a potential security issue in the Linux
>>> kernel ext4 filesystem, which I found using a modified
>>> syzkaller-based kernel fuzzing tool that I developed.
>>
>> Thank you for submitting this bug report, and thank you for doing the
>> work to create a simplified reproducer and doing the initial analysis.
>> It is much appreciated.  Unfortunately, I haven't been able to
>> reproduce the issue.  You didn't send me the exact kernel config that
>> you used, so I used my default kernel config that I use by testing
>> via:
>>
>> % install-kconfig --kasan
>> % kbuild
>>
>> ... using the kvm-xfstests utilities that can be found at [1], in the
>> kernel-build directory.
>>
>>        https://github.com/tytso/xfstests-bld
>>
>> I tried using both the latest mainline kernel, as well as 6.12.51,
>> this that was your reported that you were doing your testing.
>>
>> % kvm-xfstests shell
>>     ...
>> root@kvm-xfstests:~# uname -a 
>> Linux kvm-xfstests 6.18.0-rc7-xfstests-kasan-01168-g7b2a79c93971 #312 SMP PREEMPT_DYNAMIC Mon Dec  1 21:30:56 EST 2025 x86_64 GNU/Linux
>> root@kvm-xfstests:~# cd /vtmp/   
>> root@kvm-xfstests:/vtmp# ./repro_simplified 
>> [*] Using loop device: /dev/loop0
>> [   14.949088] loop0: detected capacity change from 0 to 512
>> [   14.953285] EXT4-fs warning (device loop0): ext4_multi_mount_protect:324: MMP interval 42 higher than expected, please wait.
>> [   14.953285] 
>> [   59.461261] EXT4-fs (loop0): warning: mounting unchecked fs, running e2fsck is recommended
>> [   59.463299] EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: writeback.
>> [*] Mounted image.img to ./mnt
>> [*] Triggering bug...
>> [*] sendfile returned: 170
>> [*] Done. If kernel didn't crash, the repro finished.
>> root@kvm-xfstests:/vtmp# 
>>
>> So I then took a look at the code in question, and at your proposed
>> patch.  If you could do some more analysis, please take a look at all
>> of the checks done by the function __ext4_ext_check(), which
>> implements the checks in the functions ext4_ext_check_inode() and
>> ext4_ext_check().  These functions get called when the inode is read
>> into memory (for the root extent tree in the inode) or when an extent
>> tree block is read into memory.
>>
>> So I'm not sure why your patch would make a difference --- and given
>> that your simplified reproducer isn't triggering the crash, even when
>> KASAN is enabled, I can't validate whether your patch *would* make a
>> difference.
>>
>> Could you try to do a deeper analysis?   Thanks,
>>
>> 						- Ted


