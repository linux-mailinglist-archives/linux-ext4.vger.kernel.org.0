Return-Path: <linux-ext4+bounces-14703-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2xkpLv3TrGkUvAEAu9opvQ
	(envelope-from <linux-ext4+bounces-14703-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sun, 08 Mar 2026 02:42:21 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9A922E3DB
	for <lists+linux-ext4@lfdr.de>; Sun, 08 Mar 2026 02:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 32247300D0C7
	for <lists+linux-ext4@lfdr.de>; Sun,  8 Mar 2026 01:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E37727EFE9;
	Sun,  8 Mar 2026 01:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUqfjNP7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DF0257848
	for <linux-ext4@vger.kernel.org>; Sun,  8 Mar 2026 01:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772934131; cv=none; b=GoHn/QGhT/QudiF6gaOaZz3NrFfQjUoJ1xd2a1P3kNx9iSsQ3NFNyF9wHN49mrzkJlrUOxUEWXndYNfiYzbWd9FHOOQ8nOmuVk8vM+taStxtgiteFcbL0YFdszf9x7dpc9ekaUFm+cMIzY5oftjPb0AExV+47IYe7oLdEur6o7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772934131; c=relaxed/simple;
	bh=6w9BI6BfJdUAhYpUrg5zWWv800AOqnL/G7aabYtxMlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ptTBebEu5Ta0Ic7Ir9Mt+dmw9w5f8bIMzJtbfo62Rm0szVl/M+ghPqzXvGkumNsgc9/1HyjXYZJzW5z74mRxKS0gaLOHLfYX/Aa37jUfd5rW/eI7ey3yMpmkvcqEpmVm+fO2WEGKXLDYh3yOdV88YIyRqfMpr5AcBUIw/HLbOp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUqfjNP7; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cb3825b0fbso1042971985a.0
        for <linux-ext4@vger.kernel.org>; Sat, 07 Mar 2026 17:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772934128; x=1773538928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/CpwvAj77DGy7S8ny9m9WU+Lr62sQDiMN75c1U+Fw4=;
        b=mUqfjNP7w16Vs4uXJ5SURGA8/3M8aASujCg5RoMikf8XgyABbAInWw9TlH5P8OzU2X
         9McxxRaCnApwBpVjmNQi7LguUwYlYsrtRW+nt8A8Zbio3JYPaWlC6mYLH3l8ww0BxjKY
         nU8sEbgIycOrSut4pF48ToUB5yt4vMxjY0STAZPI2XJQ8ot4WZVEzO7HWRVoTSk6syco
         GGKu7Pa9ml9c2zb6VNFtWXjM+bssAsl8apdTHBXTCFAwEKH8nZBV9Wma2wJFYxiWZo62
         29GNUU6058ZLtQ8Q04ZEF15erBg9xqww/9R/fcPPgIx2H4jgG5Nbaj1TP3SlKrG107TH
         agXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772934128; x=1773538928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P/CpwvAj77DGy7S8ny9m9WU+Lr62sQDiMN75c1U+Fw4=;
        b=A8OnqLjDJVqPO6kPgFONdkYJt8up1B+03wYKcpLP9LnS7yPUpHJjgUJfB2pP16Tch2
         ZI0XfeIQnq2fQ+RGBbuTAnrpiEwK+eFFXmbaUjxwUskZC63DU+sITv2b30bAecDimK5l
         n6uV1IiocezX+tFQGxWssbnzt7Zwgy5I9P5BSu4Tn6oGrU22GdJv+ENSqpzDxWdLVXFB
         /j3o72SaZHIECI4z/0EzVT+NMivJzcaxG/IWrlgpRhUiEU5Qf+BRLrcnKGAtXmVT4rZE
         XBsG8ecck8LsvBnqaJnzQn3yXflrxa9iK+Pa7zxcO/KRpfR1/QOqvW/45blTmF19p789
         ygCg==
X-Gm-Message-State: AOJu0YzDwWtJ0Zog0iT6mzP6cybqNUPJ43uuqa0MoMGIXpU54KLVvKwN
	RKSIuhObWuSmB/XzPCI0w4OhWotmx2BEVvbNj04pSfW/TOPza5v3j/qxQv/2Rw==
X-Gm-Gg: ATEYQzzK9XEUJxv5P56YKss+hWHMQXrgtO6Ukp7CWNOMyxg/Ws7vhI4P0nKZIj+yO2g
	kqgi4dTewjCrKB4sUMsI5YPK8lBoheX3ojsJw1oR46y5nqwOIFUVTJnzysb1jH1qUlb3o8RQjfo
	KW+xjMPEXzRahb1G5hqtV9Tx25hCWfP8MbttEIrCSN1mX0O4a6knUo7S6lwcop9rjj/qixON0Rh
	Oie75Ew5SJOcP50F4793b3Zq0sqWdRkqE7dv0k7Wf/9gIWinECaUtzMG67HcB2z2E/bw8dB6RdH
	N59iwB88UNMYGZEE66U5ouRx4XWMZXdUKF282XSpqnUG+cyGLfnWV3cvZSQ8uJEIzYTzt0SJZnU
	/j3zqNBTdCaE0esgbgslYLHczpw/wJnZSU4Nxu+ZAP2n+3QMDD53ScResCp+OcMnSCop/VPXpuj
	wxatnUz4SVTqccqg/3VB2BCI8+rdrYVDRnNYhKbivp2TfEJcd/lxTqBxkWu+w2W7AB
X-Received: by 2002:a05:620a:45a4:b0:8a2:3be9:1d79 with SMTP id af79cd13be357-8cd6d433c6amr886735785a.18.1772934127673;
        Sat, 07 Mar 2026 17:42:07 -0800 (PST)
Received: from daniel-desktop3.localnet ([204.48.79.218])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd7f9a286csm90068285a.18.2026.03.07.17.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 17:42:06 -0800 (PST)
From: Daniel Tang <danielzgtg.opensource@gmail.com>
To: Theodore Tso <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH e2fsprogs] e2fsck: preen inline data no attr
Date: Sat, 07 Mar 2026 20:42:04 -0500
Message-ID: <25105329.ouqheUzb2q@daniel-desktop3>
In-Reply-To: <20260306222315.GA42132@macsyma.local>
References:
 <3188418.mvXUDI8C0e@daniel-desktop3> <2415922.vCJZsxu672@daniel-desktop3>
 <20260306222315.GA42132@macsyma.local>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart2312477.KlZ2vcFHjT"
Content-Transfer-Encoding: 7Bit
X-Rspamd-Queue-Id: 8B9A922E3DB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	CTE_CASE(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14703-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzgtgopensource@gmail.com,linux-ext4@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.964];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

This is a multi-part message in MIME format.

--nextPart2312477.KlZ2vcFHjT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

> Does the problem go away if you disable fast_commit?

Disabling fast_commit on all 5 ext4 partitions successfully brought me
from 4 unpreenable unclean shutdowns to a streak of 2 preenable unclean
shutdowns. `/`, /boot, /var, /tmp are clean without needs_recovery in
dumpe2fs, and `fsck.ext4 -f` found no needed fixes. /home was
"Filesystem state: clean" but had needs_recovery and orphan_present.
`fsck.ext4 -p` removed 1=E2=80=932 orphaned inodes.

Testing was performed on the tablet with Firefox open to new tab
without internet, and the same USB-C=E2=80=93HDMI adapter. I might leave
fast_commit off for all partition except `/`, which I mount readonly
except when updating while I sit in a stable environment.

```console
root@ubuntu:~# cryptsetup luksOpen /dev/nvme0n1p9 homecrypt
Enter passphrase for /dev/nvme0n1p9:=20
root@ubuntu:~# dumpe2fs -h /dev/mapper/homecrypt
dumpe2fs 1.47.0 (5-Feb-2023)
=46ilesystem volume name:   <none>
Last mounted on:          /home
=46ilesystem UUID:          b4dee0c9-72e8-4ad8-a277-d14ab505732b
=46ilesystem magic number:  0xEF53
=46ilesystem revision #:    1 (dynamic)
=46ilesystem features:      has_journal ext_attr dir_index sparse_super2 or=
phan_file filetype needs_recovery extent flex_bg inline_data encrypt sparse=
_super large_file metadata_csum orphan_present
=46ilesystem flags:         signed_directory_hash=20
Default mount options:    user_xattr acl
=46ilesystem state:         clean
Errors behavior:          Remount read-only
=46ilesystem OS type:       Linux
Inode count:              9756672
Block count:              78022481
Reserved block count:     0
Overhead clusters:        880816
=46ree blocks:              72084435
=46ree inodes:              9277324
=46irst block:              0
Block size:               4096
=46ragment size:            4096
Blocks per group:         32768
=46ragments per group:      32768
Inodes per group:         4096
Inode blocks per group:   256
=46lex block group size:    8192
=46ilesystem created:       Mon Feb  9 17:26:30 2026
Last mount time:          Sun Mar  8 00:22:42 2026
Last write time:          Sun Mar  8 00:22:42 2026
Mount count:              1
Maximum mount count:      -1
Last checked:             Sun Mar  8 00:22:40 2026
Check interval:           0 (<none>)
Lifetime writes:          38 GB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
=46irst inode:              11
Inode size:               256
Required extra isize:     32
Desired extra isize:      32
Journal inode:            8
Default directory hash:   half_md4
Directory Hash Seed:      3d04ee5a-9500-4206-8eaf-dac860feeb2c
Journal backup:           inode blocks
Checksum type:            crc32c
Checksum:                 0x81ad4fc4
Orphan file inode:        12
Journal features:         journal_incompat_revoke journal_checksum_v3
Total journal size:       1040M
Total journal blocks:     266240
Max transaction length:   266240
=46ast commit length:       0
Journal sequence:         0x00001cf8
Journal start:            205738
Journal checksum type:    crc32c
Journal checksum:         0xfe1d1be0

root@ubuntu:~# fsck.ext4 -p /dev/mapper/homecrypt
/dev/mapper/homecrypt: recovering journal
/dev/mapper/homecrypt: Clearing orphaned inode 430228 (uid=3D1000, gid=3D10=
00, mode=3D0100664, size=3D8028)
/dev/mapper/homecrypt: clean, 479363/9756672 files, 5937874/78022481 blocks
```

> What would be really interesting is
> to see the logs from the fsck.ext4 or kernel run to see what the
> initial complete was

See the attachment in my previous email. Ubuntu and/or systemd will
always fsck before mounting, even on clean reboots. This time I booted
into a Ubuntu 24.04 LiveUSB after the unclean shutdowns to run
dumpe2fs and fsck.ext4.

> More importantly, information about the source of the inconsistency
> report would be written to the superblock

What could have the opportunity to write anything to the superblock?
Before a panic, there's no inconsistency. After a panic, Linux would
say "not syncing", or after a panic, hardware stops before new writes
can reach the disk. systemd, as shown by `systemd-analyze plot` runs
fsck before attempting any `.mount`. initramfs mounts `/` readonly,
and any readwrite setting in `/etc/fstab` is only applied later. In
LiveUSB, I too always fsck first before mounting. Basically, the
filesystem would need to be readwrite or at least mounted and have a
corrupt file be accessed, for the inconsistency report to be written.
Since the fsck always precedes the mount, I don't think any report
will be written to the superblock.

> with the intersection of fast_commit and
> inline_data.
> sign that something isn't quite right,

`/proc/fs/ext4/*/fc-info`'s Ineligible reasons' "Extended attributes
changed" suggests that inline data will requests that fast commit be
disabled each time a small file is written. But the workload that
benefits from each is different. Inline data is for mostly-reading
30,000 mostly-small Javascript files totalling 100 MiB. Fast commit is
for monthly-apt-upgrading 250,000-max (TeX Live) 300-average
(google-chrome-stable) files totaling 64 GiB-max 2 GiB-average.

> is there a reason why you enabled inline_data and fast_commit in the
> first place?  Was there something specific about how you expect the
> file systems will be used that led you to believe they would be
> helpful?

The reason is performance, especially on my desktop with a HDD. Raw
data is in the attached file. In summary:

* apt-get is 7% (48.018 s) faster with fast_commit writes
* npm is 5% (0.9154 s) faster with inline_data reads
--nextPart2312477.KlZ2vcFHjT
Content-Disposition: attachment;
 filename="desktop_20260308_ext4_inlinedata_fastcommit_benchmarks.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8";
 name="desktop_20260308_ext4_inlinedata_fastcommit_benchmarks.txt"

root@daniel-desktop3:~# uname -a
Linux daniel-desktop3 6.17.0-14-generic #14-Ubuntu SMP PREEMPT_DYNAMIC Fri Jan  9 17:01:16 UTC 2026 x86_64 GNU/Linux
root@daniel-desktop3:~# cat /sys/block/sdb/device/model
WDC WD80EAZZ-00B
root@daniel-desktop3:~# fdisk -l /dev/sdb
Disk /dev/sdb: 7.28 TiB, 8001563222016 bytes, 15628053168 sectors
Disk model: WDC WD80EAZZ-00B
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disklabel type: gpt
Disk identifier: 5C03C302-C74E-6A42-8293-CFFDB44076B9

Device           Start         End     Sectors  Size Type
/dev/sdb1         2048 15611275263 15611273216  7.3T Linux filesystem
/dev/sdb2  15611275264 15628052479    16777216    8G Linux filesystem
root@daniel-desktop3:~# cat /etc/mke2fs.conf
[defaults]
        creator_os = Linux
        base_features = ""
        fs_type = ext4
        enable_periodic_fsck = 0
        errors = remount-ro
        force_undo = 0
        auto_64-bit_support = 0
        default_mntopts = acl,user_xattr
        blocksize = 4096
        lazy_itable_init = 1
        lazy_journal_init = 0
        num_backup_sb = 0
        packed_meta_blocks = 1
        inode_ratio = 32768
        inode_size = 256
        reserved_ratio = 0
        hash_alg = half_md4
        flex_bg_size = 8196
        discard = 1
        encoding = utf8-12.1
        encoding_flags = strict

[fs_types]
        ext4 = {
                features = dir_index,ext_attr,extent,fast_commit,filetype,flex_bg,has_journal,inline_data,large_file,metadata_csum,orphan_file,sparse_super,sparse_super2
        }
        tmp = {
                discard = 0
                features = ^has_journal # Note that I didn't disable journaling on my tablet
        }
        home = {
                features = casefold,encrypt
        }
        boot = {
                features = ^inline_data
                inode_ratio = 65536
        }
        small = {
                inode_ratio = 4096
        }
        floppy = {
                inode_ratio = 8192
        }
        big = {
                inode_ratio = 32768
        }
        huge = {
                inode_ratio = 65536
        }
        news = {
                inode_ratio = 4096
        }
        largefile = {
                inode_ratio = 1048576
                blocksize = -1
        }
        largefile4 = {
                inode_ratio = 4194304
                blocksize = -1
        }
        hurd = {
                blocksize = 4096
                inode_size = 128
                warn_y2038_dates = 0
        }
root@daniel-desktop3:~# systemctl stop containerd docker
root@daniel-desktop3:~# mkdir -p /run/downloadtmp /run/archives
root@daniel-desktop3:~# mount -o remount,size=8G /run
root@daniel-desktop3:~# mount --bind /run/downloadtmp /var/lib/containerd
root@daniel-desktop3:~# systemctl start containerd docker
root@daniel-desktop3:~# docker run --rm -itv /run/archives:/var/cache/apt/archives ubuntu:24.04 bash -c 'apt update && apt install -dy texlive-full'
[... 4417 MB and 755 packages ...]
root@daniel-desktop3:~# systemctl stop containerd docker
root@daniel-desktop3:~# umount /var/lib/containerd
root@daniel-desktop3:~# wipefs -a /dev/sdb2
root@daniel-desktop3:~# mkfs.ext4 /dev/sdb2
mke2fs 1.47.2 (1-Jan-2025)
64-bit filesystem support is not enabled.  The larger fields afforded by this feature enable full-strength checksumming.  Pass -O 64bit to rectify.
Creating filesystem with 2097152 4k blocks and 262144 inodes
Filesystem UUID: d370114c-abe5-4b16-adba-e6b626b76f1d
Superblock backups stored on blocks:

Allocating group tables: done
Writing inode tables: done
Creating journal (16640 blocks): done
Writing superblocks and filesystem accounting information: done
root@daniel-desktop3:~# mount /dev/sdb2 /var/lib/containerd
root@daniel-desktop3:~# rm -rf /var/lib/containerd/* /run/containerd
root@daniel-desktop3:~# systemctl start containerd docker
root@daniel-desktop3:~# docker pull ubuntu:24.04
24.04: Pulling from library/ubuntu
01d7766a2e4a: Pull complete
fd8cda969ed2: Download complete
Digest: sha256:d1e2e92c075e5ca139d51a140fff46f84315c0fdce203eab2807c7e495eff4f9
Status: Downloaded newer image for ubuntu:24.04
docker.io/library/ubuntu:24.04
root@daniel-desktop3:~# sync; sysctl -w vm.drop_caches=3
vm.drop_caches = 3
root@daniel-desktop3:~# time docker run --rm -v /run/archives:/mnt ubuntu:24.04 bash -c 'dpkg --force-all -i /mnt/*.deb ; sync'
[...]
real    10m11.195s
user    0m0.102s
sys     0m0.135s
root@daniel-desktop3:~# systemctl stop containerd docker
root@daniel-desktop3:~# umount /var/lib/containerd
root@daniel-desktop3:~# wipefs -a /dev/sdb2
root@daniel-desktop3:~# mkfs.ext4 /dev/sdb2 -O ^fast_commit
[... similar ...]
root@daniel-desktop3:~# mount /dev/sdb2 /var/lib/containerd
root@daniel-desktop3:~# rm -rf /var/lib/containerd/* /run/containerd
root@daniel-desktop3:~# systemctl start containerd docker
root@daniel-desktop3:~# docker pull ubuntu:24.04
[... same ...]
root@daniel-desktop3:~# sync; sysctl -w vm.drop_caches=3
vm.drop_caches = 3
root@daniel-desktop3:~# time docker run --rm -v /run/archives:/mnt ubuntu:24.04 bash -c 'dpkg --force-all -i /mnt/*.deb ; sync'
[...]
real    10m59.213s
user    0m0.117s
sys     0m0.128s
root@daniel-desktop3:~# systemctl stop containerd docker
root@daniel-desktop3:~# umount /var/lib/containerd
root@daniel-desktop3:~# mount -t tmpfs tmpfs /var/lib/containerd
root@daniel-desktop3:~# systemctl start containerd docker
root@daniel-desktop3:~# docker pull ubuntu:24.04
[... same ...]
root@daniel-desktop3:~# runuser home -c 'git -C /home/home/.nvm rev-parse HEAD'
4c556a19b08728989267a89728152e4b6765000b
root@daniel-desktop3:~# runuser home -c 'mkdir /home/home/.nvm2'
root@daniel-desktop3:~# wipefs -a /dev/sdb2
root@daniel-desktop3:~# mkfs.ext4 /dev/sdb2 -E root_owner=1000:1000
[... similar ...]
root@daniel-desktop3:~# mount /dev/sdb2 /home/home/.nvm2
root@daniel-desktop3:~# rm -rf /home/home/.nvm2/lost+found
root@daniel-desktop3:~# runuser home -c 'git clone /home/home/.nvm /home/home/.nvm2'
Cloning into '/home/home/.nvm2'...
done.
root@daniel-desktop3:~# docker run --rm -v /home/home/.nvm2:/.nvm -v /usr/lib/x86_64-linux-gnu/libatomic.so.1.2.0:/usr/lib/x86_64-linux-gnu/libatomic.so.1.2.0:ro ubuntu:24.04 bash -c 'apt update && apt install -y bzip2 wget && . .nvm/nvm.sh && nvm install 25.6.0 && npm i -g @angular/cli@21.1.3 apollo@2.34.0 asar@3.2.0 bun-repl@2.1.1 bun@1.3.9 clipboard-cli@5.0.0 create-react-app@5.1.0 detox-cli@20.47.0 elasticdump@6.124.2 expo-cli@6.3.12 express-generator@4.16.1 firebase-tools@15.5.1 google-closure-compiler@20260128.0.0 graphql@16.12.0 har-extractor@1.1.2 http-server-upload@3.0.0 json@11.0.0 lighthouse@13.0.2 markdown-pdf@11.0.0 npm-check-updates@19.3.2 npm@11.9.0 prettier@3.8.1 qrcode@1.5.4 showdown@2.1.0 svgo@4.0.0 typescript@5.9.3 uglify-js@3.19.3 web-ext@9.2.0'
[...]
added 3892 packages, removed 1 package, and changed 24 packages in [...]s
[...]
root@daniel-desktop3:~# time docker run --rm -v /home/home/.nvm2:/.nvm -v /usr/lib/x86_64-linux-gnu/libatomic.so.1.2.0:/usr/lib/x86_64-linux-gnu/libatomic.so.1.2.0:ro ubuntu:24.04 bash -c 'ln -s /usr/lib/x86_64-linux-gnu/libatomic.so.1.2.0 /usr/lib/x86_64-linux-gnu/libatomic.so.1 && . .nvm/nvm.sh && npm ls -g --depth=0'
[...]
real    0m1.785s
user    0m0.007s
sys     0m0.012s
root@daniel-desktop3:~# sync; sysctl -w vm.drop_caches=3
root@daniel-desktop3:~# time docker run --rm -v /home/home/.nvm2:/.nvm -v /usr/lib/x86_64-linux-gnu/libatomic.so.1.2.0:/usr/lib/x86_64-linux-gnu/libatomic.so.1.2.0:ro ubuntu:24.04 bash -c 'ln -s /usr/lib/x86_64-linux-gnu/libatomic.so.1.2.0 /usr/lib/x86_64-linux-gnu/libatomic.so.1 && . .nvm/nvm.sh && npm ls -g --depth=0'
[...]
real    0m15.520s
user    0m0.007s
sys     0m0.022s
[rerunning, remembering drop_caches:]
real    0m16.480s
user    0m0.007s
sys     0m0.024s
real    0m16.997s
user    0m0.011s
sys     0m0.020s
real    0m16.651s
user    0m0.009s
sys     0m0.020s
real    0m17.035s
user    0m0.008s
sys     0m0.023s
[mean = 16.5366]
[real/user is meaningless with `time docker`]
root@daniel-desktop3:~# umount /home/home/.nvm2
root@daniel-desktop3:~# wipefs -a /dev/sdb2
root@daniel-desktop3:~# mkfs.ext4 /dev/sdb2 -E root_owner=1000:1000 -O ^inline_data
[... similar ...]
root@daniel-desktop3:~# mount /dev/sdb2 /home/home/.nvm2
root@daniel-desktop3:~# rm -rf /home/home/.nvm2/lost+found
root@daniel-desktop3:~# runuser home -c 'git clone /home/home/.nvm /home/home/.nvm2'
Cloning into '/home/home/.nvm2'...
done.
root@daniel-desktop3:~# docker run --rm -v /home/home/.nvm2:/.nvm -v /usr/lib/x86_64-linux-gnu/libatomic.so.1.2.0:/usr/lib/x86_64-linux-gnu/libatomic.so.1.2.0:ro ubuntu:24.04 bash -c 'apt update && apt install -y bzip2 wget && . .nvm/nvm.sh && nvm install 25.6.0 && npm i -g @angular/cli@21.1.3 apollo@2.34.0 asar@3.2.0 bun-repl@2.1.1 bun@1.3.9 clipboard-cli@5.0.0 create-react-app@5.1.0 detox-cli@20.47.0 elasticdump@6.124.2 expo-cli@6.3.12 express-generator@4.16.1 firebase-tools@15.5.1 google-closure-compiler@20260128.0.0 graphql@16.12.0 har-extractor@1.1.2 http-server-upload@3.0.0 json@11.0.0 lighthouse@13.0.2 markdown-pdf@11.0.0 npm-check-updates@19.3.2 npm@11.9.0 prettier@3.8.1 qrcode@1.5.4 showdown@2.1.0 svgo@4.0.0 typescript@5.9.3 uglify-js@3.19.3 web-ext@9.2.0'
[...]
added 3892 packages, removed 1 package, and changed 24 packages in [...]s
[...]
root@daniel-desktop3:~# time docker run --rm -v /home/home/.nvm2:/.nvm -v /usr/lib/x86_64-linux-gnu/libatomic.so.1.2.0:/usr/lib/x86_64-linux-gnu/libatomic.so.1.2.0:ro ubuntu:24.04 bash -c 'ln -s /usr/lib/x86_64-linux-gnu/libatomic.so.1.2.0 /usr/lib/x86_64-linux-gnu/libatomic.so.1 && . .nvm/nvm.sh && npm ls -g --depth=0'
[...]
real    0m1.812s
user    0m0.007s
sys     0m0.012s
root@daniel-desktop3:~# sync; sysctl -w vm.drop_caches=3
root@daniel-desktop3:~# time docker run --rm -v /home/home/.nvm2:/.nvm -v /usr/lib/x86_64-linux-gnu/libatomic.so.1.2.0:/usr/lib/x86_64-linux-gnu/libatomic.so.1.2.0:ro ubuntu:24.04 bash -c 'ln -s /usr/lib/x86_64-linux-gnu/libatomic.so.1.2.0 /usr/lib/x86_64-linux-gnu/libatomic.so.1 && . .nvm/nvm.sh && npm ls -g --depth=0'
[...]
real    0m16.651s
user    0m0.010s
sys     0m0.021s
[rerunning, remembering drop_caches:]
real    0m17.615s
user    0m0.004s
sys     0m0.025s
real    0m17.930s
user    0m0.007s
sys     0m0.025s
real    0m17.495s
user    0m0.008s
sys     0m0.023s
real    0m17.574s
user    0m0.011s
sys     0m0.018s
[mean = 17.453]
[I didn't have time to repeat mkfs.ext4, but I assumed inode placement differences' effects small]

--nextPart2312477.KlZ2vcFHjT--




