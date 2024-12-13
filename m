Return-Path: <linux-ext4+bounces-5614-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 455A19F0A03
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 11:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017AA165B47
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 10:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC221C3BE4;
	Fri, 13 Dec 2024 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZhg6Z5U"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098CE1AE01B;
	Fri, 13 Dec 2024 10:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086869; cv=none; b=JavQ+SMlVC/dZB9J+8/U9lv9T0e0FNL6tXhExWnf6BkUaBjcXtrvPe8nxLUAGVi29pq6guNrA9f+myqOOlNzUYfCHYjejTRlRxzByp+xRpdzvysDckLPWsyBMXsy5bisqJyLTLvoF9QX1rkUylN5draATLa+kan8lccUrF8Bf6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086869; c=relaxed/simple;
	bh=zjU4KhDeGcKIwJPpvk0LLwPiFVFltkicNVkF4cZIADk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PCZ7gs1Aqt6psMXjLuRgMAwFW6b3TbEtoYx1ueQwvcfjBxnXyuebOFhKTa/G3UOml854qHMUEaHid9mDKRMqaSVsfAmMn/Xnukn9HBtm40Gd6e18p63lF1BLHCQn0ThPLClZ/dDhMOacAaHOzT76rJSPG+2dpHQfhAWqc788Gvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZhg6Z5U; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30229d5b21cso13246941fa.1;
        Fri, 13 Dec 2024 02:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734086865; x=1734691665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zM7dxvS0mBxnXFVLmEA6pLfwH2H9xBqQJQJBud7GDRM=;
        b=eZhg6Z5UbD5Ip6rBVg4EoW/ONt5K+jtc6ey3e7FvBVeGtH2kFh4oZYJwP8OfxuOO+j
         eR39wh3tM9HWdQ5fzx5ZOYwn8fWl1D9zthS7+ZlHamFM7mAG/D95ZZRaXzAS0T4HbNXG
         bOYHfTf/gIzjDW1icHjLGs3mVk2DBqG8tj+hJu7NadP+5oauHapp/whltccZfZYmamrW
         DuVdx/mOlMDgNjg7IZpFR6Ty8YTy1YmKhdyO09RxcHYMudcsnMtxvovqZSbCoYM6Zjt4
         w6nHhb7mhKLaSTy9q9Qf/61sUHE3Vvy6JwSfnBi3fURCc1dpbx0yDY83kwl0OierIdF1
         gM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734086865; x=1734691665;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zM7dxvS0mBxnXFVLmEA6pLfwH2H9xBqQJQJBud7GDRM=;
        b=dJAVF9pZ1vWUTlqg9E854ZKSuyUEECk1DI8NrzE3kyObHjiAd+GNhC9EQ+B5xnOrAb
         Qq8ISwYOilZ/QMA6TAWedktz8KFDfgxOjCAyszNGieAYUbNJ+eZnDg6HlZyeVOdzAJvL
         g/uN0iVnXx0IjX0m+IEp0bG/b/BNFhD6yFcbddjQw5v+rJJsj28ojtWB4wwQuj55c9pw
         u3KRSEsxr4OKr3ipQKWBrhkDTbGDVO/nenjvBQkhAdiUfI0TS9MuCfsn7fdd5lGJt3tw
         5cWr9a9yyiwj0Y+WPASwSalaSZEcH0VqZTvZFjvPuv/3OwgCVYhOVT9kMVzFZwseLnwA
         c+ZA==
X-Forwarded-Encrypted: i=1; AJvYcCX1gtIGlm/6gjjEggx98wSo2ycACynzV2VHLje9grN96jQfz5RVSypWZ06eGVrLdBGnsw4gTOJhtBY32/Q=@vger.kernel.org, AJvYcCXkvQWA6RGaO7UWpG1SYWM6GNItGG6fwyndihB13KHU9Gt916hS/Uiix/Cz/1uuRwg/u4Brtrqo@vger.kernel.org
X-Gm-Message-State: AOJu0YwdXcxc/+SiW6762LbqGBnzbmtmG+3PI9cChCyeAjZfaq5FPkO3
	rZR525tZLREWKnkIAy+y5HKKWspIfBDmqrxXoYFWWgjr9A9j7PNh
X-Gm-Gg: ASbGnctygHH8uTbXJgYkKT/1McE43MwqzA7dX/384xsqeCq3G7mQ/IveBswx3OYqi3H
	TaDpgEUYCshgaX34XIpq0nR2DteqYAeMOTN2DmeLw/gmP1ulgIirmWwzVXFaE4PsQMXBGCcS9jP
	4QkPSEluSOi/SrTpPnfDz0iS15lD5mExj78VLaUXk2AR8ePccJqrR0woBD7dLtR2V6YskYTKtil
	l0Qz+Tw5828YVU4FdA/Qab/IRVPsq1nTo00m3tg8NzrDwwED1RLmuBJTCM=
X-Google-Smtp-Source: AGHT+IH486K7s98DFhHG4bd/ZMEsDVoN25MYgvwtS6bqPFiQP4zeJ4ANR78Kv3kiGC1IFNJGZjfgvA==
X-Received: by 2002:a2e:b8c4:0:b0:300:1699:6e9e with SMTP id 38308e7fff4ca-302544cf517mr6532121fa.38.1734086864657;
        Fri, 13 Dec 2024 02:47:44 -0800 (PST)
Received: from [192.168.0.91] ([188.242.176.155])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3015fbfc813sm18233221fa.77.2024.12.13.02.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 02:47:42 -0800 (PST)
Message-ID: <79af4b93-63a1-da4c-2793-8843c60068f5@gmail.com>
Date: Fri, 13 Dec 2024 13:49:59 +0300
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From: Nikolai Zhubr <zhubr.2@gmail.com>
Subject: Re: ext4 damage suspected in between 5.15.167 - 5.15.170
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, jack@suse.cz
References: <CALQo8TpjoV8JtuYDH_nBU5i4e-iuCQ1-NORAE8uobpDD_yYBTA@mail.gmail.com>
 <20241212191603.GA2158320@mit.edu>
Content-Language: en-US
In-Reply-To: <20241212191603.GA2158320@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ted,

> On Thu, Dec 12, 2024 at 09:31:05PM +0300, Nikolai Zhubr wrote:
>> This is to report that after jumping from generic kernel 5.15.167 to
>> 5.15.170 I apparently observe ext4 damage.
> 
> Hi Nick,
> 
> In general this is not something that upstream kernel developers will
> pay a lot of attention to try to root cause.  If you can come up with

Thanks for a quick and detailed reply. That's really appreciated. I need 
to clarify. I'm not a hardcore kernel developer at all, I just touch it 
a little bit occasionally, for random reasons. Debugging the situation 
thoroughly so as to find and prove the cause is far beyond my capability 
and also not exactly my personal or professional interest. I also don't 
need any sort of support (i.e. as a client) - I've already repaired and 
validated/restored from backups almost everything now, and I can just 
stick at 5.15.167 for basically as long as I like.

On the other hand, having buggy kernels (to the point of ext4 fs 
corruption) published as suitable for wide general use is not a good 
thing in my book, therefore I believe in the case of reasonable suspects 
I must at least raise a warning about it, and if I can somehow 
contribute to tracking the problem I'll do what I'm able to.

Not going to argue, but it'd seem if 5.15 is totally out of interest 
already, why keep patching it? And as long as it keeps receiving 
patches, supposedly they are backported and applied to stabilize, not 
damage it? Ok, nevermind :-)

> People will also pay more attention if you give more detail in your
> message.  Not just some vague "ext4 damage" (where 99% of time, these
> sorts of things happen due to hardware-induced corruption), but the
> exact message when mount failed.

Yes. That is why I spent 2 days for solely testing hardware, booting 
from separate media, stressing everything, and making plenty of copies. 
As I mentioned in my initial post, this had revealed no hardware issues. 
And I'm enjoying md raid-1 since around 2003 already (Not on this device 
though). I can post all my "smart" values as is, but I can assure they 
are perfectly fine for both raid-1 members. I encounter faulty hdds 
elsewhere routinely so its not something unseen too.

#smartctl -a /dev/nvme0n1 | grep Spare
Available Spare:                    100%
Available Spare Threshold:          10%

#smartctl -a /dev/sda | grep Sector
Sector Sizes:     512 bytes logical, 4096 bytes physical
   5 Reallocated_Sector_Ct   0x0033   100   100   050    Pre-fail Always 
       -       0
197 Current_Pending_Sector  0x0032   100   100   000    Old_age   Always 
       -       0

I have a copy of the entire ext4 partition taken immediately as mount 
first failed, it is ~800Gb and may contain some sensitive data so I 
cannot just hand it to someone else or publish for examination. But I 
can now easily do a replay of mount failure and fsck processing as many 
times as needed. For now, it seems file/dir bodies had not been damaged, 
just some system areas had. I've not encountered any file which would 
give wrong checksum or otherwise appeared definitely damaged, with 
overall like 95% verified and definitely fine, 5% hard to reliably 
verify but those are less important files.

> Also helpful when reporting ext4 issues, it's helpful to include
> information about the file system configuration using "dumpe2fs -h

This is a dump run on a standalone copy taken before repair (after 
successful raid re-check):

#dumpe2fs -h /dev/sdb1
Filesystem volume name:   DATA
Last mounted on:          /opt
Filesystem UUID:          ea823c6c-500f-4bf0-a4a7-a872ed740af3
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index 
filetype extent 64bit flex_bg sparse_super large_file huge_file 
dir_nlink extra_isize
Filesystem flags:         signed_directory_hash
Default mount options:    user_xattr acl
Filesystem state:         clean with errors
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              51634176
Block count:              206513920
Reserved block count:     10325696
Overhead clusters:        3292742
Free blocks:              48135978
Free inodes:              50216050
First block:              0
Block size:               4096
Fragment size:            4096
Group descriptor size:    64
Reserved GDT blocks:      1024
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         8192
Inode blocks per group:   512
Flex block group size:    16
Filesystem created:       Tue Jul  9 01:51:16 2024
Last mount time:          Mon Dec  9 10:08:27 2024
Last write time:          Tue Dec 10 04:08:17 2024
Mount count:              273
Maximum mount count:      -1
Last checked:             Tue Jul  9 01:51:16 2024
Check interval:           0 (<none>)
Lifetime writes:          913 GB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:	          256
Required extra isize:     32
Desired extra isize:      32
Journal inode:            8
Default directory hash:   half_md4
Directory Hash Seed:      60bfa28b-cdd2-4ba6-8261-87961db4ecea
Journal backup:           inode blocks
FS Error count:           293
First error time:         Tue Dec 10 06:17:23 2024
First error function:     ext4_lookup
First error line #:       1437
First error inode #:      20709377
Last error time:          Tue Dec 10 21:12:30 2024
Last error function:      ext4_lookup
Last error line #:        1437
Last error inode #:       20709377
Journal features:         journal_incompat_revoke journal_64bit
Total journal size:       128M
Total journal blocks:     32768
Max transaction length:   32768
Fast commit length:       0
Journal sequence:         0x00064c6e
Journal start:            0

> /dev/XXX".  Extracting kernel log messages that include the string
> "EXT4-fs", via commands like "sudo dmesg | grep EXT4-fs", or "sudo
> journalctl | grep EXT4-fs", or "grep EXT4-fs /var/log/messages" are
> also helpful, as is getting a report from fsck via a command like

#grep EXT4-fs messages-20241212 | grep md126
2024-12-06T11:53:09.471317+03:00 lenovo-zh kernel: [    7.649474][ 
T1124] EXT4-fs (md126): Mount option "noacl" will be removed by 3.5
2024-12-06T11:53:09.471351+03:00 lenovo-zh kernel: [    7.899321][ 
T1124] EXT4-fs (md126): mounted filesystem with ordered data mode. Opts: 
noacl. Quota mode: none.
2024-12-07T12:03:18.518047+03:00 lenovo-zh kernel: [    7.633150][ 
T1106] EXT4-fs (md126): Mount option "noacl" will be removed by 3.5
2024-12-07T12:03:18.518054+03:00 lenovo-zh kernel: [    7.951716][ 
T1106] EXT4-fs (md126): mounted filesystem with ordered data mode. Opts: 
noacl. Quota mode: none.
2024-12-08T12:41:33.686145+03:00 lenovo-zh kernel: [    7.588405][ 
T1118] EXT4-fs (md126): Mount option "noacl" will be removed by 3.5
2024-12-08T12:41:33.686148+03:00 lenovo-zh kernel: [    7.679963][ 
T1118] EXT4-fs (md126): mounted filesystem with ordered data mode. Opts: 
noacl. Quota mode: none.
(* normal boot failed and subsequently fsck was run on real data here *)
2024-12-10T18:21:40.356656+03:00 lenovo-zh kernel: [  483.522025][ 
T1740] EXT4-fs (md126): failed to initialize system zone (-117)
2024-12-10T18:21:40.356685+03:00 lenovo-zh kernel: [  483.522050][ 
T1740] EXT4-fs (md126): mount failed
2024-12-11T02:00:18.382301+03:00 lenovo-zh kernel: [  490.551080][ 
T1809] EXT4-fs (md126): mounted filesystem with ordered data mode. Opts: 
(null). Quota mode: none.
2024-12-11T12:00:53.249626+03:00 lenovo-zh kernel: [    7.550823][ 
T1056] EXT4-fs (md126): Mount option "noacl" will be removed by 3.5
2024-12-11T12:00:53.249629+03:00 lenovo-zh kernel: [    7.662317][ 
T1056] EXT4-fs (md126): mounted filesystem with ordered data mode. Opts: 
noacl. Quota mode: none.

#grep md126 messages-20241212
2024-12-07T12:03:18.518038+03:00 lenovo-zh kernel: [    7.154448][ T992] 
md126: detected capacity change from 0 to 1652111360
2024-12-07T12:03:18.518047+03:00 lenovo-zh kernel: [    7.633150][ 
T1106] EXT4-fs (md126): Mount option "noacl" will be removed by 3.5
2024-12-07T12:03:18.518054+03:00 lenovo-zh kernel: [    7.951716][ 
T1106] EXT4-fs (md126): mounted filesystem with ordered data mode. Opts: 
noacl. Quota mode: none.
2024-12-08T12:41:33.685280+03:00 lenovo-zh systemd[1]: Started Timer to 
wait for more drives before activating degraded array md126..
2024-12-08T12:41:33.685325+03:00 lenovo-zh systemd[1]: 
mdadm-last-resort@md126.timer: Deactivated successfully.
2024-12-08T12:41:33.685327+03:00 lenovo-zh systemd[1]: Stopped Timer to 
wait for more drives before activating degraded array md126..
2024-12-08T12:41:33.686136+03:00 lenovo-zh kernel: [    7.346744][ 
T1107] md/raid1:md126: active with 2 out of 2 mirrors
2024-12-08T12:41:33.686137+03:00 lenovo-zh kernel: [    7.357218][ 
T1107] md126: detected capacity change from 0 to 1652111360
2024-12-08T12:41:33.686145+03:00 lenovo-zh kernel: [    7.588405][ 
T1118] EXT4-fs (md126): Mount option "noacl" will be removed by 3.5
2024-12-08T12:41:33.686148+03:00 lenovo-zh kernel: [    7.679963][ 
T1118] EXT4-fs (md126): mounted filesystem with ordered data mode. Opts: 
noacl. Quota mode: none.
(* on 2024-12-09 system refused to boot and no normal log was written *)
2024-12-10T18:13:44.862091+03:00 lenovo-zh systemd[1]: Started Timer to 
wait for more drives before activating degraded array md126..
2024-12-10T18:13:45.164589+03:00 lenovo-zh kernel: [    8.332616][ 
T1248] md/raid1:md126: active with 2 out of 2 mirrors
2024-12-10T18:13:45.196580+03:00 lenovo-zh kernel: [    8.363066][ 
T1248] md126: detected capacity change from 0 to 1652111360
2024-12-10T18:13:45.469396+03:00 lenovo-zh systemd[1]: 
mdadm-last-resort@md126.timer: Deactivated successfully.
2024-12-10T18:13:45.469584+03:00 lenovo-zh systemd[1]: Stopped Timer to 
wait for more drives before activating degraded array md126..
2024-12-10T18:18:51.652575+03:00 lenovo-zh kernel: [  314.821429][ 
T1657] md: data-check of RAID array md126
2024-12-10T18:21:40.356656+03:00 lenovo-zh kernel: [  483.522025][ 
T1740] EXT4-fs (md126): failed to initialize system zone (-117)
2024-12-10T18:21:40.356685+03:00 lenovo-zh kernel: [  483.522050][ 
T1740] EXT4-fs (md126): mount failed
2024-12-10T20:07:29.116652+03:00 lenovo-zh kernel: [ 6832.284366][ 
T1657] md: md126: data-check done.
(fsck was run on real data here)
2024-12-11T01:52:15.839052+03:00 lenovo-zh systemd[1]: Started Timer to 
wait for more drives before activating degraded array md126..
2024-12-11T01:52:15.840396+03:00 lenovo-zh kernel: [    7.832271][ 
T1170] md/raid1:md126: active with 2 out of 2 mirrors
2024-12-11T01:52:15.840397+03:00 lenovo-zh kernel: [    7.845385][ 
T1170] md126: detected capacity change from 0 to 1652111360
2024-12-11T01:52:16.255454+03:00 lenovo-zh systemd[1]: 
mdadm-last-resort@md126.timer: Deactivated successfully.
2024-12-11T01:52:16.255573+03:00 lenovo-zh systemd[1]: Stopped Timer to 
wait for more drives before activating degraded array md126..
2024-12-11T02:00:18.382301+03:00 lenovo-zh kernel: [  490.551080][ 
T1809] EXT4-fs (md126): mounted filesystem with ordered data mode. Opts: 
(null). Quota mode: none.

> "fsck.ext4 -fn /dev/XXX >& /tmp/fsck.out"

This is a fsck run on a standalone copy taken before repair (after 
successful raid re-check):

#fsck.ext4 -fn /dev/sdb1
ext2fs_check_desc: Corrupt group descriptor: bad block for block bitmap
fsck.ext4: Group descriptors look bad... trying backup blocks...
Pass 1: Checking inodes, blocks, and sizes
Inode 9185447 extent tree (at level 1) could be narrower.  Optimize? no
Inode 9189969 extent tree (at level 1) could be narrower.  Optimize? no
Inode 22054610 extent tree (at level 1) could be shorter.  Optimize? no
Inode 22959998 extent tree (at level 1) could be shorter.  Optimize? no
Inode 23351116 extent tree (at level 1) could be shorter.  Optimize? no
Inode 23354700 extent tree (at level 1) could be shorter.  Optimize? no
Inode 23363083 extent tree (at level 1) could be shorter.  Optimize? no
Inode 25197205 extent tree (at level 1) could be narrower.  Optimize? no
Inode 25197271 extent tree (at level 1) could be narrower.  Optimize? no
Inode 47710225 extent tree (at level 1) could be narrower.  Optimize? no
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Free blocks count wrong for group #0 (23414, counted=22437).
Fix? no
Free blocks count wrong for group #1 (31644, counted=7).
Fix? no
Free blocks count wrong for group #2 (32768, counted=0).
Fix? no
Free blocks count wrong for group #3 (31644, counted=4).
Fix? no

[repeated tons of times]

Free inodes count wrong for group #4895 (8192, counted=8044).
Fix? no
Directories count wrong for group #4895 (0, counted=148).
Fix? no
Free inodes count wrong for group #4896 (8192, counted=8114).
Fix? no
Directories count wrong for group #4896 (0, counted=13).
Fix? no
Free inodes count wrong for group #5824 (8192, counted=8008).
Fix? no
Directories count wrong for group #5824 (0, counted=31).
Fix? no
Free inodes count wrong (51634165, counted=50157635).
Fix? no
DATA: ********** WARNING: Filesystem still has errors **********
DATA: 11/51634176 files (73845.5% non-contiguous), 3292748/206513920 blocks

>> And because there are apparently 0 commits to ext4 in 5.15 since
>> 5.15.168 at the moment, I thought I'd report.
> 
> Did you check for any changes to the md/dm code, or the block layer?

No. Generally, it could be just anything, therefore I see no point even 
starting without good background knowledge. That is why I'm trying to 
draw attention of those who are more aware instead. :-)

> Also, if you checked for I/O errors in the system logs, or run
> "smartctl" on the block devices, please say so.  (And if there are
> indications of I/O errors or storage device issues, please do
> immediate backups and make plans to replace your hardware before you

I have not found any indication of hardware errors at this point.

#grep -i err messages-20241212 | grep sda
(nothing)
#grep -i err messages-20241212 | grep nvme
(nothing)

Some "smart" values are posted above. Nothing suspicious whatsoever.


Thank you!

Regards,

Nick

> suffer more serious data loss.)
> 
> Finally, if you want more support than what volunteers in the upstream
> linux kernel community can provide, this is what paid support from
> companies like SuSE, or Red Hat, can provide.
> 
> Cheers,
> 
> 							- Ted

