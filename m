Return-Path: <linux-ext4+bounces-8972-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E18B03535
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 06:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9872166102
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 04:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62EF1F0E47;
	Mon, 14 Jul 2025 04:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ep4ypj/H"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24C419307F
	for <linux-ext4@vger.kernel.org>; Mon, 14 Jul 2025 04:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752467854; cv=none; b=YeMtQxd0xk20jCSF42BmtmIi/m4g/u9ZhSad0TpHuQ7/OeIY4iSRfhXkz9FXtbz9i2gtOGZJqA92xsUEedqTfhW9q/K2WBPMthC8TscEY/9LKnut//m5GgPqGs9BEQhRh2GGUDPNhcgu0dCERdbEfkbJId2BnyzwXJrA2qCywGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752467854; c=relaxed/simple;
	bh=KcCGIYELO+lqtFueLrn9daxOieki9lMbtCBfsvSTZto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3pNEWAddekMmck903bWECZ+ePkF4q+zYSE+XlBuYOHaCn0GMX1EiXkUm0A+2Qld64GgH0LQLMPcMaiDFeHfTu0LBCV3N6c3DGL36kCvoejSB4+60NeLiyhIvnmO75uGUQd+PRnkHQL8pCjcXKQqneKyVQld5PxKf2K0qvAzQWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ep4ypj/H; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32b78b5aa39so33825421fa.1
        for <linux-ext4@vger.kernel.org>; Sun, 13 Jul 2025 21:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752467851; x=1753072651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nDKMJme8pov8zoQqIPu91oDNA3PDRvb1DsOjYdl3/E=;
        b=ep4ypj/HfCuseuR81BrL/PoOGfjqst4wRMNCspHmDbUaS9+dlbhhN3bfnowE57xKST
         +kmaWPAa6G+YDZJb3ymBy/pNka7cawVudqvFuP3QIfzyFtx7+FazD2B6dhcxdGaguAvz
         6+qYanQbrKINgznwZVx9CJPz0Epu/fevbC6ajixRNFyLzs7ikKWixbhz0xamHzPWHh2T
         sq7Dm2zihLNlowem5B39s72etTCZAS6S//yTknR+KFZnKhidy/ceJuvly6w8/OaKuDKF
         cdAlTDLbCbwNNjMPRkvkGqnfCTV3hEyzNk0Zln0DQd+ncP8/Mvw2RT7PtmMef4GXfbnR
         2Hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752467851; x=1753072651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nDKMJme8pov8zoQqIPu91oDNA3PDRvb1DsOjYdl3/E=;
        b=b9z4H7UshlPVNjjUfhoMJzpJJpRXR/VMcgUUCMQ1wEDIJfDAYhTjSUHtF+TP9H4S6C
         TOtbwz4A1/X1YFvlJDHFgvaTYKRUREoTVYQ6Av9X3oyWdMtnj4OvjX+tHKwxC9yaajoT
         tH8IXEar/PVVoR8S6+fHioHdkmHhubPaceHiU0NqfKTVjbql+nC6yIr/BpgebPDS61y3
         fXXIn+QrdxrifGFqVfSnN7IhB8jEKAdg9ooUCbQV0Smqg4R45caHocZ3X89XWFkXXt7V
         inPJnM5dFohI139xLClNZg5GBYGjR1QKDShRRGNWg4m05VKzXFysCsO4K22DQjGEFrnt
         ZsAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDPoRkOIqNHHngkohZbIdh2hlf2lU+23Z1OoME9kh20uWkxy6akl/IxfbDgWD1uULkw5f01lZh4KP7@vger.kernel.org
X-Gm-Message-State: AOJu0YzpTfptHDOS4RSoIxGu2k5Juu5URsmCYk3fdHNfAuFbisqIXt4d
	NOws35aRHrRKs6qN08/eWf2hXkUyi+yfl61FYk3X9BT5cb9/U/sqPy2I6SImHBn8w1UEwjU8s88
	hY894PwCr0iPayGIvfO+HF4G6rxPnAUM=
X-Gm-Gg: ASbGncvOSHEnI5uOKxFJA3UflId1+YHz1b1u6xya8X5JuCWRiEQv3D5T4GBJSkLAb25
	L2/1hTZkN6WVLI/TyQGXAB0hNl8vv3jhsyDdPavgmaM5aPoxLfxtouc9sqVDkTiQOsvIntvKtKh
	EX/rTC74QQ5YtX+IeHKpTdtmkp0MYiAbjBByG0MmLRyHBm9iznSmMrYat+7BFpl/5SPs4SuIp0u
	Yr/
X-Google-Smtp-Source: AGHT+IG8on6l7VzkyAPaTgCf6QTc0DsJu1GMpW1k86pFTqLNCIgy8+NlhovdB5yRDL7/lvmqeTmf0Uu87dRnSDS25s8=
X-Received: by 2002:a05:651c:2206:b0:32b:a8f7:9176 with SMTP id
 38308e7fff4ca-330532984f9mr26754041fa.3.1752467850381; Sun, 13 Jul 2025
 21:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJxJ_jhEbHJiP-OzSpp2xqai-n=t2CGKXqkmvqf7T3i37Eki0A@mail.gmail.com>
 <20250711052905.GC2026761@mit.edu> <CAJxJ_jhYUqYhNcsLnjPv+2-n83G77zeQ1jppC6YGfo6bHv+vaA@mail.gmail.com>
 <20250711154012.GB4040@mit.edu> <20250712042714.GG2672022@frogsfrogsfrogs> <20250712143432.GE4040@mit.edu>
In-Reply-To: <20250712143432.GE4040@mit.edu>
From: Jiany Wu <wujianyue000@gmail.com>
Date: Mon, 14 Jul 2025 12:37:21 +0800
X-Gm-Features: Ac12FXyXM8fVTCfXiTGddueSb4_zo5ppW_s52XYugixq_RAgd5Sr0gqgzWEBOaQ
Message-ID: <CAJxJ_jh=4q81OnSXk=yAU3u_7CCHZLGhb31eALF0cSyNv34E1g@mail.gmail.com>
Subject: Re: Issue with ext4 filesystem corruption when writing to a file
 after disk exhaustion
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Darrick J. Wong" <djwong@kernel.org>, yi.zhang@huawei.com, jack@suse.cz, 
	linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Ted,

Good day, thanks indeed for the clarification~
Yes, previously tried to mount a specific ext4 disk-img to /var/log,
with /dev/loop1 device, and rsyslogd will write to /var/log/syslog.
When /tmp directory exhaust manually via fallocate, / dir will be also
occupied as 100%, and rsyslog write errors in /dev/loop1 happen, later
mount as read-only. Different from the early scenario, but this
scenario is not easy to reproduce.
Tried updating the test case, not fallocate all spaces in disk, now
alloc 95%, everything is normal now, no related error prints anymore.
It is confirmed errors are caused by disk exhaust.
I think the main hesitation part is whether fallocate is allowed to
use the whole disk space.
root@testbed:~$ df -Th
Filesystem     Type      Size  Used Avail Use% Mounted on
udev           devtmpfs   16G     0   16G   0% /dev
tmpfs          tmpfs     3.2G   53M  3.1G   2% /run
root-overlay   overlay    32G  6.2G   25G  20% /
/dev/nvme0n1p3 ext4       32G  6.2G   25G  20% /host
/dev/loop1     ext4      3.9G  189M  3.5G   6% /var/log
tmpfs          tmpfs      16G  236M   16G   2% /dev/shm
tmpfs          tmpfs     5.0M     0  5.0M   0% /run/lock
tmpfs          tmpfs     4.0M     0  4.0M   0% /sys/fs/cgroup
root@testbed:~$ mount | grep log
/host/disk-img/var-log.ext4 on /var/log type ext4 (rw,relatime)
root@testbed:~$ ls -lh /host/disk-img/var-log.ext4
-rw-r--r-- 1 root root 4.0G Jul 14 07:05 /host/disk-img/var-log.ext4
root@testbed:~$ file /host/disk-img/var-log.ext4
/host/disk-img/var-log.ext4: Linux rev 1.0 ext4 filesystem data,
UUID=3D49281462-eb22-4f19-8d03-51338eaf278a (needs journal recovery)
(extents) (64bit) (large files) (huge files)

# fallocate to exhaust /tmp directly
root@testbed:~$ df /tmp
Filesystem     1K-blocks      Used Available Use% Mounted on
root-overlay   229572940 229556556         0 100% /

# loop write error
testbed ERR kernel: [ 1019.470013] I/O error, dev loop1, sector 266248
op 0x1:(WRITE) flags 0x103000 phys_seg 1 prio class 2
testbed ERR kernel: [ 1019.479242] Buffer I/O error on dev loop1,
logical block 33281, lost async page write
testbed ERR kernel: [ 1009.228833] loop: Write error at byte offset
673349632, length 4096.
testbed CRIT kernel: [ 1019.487101] EXT4-fs error (device loop1):
ext4_check_bdev_write_error:217: comm rs:main Q:Reg: Error while async
write back metadata

# remounting fs as read-only
testbed ERR kernel: [ 1326.758055] Aborting journal on device loop1-8.
testbed CRIT kernel: [ 1326.765336] EXT4-fs error (device loop1):
ext4_journal_check_start:83: comm auditd: Detected aborted journal
testbed CRIT kernel: [ 1326.765960] EXT4-fs error (device loop1):
ext4_journal_check_start:83: comm rs:main Q:Reg: Detected aborted
journal
testbed CRIT kernel: [ 1326.775629] EXT4-fs (loop1): Remounting
filesystem read-only

Best regards,
Jianyue Wu

On Sat, Jul 12, 2025 at 10:34=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrot=
e:
>
> On Fri, Jul 11, 2025 at 09:27:14PM -0700, Darrick J. Wong wrote:
> >
> > Honestly it's really too bad that there's no way for an fs to ask the
> > block device how much space it thinks is available, and then teach its
> > own statfs method to return min(fs space available, bdev space
> > availble).
> >
> > Then at least df could report that your 500T ramdisk filesystem on a 4G
> > /tmp really only has 4G of space available.
>
> I think it would be better if there was an extra field in the statfs
> structure that reported bdev space available, and have it show up
> as an extra (optional) column in the df report.
>
> The problem is that bdev space available could be highly variable.
> For example, suppose you had a few thousand users all sharing thinly
> provisioned space.  If a whole bunch of users suddenly all start using
> space, the available space at the storage layer could suddenly
> plummet.  And if the available space starts getting low, this might trigg=
er
> automated, central fstrims on all of the volumes, causing the free
> space to go back up.
>
> Having the free space on a file system as reported by df go up and
> down randomly would very likely cause users to get very confused
> and upset, especially when it wasn't under their control.  Even for a
> single user system the free space in tmpfs could go down suddenly when
> some huge process suddenly started, and then go up suddenly when that
> process gets OOM-killed.  :-)
>
>                                            - Ted

