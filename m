Return-Path: <linux-ext4+bounces-14696-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mI4IJkwXq2nMZwEAu9opvQ
	(envelope-from <linux-ext4+bounces-14696-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Mar 2026 19:05:00 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8C92268AB
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Mar 2026 19:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12706306BC34
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Mar 2026 18:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51967350A1F;
	Fri,  6 Mar 2026 18:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAwEDvR/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF43318FDBD
	for <linux-ext4@vger.kernel.org>; Fri,  6 Mar 2026 18:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772820292; cv=none; b=ip7yEUO0MPtFMEfNAqlGOgXjpN5e8lfPCTqBrAXpjbClDF4Ru43ywFHvH8VABA+qrNZ5OiSY5IobNKefrYfmyfNAYK+rv/dVu6NNolF0ObkJSf5CDBjVhdFDSbyVrxl8Bgx7VM3S0BtXtrUzLv5EG7wdy6SIHXjkbg7CqVqBOo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772820292; c=relaxed/simple;
	bh=tSHnHJNZumBfYVXvTpHeuev0bMUv5euOjO6+FnIEwGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qao98xWUOPQhKZFQfA9BreVrbqKDnnsOWSGhWHHwue+vTk3eqcA5foB+WS324PzdZA6bovfFgMhTzPe7AR9YhTfjR3dr3YUhsjVBMIHkSaTvIkYaG7n1jdLPZ+DPuQqMKXpcu9Fw/WUHJGjyck5CRMsj2YLBSBJRlaLltb2enZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAwEDvR/; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-899e43ae2e1so58843776d6.2
        for <linux-ext4@vger.kernel.org>; Fri, 06 Mar 2026 10:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772820283; x=1773425083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43CUSb9bRRookBCnraia/1K96xv+Wh5kYPnYnzJvKys=;
        b=lAwEDvR/DYo79YyrG24YA0iPOY/en+MNyAjvG1kTJLx8yeR/jPC3cF5dveKqAbJ+5O
         J6jrzqwogKC5Hl1Kfa2xuGDymSWB9TAVJvzXJpzBV0bBcWBmr9NoAHZoWDNQxOrMv2ZJ
         c/T9/lqEwjHfNlyKRZTLadCvMSjSCAUImiYTCf+LBGLrQYUXNI5KNr9q08P57VinIYdr
         wRo8pGUJsZINyiv0g8gjT9pWoi1XLLW2CHJqJf7lTQtukn8eZPqewIzh0oSy4rn1U8c/
         DaiZgjMpe/Yin4Tjs97X8dm1rwP4h5QNJ7B59tcoYS2y2twTwbia1A1fFkQb6V0pA265
         jgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772820283; x=1773425083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=43CUSb9bRRookBCnraia/1K96xv+Wh5kYPnYnzJvKys=;
        b=oT3gJxjV0HkWDvIEXvAZ7cgsUi5eq3oUUI2H5rLWCYw6LysYg6eY9iFmi6+o0YYutk
         aG62Wfv7iNVLxezeHwT6IKNKwzngRJxox03Wj75MpJSA4O8w8bcJ/nNlJqUvXLjq08oR
         6hUkzovJ1vh4k31bNb7uzcsHmy4JQHHbRPWetPyb0ml+kCrW6JaKyZsx9B5YKcVhKK3u
         huZvyepeV0U7u/IXzT5Mo5SQ3NuxlLqA5dk1x3LOP350UNjkPWE7ZttY9H+d3f3/wEal
         yrpKpAVBL3trwPHsHDXfy10IS5HjRpXBxDWy+pzmpi82mkrd1iORsgHpNMNzWndglh0t
         vMlg==
X-Gm-Message-State: AOJu0Yxs7XqgBnTzfVUFIp6BHs5+1415RO65upJ4YYElgHdJQ/pOG+Bm
	9Hwhb18LwZbkBPoLJoMDpahm8+r0gdC5AF89/7WIUcZMgzB+j8bD/c/A
X-Gm-Gg: ATEYQzzW7NEjcXnCFsSugxOaiDLcgSTG5y3othlBDRv1MACRG4LBCgmqMrOLO/0sGeK
	UEZyyMiGyPHRM6fxHwKZkgNtLG9L7ogQO4etAtX+/OiaBZMCpGmnU4D7Sq657ij7B+GHnDXHuZm
	lUOaPecyWbKdUfPv9U5e6VhzdsGvUnMcQzTqrijIrGaTg4wIsT9flSBPVPLASpEPj19mFdBM+oP
	ZsErbRHhlwum98Qu5MJZZOsLE9EVEfV7cfC+aKs32+dzyF7aN1eybJ0Qw1+SfrnU7048uBJFBWS
	RioEOWSUJ/JATiWOhczTGC7xOe9tdV4q189M4CPamqzfVn98uIPiT6wIVDgmOmIec2swDUuvtAf
	FFCAJbr9+AGPJ/duTwDACabtOk1KQU9j80g1GctSQ23sr0rK/DlCOQOuo/7tcAsLiPSBy62beBr
	2VnoNtSX8p/PJwS2Yl4ehvm3+5k24r009onSaTMJAC8DYVsTzbcDWT
X-Received: by 2002:a05:6214:234b:b0:899:f6b6:5442 with SMTP id 6a1803df08f44-89a30a2ad37mr44812356d6.15.1772820282123;
        Fri, 06 Mar 2026 10:04:42 -0800 (PST)
Received: from daniel-desktop3.localnet ([204.48.78.87])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a3140e6c9sm19290616d6.2.2026.03.06.10.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 10:04:40 -0800 (PST)
From: Daniel Tang <danielzgtg.opensource@gmail.com>
To: Theodore Tso <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH e2fsprogs] e2fsck: preen inline data no attr
Date: Fri, 06 Mar 2026 13:03:19 -0500
Message-ID: <2415922.vCJZsxu672@daniel-desktop3>
In-Reply-To: <20260306155108.GA19348@macsyma.local>
References:
 <3188418.mvXUDI8C0e@daniel-desktop3> <20260306155108.GA19348@macsyma.local>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart2828550.3Lj2Plt8kZ"
Content-Transfer-Encoding: 7Bit
X-Rspamd-Queue-Id: 1A8C92268AB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	CTE_CASE(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14696-lists,linux-ext4=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:+,5:+,6:+,7:~,8:~,9:+];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzgtgopensource@gmail.com,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.965];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,daniel-tablet1:email,backlight:email]
X-Rspamd-Action: no action

This is a multi-part message in MIME format.

--nextPart2828550.3Lj2Plt8kZ
Content-Type: multipart/alternative; boundary="nextPart6838103.31tnzDBltd"
Content-Transfer-Encoding: 7Bit

This is a multi-part message in MIME format.

--nextPart6838103.31tnzDBltd
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Today I tested the bug and this time it was a directory in /var,
unlike the inline-data lockfile in /home last time.
I reformatted /home with encryption in the meantime.

The unrecoverable system freeze=E2=80=94a kernel panic probably=E2=80=94hap=
pens after
unplugging a "link-002" USB-C=E2=80=93HDMI adapter 1=E2=80=9350 times (aver=
age 5). That'll
be debugged separately. The other end must be connected to HDMI 2
(not HDMI 1) of a DELL S2721QS.

Although it's not the same inline file data bug, it's an inline
directory bug this time. Note that `ncheck` worked last time but not
this time.

```console
root@daniel-tablet1:~# # After somehow starting sshd in systemd recovery sh=
ell:
root@daniel-tablet1:~# dumpe2fs -h /dev/nvme0n1p7
dumpe2fs 1.47.2 (1-Jan-2025)
=46ilesystem volume name:   <none>
Last mounted on:          /var
=46ilesystem UUID:          46916dcd-c245-4384-bbaf-2f9460979425
=46ilesystem magic number:  0xEF53
=46ilesystem revision #:    1 (dynamic)
=46ilesystem features:      has_journal ext_attr dir_index sparse_super2 fa=
st_commit orphan_file filetype extent flex_bg inline_data sparse_super larg=
e_file extra_isize metadata_csum
=46ilesystem flags:         signed_directory_hash=20
Default mount options:    user_xattr acl
=46ilesystem state:         not clean with errors
Errors behavior:          Remount read-only
=46ilesystem OS type:       Linux
Inode count:              640848
Block count:              2560000
Reserved block count:     128000
Overhead clusters:        56597
=46ree blocks:              1335285
=46ree inodes:              576232
=46irst block:              0
Block size:               4096
=46ragment size:            4096
Blocks per group:         32768
=46ragments per group:      32768
Inodes per group:         8112
Inode blocks per group:   507
=46lex block group size:    16
=46ilesystem created:       Sat Dec 28 15:24:12 2019
Last mount time:          Fri Mar  6 11:20:11 2026
Last write time:          Fri Mar  6 11:37:08 2026
Mount count:              3
Maximum mount count:      -1
Last checked:             Mon Mar  2 01:08:36 2026
Check interval:           0 (<none>)
Lifetime writes:          1457 GB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
=46irst inode:              11
Inode size:               256
Required extra isize:     32
Desired extra isize:      32
Journal inode:            8
Default directory hash:   half_md4
Directory Hash Seed:      dcb465c1-50d7-4793-a3d0-9e0e02cd4c29
Journal backup:           inode blocks
Checksum type:            crc32c
Checksum:                 0x1a947ea3
Orphan file inode:        42
Journal features:         journal_incompat_revoke journal_checksum_v3 FEATU=
RE_I5
Total journal size:       64M
Total journal blocks:     16384
Max transaction length:   16128
=46ast commit length:       256
Journal sequence:         0x00388937
Journal start:            0
Journal checksum type:    crc32c
Journal checksum:         0x6a84a638
root@daniel-tablet1:~# fsck.ext4 -p /dev/nvme0n1p7 # For example
/dev/nvme0n1p7 contains a file system with errors, check forced.
/dev/nvme0n1p7: Entry '..' in /tmp/???/??? (137) has deleted/unused inode 1=
20.  CLEARED.
/dev/nvme0n1p7: Entry '..' in /tmp/???/??? (195) has deleted/unused inode 1=
67.  CLEARED.
/dev/nvme0n1p7: Unconnected directory inode 137 (was in /tmp/???)


/dev/nvme0n1p7: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.
        (i.e., without -a or -p options)
root@daniel-tablet1:~# debugfs -nc /dev/nvme0n1p7
debugfs 1.47.2 (1-Jan-2025)
debugfs:  stat <137>
Inode: 137   Type: directory    Mode:  01777   Flags: 0x10000000
Generation: 2378807545    Version: 0x00000000:00000001
User:     0   Group:     0   Project:     0   Size: 60
=46ile ACL: 0
Links: 2   Blockcount: 0
=46ragment:  Address: 0    Number: 0    Size: 0
 ctime: 0x69aafee3:66aff6ec -- Fri Mar  6 11:20:51 2026
 atime: 0x69aafee3:66aff6ec -- Fri Mar  6 11:20:51 2026
 mtime: 0x69aafee3:66aff6ec -- Fri Mar  6 11:20:51 2026
crtime: 0x69aafee3:66aff6ec -- Fri Mar  6 11:20:51 2026
Size of extra inode fields: 32
Extended attributes:
  system.data (0)
Inode checksum: 0x1decf2a9
Size of inline data: 60
debugfs:  stat <195>
Inode: 195   Type: directory    Mode:  01777   Flags: 0x10000000
Generation: 4036975850    Version: 0x00000000:00000001
User:     0   Group:     0   Project:     0   Size: 60
=46ile ACL: 0
Links: 2   Blockcount: 0
=46ragment:  Address: 0    Number: 0    Size: 0
 ctime: 0x69aafee9:230c2808 -- Fri Mar  6 11:20:57 2026
 atime: 0x69aafee9:230c2808 -- Fri Mar  6 11:20:57 2026
 mtime: 0x69aafee9:230c2808 -- Fri Mar  6 11:20:57 2026
crtime: 0x69aafee9:230c2808 -- Fri Mar  6 11:20:57 2026
Size of extra inode fields: 32
Extended attributes:
  system.data (0)
Inode checksum: 0xcf705890
Size of inline data: 60
debugfs:  orphan_inodes
Orphan inode list empty
Dumping orphan file inode 42:
debugfs:  ncheck <137>
Inode   Pathname
debugfs:  ncheck <195>
Inode   Pathname
debugfs:  logdump
Journal starts at block 0, transaction 3705143

*** Fast Commit Area ***
tag HEAD, features 0x0, tid 3705170
tag INODE, inode 129952
tag ADD_RANGE, inode 129952, lblk 0, pblk 2392580, len 1
tag CREAT_DENTRY, parent 139307, ino 129952, name "attributes.3R2DL3"
tag INODE, inode 119
tag INODE, inode 184
tag INODE, inode 87
tag INODE, inode 169
tag INODE, inode 129952
tag TAIL, tid 3705170
tag TAIL, tid 3705167
tag ADD_RANGE, inode 169, lblk 1160, pblk 1517192, len 12
tag INODE, inode 169
tag TAIL, tid 3705140
root@daniel-tablet1:~# fsck.ext4 -y /dev/nvme0n1p7
e2fsck 1.47.2 (1-Jan-2025)
/dev/nvme0n1p7 contains a file system with errors, check forced.
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Entry '..' in /tmp/???/??? (137) has deleted/unused inode 120.  Clear? yes

Entry '..' in /tmp/???/??? (195) has deleted/unused inode 167.  Clear? yes

Pass 3: Checking directory connectivity
Unconnected directory inode 137 (was in /tmp/???)
Connect to /lost+found? yes

Unconnected directory inode 195 (was in /tmp/???)
Connect to /lost+found? yes

Pass 4: Checking reference counts
Inode 13 ref count is 14, should be 12.  Fix? yes

Inode 137 ref count is 3, should be 2.  Fix? yes

Inode 195 ref count is 3, should be 2.  Fix? yes

Pass 5: Checking group summary information
=46ree blocks count wrong (1335285, counted=3D1335286).
=46ix? yes

Inode bitmap differences:  -120 -167
=46ix? yes

=46ree inodes count wrong for group #0 (7815, counted=3D7817).
=46ix? yes

Directories count wrong for group #0 (51, counted=3D49).
=46ix? yes

=46ree inodes count wrong (576232, counted=3D576212).
=46ix? yes


/dev/nvme0n1p7: ***** FILE SYSTEM WAS MODIFIED *****
/dev/nvme0n1p7: 64636/640848 files (0.8% non-contiguous), 1224714/2560000 b=
locks
root@daniel-tablet1:~# mount /var
root@daniel-tablet1:~# cd /var/lost+found
root@daniel-tablet1:/var/lost+found# find
=2E
=2E/#137
=2E/#195
root@daniel-tablet1:/var/lost+found# mount -o remount,ro /var
[then Magic Sysrq O then U then reboot -f]
```

`journalctl -b` is attached.

Besides connecting the monitor, all of my unclean shutdowns were during
system idleness. I've always caused this less than an hour after boot.
Therefore all of mine are temporary files, and I don't know whether this
also happens to someone's important files.

I do not need to manually remove or truncate beyond what `fsck.ext4`
does automatically when started `-p`. I can choose to remove or
truncate them anyway because they are all temporary files.

After reboot, without unplugging the adapter:

```console
root@daniel-tablet1:~# dhclient
mkdtemp: Read-only file system (os error 30) at path "/tmp/tmp.isEJLAByyM"
/sbin/dhclient-script: 38: /etc/dhcp/dhclient-exit-hooks.d/resolved: cannot=
 create : Directory nonexistent
[repeated 5 times with other line numbers and filepaths]
Setting LLMNR [...]
root@daniel-tablet1:~# rm /run/nologin
root@daniel-tablet1:~# /usr/sbin/sshd -D
root@daniel-tablet1:~# # Then I did similar with /dev/nvme0n1p6
```

After rebooting, unplugging the adapter 10 times, then force-rebooting:

```console
root@daniel-tablet1:~# fsck.ext4 -p /dev/nvme0n1p6
/dev/nvme0n1p6 contains a file system with errors, check forced.
/dev/nvme0n1p6: Entry 'systemd-private-79893677cb354f8c82fb240966b39bb2-lm-=
sensors.service-6lXzxn' in / (2) is a link to directory /systemd-private-79=
893677cb354f8c82fb240966b39bb2-lm-sensors.service-6lXzxn (389382).


/dev/nvme0n1p6: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.
        (i.e., without -a or -p options)
root@daniel-tablet1:~# debugfs -nc /dev/nvme0n1p6
debugfs 1.47.2 (1-Jan-2025)
debugfs:  stat <389382>
debugfs:  ls <389382>
 389382  (12) .    2  (12) ..    389383  (56) tmp  =20
Inode: 389382   Type: directory    Mode:  0700   Flags: 0x10000000
Generation: 749221114    Version: 0x00000000:00000002
User:     0   Group:     0   Project:     0   Size: 60
=46ile ACL: 0
Links: 3   Blockcount: 0
=46ragment:  Address: 0    Number: 0    Size: 0
 ctime: 0x69ab0ba2:33f9a744 -- Fri Mar  6 12:15:14 2026
 atime: 0x69ab0ba2:33f9a744 -- Fri Mar  6 12:15:14 2026
 mtime: 0x69ab0ba2:33f9a744 -- Fri Mar  6 12:15:14 2026
crtime: 0x69ab0ba2:33f9a744 -- Fri Mar  6 12:15:14 2026
Size of extra inode fields: 32
Extended attributes:
  system.data (0)
Inode checksum: 0x79edbb64
Size of inline data: 60
root@daniel-tablet1:~# fsck.ext4 -y /dev/nvme0n1p6
e2fsck 1.47.2 (1-Jan-2025)
/dev/nvme0n1p6 contains a file system with errors, check forced.
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Entry 'systemd-private-79893677cb354f8c82fb240966b39bb2-lm-sensors.service-=
6lXzxn' in / (2) is a link to directory /systemd-private-79893677cb354f8c82=
fb240966b39bb2-lm-sensors.service-6lXzxn (389382).
Clear? yes

Entry 'systemd-private-26e6cb34d76b4af6b450ce062fdec7a6-colord.service-KZRR=
vf' in / (2) has deleted/unused inode 21.  Clear? yes

Entry 'systemd-private-26e6cb34d76b4af6b450ce062fdec7a6-geoclue.service-iXW=
qgN' in / (2) has deleted/unused inode 129802.  Clear? yes

Pass 3: Checking directory connectivity
Unconnected directory inode 129798 (was in /)
Connect to /lost+found? yes

Unconnected directory inode 129800 (was in /)
Connect to /lost+found? yes

Unconnected directory inode 389388 (was in /)
Connect to /lost+found? yes

Pass 4: Checking reference counts
Inode 129798 ref count is 4, should be 3.  Fix? yes

Inode 129800 ref count is 4, should be 3.  Fix? yes

Unattached inode 129804
Connect to /lost+found? yes

Inode 129804 ref count is 2, should be 1.  Fix? yes

Inode 389388 ref count is 4, should be 3.  Fix? yes

Pass 5: Checking group summary information

/dev/nvme0n1p6: ***** FILE SYSTEM WAS MODIFIED *****
/dev/nvme0n1p6: 46/640848 files (2.2% non-contiguous), 59413/2560000 blocks
root@daniel-tablet1:~# reboot # It worked without Magic Sysrq this time and=
 prompt was uncolored
```

Another adapter unplug attempt resulted in `/tmp/systemd-private*colord*`
having "an incorrect filetype (was 2, should be 1)."

I don't know why there are some many different problems this time. During
the time that I had unencrypted /home, I only got inline data errors with
inside what I think is `/home/home/.cache`. It was perhaps some lockfile
or pidfile.

Another attempt, but this time with Firefox open, but the problematic
inode didn't have inline data:

```console
[omitted fixing /tmp like last time ...]
root@daniel-tablet1:~# fsck.ext4 -p /dev/mapper/homecrypt
/dev/mapper/homecrypt: Unattached inode 408852


/dev/mapper/homecrypt: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.
        (i.e., without -a or -p options)
root@daniel-tablet1:~# debugfs -nc /dev/mapper/homecrypt
debugfs 1.47.2 (1-Jan-2025)
debugfs:  stat <408852>
Inode: 408852   Type: regular    Mode:  0664   Flags: 0x80000
Generation: 2194885973    Version: 0x00000000:00000003
User:  1000   Group:  1000   Project:     0   Size: 98914
=46ile ACL: 0
Links: 1   Blockcount: 200
=46ragment:  Address: 0    Number: 0    Size: 0
 ctime: 0x69ab0fdc:839b6170 -- Fri Mar  6 12:33:16 2026
 atime: 0x69ab0fdc:83214f70 -- Fri Mar  6 12:33:16 2026
 mtime: 0x69ab0fdc:83797658 -- Fri Mar  6 12:33:16 2026
crtime: 0x69ab0fdc:83214f70 -- Fri Mar  6 12:33:16 2026
Size of extra inode fields: 32
Inode checksum: 0x570a769b
EXTENTS:
(0-24):6307264-6307288

debugfs:  ncheck <408852>
Inode   Pathname
debugfs: cat <408852>
[binary, but could be a Mesa shader cache file]
debugfs: logdump
[attached]
root@daniel-tablet1:~# fsck.ext4 /dev/mapper/homecrypt
e2fsck 1.47.2 (1-Jan-2025)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Unattached inode 408852
Connect to /lost+found<y>? yes
Inode 408852 ref count is 2, should be 1.  Fix<y>? yes
Pass 5: Checking group summary information
Block bitmap differences:  -(4286031--4286032) +(4286035--4286036) -(570624=
1--5706242) +(6307264--6307288) -(6307296--6307320) -(6308064--6308088) +(6=
494304--6494328)
=46ix<y>? yes
=46ree blocks count wrong for group #26 (41, counted=3D40).
=46ix<y>? yes
=46ree blocks count wrong for group #81 (43, counted=3D64).
=46ix<y>? yes
=46ree blocks count wrong for group #128 (1608, counted=3D1589).
=46ix<y>? yes
=46ree blocks count wrong for group #130 (3533, counted=3D3530).
=46ix<y>? yes
=46ree blocks count wrong for group #131 (3124, counted=3D3097).
=46ix<y>? yes
=46ree blocks count wrong for group #148 (0, counted=3D1).
=46ix<y>? yes
=46ree blocks count wrong for group #159 (1467, counted=3D1561).
=46ix ('a' enables 'yes' to all) <y>? yes
=46ree blocks count wrong for group #173 (7616, counted=3D7669).
=46ix ('a' enables 'yes' to all) <y>? yes
=46ree blocks count wrong for group #174 (31543, counted=3D29570).
=46ix ('a' enables 'yes' to all) <y>? yes
=46ree blocks count wrong for group #175 (30878, counted=3D31741).
=46ix ('a' enables 'yes' to all) <y>? yes
=46ree blocks count wrong for group #176 (28457, counted=3D32578).
=46ix<y>? yes
=46ree blocks count wrong for group #177 (32241, counted=3D29745).
=46ix<y>? yes
=46ree blocks count wrong for group #178 (3895, counted=3D3914).
=46ix<y>? yes
=46ree blocks count wrong for group #187 (21504, counted=3D22309).
=46ix<y>? yes
=46ree blocks count wrong for group #191 (8471, counted=3D8487).
=46ix<y>? yes
=46ree blocks count wrong for group #192 (3689, counted=3D3725).
=46ix<y>? yes
=46ree blocks count wrong for group #193 (3587, counted=3D3586).
=46ix<y>? yes
=46ree blocks count wrong for group #194 (7573, counted=3D7540).
=46ix<y>? yes
=46ree blocks count wrong for group #197 (16064, counted=3D16076).
=46ix<y>? yes
=46ree blocks count wrong for group #198 (27631, counted=3D25974).
=46ix<y>? yes
=46ree blocks count wrong (72088071, counted=3D72087902).
=46ix<y>? yes
Inode bitmap differences:  -407142 +471162
=46ix<y>? yes
=46ree inodes count wrong for group #115 (3, counted=3D4).
=46ix<y>? yes
=46ree inodes count wrong for group #116 (755, counted=3D728).
=46ix<y>? yes
=46ree inodes count wrong (9277815, counted=3D9277789).
=46ix<y>? yes
Orphan file (inode 12) block 39 is not clean.
Clear<y>? yes

/dev/mapper/homecrypt: ***** FILE SYSTEM WAS MODIFIED *****
/dev/mapper/homecrypt: 478883/9756672 files (0.2% non-contiguous), 5934579/=
78022481 blocks
```

So there are a lot of unrelated errors, which look more severe than
the original one targeted by this patch. I will stop testing unplugging
for now, as something needs to be fixed to remove the noise. But my patch
should resolve the original error I got.

```console
home@daniel-tablet1:~$ uname -a # During good boot
Linux daniel-tablet1 6.18.7-surface-1 #1 SMP PREEMPT_DYNAMIC Mon Jan 26 00:=
16:20 UTC 2026 x86_64 GNU/Linux
home@daniel-tablet1:~$ apt-cache policy e2fsprogs
e2fsprogs:
  Installed: 1.47.2-3ubuntu2
  Candidate: 1.47.2-3ubuntu2
  Version table:
 *** 1.47.2-3ubuntu2 500
        500 https://gpl.savoirfairelinux.net/pub/mirrors/ubuntu questing/ma=
in amd64 Packages
        100 /var/lib/dpkg/status
root@daniel-tablet1:~# cat /proc/1/mounts
sysfs /sys sysfs rw,nosuid,nodev,noexec,relatime 0 0
proc /proc proc rw,nosuid,nodev,noexec,relatime 0 0
udev /dev devtmpfs rw,nosuid,relatime,size=3D7936332k,nr_inodes=3D1984083,m=
ode=3D755,inode64 0 0
devpts /dev/pts devpts rw,nosuid,noexec,relatime,gid=3D5,mode=3D600,ptmxmod=
e=3D000 0 0
tmpfs /run tmpfs rw,nosuid,nodev,noexec,relatime,size=3D1596384k,mode=3D755=
,inode64 0 0
/dev/nvme0n1p8 / ext4 ro,nodev,noatime,nombcache,min_batch_time=3D15000,max=
_dir_size_kb=3D4096 0 0
securityfs /sys/kernel/security securityfs rw,nosuid,nodev,noexec,relatime =
0 0
tmpfs /dev/shm tmpfs rw,nosuid,nodev,inode64 0 0
cgroup2 /sys/fs/cgroup cgroup2 rw,nosuid,nodev,noexec,relatime,nsdelegate,m=
emory_recursiveprot 0 0
none /sys/fs/pstore pstore rw,nosuid,nodev,noexec,relatime 0 0
efivarfs /sys/firmware/efi/efivars efivarfs rw,nosuid,nodev,noexec,relatime=
 0 0
bpf /sys/fs/bpf bpf rw,nosuid,nodev,noexec,relatime,mode=3D700 0 0
systemd-1 /proc/sys/fs/binfmt_misc autofs rw,relatime,fd=3D36,pgrp=3D1,time=
out=3D0,minproto=3D5,maxproto=3D5,direct,pipe_ino=3D1296 0 0
hugetlbfs /dev/hugepages hugetlbfs rw,nosuid,nodev,relatime,pagesize=3D2M 0=
 0
mqueue /dev/mqueue mqueue rw,nosuid,nodev,noexec,relatime 0 0
tmpfs /run/lock tmpfs rw,nosuid,nodev,noexec,relatime,size=3D5120k,inode64 =
0 0
debugfs /sys/kernel/debug debugfs rw,nosuid,nodev,noexec,relatime 0 0
tracefs /sys/kernel/tracing tracefs rw,nosuid,nodev,noexec,relatime 0 0
tmpfs /run/credentials/systemd-journald.service tmpfs ro,nosuid,nodev,noexe=
c,relatime,nosymfollow,size=3D1024k,nr_inodes=3D1024,mode=3D700,inode64,nos=
wap 0 0
fusectl /sys/fs/fuse/connections fusectl rw,nosuid,nodev,noexec,relatime 0 0
configfs /sys/kernel/config configfs rw,nosuid,nodev,noexec,relatime 0 0
tmpfs /run/credentials/systemd-cryptsetup@homecrypt.service tmpfs ro,nosuid=
,nodev,noexec,relatime,nosymfollow,size=3D1024k,nr_inodes=3D1024,mode=3D700=
,inode64,noswap 0 0
tmpfs /media tmpfs rw,nosuid,nodev,noexec,noatime,size=3D5120k,mode=3D755,i=
node64 0 0
/dev/nvme0n1p5 /boot ext4 ro,nosuid,nodev,noexec,noatime,nombcache,min_batc=
h_time=3D15000,max_dir_size_kb=3D1024 0 0
/dev/nvme0n1p6 /tmp ext4 rw,nosuid,nodev,noatime,nombcache,min_batch_time=
=3D15000,max_dir_size_kb=3D4096 0 0
/dev/nvme0n1p7 /var ext4 rw,nosuid,nodev,noatime,nombcache,min_batch_time=
=3D15000,max_dir_size_kb=3D4096 0 0
/dev/nvme0n1p1 /boot/efi vfat ro,nosuid,nodev,noexec,noatime,fmask=3D0006,d=
mask=3D0007,allow_utime=3D0020,codepage=3D437,iocharset=3Diso8859-1,shortna=
me=3Dmixed,errors=3Dremount-ro 0 0
tmpfs /run/credentials/systemd-resolved.service tmpfs ro,nosuid,nodev,noexe=
c,relatime,nosymfollow,size=3D1024k,nr_inodes=3D1024,mode=3D700,inode64,nos=
wap 0 0
tmpfs /var/lib/gdm3 tmpfs rw,nosuid,nodev,noexec,noatime,size=3D400k,nr_ino=
des=3D100,mode=3D000,inode64 0 0
/dev/mapper/homecrypt /home ext4 rw,nosuid,nodev,noatime,nombcache,min_batc=
h_time=3D15000,max_dir_size_kb=3D4096 0 0
binfmt_misc /proc/sys/fs/binfmt_misc binfmt_misc rw,nosuid,nodev,noexec,rel=
atime 0 0
tmpfs /run/user/1001 tmpfs rw,nosuid,nodev,relatime,size=3D1596380k,nr_inod=
es=3D399095,mode=3D700,uid=3D1001,gid=3D1000,inode64 0 0
tmpfs /run/user/1000 tmpfs rw,nosuid,nodev,relatime,size=3D1596380k,nr_inod=
es=3D399095,mode=3D700,uid=3D1000,gid=3D1000,inode64 0 0
tmpfs /run/user/60578 tmpfs rw,nosuid,nodev,relatime,size=3D1596380k,nr_ino=
des=3D399095,mode=3D700,uid=3D60578,gid=3D139,inode64 0 0
portal /run/user/60578/doc fuse.portal rw,nosuid,nodev,relatime,user_id=3D6=
0578,group_id=3D139 0 0
tmpfs /run/user/0 tmpfs rw,nosuid,nodev,relatime,size=3D1596380k,nr_inodes=
=3D399095,mode=3D700,inode64 0 0
root@daniel-tablet1:~# cat /etc/fstab
UUID=3D36fa67db-bdeb-4537-a4b0-4b001d623ccf / ext4 errors=3Dremount-ro,max_=
dir_size_kb=3D4096,min_batch_time=3D15000,noatime,nodev,nombcache,ro 0 1
UUID=3Db36382aa-72e5-4584-8066-d8250cb1c86b /boot ext4 errors=3Dremount-ro,=
max_dir_size_kb=3D1024,min_batch_time=3D15000,noatime,nodev,noexec,nombcach=
e,nosuid,ro 0 2
UUID=3DC4B7-85E2 /boot/efi vfat dmask=3D0007,fmask=3D0006,noatime,nodev,noe=
xec,nosuid,ro 0 2
/dev/mapper/homecrypt /home ext4 errors=3Dremount-ro,max_dir_size_kb=3D4096=
,min_batch_time=3D15000,noatime,nodev,nombcache,nosuid 0 2
UUID=3D69452394-6e8e-4a5b-9116-0a8402d66401 /tmp ext4 errors=3Dremount-ro,m=
ax_dir_size_kb=3D4096,min_batch_time=3D15000,noatime,nodev,nombcache,nosuid=
 0 2
UUID=3D46916dcd-c245-4384-bbaf-2f9460979425 /var ext4 errors=3Dremount-ro,m=
ax_dir_size_kb=3D4096,min_batch_time=3D15000,noatime,nodev,nombcache,nosuid=
 0 2
tmpfs /media tmpfs mode=3D755,noatime,nodev,noexec,nosuid,size=3D5120k 0 0
tmpfs /var/lib/gdm3 tmpfs nodev,nosuid,noexec,noatime,nr_blocks=3D100,nr_in=
odes=3D100,mode=3D0 0 0
root@daniel-tablet1:~# cat /etc/crypttab=20
# <target name> <source device>         <key file>      <options>
homecrypt UUID=3D0ffa31a8-58f7-48a5-ae99-71f40d376bd6 none discard,luks,no-=
read-workqueue,no-write-workqueue,same-cpu-crypt,submit-from-crypt-cpus
```


--nextPart6838103.31tnzDBltd
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="utf-8"

<html>
<head>
<meta http-equiv=3D"content-type" content=3D"text/html; charset=3DUTF-8">
</head>
<body><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Today I tested the bug and this time it was a directory in /var,</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">unl=
ike the inline-data lockfile in /home last time.</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">I r=
eformatted /home with encryption in the meantime.</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">The unrecoverable system freeze=E2=80=94a kernel panic probably=E2=80=94=
happens after</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">unp=
lugging a &quot;link-002&quot; USB-C=E2=80=93HDMI adapter 1=E2=80=9350 time=
s (average 5). That'll</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">be =
debugged separately. The other end must be connected to HDMI 2</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">(no=
t HDMI 1) of a DELL S2721QS.</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Although it's not the same inline file data bug, it's an inline</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">dir=
ectory bug this time. Note that `ncheck` worked last time but not</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">thi=
s time.</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">```console</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">roo=
t@daniel-tablet1:~# # After somehow starting sshd in systemd recovery shell=
:</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">roo=
t@daniel-tablet1:~# dumpe2fs -h /dev/nvme0n1p7</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">dum=
pe2fs 1.47.2 (1-Jan-2025)</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fil=
esystem volume name:&nbsp;&nbsp; &lt;none&gt;</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Las=
t mounted on:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /var</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fil=
esystem UUID:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 46916dc=
d-c245-4384-bbaf-2f9460979425</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fil=
esystem magic number:&nbsp; 0xEF53</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fil=
esystem revision #:&nbsp;&nbsp;&nbsp; 1 (dynamic)</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fil=
esystem features:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; has_journal ext_attr dir_in=
dex sparse_super2 fast_commit orphan_file filetype extent flex_bg inline_da=
ta sparse_super large_file extra_isize metadata_csum</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fil=
esystem flags:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; signed_direc=
tory_hash </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Def=
ault mount options:&nbsp;&nbsp;&nbsp; user_xattr acl</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fil=
esystem state:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; not clean wi=
th errors</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Err=
ors behavior:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Remount=
 read-only</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fil=
esystem OS type:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Linux</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Ino=
de count:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 640848</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Blo=
ck count:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 2560000</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Res=
erved block count:&nbsp;&nbsp;&nbsp;&nbsp; 128000</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Ove=
rhead clusters:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 56597</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fre=
e blocks:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 1335285</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fre=
e inodes:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 576232</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fir=
st block:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Blo=
ck size:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 4096</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fra=
gment size:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 4096</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Blo=
cks per group:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 32768</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fra=
gments per group:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 32768</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Ino=
des per group:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8112</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Ino=
de blocks per group:&nbsp;&nbsp; 507</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fle=
x block group size:&nbsp;&nbsp;&nbsp; 16</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fil=
esystem created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sat Dec 28 15:24:12 20=
19</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Las=
t mount time:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Fri Mar=
&nbsp; 6 11:20:11 2026</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Las=
t write time:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Fri Mar=
&nbsp; 6 11:37:08 2026</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Mou=
nt count:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 3</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Max=
imum mount count:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -1</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Las=
t checked:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; Mon Mar&nbsp; 2 01:08:36 2026</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Che=
ck interval:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 =
(&lt;none&gt;)</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Lif=
etime writes:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1457 GB=
</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Res=
erved blocks uid:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 (user root)</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Res=
erved blocks gid:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 (group root)</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fir=
st inode:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 11</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Ino=
de size:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 256</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Req=
uired extra isize:&nbsp;&nbsp;&nbsp;&nbsp; 32</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Des=
ired extra isize:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 32</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Jou=
rnal inode:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 8</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Def=
ault directory hash:&nbsp;&nbsp; half_md4</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Dir=
ectory Hash Seed:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcb465c1-50d7-4793-a3d0-9e0=
e02cd4c29</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Jou=
rnal backup:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in=
ode blocks</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Che=
cksum type:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; crc32c</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Che=
cksum:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1a947ea3</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Orp=
han file inode:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 42</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Jou=
rnal features:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; journal_inco=
mpat_revoke journal_checksum_v3 FEATURE_I5</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Tot=
al journal size:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 64M</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Tot=
al journal blocks:&nbsp;&nbsp;&nbsp;&nbsp; 16384</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Max=
 transaction length:&nbsp;&nbsp; 16128</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fas=
t commit length:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 256</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Jou=
rnal sequence:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00388937</=
p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Jou=
rnal start:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Jou=
rnal checksum type:&nbsp;&nbsp;&nbsp; crc32c</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Jou=
rnal checksum:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x6a84a638</=
p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">roo=
t@daniel-tablet1:~# fsck.ext4 -p /dev/nvme0n1p7 # For example</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">/de=
v/nvme0n1p7 contains a file system with errors, check forced.</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">/de=
v/nvme0n1p7: Entry '..' in /tmp/???/??? (137) has deleted/unused inode 120.=
&nbsp; CLEARED.</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">/de=
v/nvme0n1p7: Entry '..' in /tmp/???/??? (195) has deleted/unused inode 167.=
&nbsp; CLEARED.</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">/de=
v/nvme0n1p7: Unconnected directory inode 137 (was in /tmp/???)</p>
<br /><br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-r=
ight:0;">/dev/nvme0n1p7: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (i.e., without -a or -p options)</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">roo=
t@daniel-tablet1:~# debugfs -nc /dev/nvme0n1p7</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">deb=
ugfs 1.47.2 (1-Jan-2025)</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">deb=
ugfs:&nbsp; stat &lt;137&gt;</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Ino=
de: 137&nbsp;&nbsp; Type: directory&nbsp;&nbsp;&nbsp; Mode:&nbsp; 01777&nbs=
p;&nbsp; Flags: 0x10000000</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Gen=
eration: 2378807545&nbsp;&nbsp;&nbsp; Version: 0x00000000:00000001</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Use=
r:&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp; Group:&nbsp;&nbsp;&nbsp;&nbsp; 0&n=
bsp;&nbsp; Project:&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp; Size: 60</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fil=
e ACL: 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Lin=
ks: 2&nbsp;&nbsp; Blockcount: 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fra=
gment:&nbsp; Address: 0&nbsp;&nbsp;&nbsp; Number: 0&nbsp;&nbsp;&nbsp; Size:=
 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&nb=
sp;ctime: 0x69aafee3:66aff6ec -- Fri Mar&nbsp; 6 11:20:51 2026</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&nb=
sp;atime: 0x69aafee3:66aff6ec -- Fri Mar&nbsp; 6 11:20:51 2026</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&nb=
sp;mtime: 0x69aafee3:66aff6ec -- Fri Mar&nbsp; 6 11:20:51 2026</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">crt=
ime: 0x69aafee3:66aff6ec -- Fri Mar&nbsp; 6 11:20:51 2026</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Siz=
e of extra inode fields: 32</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Ext=
ended attributes:</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&nb=
sp; system.data (0)</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Ino=
de checksum: 0x1decf2a9</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Siz=
e of inline data: 60</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">deb=
ugfs:&nbsp; stat &lt;195&gt;</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Ino=
de: 195&nbsp;&nbsp; Type: directory&nbsp;&nbsp;&nbsp; Mode:&nbsp; 01777&nbs=
p;&nbsp; Flags: 0x10000000</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Gen=
eration: 4036975850&nbsp;&nbsp;&nbsp; Version: 0x00000000:00000001</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Use=
r:&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp; Group:&nbsp;&nbsp;&nbsp;&nbsp; 0&n=
bsp;&nbsp; Project:&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp; Size: 60</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fil=
e ACL: 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Lin=
ks: 2&nbsp;&nbsp; Blockcount: 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fra=
gment:&nbsp; Address: 0&nbsp;&nbsp;&nbsp; Number: 0&nbsp;&nbsp;&nbsp; Size:=
 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&nb=
sp;ctime: 0x69aafee9:230c2808 -- Fri Mar&nbsp; 6 11:20:57 2026</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&nb=
sp;atime: 0x69aafee9:230c2808 -- Fri Mar&nbsp; 6 11:20:57 2026</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&nb=
sp;mtime: 0x69aafee9:230c2808 -- Fri Mar&nbsp; 6 11:20:57 2026</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">crt=
ime: 0x69aafee9:230c2808 -- Fri Mar&nbsp; 6 11:20:57 2026</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Siz=
e of extra inode fields: 32</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Ext=
ended attributes:</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&nb=
sp; system.data (0)</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Ino=
de checksum: 0xcf705890</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Siz=
e of inline data: 60</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">deb=
ugfs:&nbsp; orphan_inodes</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Orp=
han inode list empty</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Dum=
ping orphan file inode 42:</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">deb=
ugfs:&nbsp; ncheck &lt;137&gt;</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Ino=
de&nbsp;&nbsp; Pathname</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">deb=
ugfs:&nbsp; ncheck &lt;195&gt;</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Ino=
de&nbsp;&nbsp; Pathname</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">deb=
ugfs:&nbsp; logdump</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Jou=
rnal starts at block 0, transaction 3705143</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">*** Fast Commit Area ***</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">tag=
 HEAD, features 0x0, tid 3705170</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">tag=
 INODE, inode 129952</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">tag=
 ADD_RANGE, inode 129952, lblk 0, pblk 2392580, len 1</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">tag=
 CREAT_DENTRY, parent 139307, ino 129952, name &quot;attributes.3R2DL3&quot=
;</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">tag=
 INODE, inode 119</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">tag=
 INODE, inode 184</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">tag=
 INODE, inode 87</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">tag=
 INODE, inode 169</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">tag=
 INODE, inode 129952</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">tag=
 TAIL, tid 3705170</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">tag=
 TAIL, tid 3705167</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">tag=
 ADD_RANGE, inode 169, lblk 1160, pblk 1517192, len 12</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">tag=
 INODE, inode 169</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">tag=
 TAIL, tid 3705140</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">roo=
t@daniel-tablet1:~# fsck.ext4 -y /dev/nvme0n1p7</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">e2f=
sck 1.47.2 (1-Jan-2025)</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">/de=
v/nvme0n1p7 contains a file system with errors, check forced.</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Pas=
s 1: Checking inodes, blocks, and sizes</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Pas=
s 2: Checking directory structure</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Ent=
ry '..' in /tmp/???/??? (137) has deleted/unused inode 120.&nbsp; Clear? ye=
s</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Entry '..' in /tmp/???/??? (195) has deleted/unused inode 167.&nbsp; Cle=
ar? yes</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Pass 3: Checking directory connectivity</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Unc=
onnected directory inode 137 (was in /tmp/???)</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Con=
nect to /lost+found? yes</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Unconnected directory inode 195 (was in /tmp/???)</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Con=
nect to /lost+found? yes</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Pass 4: Checking reference counts</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Ino=
de 13 ref count is 14, should be 12.&nbsp; Fix? yes</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Inode 137 ref count is 3, should be 2.&nbsp; Fix? yes</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Inode 195 ref count is 3, should be 2.&nbsp; Fix? yes</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Pass 5: Checking group summary information</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fre=
e blocks count wrong (1335285, counted=3D1335286).</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fix=
? yes</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Inode bitmap differences:&nbsp; -120 -167</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fix=
? yes</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Free inodes count wrong for group #0 (7815, counted=3D7817).</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fix=
? yes</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Directories count wrong for group #0 (51, counted=3D49).</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fix=
? yes</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Free inodes count wrong (576232, counted=3D576212).</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fix=
? yes</p>
<br /><br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-r=
ight:0;">/dev/nvme0n1p7: ***** FILE SYSTEM WAS MODIFIED *****</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">/de=
v/nvme0n1p7: 64636/640848 files (0.8% non-contiguous), 1224714/2560000 bloc=
ks</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">roo=
t@daniel-tablet1:~# mount /var</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">roo=
t@daniel-tablet1:~# cd /var/lost+found</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">roo=
t@daniel-tablet1:/var/lost+found# find</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">.</=
p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">./#=
137</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">./#=
195</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">roo=
t@daniel-tablet1:/var/lost+found# mount -o remount,ro /var</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">[th=
en Magic Sysrq O then U then reboot -f]</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">```=
</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">`journalctl -b` is attached.</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Besides connecting the monitor, all of my unclean shutdowns were during<=
/p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">sys=
tem idleness. I've always caused this less than an hour after boot.</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">The=
refore all of mine are temporary files, and I don't know whether this</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">als=
o happens to someone's important files.</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">I do not need to manually remove or truncate beyond what `fsck.ext4`</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">doe=
s automatically when started `-p`. I can choose to remove or</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">tru=
ncate them anyway because they are all temporary files.</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">After reboot, without unplugging the adapter:</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">```console</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">roo=
t@daniel-tablet1:~# dhclient</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">mkd=
temp: Read-only file system (os error 30) at path &quot;/tmp/tmp.isEJLAByyM=
&quot;</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">/sb=
in/dhclient-script: 38: /etc/dhcp/dhclient-exit-hooks.d/resolved: cannot cr=
eate : Directory nonexistent</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">[re=
peated 5 times with other line numbers and filepaths]</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Set=
ting LLMNR [...]</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">roo=
t@daniel-tablet1:~# rm /run/nologin</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">roo=
t@daniel-tablet1:~# /usr/sbin/sshd -D</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">roo=
t@daniel-tablet1:~# # Then I did similar with /dev/nvme0n1p6</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">```=
</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">After rebooting, unplugging the adapter 10 times, then force-rebooting:<=
/p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">```console</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">roo=
t@daniel-tablet1:~# fsck.ext4 -p /dev/nvme0n1p6</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">/de=
v/nvme0n1p6 contains a file system with errors, check forced.</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">/de=
v/nvme0n1p6: Entry 'systemd-private-79893677cb354f8c82fb240966b39bb2-lm-sen=
sors.service-6lXzxn' in / (2) is a link to directory /systemd-private-79893=
677cb354f8c82fb240966b39bb2-lm-sensors.service-6lXzxn (389382).</p>
<br /><br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-r=
ight:0;">/dev/nvme0n1p6: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (i.e., without -a or -p options)</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">roo=
t@daniel-tablet1:~# debugfs -nc /dev/nvme0n1p6</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">deb=
ugfs 1.47.2 (1-Jan-2025)</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">deb=
ugfs:&nbsp; stat &lt;389382&gt;</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">deb=
ugfs:&nbsp; ls &lt;389382&gt;</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&nb=
sp;389382&nbsp; (12) .&nbsp;&nbsp;&nbsp; 2&nbsp; (12) ..&nbsp;&nbsp;&nbsp; =
389383&nbsp; (56) tmp&nbsp;&nbsp; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Ino=
de: 389382&nbsp;&nbsp; Type: directory&nbsp;&nbsp;&nbsp; Mode:&nbsp; 0700&n=
bsp;&nbsp; Flags: 0x10000000</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Gen=
eration: 749221114&nbsp;&nbsp;&nbsp; Version: 0x00000000:00000002</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Use=
r:&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp; Group:&nbsp;&nbsp;&nbsp;&nbsp; 0&n=
bsp;&nbsp; Project:&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp; Size: 60</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fil=
e ACL: 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Lin=
ks: 3&nbsp;&nbsp; Blockcount: 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fra=
gment:&nbsp; Address: 0&nbsp;&nbsp;&nbsp; Number: 0&nbsp;&nbsp;&nbsp; Size:=
 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&nb=
sp;ctime: 0x69ab0ba2:33f9a744 -- Fri Mar&nbsp; 6 12:15:14 2026</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&nb=
sp;atime: 0x69ab0ba2:33f9a744 -- Fri Mar&nbsp; 6 12:15:14 2026</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&nb=
sp;mtime: 0x69ab0ba2:33f9a744 -- Fri Mar&nbsp; 6 12:15:14 2026</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">crt=
ime: 0x69ab0ba2:33f9a744 -- Fri Mar&nbsp; 6 12:15:14 2026</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Siz=
e of extra inode fields: 32</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Ext=
ended attributes:</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&nb=
sp; system.data (0)</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Ino=
de checksum: 0x79edbb64</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Siz=
e of inline data: 60</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">roo=
t@daniel-tablet1:~# fsck.ext4 -y /dev/nvme0n1p6</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">e2f=
sck 1.47.2 (1-Jan-2025)</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">/de=
v/nvme0n1p6 contains a file system with errors, check forced.</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Pas=
s 1: Checking inodes, blocks, and sizes</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Pas=
s 2: Checking directory structure</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Ent=
ry 'systemd-private-79893677cb354f8c82fb240966b39bb2-lm-sensors.service-6lX=
zxn' in / (2) is a link to directory /systemd-private-79893677cb354f8c82fb2=
40966b39bb2-lm-sensors.service-6lXzxn (389382).</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Cle=
ar? yes</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Entry 'systemd-private-26e6cb34d76b4af6b450ce062fdec7a6-colord.service-K=
ZRRvf' in / (2) has deleted/unused inode 21.&nbsp; Clear? yes</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Entry 'systemd-private-26e6cb34d76b4af6b450ce062fdec7a6-geoclue.service-=
iXWqgN' in / (2) has deleted/unused inode 129802.&nbsp; Clear? yes</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Pass 3: Checking directory connectivity</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Unc=
onnected directory inode 129798 (was in /)</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Con=
nect to /lost+found? yes</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Unconnected directory inode 129800 (was in /)</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Con=
nect to /lost+found? yes</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Unconnected directory inode 389388 (was in /)</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Con=
nect to /lost+found? yes</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Pass 4: Checking reference counts</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Ino=
de 129798 ref count is 4, should be 3.&nbsp; Fix? yes</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Inode 129800 ref count is 4, should be 3.&nbsp; Fix? yes</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Unattached inode 129804</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Con=
nect to /lost+found? yes</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Inode 129804 ref count is 2, should be 1.&nbsp; Fix? yes</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Inode 389388 ref count is 4, should be 3.&nbsp; Fix? yes</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Pass 5: Checking group summary information</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">/dev/nvme0n1p6: ***** FILE SYSTEM WAS MODIFIED *****</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">/de=
v/nvme0n1p6: 46/640848 files (2.2% non-contiguous), 59413/2560000 blocks</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">roo=
t@daniel-tablet1:~# reboot # It worked without Magic Sysrq this time and pr=
ompt was uncolored</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">```=
</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Another adapter unplug attempt resulted in `/tmp/systemd-private*colord*=
`</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">hav=
ing &quot;an incorrect filetype (was 2, should be 1).&quot;</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">I don't know why there are some many different problems this time. Durin=
g</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">the=
 time that I had unencrypted /home, I only got inline data errors with</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">ins=
ide what I think is `/home/home/.cache`. It was perhaps some lockfile</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">or =
pidfile.</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Another attempt, but this time with Firefox open, but the problematic</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">ino=
de didn't have inline data:</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">```console</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">[om=
itted fixing /tmp like last time ...]</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">roo=
t@daniel-tablet1:~# fsck.ext4 -p /dev/mapper/homecrypt</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">/de=
v/mapper/homecrypt: Unattached inode 408852</p>
<br /><br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-r=
ight:0;">/dev/mapper/homecrypt: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY=
=2E</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (i.e., without -a or -p options)</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">roo=
t@daniel-tablet1:~# debugfs -nc /dev/mapper/homecrypt</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">deb=
ugfs 1.47.2 (1-Jan-2025)</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">deb=
ugfs:&nbsp; stat &lt;408852&gt;</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Ino=
de: 408852&nbsp;&nbsp; Type: regular&nbsp;&nbsp;&nbsp; Mode:&nbsp; 0664&nbs=
p;&nbsp; Flags: 0x80000</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Gen=
eration: 2194885973&nbsp;&nbsp;&nbsp; Version: 0x00000000:00000003</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Use=
r:&nbsp; 1000&nbsp;&nbsp; Group:&nbsp; 1000&nbsp;&nbsp; Project:&nbsp;&nbsp=
;&nbsp;&nbsp; 0&nbsp;&nbsp; Size: 98914</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fil=
e ACL: 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Lin=
ks: 1&nbsp;&nbsp; Blockcount: 200</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fra=
gment:&nbsp; Address: 0&nbsp;&nbsp;&nbsp; Number: 0&nbsp;&nbsp;&nbsp; Size:=
 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&nb=
sp;ctime: 0x69ab0fdc:839b6170 -- Fri Mar&nbsp; 6 12:33:16 2026</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&nb=
sp;atime: 0x69ab0fdc:83214f70 -- Fri Mar&nbsp; 6 12:33:16 2026</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&nb=
sp;mtime: 0x69ab0fdc:83797658 -- Fri Mar&nbsp; 6 12:33:16 2026</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">crt=
ime: 0x69ab0fdc:83214f70 -- Fri Mar&nbsp; 6 12:33:16 2026</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Siz=
e of extra inode fields: 32</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Ino=
de checksum: 0x570a769b</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">EXT=
ENTS:</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">(0-=
24):6307264-6307288</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">debugfs:&nbsp; ncheck &lt;408852&gt;</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Ino=
de&nbsp;&nbsp; Pathname</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">deb=
ugfs: cat &lt;408852&gt;</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">[bi=
nary, but could be a Mesa shader cache file]</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">deb=
ugfs: logdump</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">[at=
tached]</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">roo=
t@daniel-tablet1:~# fsck.ext4 /dev/mapper/homecrypt</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">e2f=
sck 1.47.2 (1-Jan-2025)</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Pas=
s 1: Checking inodes, blocks, and sizes</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Pas=
s 2: Checking directory structure</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Pas=
s 3: Checking directory connectivity</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Pas=
s 4: Checking reference counts</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Una=
ttached inode 408852</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Con=
nect to /lost+found&lt;y&gt;? yes</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Ino=
de 408852 ref count is 2, should be 1.&nbsp; Fix&lt;y&gt;? yes</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Pas=
s 5: Checking group summary information</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Blo=
ck bitmap differences:&nbsp; -(4286031--4286032) +(4286035--4286036) -(5706=
241--5706242) +(6307264--6307288) -(6307296--6307320) -(6308064--6308088) +=
(6494304--6494328)</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fix=
&lt;y&gt;? yes</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fre=
e blocks count wrong for group #26 (41, counted=3D40).</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fix=
&lt;y&gt;? yes</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fre=
e blocks count wrong for group #81 (43, counted=3D64).</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fix=
&lt;y&gt;? yes</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fre=
e blocks count wrong for group #128 (1608, counted=3D1589).</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fix=
&lt;y&gt;? yes</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fre=
e blocks count wrong for group #130 (3533, counted=3D3530).</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fix=
&lt;y&gt;? yes</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fre=
e blocks count wrong for group #131 (3124, counted=3D3097).</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fix=
&lt;y&gt;? yes</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fre=
e blocks count wrong for group #148 (0, counted=3D1).</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fix=
&lt;y&gt;? yes</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fre=
e blocks count wrong for group #159 (1467, counted=3D1561).</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fix=
 ('a' enables 'yes' to all) &lt;y&gt;? yes</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fre=
e blocks count wrong for group #173 (7616, counted=3D7669).</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fix=
 ('a' enables 'yes' to all) &lt;y&gt;? yes</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fre=
e blocks count wrong for group #174 (31543, counted=3D29570).</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fix=
 ('a' enables 'yes' to all) &lt;y&gt;? yes</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fre=
e blocks count wrong for group #175 (30878, counted=3D31741).</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fix=
 ('a' enables 'yes' to all) &lt;y&gt;? yes</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fre=
e blocks count wrong for group #176 (28457, counted=3D32578).</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fix=
&lt;y&gt;? yes</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fre=
e blocks count wrong for group #177 (32241, counted=3D29745).</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fix=
&lt;y&gt;? yes</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fre=
e blocks count wrong for group #178 (3895, counted=3D3914).</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fix=
&lt;y&gt;? yes</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fre=
e blocks count wrong for group #187 (21504, counted=3D22309).</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fix=
&lt;y&gt;? yes</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fre=
e blocks count wrong for group #191 (8471, counted=3D8487).</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fix=
&lt;y&gt;? yes</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fre=
e blocks count wrong for group #192 (3689, counted=3D3725).</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fix=
&lt;y&gt;? yes</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fre=
e blocks count wrong for group #193 (3587, counted=3D3586).</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fix=
&lt;y&gt;? yes</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fre=
e blocks count wrong for group #194 (7573, counted=3D7540).</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fix=
&lt;y&gt;? yes</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fre=
e blocks count wrong for group #197 (16064, counted=3D16076).</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fix=
&lt;y&gt;? yes</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fre=
e blocks count wrong for group #198 (27631, counted=3D25974).</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fix=
&lt;y&gt;? yes</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fre=
e blocks count wrong (72088071, counted=3D72087902).</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fix=
&lt;y&gt;? yes</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Ino=
de bitmap differences:&nbsp; -407142 +471162</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fix=
&lt;y&gt;? yes</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fre=
e inodes count wrong for group #115 (3, counted=3D4).</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fix=
&lt;y&gt;? yes</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fre=
e inodes count wrong for group #116 (755, counted=3D728).</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fix=
&lt;y&gt;? yes</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fre=
e inodes count wrong (9277815, counted=3D9277789).</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Fix=
&lt;y&gt;? yes</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Orp=
han file (inode 12) block 39 is not clean.</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Cle=
ar&lt;y&gt;? yes</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">/dev/mapper/homecrypt: ***** FILE SYSTEM WAS MODIFIED *****</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">/de=
v/mapper/homecrypt: 478883/9756672 files (0.2% non-contiguous), 5934579/780=
22481 blocks</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">```=
</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">So there are a lot of unrelated errors, which look more severe than</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">the=
 original one targeted by this patch. I will stop testing unplugging</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">for=
 now, as something needs to be fixed to remove the noise. But my patch</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">sho=
uld resolve the original error I got.</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">```console</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">hom=
e@daniel-tablet1:~$ uname -a # During good boot</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Lin=
ux daniel-tablet1 6.18.7-surface-1 #1 SMP PREEMPT_DYNAMIC Mon Jan 26 00:16:=
20 UTC 2026 x86_64 GNU/Linux</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">hom=
e@daniel-tablet1:~$ apt-cache policy e2fsprogs</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">e2f=
sprogs:</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&nb=
sp; Installed: 1.47.2-3ubuntu2</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&nb=
sp; Candidate: 1.47.2-3ubuntu2</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&nb=
sp; Version table:</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&nb=
sp;*** 1.47.2-3ubuntu2 500</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 500 https://gpl.savoirfairelinux.ne=
t/pub/mirrors/ubuntu questing/main amd64 Packages</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 100 /var/lib/dpkg/status</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">roo=
t@daniel-tablet1:~# cat /proc/1/mounts</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">sys=
fs /sys sysfs rw,nosuid,nodev,noexec,relatime 0 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">pro=
c /proc proc rw,nosuid,nodev,noexec,relatime 0 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">ude=
v /dev devtmpfs rw,nosuid,relatime,size=3D7936332k,nr_inodes=3D1984083,mode=
=3D755,inode64 0 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">dev=
pts /dev/pts devpts rw,nosuid,noexec,relatime,gid=3D5,mode=3D600,ptmxmode=
=3D000 0 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">tmp=
fs /run tmpfs rw,nosuid,nodev,noexec,relatime,size=3D1596384k,mode=3D755,in=
ode64 0 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">/de=
v/nvme0n1p8 / ext4 ro,nodev,noatime,nombcache,min_batch_time=3D15000,max_di=
r_size_kb=3D4096 0 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">sec=
urityfs /sys/kernel/security securityfs rw,nosuid,nodev,noexec,relatime 0 0=
</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">tmp=
fs /dev/shm tmpfs rw,nosuid,nodev,inode64 0 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">cgr=
oup2 /sys/fs/cgroup cgroup2 rw,nosuid,nodev,noexec,relatime,nsdelegate,memo=
ry_recursiveprot 0 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">non=
e /sys/fs/pstore pstore rw,nosuid,nodev,noexec,relatime 0 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">efi=
varfs /sys/firmware/efi/efivars efivarfs rw,nosuid,nodev,noexec,relatime 0 =
0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">bpf=
 /sys/fs/bpf bpf rw,nosuid,nodev,noexec,relatime,mode=3D700 0 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">sys=
temd-1 /proc/sys/fs/binfmt_misc autofs rw,relatime,fd=3D36,pgrp=3D1,timeout=
=3D0,minproto=3D5,maxproto=3D5,direct,pipe_ino=3D1296 0 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">hug=
etlbfs /dev/hugepages hugetlbfs rw,nosuid,nodev,relatime,pagesize=3D2M 0 0<=
/p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">mqu=
eue /dev/mqueue mqueue rw,nosuid,nodev,noexec,relatime 0 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">tmp=
fs /run/lock tmpfs rw,nosuid,nodev,noexec,relatime,size=3D5120k,inode64 0 0=
</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">deb=
ugfs /sys/kernel/debug debugfs rw,nosuid,nodev,noexec,relatime 0 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">tra=
cefs /sys/kernel/tracing tracefs rw,nosuid,nodev,noexec,relatime 0 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">tmp=
fs /run/credentials/systemd-journald.service tmpfs ro,nosuid,nodev,noexec,r=
elatime,nosymfollow,size=3D1024k,nr_inodes=3D1024,mode=3D700,inode64,noswap=
 0 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">fus=
ectl /sys/fs/fuse/connections fusectl rw,nosuid,nodev,noexec,relatime 0 0</=
p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">con=
figfs /sys/kernel/config configfs rw,nosuid,nodev,noexec,relatime 0 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">tmp=
fs /run/credentials/systemd-cryptsetup@homecrypt.service tmpfs ro,nosuid,no=
dev,noexec,relatime,nosymfollow,size=3D1024k,nr_inodes=3D1024,mode=3D700,in=
ode64,noswap 0 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">tmp=
fs /media tmpfs rw,nosuid,nodev,noexec,noatime,size=3D5120k,mode=3D755,inod=
e64 0 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">/de=
v/nvme0n1p5 /boot ext4 ro,nosuid,nodev,noexec,noatime,nombcache,min_batch_t=
ime=3D15000,max_dir_size_kb=3D1024 0 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">/de=
v/nvme0n1p6 /tmp ext4 rw,nosuid,nodev,noatime,nombcache,min_batch_time=3D15=
000,max_dir_size_kb=3D4096 0 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">/de=
v/nvme0n1p7 /var ext4 rw,nosuid,nodev,noatime,nombcache,min_batch_time=3D15=
000,max_dir_size_kb=3D4096 0 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">/de=
v/nvme0n1p1 /boot/efi vfat ro,nosuid,nodev,noexec,noatime,fmask=3D0006,dmas=
k=3D0007,allow_utime=3D0020,codepage=3D437,iocharset=3Diso8859-1,shortname=
=3Dmixed,errors=3Dremount-ro 0 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">tmp=
fs /run/credentials/systemd-resolved.service tmpfs ro,nosuid,nodev,noexec,r=
elatime,nosymfollow,size=3D1024k,nr_inodes=3D1024,mode=3D700,inode64,noswap=
 0 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">tmp=
fs /var/lib/gdm3 tmpfs rw,nosuid,nodev,noexec,noatime,size=3D400k,nr_inodes=
=3D100,mode=3D000,inode64 0 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">/de=
v/mapper/homecrypt /home ext4 rw,nosuid,nodev,noatime,nombcache,min_batch_t=
ime=3D15000,max_dir_size_kb=3D4096 0 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">bin=
fmt_misc /proc/sys/fs/binfmt_misc binfmt_misc rw,nosuid,nodev,noexec,relati=
me 0 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">tmp=
fs /run/user/1001 tmpfs rw,nosuid,nodev,relatime,size=3D1596380k,nr_inodes=
=3D399095,mode=3D700,uid=3D1001,gid=3D1000,inode64 0 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">tmp=
fs /run/user/1000 tmpfs rw,nosuid,nodev,relatime,size=3D1596380k,nr_inodes=
=3D399095,mode=3D700,uid=3D1000,gid=3D1000,inode64 0 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">tmp=
fs /run/user/60578 tmpfs rw,nosuid,nodev,relatime,size=3D1596380k,nr_inodes=
=3D399095,mode=3D700,uid=3D60578,gid=3D139,inode64 0 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">por=
tal /run/user/60578/doc fuse.portal rw,nosuid,nodev,relatime,user_id=3D6057=
8,group_id=3D139 0 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">tmp=
fs /run/user/0 tmpfs rw,nosuid,nodev,relatime,size=3D1596380k,nr_inodes=3D3=
99095,mode=3D700,inode64 0 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">roo=
t@daniel-tablet1:~# cat /etc/fstab</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">UUI=
D=3D36fa67db-bdeb-4537-a4b0-4b001d623ccf / ext4 errors=3Dremount-ro,max_dir=
_size_kb=3D4096,min_batch_time=3D15000,noatime,nodev,nombcache,ro 0 1</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">UUI=
D=3Db36382aa-72e5-4584-8066-d8250cb1c86b /boot ext4 errors=3Dremount-ro,max=
_dir_size_kb=3D1024,min_batch_time=3D15000,noatime,nodev,noexec,nombcache,n=
osuid,ro 0 2</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">UUI=
D=3DC4B7-85E2 /boot/efi vfat dmask=3D0007,fmask=3D0006,noatime,nodev,noexec=
,nosuid,ro 0 2</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">/de=
v/mapper/homecrypt /home ext4 errors=3Dremount-ro,max_dir_size_kb=3D4096,mi=
n_batch_time=3D15000,noatime,nodev,nombcache,nosuid 0 2</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">UUI=
D=3D69452394-6e8e-4a5b-9116-0a8402d66401 /tmp ext4 errors=3Dremount-ro,max_=
dir_size_kb=3D4096,min_batch_time=3D15000,noatime,nodev,nombcache,nosuid 0 =
2</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">UUI=
D=3D46916dcd-c245-4384-bbaf-2f9460979425 /var ext4 errors=3Dremount-ro,max_=
dir_size_kb=3D4096,min_batch_time=3D15000,noatime,nodev,nombcache,nosuid 0 =
2</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">tmp=
fs /media tmpfs mode=3D755,noatime,nodev,noexec,nosuid,size=3D5120k 0 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">tmp=
fs /var/lib/gdm3 tmpfs nodev,nosuid,noexec,noatime,nr_blocks=3D100,nr_inode=
s=3D100,mode=3D0 0 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">roo=
t@daniel-tablet1:~# cat /etc/crypttab </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;"># &=
lt;target name&gt; &lt;source device&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; &lt;key file&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;options&gt=
;</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">hom=
ecrypt UUID=3D0ffa31a8-58f7-48a5-ae99-71f40d376bd6 none discard,luks,no-rea=
d-workqueue,no-write-workqueue,same-cpu-crypt,submit-from-crypt-cpus</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">```=
</p>
<br /></body>
</html>
--nextPart6838103.31tnzDBltd--

--nextPart2828550.3Lj2Plt8kZ
Content-Disposition: attachment;
 filename="tabletjournalctlb0_202603061148160001.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: multipart/mixed; boundary="nextPart2937681.3ZeAukHxDK"

--nextPart2937681.3ZeAukHxDK
Content-Transfer-Encoding: 7Bit
Content-Type: multipart/mixed; boundary="nextPart3413652.mvXUDI8C0e"

--nextPart3413652.mvXUDI8C0e
Content-Type: text/plain
Content-Transfer-Encoding: 7Bit

Mar 06 11:22:24 daniel-tablet1 kernel: Linux version 6.18.7-surface-1 (root@e61ac5a62644) (gcc (Ubuntu 11.4.0-1ubuntu1~22.04.2) 11.4.0, GNU ld (GNU Binutils for Ubuntu) 2.38) #1 SMP PREEMPT_DYNAMIC Mon Jan 26 00:16:20 UTC 2026
Mar 06 11:22:24 daniel-tablet1 kernel: Command line: BOOT_IMAGE=/vmlinuz-6.18.7-surface-1 root=/dev/nvme0n1p8 ro fbcon=font:TER16x32 rootflags=nombcache quiet splash usbcore.autosuspend=-1 usbcore.quirks=0bda:8153:k reboot=pci
Mar 06 11:22:24 daniel-tablet1 kernel: KERNEL supported cpus:
Mar 06 11:22:24 daniel-tablet1 kernel:   Intel GenuineIntel
Mar 06 11:22:24 daniel-tablet1 kernel:   AMD AuthenticAMD
Mar 06 11:22:24 daniel-tablet1 kernel:   Hygon HygonGenuine
Mar 06 11:22:24 daniel-tablet1 kernel:   Centaur CentaurHauls
Mar 06 11:22:24 daniel-tablet1 kernel:   zhaoxin   Shanghai
Mar 06 11:22:24 daniel-tablet1 kernel: x86/split lock detection: #AC: crashing the kernel on kernel split_locks and warning on user-space split_locks
Mar 06 11:22:24 daniel-tablet1 kernel: BIOS-provided physical RAM map:
Mar 06 11:22:24 daniel-tablet1 kernel: BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
Mar 06 11:22:24 daniel-tablet1 kernel: BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
Mar 06 11:22:24 daniel-tablet1 kernel: BIOS-e820: [mem 0x0000000000100000-0x0000000077094fff] usable
Mar 06 11:22:24 daniel-tablet1 kernel: BIOS-e820: [mem 0x0000000077095000-0x00000000770a0fff] ACPI data
Mar 06 11:22:24 daniel-tablet1 kernel: BIOS-e820: [mem 0x00000000770a1000-0x0000000079cbffff] usable
Mar 06 11:22:24 daniel-tablet1 kernel: BIOS-e820: [mem 0x0000000079cc0000-0x0000000079cc0fff] ACPI NVS
Mar 06 11:22:24 daniel-tablet1 kernel: BIOS-e820: [mem 0x0000000079cc1000-0x0000000079cc1fff] usable
Mar 06 11:22:24 daniel-tablet1 kernel: BIOS-e820: [mem 0x0000000079cc2000-0x0000000079cc2fff] reserved
Mar 06 11:22:24 daniel-tablet1 kernel: BIOS-e820: [mem 0x0000000079cc3000-0x000000007b62bfff] usable
Mar 06 11:22:24 daniel-tablet1 kernel: BIOS-e820: [mem 0x000000007b62c000-0x000000007ba2bfff] reserved
Mar 06 11:22:24 daniel-tablet1 kernel: BIOS-e820: [mem 0x000000007ba2c000-0x000000007ba45fff] usable
Mar 06 11:22:24 daniel-tablet1 kernel: BIOS-e820: [mem 0x000000007ba46000-0x000000007bb89fff] reserved
Mar 06 11:22:24 daniel-tablet1 kernel: BIOS-e820: [mem 0x000000007bb8a000-0x000000007bbb3fff] ACPI NVS
Mar 06 11:22:24 daniel-tablet1 kernel: BIOS-e820: [mem 0x000000007bbb4000-0x000000007bbfefff] ACPI data
Mar 06 11:22:24 daniel-tablet1 kernel: BIOS-e820: [mem 0x000000007bbff000-0x000000007bbfffff] usable
Mar 06 11:22:24 daniel-tablet1 kernel: BIOS-e820: [mem 0x000000007bc00000-0x00000000953fffff] reserved
Mar 06 11:22:24 daniel-tablet1 kernel: BIOS-e820: [mem 0x00000000fe010000-0x00000000fe010fff] reserved
Mar 06 11:22:24 daniel-tablet1 kernel: BIOS-e820: [mem 0x00000000fed20000-0x00000000fed7ffff] reserved
Mar 06 11:22:24 daniel-tablet1 kernel: BIOS-e820: [mem 0x0000000100000000-0x000000046abfffff] usable
Mar 06 11:22:24 daniel-tablet1 kernel: NX (Execute Disable) protection: active
Mar 06 11:22:24 daniel-tablet1 kernel: APIC: Static calls initialized
Mar 06 11:22:24 daniel-tablet1 kernel: efi: EFI v2.7 by MSFT
Mar 06 11:22:24 daniel-tablet1 kernel: efi: ACPI=0x7bbfe000 ACPI 2.0=0x7bbfe014 TPMFinalLog=0x7bbab000 SMBIOS=0x7bac4000 SMBIOS 3.0=0x7bac2000 MEMATTR=0x7769c018 ESRT=0x78de5e98 MOKvar=0x7babf000 INITRD=0x7766e198 RNG=0x7bbb7018 TPMEventLog=0x77095018
Mar 06 11:22:24 daniel-tablet1 kernel: random: crng init done
Mar 06 11:22:24 daniel-tablet1 kernel: efi: Not removing mem199: MMIO range=[0xfe010000-0xfe010fff] (4KB) from e820 map
Mar 06 11:22:24 daniel-tablet1 kernel: SMBIOS 3.3.0 present.
Mar 06 11:22:24 daniel-tablet1 kernel: DMI: Microsoft Corporation Surface Pro 7/Surface Pro 7, BIOS 24.109.140 07/21/2025
Mar 06 11:22:24 daniel-tablet1 kernel: DMI: Memory slots populated: 2/2
Mar 06 11:22:24 daniel-tablet1 kernel: tsc: Detected 1500.000 MHz processor
Mar 06 11:22:24 daniel-tablet1 kernel: tsc: Detected 1497.600 MHz TSC
Mar 06 11:22:24 daniel-tablet1 kernel: e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
Mar 06 11:22:24 daniel-tablet1 kernel: e820: remove [mem 0x000a0000-0x000fffff] usable
Mar 06 11:22:24 daniel-tablet1 kernel: last_pfn = 0x46ac00 max_arch_pfn = 0x400000000
Mar 06 11:22:24 daniel-tablet1 kernel: MTRR map: 5 entries (3 fixed + 2 variable; max 23), built from 10 variable MTRRs
Mar 06 11:22:24 daniel-tablet1 kernel: x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
Mar 06 11:22:24 daniel-tablet1 kernel: last_pfn = 0x7bc00 max_arch_pfn = 0x400000000
Mar 06 11:22:24 daniel-tablet1 kernel: esrt: Reserving ESRT space from 0x0000000078de5e98 to 0x0000000078de5f70.
Mar 06 11:22:24 daniel-tablet1 kernel: e820: update [mem 0x78de5000-0x78de5fff] usable ==> reserved
Mar 06 11:22:24 daniel-tablet1 kernel: Using GB pages for direct mapping
Mar 06 11:22:24 daniel-tablet1 kernel: Secure boot enabled
Mar 06 11:22:24 daniel-tablet1 kernel: RAMDISK: [mem 0x6652f000-0x6b3d2fff]
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Early table checksum verification disabled
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: RSDP 0x000000007BBFE014 000024 (v02 MSFT  )
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: XSDT 0x000000007BBFD0E8 0000BC (v01 MSFT   MSFT     00000002 MSFT 20160422)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: FACP 0x000000007BBE1000 000114 (v06 MSFT   MSFT     00000002 MSFT 20160422)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: DSDT 0x000000007BBC0000 01C074 (v02 MSFT   MSFT     00000002 MSFT 20160422)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: FACS 0x000000007BB91000 000040
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: WSMT 0x000000007BBFC000 000028 (v01 MSFT   MSFT     00000002 MSFT 20160422)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: SSDT 0x000000007BBFA000 001B61 (v02 CpuRef CpuSsdt  00003000 INTL 20181003)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: MSDM 0x000000007BBF9000 000055 (v01 MSFT            00000001 MSFT 00000001)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: SSDT 0x000000007BBF2000 006230 (v02 MSFT   DptfTabl 00001000 INTL 20181003)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: SSDT 0x000000007BBEE000 0033E3 (v02 SaSsdt SaSsdt   00003000 INTL 20181003)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: SSDT 0x000000007BBE2000 00B27A (v02 INTEL  TcssSsdt 00001000 INTL 20181003)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: HPET 0x000000007BBE0000 000038 (v01 MSFT   MSFT     00000002 MSFT 20160422)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: LPIT 0x000000007BBDF000 000094 (v01 MSFT   MSFT     00000002 MSFT 20160422)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: APIC 0x000000007BBDE000 00012C (v04 MSFT   MSFT     00000002 MSFT 20160422)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: MCFG 0x000000007BBDD000 00003C (v01 MSFT   MSFT     00000002 MSFT 20160422)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: SSDT 0x000000007BBBF000 000DB4 (v02 MSFT   RTD3_JL  00001000 INTL 20181003)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: SSDT 0x000000007BBBE000 0009E3 (v02 MSFT   xh_jl000 00000000 INTL 20181003)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: NHLT 0x000000007BBBD000 00002D (v00 MSFT   MSFT     00000002 MSFT 20160422)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: SSDT 0x000000007BBBC000 000574 (v02 MSFT   Tpm2Tabl 00001000 INTL 20181003)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: TPM2 0x000000007BBBB000 000034 (v03 MSFT   MSFT     00000002 MSFT 20160422)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: DMAR 0x000000007BBBA000 0000A0 (v02 MSFT   MSFT     00000002 MSFT 20160422)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: FPDT 0x000000007BBB9000 000034 (v01 MSFT   MSFT     00000002 MSFT 20160422)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: BGRT 0x000000007BBB8000 000038 (v01 MSFT   MSFT     00000002 MSFT 20160422)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Reserving FACP table memory at [mem 0x7bbe1000-0x7bbe1113]
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Reserving DSDT table memory at [mem 0x7bbc0000-0x7bbdc073]
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Reserving FACS table memory at [mem 0x7bb91000-0x7bb9103f]
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Reserving WSMT table memory at [mem 0x7bbfc000-0x7bbfc027]
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Reserving SSDT table memory at [mem 0x7bbfa000-0x7bbfbb60]
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Reserving MSDM table memory at [mem 0x7bbf9000-0x7bbf9054]
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Reserving SSDT table memory at [mem 0x7bbf2000-0x7bbf822f]
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Reserving SSDT table memory at [mem 0x7bbee000-0x7bbf13e2]
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Reserving SSDT table memory at [mem 0x7bbe2000-0x7bbed279]
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Reserving HPET table memory at [mem 0x7bbe0000-0x7bbe0037]
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Reserving LPIT table memory at [mem 0x7bbdf000-0x7bbdf093]
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Reserving APIC table memory at [mem 0x7bbde000-0x7bbde12b]
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Reserving MCFG table memory at [mem 0x7bbdd000-0x7bbdd03b]
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Reserving SSDT table memory at [mem 0x7bbbf000-0x7bbbfdb3]
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Reserving SSDT table memory at [mem 0x7bbbe000-0x7bbbe9e2]
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Reserving NHLT table memory at [mem 0x7bbbd000-0x7bbbd02c]
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Reserving SSDT table memory at [mem 0x7bbbc000-0x7bbbc573]
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Reserving TPM2 table memory at [mem 0x7bbbb000-0x7bbbb033]
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Reserving DMAR table memory at [mem 0x7bbba000-0x7bbba09f]
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Reserving FPDT table memory at [mem 0x7bbb9000-0x7bbb9033]
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Reserving BGRT table memory at [mem 0x7bbb8000-0x7bbb8037]
Mar 06 11:22:24 daniel-tablet1 kernel: No NUMA configuration found
Mar 06 11:22:24 daniel-tablet1 kernel: Faking a node at [mem 0x0000000000000000-0x000000046abfffff]
Mar 06 11:22:24 daniel-tablet1 kernel: NODE_DATA(0) allocated [mem 0x46abd3280-0x46abfdfff]
Mar 06 11:22:24 daniel-tablet1 kernel: Zone ranges:
Mar 06 11:22:24 daniel-tablet1 kernel:   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
Mar 06 11:22:24 daniel-tablet1 kernel:   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
Mar 06 11:22:24 daniel-tablet1 kernel:   Normal   [mem 0x0000000100000000-0x000000046abfffff]
Mar 06 11:22:24 daniel-tablet1 kernel:   Device   empty
Mar 06 11:22:24 daniel-tablet1 kernel: Movable zone start for each node
Mar 06 11:22:24 daniel-tablet1 kernel: Early memory node ranges
Mar 06 11:22:24 daniel-tablet1 kernel:   node   0: [mem 0x0000000000001000-0x000000000009ffff]
Mar 06 11:22:24 daniel-tablet1 kernel:   node   0: [mem 0x0000000000100000-0x0000000077094fff]
Mar 06 11:22:24 daniel-tablet1 kernel:   node   0: [mem 0x00000000770a1000-0x0000000079cbffff]
Mar 06 11:22:24 daniel-tablet1 kernel:   node   0: [mem 0x0000000079cc1000-0x0000000079cc1fff]
Mar 06 11:22:24 daniel-tablet1 kernel:   node   0: [mem 0x0000000079cc3000-0x000000007b62bfff]
Mar 06 11:22:24 daniel-tablet1 kernel:   node   0: [mem 0x000000007ba2c000-0x000000007ba45fff]
Mar 06 11:22:24 daniel-tablet1 kernel:   node   0: [mem 0x000000007bbff000-0x000000007bbfffff]
Mar 06 11:22:24 daniel-tablet1 kernel:   node   0: [mem 0x0000000100000000-0x000000046abfffff]
Mar 06 11:22:24 daniel-tablet1 kernel: Initmem setup node 0 [mem 0x0000000000001000-0x000000046abfffff]
Mar 06 11:22:24 daniel-tablet1 kernel: On node 0, zone DMA: 1 pages in unavailable ranges
Mar 06 11:22:24 daniel-tablet1 kernel: On node 0, zone DMA: 96 pages in unavailable ranges
Mar 06 11:22:24 daniel-tablet1 kernel: On node 0, zone DMA32: 12 pages in unavailable ranges
Mar 06 11:22:24 daniel-tablet1 kernel: On node 0, zone DMA32: 1 pages in unavailable ranges
Mar 06 11:22:24 daniel-tablet1 kernel: On node 0, zone DMA32: 1 pages in unavailable ranges
Mar 06 11:22:24 daniel-tablet1 kernel: On node 0, zone DMA32: 1024 pages in unavailable ranges
Mar 06 11:22:24 daniel-tablet1 kernel: On node 0, zone DMA32: 441 pages in unavailable ranges
Mar 06 11:22:24 daniel-tablet1 kernel: On node 0, zone Normal: 17408 pages in unavailable ranges
Mar 06 11:22:24 daniel-tablet1 kernel: On node 0, zone Normal: 21504 pages in unavailable ranges
Mar 06 11:22:24 daniel-tablet1 kernel: Reserving Intel graphics memory at [mem 0x91800000-0x953fffff]
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: PM-Timer IO Port: 0x1808
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
Mar 06 11:22:24 daniel-tablet1 kernel: IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Using ACPI (MADT) for SMP configuration information
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: HPET id: 0x8086a201 base: 0xfed00000
Mar 06 11:22:24 daniel-tablet1 kernel: e820: update [mem 0x775f5000-0x77632fff] usable ==> reserved
Mar 06 11:22:24 daniel-tablet1 kernel: TSC deadline timer available
Mar 06 11:22:24 daniel-tablet1 kernel: CPU topo: Max. logical packages:   1
Mar 06 11:22:24 daniel-tablet1 kernel: CPU topo: Max. logical dies:       1
Mar 06 11:22:24 daniel-tablet1 kernel: CPU topo: Max. dies per package:   1
Mar 06 11:22:24 daniel-tablet1 kernel: CPU topo: Max. threads per core:   2
Mar 06 11:22:24 daniel-tablet1 kernel: CPU topo: Num. cores per package:     4
Mar 06 11:22:24 daniel-tablet1 kernel: CPU topo: Num. threads per package:   8
Mar 06 11:22:24 daniel-tablet1 kernel: CPU topo: Allowing 8 present CPUs plus 0 hotplug CPUs
Mar 06 11:22:24 daniel-tablet1 kernel: PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
Mar 06 11:22:24 daniel-tablet1 kernel: PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
Mar 06 11:22:24 daniel-tablet1 kernel: PM: hibernation: Registered nosave memory: [mem 0x77095000-0x770a0fff]
Mar 06 11:22:24 daniel-tablet1 kernel: PM: hibernation: Registered nosave memory: [mem 0x775f5000-0x77632fff]
Mar 06 11:22:24 daniel-tablet1 kernel: PM: hibernation: Registered nosave memory: [mem 0x78de5000-0x78de5fff]
Mar 06 11:22:24 daniel-tablet1 kernel: PM: hibernation: Registered nosave memory: [mem 0x79cc0000-0x79cc0fff]
Mar 06 11:22:24 daniel-tablet1 kernel: PM: hibernation: Registered nosave memory: [mem 0x79cc2000-0x79cc2fff]
Mar 06 11:22:24 daniel-tablet1 kernel: PM: hibernation: Registered nosave memory: [mem 0x7b62c000-0x7ba2bfff]
Mar 06 11:22:24 daniel-tablet1 kernel: PM: hibernation: Registered nosave memory: [mem 0x7ba46000-0x7bbfefff]
Mar 06 11:22:24 daniel-tablet1 kernel: PM: hibernation: Registered nosave memory: [mem 0x7bc00000-0xffffffff]
Mar 06 11:22:24 daniel-tablet1 kernel: [mem 0x95400000-0xfe00ffff] available for PCI devices
Mar 06 11:22:24 daniel-tablet1 kernel: Booting paravirtualized kernel on bare hardware
Mar 06 11:22:24 daniel-tablet1 kernel: clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
Mar 06 11:22:24 daniel-tablet1 kernel: setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
Mar 06 11:22:24 daniel-tablet1 kernel: percpu: Embedded 84 pages/cpu s221184 r8192 d114688 u524288
Mar 06 11:22:24 daniel-tablet1 kernel: pcpu-alloc: s221184 r8192 d114688 u524288 alloc=1*2097152
Mar 06 11:22:24 daniel-tablet1 kernel: pcpu-alloc: [0] 0 1 2 3 [0] 4 5 6 7
Mar 06 11:22:24 daniel-tablet1 kernel: Kernel command line: BOOT_IMAGE=/vmlinuz-6.18.7-surface-1 root=/dev/nvme0n1p8 ro fbcon=font:TER16x32 rootflags=nombcache quiet splash usbcore.autosuspend=-1 usbcore.quirks=0bda:8153:k reboot=pci
Mar 06 11:22:24 daniel-tablet1 kernel: Unknown kernel command line parameters "splash", will be passed to user space.
Mar 06 11:22:24 daniel-tablet1 kernel: printk: log buffer data + meta data: 262144 + 917504 = 1179648 bytes
Mar 06 11:22:24 daniel-tablet1 kernel: Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
Mar 06 11:22:24 daniel-tablet1 kernel: Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
Mar 06 11:22:24 daniel-tablet1 kernel: software IO TLB: area num 8.
Mar 06 11:22:24 daniel-tablet1 kernel: Fallback order for Node 0: 0
Mar 06 11:22:24 daniel-tablet1 kernel: Built 1 zonelists, mobility grouping on.  Total pages: 4088280
Mar 06 11:22:24 daniel-tablet1 kernel: Policy zone: Normal
Mar 06 11:22:24 daniel-tablet1 kernel: mem auto-init: stack:off, heap alloc:on, heap free:off
Mar 06 11:22:24 daniel-tablet1 kernel: SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
Mar 06 11:22:24 daniel-tablet1 kernel: ftrace: allocating 58226 entries in 228 pages
Mar 06 11:22:24 daniel-tablet1 kernel: ftrace: allocated 228 pages with 4 groups
Mar 06 11:22:24 daniel-tablet1 kernel: Dynamic Preempt: voluntary
Mar 06 11:22:24 daniel-tablet1 kernel: rcu: Preemptible hierarchical RCU implementation.
Mar 06 11:22:24 daniel-tablet1 kernel: rcu:         RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=8.
Mar 06 11:22:24 daniel-tablet1 kernel:         Trampoline variant of Tasks RCU enabled.
Mar 06 11:22:24 daniel-tablet1 kernel:         Rude variant of Tasks RCU enabled.
Mar 06 11:22:24 daniel-tablet1 kernel:         Tracing variant of Tasks RCU enabled.
Mar 06 11:22:24 daniel-tablet1 kernel: rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
Mar 06 11:22:24 daniel-tablet1 kernel: rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
Mar 06 11:22:24 daniel-tablet1 kernel: RCU Tasks: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=8.
Mar 06 11:22:24 daniel-tablet1 kernel: RCU Tasks Rude: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=8.
Mar 06 11:22:24 daniel-tablet1 kernel: RCU Tasks Trace: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=8.
Mar 06 11:22:24 daniel-tablet1 kernel: NR_IRQS: 524544, nr_irqs: 2048, preallocated irqs: 16
Mar 06 11:22:24 daniel-tablet1 kernel: rcu: srcu_init: Setting srcu_struct sizes based on contention.
Mar 06 11:22:24 daniel-tablet1 kernel: Console: colour dummy device 80x25
Mar 06 11:22:24 daniel-tablet1 kernel: printk: legacy console [tty0] enabled
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Core revision 20250807
Mar 06 11:22:24 daniel-tablet1 kernel: hpet: HPET dysfunctional in PC10. Force disabled.
Mar 06 11:22:24 daniel-tablet1 kernel: APIC: Switch to symmetric I/O mode setup
Mar 06 11:22:24 daniel-tablet1 kernel: DMAR: Host address width 39
Mar 06 11:22:24 daniel-tablet1 kernel: DMAR: DRHD base: 0x000000fed90000 flags: 0x0
Mar 06 11:22:24 daniel-tablet1 kernel: DMAR: dmar0: reg_base_addr fed90000 ver 4:0 cap 1c0000c40660462 ecap 49e2ff0505e
Mar 06 11:22:24 daniel-tablet1 kernel: DMAR: DRHD base: 0x000000fed92000 flags: 0x0
Mar 06 11:22:24 daniel-tablet1 kernel: DMAR: dmar1: reg_base_addr fed92000 ver 1:0 cap d2008c40660462 ecap f050da
Mar 06 11:22:24 daniel-tablet1 kernel: DMAR: DRHD base: 0x000000fed91000 flags: 0x1
Mar 06 11:22:24 daniel-tablet1 kernel: DMAR: dmar2: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
Mar 06 11:22:24 daniel-tablet1 kernel: DMAR: RMRR base: 0x00000091000000 end: 0x000000953fffff
Mar 06 11:22:24 daniel-tablet1 kernel: DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 2
Mar 06 11:22:24 daniel-tablet1 kernel: DMAR-IR: HPET id 0 under DRHD base 0xfed91000
Mar 06 11:22:24 daniel-tablet1 kernel: DMAR-IR: x2apic is disabled because BIOS sets x2apic opt out bit.
Mar 06 11:22:24 daniel-tablet1 kernel: DMAR-IR: Use 'intremap=no_x2apic_optout' to override the BIOS setting.
Mar 06 11:22:24 daniel-tablet1 kernel: DMAR-IR: Enabled IRQ remapping in xapic mode
Mar 06 11:22:24 daniel-tablet1 kernel: x2apic: IRQ remapping doesn't support X2APIC mode
Mar 06 11:22:24 daniel-tablet1 kernel: clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x159647815e3, max_idle_ns: 440795269835 ns
Mar 06 11:22:24 daniel-tablet1 kernel: Calibrating delay loop (skipped), value calculated using timer frequency.. 2995.20 BogoMIPS (lpj=1497600)
Mar 06 11:22:24 daniel-tablet1 kernel: x86/cpu: SGX disabled or unsupported by BIOS.
Mar 06 11:22:24 daniel-tablet1 kernel: CPU0: Thermal monitoring enabled (TM1)
Mar 06 11:22:24 daniel-tablet1 kernel: x86/cpu: User Mode Instruction Prevention (UMIP) activated
Mar 06 11:22:24 daniel-tablet1 kernel: Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
Mar 06 11:22:24 daniel-tablet1 kernel: Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
Mar 06 11:22:24 daniel-tablet1 kernel: process: using mwait in idle threads
Mar 06 11:22:24 daniel-tablet1 kernel: mitigations: Enabled attack vectors: user_kernel, user_user, guest_host, guest_guest, SMT mitigations: auto
Mar 06 11:22:24 daniel-tablet1 kernel: Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
Mar 06 11:22:24 daniel-tablet1 kernel: SRBDS: Mitigation: Microcode
Mar 06 11:22:24 daniel-tablet1 kernel: Spectre V2 : Mitigation: Enhanced / Automatic IBRS
Mar 06 11:22:24 daniel-tablet1 kernel: RETBleed: Mitigation: Enhanced IBRS
Mar 06 11:22:24 daniel-tablet1 kernel: ITS: Mitigation: Aligned branch/return thunks
Mar 06 11:22:24 daniel-tablet1 kernel: MMIO Stale Data: Mitigation: Clear CPU buffers
Mar 06 11:22:24 daniel-tablet1 kernel: Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
Mar 06 11:22:24 daniel-tablet1 kernel: Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
Mar 06 11:22:24 daniel-tablet1 kernel: Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
Mar 06 11:22:24 daniel-tablet1 kernel: GDS: Vulnerable
Mar 06 11:22:24 daniel-tablet1 kernel: active return thunk: its_return_thunk
Mar 06 11:22:24 daniel-tablet1 kernel: Spectre V2 : Spectre BHI mitigation: SW BHB clearing on syscall and VM exit
Mar 06 11:22:24 daniel-tablet1 kernel: x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
Mar 06 11:22:24 daniel-tablet1 kernel: x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
Mar 06 11:22:24 daniel-tablet1 kernel: x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
Mar 06 11:22:24 daniel-tablet1 kernel: x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
Mar 06 11:22:24 daniel-tablet1 kernel: x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
Mar 06 11:22:24 daniel-tablet1 kernel: x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
Mar 06 11:22:24 daniel-tablet1 kernel: x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
Mar 06 11:22:24 daniel-tablet1 kernel: x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
Mar 06 11:22:24 daniel-tablet1 kernel: x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
Mar 06 11:22:24 daniel-tablet1 kernel: x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
Mar 06 11:22:24 daniel-tablet1 kernel: x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
Mar 06 11:22:24 daniel-tablet1 kernel: x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
Mar 06 11:22:24 daniel-tablet1 kernel: x86/fpu: Enabled xstate features 0x2e7, context size is 2440 bytes, using 'compacted' format.
Mar 06 11:22:24 daniel-tablet1 kernel: Freeing SMP alternatives memory: 52K
Mar 06 11:22:24 daniel-tablet1 kernel: pid_max: default: 32768 minimum: 301
Mar 06 11:22:24 daniel-tablet1 kernel: LSM: initializing lsm=lockdown,capability,landlock,yama,apparmor,ima,evm
Mar 06 11:22:24 daniel-tablet1 kernel: landlock: Up and running.
Mar 06 11:22:24 daniel-tablet1 kernel: Yama: becoming mindful.
Mar 06 11:22:24 daniel-tablet1 kernel: AppArmor: AppArmor initialized
Mar 06 11:22:24 daniel-tablet1 kernel: Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
Mar 06 11:22:24 daniel-tablet1 kernel: Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
Mar 06 11:22:24 daniel-tablet1 kernel: smpboot: CPU0: Intel(R) Core(TM) i7-1065G7 CPU @ 1.30GHz (family: 0x6, model: 0x7e, stepping: 0x5)
Mar 06 11:22:24 daniel-tablet1 kernel: Performance Events: PEBS fmt4+-baseline,  AnyThread deprecated, Icelake events, 32-deep LBR, full-width counters, Intel PMU driver.
Mar 06 11:22:24 daniel-tablet1 kernel: ... version:                   5
Mar 06 11:22:24 daniel-tablet1 kernel: ... bit width:                 48
Mar 06 11:22:24 daniel-tablet1 kernel: ... generic counters:          8
Mar 06 11:22:24 daniel-tablet1 kernel: ... generic bitmap:            00000000000000ff
Mar 06 11:22:24 daniel-tablet1 kernel: ... fixed-purpose counters:    4
Mar 06 11:22:24 daniel-tablet1 kernel: ... fixed-purpose bitmap:      000000000000000f
Mar 06 11:22:24 daniel-tablet1 kernel: ... value mask:                0000ffffffffffff
Mar 06 11:22:24 daniel-tablet1 kernel: ... max period:                00007fffffffffff
Mar 06 11:22:24 daniel-tablet1 kernel: ... global_ctrl mask:          0001000f000000ff
Mar 06 11:22:24 daniel-tablet1 kernel: signal: max sigframe size: 3632
Mar 06 11:22:24 daniel-tablet1 kernel: Estimated ratio of average max frequency by base frequency (times 1024): 2389
Mar 06 11:22:24 daniel-tablet1 kernel: rcu: Hierarchical SRCU implementation.
Mar 06 11:22:24 daniel-tablet1 kernel: rcu:         Max phase no-delay instances is 400.
Mar 06 11:22:24 daniel-tablet1 kernel: Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
Mar 06 11:22:24 daniel-tablet1 kernel: NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
Mar 06 11:22:24 daniel-tablet1 kernel: smp: Bringing up secondary CPUs ...
Mar 06 11:22:24 daniel-tablet1 kernel: smpboot: x86: Booting SMP configuration:
Mar 06 11:22:24 daniel-tablet1 kernel: .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
Mar 06 11:22:24 daniel-tablet1 kernel: MMIO Stale Data CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.html for more details.
Mar 06 11:22:24 daniel-tablet1 kernel: smp: Brought up 1 node, 8 CPUs
Mar 06 11:22:24 daniel-tablet1 kernel: smpboot: Total of 8 processors activated (23961.60 BogoMIPS)
Mar 06 11:22:24 daniel-tablet1 kernel: Memory: 15845752K/16353120K available (20537K kernel code, 3452K rwdata, 8616K rodata, 5000K init, 5680K bss, 480468K reserved, 0K cma-reserved)
Mar 06 11:22:24 daniel-tablet1 kernel: devtmpfs: initialized
Mar 06 11:22:24 daniel-tablet1 kernel: x86/mm: Memory block size: 128MB
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: PM: Registering ACPI NVS region [mem 0x79cc0000-0x79cc0fff] (4096 bytes)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: PM: Registering ACPI NVS region [mem 0x7bb8a000-0x7bbb3fff] (172032 bytes)
Mar 06 11:22:24 daniel-tablet1 kernel: clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
Mar 06 11:22:24 daniel-tablet1 kernel: posixtimers hash table entries: 4096 (order: 4, 65536 bytes, linear)
Mar 06 11:22:24 daniel-tablet1 kernel: futex hash table entries: 2048 (131072 bytes on 1 NUMA nodes, total 128 KiB, linear).
Mar 06 11:22:24 daniel-tablet1 kernel: pinctrl core: initialized pinctrl subsystem
Mar 06 11:22:24 daniel-tablet1 kernel: PM: RTC time: 16:22:21, date: 2026-03-06
Mar 06 11:22:24 daniel-tablet1 kernel: NET: Registered PF_NETLINK/PF_ROUTE protocol family
Mar 06 11:22:24 daniel-tablet1 kernel: DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic allocations
Mar 06 11:22:24 daniel-tablet1 kernel: DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
Mar 06 11:22:24 daniel-tablet1 kernel: DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
Mar 06 11:22:24 daniel-tablet1 kernel: audit: initializing netlink subsys (disabled)
Mar 06 11:22:24 daniel-tablet1 kernel: audit: type=2000 audit(1772814141.019:1): state=initialized audit_enabled=0 res=1
Mar 06 11:22:24 daniel-tablet1 kernel: thermal_sys: Registered thermal governor 'fair_share'
Mar 06 11:22:24 daniel-tablet1 kernel: thermal_sys: Registered thermal governor 'bang_bang'
Mar 06 11:22:24 daniel-tablet1 kernel: thermal_sys: Registered thermal governor 'step_wise'
Mar 06 11:22:24 daniel-tablet1 kernel: thermal_sys: Registered thermal governor 'user_space'
Mar 06 11:22:24 daniel-tablet1 kernel: thermal_sys: Registered thermal governor 'power_allocator'
Mar 06 11:22:24 daniel-tablet1 kernel: cpuidle: using governor ladder
Mar 06 11:22:24 daniel-tablet1 kernel: cpuidle: using governor menu
Mar 06 11:22:24 daniel-tablet1 kernel: acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
Mar 06 11:22:24 daniel-tablet1 kernel: PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
Mar 06 11:22:24 daniel-tablet1 kernel: PCI: Using configuration type 1 for base access
Mar 06 11:22:24 daniel-tablet1 kernel: kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
Mar 06 11:22:24 daniel-tablet1 kernel: HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
Mar 06 11:22:24 daniel-tablet1 kernel: HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
Mar 06 11:22:24 daniel-tablet1 kernel: HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
Mar 06 11:22:24 daniel-tablet1 kernel: HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Added _OSI(Module Device)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Added _OSI(Processor Device)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Added _OSI(Processor Aggregator Device)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: 8 ACPI AML tables successfully acquired and loaded
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Dynamic OEM Table Load:
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: SSDT 0xFFFF8C0E02426000 000394 (v02 PmRef  Cpu0Cst  00003001 INTL 20181003)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Dynamic OEM Table Load:
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: SSDT 0xFFFF8C0E023DD800 000437 (v02 PmRef  Cpu0Ist  00003000 INTL 20181003)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Dynamic OEM Table Load:
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: SSDT 0xFFFF8C0E01793A00 0000F4 (v02 PmRef  Cpu0Psd  00003000 INTL 20181003)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Dynamic OEM Table Load:
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: SSDT 0xFFFF8C0E02376800 00012C (v02 PmRef  Cpu0Hwp  00003000 INTL 20181003)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Dynamic OEM Table Load:
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: SSDT 0xFFFF8C0E023DB000 000724 (v02 PmRef  HwpLvt   00003000 INTL 20181003)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Dynamic OEM Table Load:
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: SSDT 0xFFFF8C0E023DC000 0005FC (v02 PmRef  ApIst    00003000 INTL 20181003)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Dynamic OEM Table Load:
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: SSDT 0xFFFF8C0E02420C00 000317 (v02 PmRef  ApHwp    00003000 INTL 20181003)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Dynamic OEM Table Load:
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: SSDT 0xFFFF8C0E02435000 000AB0 (v02 PmRef  ApPsd    00003000 INTL 20181003)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Dynamic OEM Table Load:
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: SSDT 0xFFFF8C0E02420400 00030A (v02 PmRef  ApCst    00003000 INTL 20181003)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Interpreter enabled
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: PM: (supports S0 S4 S5)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Using IOAPIC for interrupt routing
Mar 06 11:22:24 daniel-tablet1 kernel: PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
Mar 06 11:22:24 daniel-tablet1 kernel: PCI: Ignoring E820 reservations for host bridge windows
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: Enabled 8 GPEs in block 00 to 7F
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: \_SB_.PCI0.XHC_.RHUB.HS10.BTPR: New power resource
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: \_SB_.PCI0.SAT0.VOL0.V0PR: New power resource
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: \_SB_.PCI0.SAT0.VOL1.V1PR: New power resource
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: \_SB_.PCI0.SAT0.VOL2.V2PR: New power resource
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: \_SB_.PCI0.CNVW.WRST: New power resource
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: \_SB_.PCI0.TBT0: New power resource
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: \_SB_.PCI0.TBT1: New power resource
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: \_SB_.PCI0.D3C_: New power resource
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: \PIN_: New power resource
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
Mar 06 11:22:24 daniel-tablet1 kernel: acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
Mar 06 11:22:24 daniel-tablet1 kernel: acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR DPC]
Mar 06 11:22:24 daniel-tablet1 kernel: PCI host bridge to bus 0000:00
Mar 06 11:22:24 daniel-tablet1 kernel: pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
Mar 06 11:22:24 daniel-tablet1 kernel: pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
Mar 06 11:22:24 daniel-tablet1 kernel: pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000fffff window]
Mar 06 11:22:24 daniel-tablet1 kernel: pci_bus 0000:00: root bus resource [mem 0x95400000-0xdfffffff window]
Mar 06 11:22:24 daniel-tablet1 kernel: pci_bus 0000:00: root bus resource [mem 0x4000000000-0x7fffffffff window]
Mar 06 11:22:24 daniel-tablet1 kernel: pci_bus 0000:00: root bus resource [bus 00-fe]
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:00.0: [8086:8a12] type 00 class 0x060000 conventional PCI endpoint
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:02.0: [8086:8a52] type 00 class 0x030000 PCIe Root Complex Integrated Endpoint
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:02.0: BAR 0 [mem 0x6001000000-0x6001ffffff 64bit]
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:02.0: BAR 2 [mem 0x4000000000-0x400fffffff 64bit pref]
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:02.0: BAR 4 [io  0x3000-0x303f]
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:02.0: DMAR: Skip IOMMU disabling for graphics
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:04.0: [8086:8a03] type 00 class 0x118000 conventional PCI endpoint
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:04.0: BAR 0 [mem 0x6002120000-0x600212ffff 64bit]
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:05.0: [8086:8a19] type 00 class 0x048000 PCIe Root Complex Integrated Endpoint
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:05.0: BAR 0 [mem 0x6000000000-0x6000ffffff 64bit]
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:0d.0: [8086:8a13] type 00 class 0x0c0330 conventional PCI endpoint
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:0d.0: BAR 0 [mem 0x6002110000-0x600211ffff 64bit]
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:0d.0: PME# supported from D3hot D3cold
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:12.0: [8086:34fc] type 00 class 0x070000 conventional PCI endpoint
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:12.0: BAR 0 [mem 0x600213a000-0x600213bfff 64bit]
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:12.0: PME# supported from D0 D3hot
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:14.0: [8086:34ed] type 00 class 0x0c0330 conventional PCI endpoint
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:14.0: BAR 0 [mem 0x6002100000-0x600210ffff 64bit]
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:14.0: PME# supported from D3hot D3cold
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:14.2: [8086:34ef] type 00 class 0x050000 conventional PCI endpoint
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:14.2: BAR 0 [mem 0x6002138000-0x6002139fff 64bit]
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:14.2: BAR 2 [mem 0x6002143000-0x6002143fff 64bit]
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:14.3: [8086:34f0] type 00 class 0x028000 PCIe Root Complex Integrated Endpoint
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:14.3: BAR 0 [mem 0x6002134000-0x6002137fff 64bit]
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:14.3: PME# supported from D0 D3hot D3cold
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:15.0: [8086:34e8] type 00 class 0x0c8000 conventional PCI endpoint
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:15.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:15.2: [8086:34ea] type 00 class 0x0c8000 conventional PCI endpoint
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:15.2: BAR 0 [mem 0x00000000-0x00000fff 64bit]
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:15.3: [8086:34eb] type 00 class 0x0c8000 conventional PCI endpoint
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:15.3: BAR 0 [mem 0x00000000-0x00000fff 64bit]
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:16.0: [8086:34e0] type 00 class 0x078000 conventional PCI endpoint
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:16.0: BAR 0 [mem 0x600213f000-0x600213ffff 64bit]
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:16.0: PME# supported from D3hot
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:16.4: [8086:34e4] type 00 class 0x078000 conventional PCI endpoint
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:16.4: BAR 0 [mem 0x600213e000-0x600213efff 64bit]
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:16.4: DMAR: Disabling IOMMU for IPTS
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:16.4: PME# supported from D3hot
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:19.0: [8086:34c5] type 00 class 0x0c8000 conventional PCI endpoint
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:19.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:1d.0: [8086:34b0] type 01 class 0x060400 PCIe Root Port
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:1d.0: PCI bridge to [bus 01]
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:1d.0:   bridge window [mem 0x95400000-0x954fffff]
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:1d.0: PTM enabled (root), 4ns granularity
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:1e.0: [8086:34a8] type 00 class 0x078000 conventional PCI endpoint
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:1e.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:1f.0: [8086:3482] type 00 class 0x060100 conventional PCI endpoint
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:1f.3: [8086:34c8] type 00 class 0x040380 conventional PCI endpoint
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:1f.3: BAR 0 [mem 0x6002130000-0x6002133fff 64bit]
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:1f.3: BAR 4 [mem 0x6002000000-0x60020fffff 64bit]
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:1f.3: PME# supported from D3hot D3cold
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:1f.5: [8086:34a4] type 00 class 0x0c8000 conventional PCI endpoint
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:01:00.0: [1c5c:1327] type 00 class 0x010802 PCIe Endpoint
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:01:00.0: BAR 0 [mem 0x95400000-0x95403fff 64bit]
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:01:00.0: supports D1
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:01:00.0: PME# supported from D0 D1 D3hot
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:1d.0: PCI bridge to [bus 01]
Mar 06 11:22:24 daniel-tablet1 kernel: Low-power S0 idle used by default for system suspend
Mar 06 11:22:24 daniel-tablet1 kernel: iommu: Default domain type: Translated
Mar 06 11:22:24 daniel-tablet1 kernel: iommu: DMA domain TLB invalidation policy: lazy mode
Mar 06 11:22:24 daniel-tablet1 kernel: SCSI subsystem initialized
Mar 06 11:22:24 daniel-tablet1 kernel: libata version 3.00 loaded.
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: bus type USB registered
Mar 06 11:22:24 daniel-tablet1 kernel: usbcore: registered new interface driver usbfs
Mar 06 11:22:24 daniel-tablet1 kernel: usbcore: registered new interface driver hub
Mar 06 11:22:24 daniel-tablet1 kernel: usbcore: registered new device driver usb
Mar 06 11:22:24 daniel-tablet1 kernel: pps_core: LinuxPPS API ver. 1 registered
Mar 06 11:22:24 daniel-tablet1 kernel: pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
Mar 06 11:22:24 daniel-tablet1 kernel: PTP clock support registered
Mar 06 11:22:24 daniel-tablet1 kernel: EDAC MC: Ver: 3.0.0
Mar 06 11:22:24 daniel-tablet1 kernel: efivars: Registered efivars operations
Mar 06 11:22:24 daniel-tablet1 kernel: NetLabel: Initializing
Mar 06 11:22:24 daniel-tablet1 kernel: NetLabel:  domain hash size = 128
Mar 06 11:22:24 daniel-tablet1 kernel: NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
Mar 06 11:22:24 daniel-tablet1 kernel: NetLabel:  unlabeled traffic allowed by default
Mar 06 11:22:24 daniel-tablet1 kernel: mctp: management component transport protocol core
Mar 06 11:22:24 daniel-tablet1 kernel: NET: Registered PF_MCTP protocol family
Mar 06 11:22:24 daniel-tablet1 kernel: PCI: Using ACPI for IRQ routing
Mar 06 11:22:24 daniel-tablet1 kernel: PCI: pci_cache_line_size set to 64 bytes
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]: can't claim; no compatible bridge window
Mar 06 11:22:24 daniel-tablet1 kernel: e820: reserve RAM buffer [mem 0x77095000-0x77ffffff]
Mar 06 11:22:24 daniel-tablet1 kernel: e820: reserve RAM buffer [mem 0x775f5000-0x77ffffff]
Mar 06 11:22:24 daniel-tablet1 kernel: e820: reserve RAM buffer [mem 0x78de5000-0x7bffffff]
Mar 06 11:22:24 daniel-tablet1 kernel: e820: reserve RAM buffer [mem 0x79cc0000-0x7bffffff]
Mar 06 11:22:24 daniel-tablet1 kernel: e820: reserve RAM buffer [mem 0x79cc2000-0x7bffffff]
Mar 06 11:22:24 daniel-tablet1 kernel: e820: reserve RAM buffer [mem 0x7b62c000-0x7bffffff]
Mar 06 11:22:24 daniel-tablet1 kernel: e820: reserve RAM buffer [mem 0x7ba46000-0x7bffffff]
Mar 06 11:22:24 daniel-tablet1 kernel: e820: reserve RAM buffer [mem 0x7bc00000-0x7bffffff]
Mar 06 11:22:24 daniel-tablet1 kernel: e820: reserve RAM buffer [mem 0x46ac00000-0x46bffffff]
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:02.0: vgaarb: setting as boot VGA device
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:02.0: vgaarb: bridge control possible
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
Mar 06 11:22:24 daniel-tablet1 kernel: vgaarb: loaded
Mar 06 11:22:24 daniel-tablet1 kernel: Monitor-Mwait will be used to enter C-1 state
Mar 06 11:22:24 daniel-tablet1 kernel: Monitor-Mwait will be used to enter C-2 state
Mar 06 11:22:24 daniel-tablet1 kernel: Monitor-Mwait will be used to enter C-3 state
Mar 06 11:22:24 daniel-tablet1 kernel: clocksource: Switched to clocksource tsc-early
Mar 06 11:22:24 daniel-tablet1 kernel: VFS: Disk quotas dquot_6.6.0
Mar 06 11:22:24 daniel-tablet1 kernel: VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Mar 06 11:22:24 daniel-tablet1 kernel: AppArmor: AppArmor Filesystem Enabled
Mar 06 11:22:24 daniel-tablet1 kernel: pnp: PnP ACPI init
Mar 06 11:22:24 daniel-tablet1 kernel: system 00:00: [io  0x0680-0x069f] has been reserved
Mar 06 11:22:24 daniel-tablet1 kernel: system 00:00: [io  0x164e-0x164f] has been reserved
Mar 06 11:22:24 daniel-tablet1 kernel: system 00:02: [mem 0xfed10000-0xfed17fff] has been reserved
Mar 06 11:22:24 daniel-tablet1 kernel: system 00:02: [mem 0xfeda0000-0xfeda0fff] has been reserved
Mar 06 11:22:24 daniel-tablet1 kernel: system 00:02: [mem 0xfeda1000-0xfeda1fff] has been reserved
Mar 06 11:22:24 daniel-tablet1 kernel: system 00:02: [mem 0xe0000000-0xefffffff] has been reserved
Mar 06 11:22:24 daniel-tablet1 kernel: system 00:02: [mem 0xfed20000-0xfed7ffff] could not be reserved
Mar 06 11:22:24 daniel-tablet1 kernel: system 00:02: [mem 0xfed90000-0xfed93fff] could not be reserved
Mar 06 11:22:24 daniel-tablet1 kernel: system 00:02: [mem 0xfee00000-0xfeefffff] has been reserved
Mar 06 11:22:24 daniel-tablet1 kernel: system 00:03: [io  0x1800-0x18fe] could not be reserved
Mar 06 11:22:24 daniel-tablet1 kernel: system 00:03: [mem 0xfd000000-0xfd68ffff] has been reserved
Mar 06 11:22:24 daniel-tablet1 kernel: system 00:03: [mem 0xfd6b0000-0xfd6cffff] has been reserved
Mar 06 11:22:24 daniel-tablet1 kernel: system 00:03: [mem 0xfd6f0000-0xfdffffff] has been reserved
Mar 06 11:22:24 daniel-tablet1 kernel: system 00:03: [mem 0xfe000000-0xfe01ffff] could not be reserved
Mar 06 11:22:24 daniel-tablet1 kernel: system 00:03: [mem 0xfe200000-0xfe7fffff] has been reserved
Mar 06 11:22:24 daniel-tablet1 kernel: system 00:03: [mem 0xff000000-0xffffffff] has been reserved
Mar 06 11:22:24 daniel-tablet1 kernel: system 00:04: [io  0x2000-0x20fe] has been reserved
Mar 06 11:22:24 daniel-tablet1 kernel: system 00:05: [mem 0xfe038000-0xfe038fff] has been reserved
Mar 06 11:22:24 daniel-tablet1 kernel: pnp: PnP ACPI: found 6 devices
Mar 06 11:22:24 daniel-tablet1 kernel: clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
Mar 06 11:22:24 daniel-tablet1 kernel: NET: Registered PF_INET protocol family
Mar 06 11:22:24 daniel-tablet1 kernel: IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
Mar 06 11:22:24 daniel-tablet1 kernel: tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
Mar 06 11:22:24 daniel-tablet1 kernel: Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
Mar 06 11:22:24 daniel-tablet1 kernel: TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
Mar 06 11:22:24 daniel-tablet1 kernel: TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
Mar 06 11:22:24 daniel-tablet1 kernel: TCP: Hash tables configured (established 131072 bind 65536)
Mar 06 11:22:24 daniel-tablet1 kernel: MPTCP token hash table entries: 16384 (order: 7, 393216 bytes, linear)
Mar 06 11:22:24 daniel-tablet1 kernel: UDP hash table entries: 8192 (order: 7, 524288 bytes, linear)
Mar 06 11:22:24 daniel-tablet1 kernel: UDP-Lite hash table entries: 8192 (order: 7, 524288 bytes, linear)
Mar 06 11:22:24 daniel-tablet1 kernel: NET: Registered PF_UNIX/PF_LOCAL protocol family
Mar 06 11:22:24 daniel-tablet1 kernel: NET: Registered PF_XDP protocol family
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:15.0: BAR 0 [mem 0x4010000000-0x4010000fff 64bit]: assigned
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:15.2: BAR 0 [mem 0x4010001000-0x4010001fff 64bit]: assigned
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:15.3: BAR 0 [mem 0x4010002000-0x4010002fff 64bit]: assigned
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:19.0: BAR 0 [mem 0x4010003000-0x4010003fff 64bit]: assigned
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:1e.0: BAR 0 [mem 0x4010004000-0x4010004fff 64bit]: assigned
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:1f.5: BAR 0 [mem 0x95500000-0x95500fff]: assigned
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:1d.0: PCI bridge to [bus 01]
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:1d.0:   bridge window [mem 0x95400000-0x954fffff]
Mar 06 11:22:24 daniel-tablet1 kernel: pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
Mar 06 11:22:24 daniel-tablet1 kernel: pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
Mar 06 11:22:24 daniel-tablet1 kernel: pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000fffff window]
Mar 06 11:22:24 daniel-tablet1 kernel: pci_bus 0000:00: resource 7 [mem 0x95400000-0xdfffffff window]
Mar 06 11:22:24 daniel-tablet1 kernel: pci_bus 0000:00: resource 8 [mem 0x4000000000-0x7fffffffff window]
Mar 06 11:22:24 daniel-tablet1 kernel: pci_bus 0000:01: resource 1 [mem 0x95400000-0x954fffff]
Mar 06 11:22:24 daniel-tablet1 kernel: PCI: CLS 0 bytes, default 64
Mar 06 11:22:24 daniel-tablet1 kernel: DMAR: No ATSR found
Mar 06 11:22:24 daniel-tablet1 kernel: DMAR: No SATC found
Mar 06 11:22:24 daniel-tablet1 kernel: DMAR: dmar1: Using Queued invalidation
Mar 06 11:22:24 daniel-tablet1 kernel: DMAR: dmar0: Using Queued invalidation
Mar 06 11:22:24 daniel-tablet1 kernel: DMAR: dmar2: Using Queued invalidation
Mar 06 11:22:24 daniel-tablet1 kernel: Trying to unpack rootfs image as initramfs...
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:05.0: Adding to iommu group 0
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:02.0: Adding to iommu group 1
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:00.0: Adding to iommu group 2
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:04.0: Adding to iommu group 3
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:0d.0: Adding to iommu group 4
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:12.0: Adding to iommu group 5
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:14.0: Adding to iommu group 6
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:14.2: Adding to iommu group 6
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:14.3: Adding to iommu group 7
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:15.0: Adding to iommu group 8
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:15.2: Adding to iommu group 8
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:15.3: Adding to iommu group 8
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:16.0: Adding to iommu group 9
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:16.4: Adding to iommu group 9
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:19.0: Adding to iommu group 10
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:1d.0: Adding to iommu group 11
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:1e.0: Adding to iommu group 12
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:1f.0: Adding to iommu group 13
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:1f.3: Adding to iommu group 13
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:00:1f.5: Adding to iommu group 13
Mar 06 11:22:24 daniel-tablet1 kernel: pci 0000:01:00.0: Adding to iommu group 14
Mar 06 11:22:24 daniel-tablet1 kernel: DMAR: Intel(R) Virtualization Technology for Directed I/O
Mar 06 11:22:24 daniel-tablet1 kernel: PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Mar 06 11:22:24 daniel-tablet1 kernel: software IO TLB: mapped [mem 0x0000000073095000-0x0000000077095000] (64MB)
Mar 06 11:22:24 daniel-tablet1 kernel: clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x159647815e3, max_idle_ns: 440795269835 ns
Mar 06 11:22:24 daniel-tablet1 kernel: clocksource: Switched to clocksource tsc
Mar 06 11:22:24 daniel-tablet1 kernel: Initialise system trusted keyrings
Mar 06 11:22:24 daniel-tablet1 kernel: Key type blacklist registered
Mar 06 11:22:24 daniel-tablet1 kernel: workingset: timestamp_bits=36 max_order=22 bucket_order=0
Mar 06 11:22:24 daniel-tablet1 kernel: squashfs: version 4.0 (2009/01/31) Phillip Lougher
Mar 06 11:22:24 daniel-tablet1 kernel: fuse: init (API version 7.45)
Mar 06 11:22:24 daniel-tablet1 kernel: integrity: Platform Keyring initialized
Mar 06 11:22:24 daniel-tablet1 kernel: integrity: Machine keyring initialized
Mar 06 11:22:24 daniel-tablet1 kernel: Key type asymmetric registered
Mar 06 11:22:24 daniel-tablet1 kernel: Asymmetric key parser 'x509' registered
Mar 06 11:22:24 daniel-tablet1 kernel: Block layer SCSI generic (bsg) driver version 0.4 loaded (major 242)
Mar 06 11:22:24 daniel-tablet1 kernel: io scheduler mq-deadline registered
Mar 06 11:22:24 daniel-tablet1 kernel: ledtrig-cpu: registered to indicate activity on CPUs
Mar 06 11:22:24 daniel-tablet1 kernel: pcieport 0000:00:1d.0: PME: Signaling with IRQ 124
Mar 06 11:22:24 daniel-tablet1 kernel: input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: button: Lid Switch [LID0]
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: thermal: [Firmware Bug]: No valid trip points!
Mar 06 11:22:24 daniel-tablet1 kernel: thermal LNXTHERM:00: registered as thermal_zone0
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: thermal: Thermal Zone [TZ01] (27 C)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: thermal: [Firmware Bug]: No valid trip points!
Mar 06 11:22:24 daniel-tablet1 kernel: thermal LNXTHERM:01: registered as thermal_zone1
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: thermal: Thermal Zone [TZ02] (27 C)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: thermal: [Firmware Bug]: No valid trip points!
Mar 06 11:22:24 daniel-tablet1 kernel: thermal LNXTHERM:02: registered as thermal_zone2
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: thermal: Thermal Zone [TZ03] (27 C)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: thermal: [Firmware Bug]: No valid trip points!
Mar 06 11:22:24 daniel-tablet1 kernel: thermal LNXTHERM:03: registered as thermal_zone3
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: thermal: Thermal Zone [TZ04] (27 C)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: thermal: [Firmware Bug]: No valid trip points!
Mar 06 11:22:24 daniel-tablet1 kernel: thermal LNXTHERM:04: registered as thermal_zone4
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: thermal: Thermal Zone [TZ05] (27 C)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: thermal: [Firmware Bug]: No valid trip points!
Mar 06 11:22:24 daniel-tablet1 kernel: thermal LNXTHERM:05: registered as thermal_zone5
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: thermal: Thermal Zone [TZ06] (27 C)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: thermal: [Firmware Bug]: No valid trip points!
Mar 06 11:22:24 daniel-tablet1 kernel: thermal LNXTHERM:06: registered as thermal_zone6
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: thermal: Thermal Zone [TZ07] (27 C)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: thermal: [Firmware Bug]: No valid trip points!
Mar 06 11:22:24 daniel-tablet1 kernel: thermal LNXTHERM:07: registered as thermal_zone7
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: thermal: Thermal Zone [TZ08] (27 C)
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: thermal: [Firmware Bug]: No valid trip points!
Mar 06 11:22:24 daniel-tablet1 kernel: thermal LNXTHERM:08: registered as thermal_zone8
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: thermal: Thermal Zone [TZ09] (27 C)
Mar 06 11:22:24 daniel-tablet1 kernel: Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
Mar 06 11:22:24 daniel-tablet1 kernel: serial 0000:00:12.0: enabling device (0000 -> 0002)
Mar 06 11:22:24 daniel-tablet1 kernel: hpet_acpi_add: no address or irqs in _CRS
Mar 06 11:22:24 daniel-tablet1 kernel: Linux agpgart interface v0.103
Mar 06 11:22:24 daniel-tablet1 kernel: ACPI: bus type drm_connector registered
Mar 06 11:22:24 daniel-tablet1 kernel: loop: module loaded
Mar 06 11:22:24 daniel-tablet1 kernel: tun: Universal TUN/TAP device driver, 1.6
Mar 06 11:22:24 daniel-tablet1 kernel: PPP generic driver version 2.4.2
Mar 06 11:22:24 daniel-tablet1 kernel: xhci_hcd 0000:00:0d.0: xHCI Host Controller
Mar 06 11:22:24 daniel-tablet1 kernel: xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 1
Mar 06 11:22:24 daniel-tablet1 kernel: xhci_hcd 0000:00:0d.0: hcc params 0x20007fc1 hci version 0x110 quirks 0x0000000200009810
Mar 06 11:22:24 daniel-tablet1 kernel: xhci_hcd 0000:00:0d.0: xHCI Host Controller
Mar 06 11:22:24 daniel-tablet1 kernel: xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 2
Mar 06 11:22:24 daniel-tablet1 kernel: xhci_hcd 0000:00:0d.0: Host supports USB 3.1 Enhanced SuperSpeed
Mar 06 11:22:24 daniel-tablet1 kernel: usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.18
Mar 06 11:22:24 daniel-tablet1 kernel: usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Mar 06 11:22:24 daniel-tablet1 kernel: usb usb1: Product: xHCI Host Controller
Mar 06 11:22:24 daniel-tablet1 kernel: usb usb1: Manufacturer: Linux 6.18.7-surface-1 xhci-hcd
Mar 06 11:22:24 daniel-tablet1 kernel: usb usb1: SerialNumber: 0000:00:0d.0
Mar 06 11:22:24 daniel-tablet1 kernel: hub 1-0:1.0: USB hub found
Mar 06 11:22:24 daniel-tablet1 kernel: hub 1-0:1.0: 1 port detected
Mar 06 11:22:24 daniel-tablet1 kernel: usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.18
Mar 06 11:22:24 daniel-tablet1 kernel: usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Mar 06 11:22:24 daniel-tablet1 kernel: usb usb2: Product: xHCI Host Controller
Mar 06 11:22:24 daniel-tablet1 kernel: usb usb2: Manufacturer: Linux 6.18.7-surface-1 xhci-hcd
Mar 06 11:22:24 daniel-tablet1 kernel: usb usb2: SerialNumber: 0000:00:0d.0
Mar 06 11:22:24 daniel-tablet1 kernel: hub 2-0:1.0: USB hub found
Mar 06 11:22:24 daniel-tablet1 kernel: hub 2-0:1.0: 4 ports detected
Mar 06 11:22:24 daniel-tablet1 kernel: xhci_hcd 0000:00:14.0: xHCI Host Controller
Mar 06 11:22:24 daniel-tablet1 kernel: xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 3
Mar 06 11:22:24 daniel-tablet1 kernel: xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci version 0x110 quirks 0x0000000000009810
Mar 06 11:22:24 daniel-tablet1 kernel: xhci_hcd 0000:00:14.0: xHCI Host Controller
Mar 06 11:22:24 daniel-tablet1 kernel: xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 4
Mar 06 11:22:24 daniel-tablet1 kernel: xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperSpeed
Mar 06 11:22:24 daniel-tablet1 kernel: usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.18
Mar 06 11:22:24 daniel-tablet1 kernel: usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Mar 06 11:22:24 daniel-tablet1 kernel: usb usb3: Product: xHCI Host Controller
Mar 06 11:22:24 daniel-tablet1 kernel: usb usb3: Manufacturer: Linux 6.18.7-surface-1 xhci-hcd
Mar 06 11:22:24 daniel-tablet1 kernel: usb usb3: SerialNumber: 0000:00:14.0
Mar 06 11:22:24 daniel-tablet1 kernel: hub 3-0:1.0: USB hub found
Mar 06 11:22:24 daniel-tablet1 kernel: hub 3-0:1.0: 12 ports detected
Mar 06 11:22:24 daniel-tablet1 kernel: usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.18
Mar 06 11:22:24 daniel-tablet1 kernel: usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Mar 06 11:22:24 daniel-tablet1 kernel: usb usb4: Product: xHCI Host Controller
Mar 06 11:22:24 daniel-tablet1 kernel: usb usb4: Manufacturer: Linux 6.18.7-surface-1 xhci-hcd
Mar 06 11:22:24 daniel-tablet1 kernel: usb usb4: SerialNumber: 0000:00:14.0
Mar 06 11:22:24 daniel-tablet1 kernel: hub 4-0:1.0: USB hub found
Mar 06 11:22:24 daniel-tablet1 kernel: hub 4-0:1.0: 6 ports detected
Mar 06 11:22:24 daniel-tablet1 kernel: i8042: PNP: No PS/2 controller found.
Mar 06 11:22:24 daniel-tablet1 kernel: mousedev: PS/2 mouse device common for all mice
Mar 06 11:22:24 daniel-tablet1 kernel: rtc_cmos 00:01: RTC can wake from S4
Mar 06 11:22:24 daniel-tablet1 kernel: rtc_cmos 00:01: registered as rtc0
Mar 06 11:22:24 daniel-tablet1 kernel: rtc_cmos 00:01: setting system clock to 2026-03-06T16:22:21 UTC (1772814141)
Mar 06 11:22:24 daniel-tablet1 kernel: rtc_cmos 00:01: alarms up to one month, y3k, 242 bytes nvram
Mar 06 11:22:24 daniel-tablet1 kernel: i2c_dev: i2c /dev entries driver
Mar 06 11:22:24 daniel-tablet1 kernel: device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
Mar 06 11:22:24 daniel-tablet1 kernel: device-mapper: uevent: version 1.0.3
Mar 06 11:22:24 daniel-tablet1 kernel: device-mapper: ioctl: 4.50.0-ioctl (2025-04-28) initialised: dm-devel@lists.linux.dev
Mar 06 11:22:24 daniel-tablet1 kernel: intel_pstate: Intel P-state driver initializing
Mar 06 11:22:24 daniel-tablet1 kernel: intel_pstate: HWP enabled
Mar 06 11:22:24 daniel-tablet1 kernel: simple-framebuffer simple-framebuffer.0: [drm] Registered 1 planes with drm panic
Mar 06 11:22:24 daniel-tablet1 kernel: [drm] Initialized simpledrm 1.0.0 for simple-framebuffer.0 on minor 0
Mar 06 11:22:24 daniel-tablet1 kernel: fbcon: Deferring console take-over
Mar 06 11:22:24 daniel-tablet1 kernel: simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledrmdrmfb frame buffer device
Mar 06 11:22:24 daniel-tablet1 kernel: drop_monitor: Initializing network drop monitor service
Mar 06 11:22:24 daniel-tablet1 kernel: NET: Registered PF_INET6 protocol family
Mar 06 11:22:24 daniel-tablet1 kernel: Segment Routing with IPv6
Mar 06 11:22:24 daniel-tablet1 kernel: In-situ OAM (IOAM) with IPv6
Mar 06 11:22:24 daniel-tablet1 kernel: NET: Registered PF_PACKET protocol family
Mar 06 11:22:24 daniel-tablet1 kernel: Key type dns_resolver registered
Mar 06 11:22:24 daniel-tablet1 kernel: ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
Mar 06 11:22:24 daniel-tablet1 kernel: microcode: Current revision: 0x000000ca
Mar 06 11:22:24 daniel-tablet1 kernel: microcode: Updated early from: 0x000000c6
Mar 06 11:22:24 daniel-tablet1 kernel: IPI shorthand broadcast: enabled
Mar 06 11:22:24 daniel-tablet1 kernel: sched_clock: Marking stable (557000897, 7522984)->(636246354, -71722473)
Mar 06 11:22:24 daniel-tablet1 kernel: registered taskstats version 1
Mar 06 11:22:24 daniel-tablet1 kernel: Loading compiled-in X.509 certificates
Mar 06 11:22:24 daniel-tablet1 kernel: Loaded X.509 cert 'Build time autogenerated kernel key: 48f65da3e1ba40b8962cdc3b181bebcc065f2fe1'
Mar 06 11:22:24 daniel-tablet1 kernel: Demotion targets for Node 0: null
Mar 06 11:22:24 daniel-tablet1 kernel: Key type .fscrypt registered
Mar 06 11:22:24 daniel-tablet1 kernel: Key type fscrypt-provisioning registered
Mar 06 11:22:24 daniel-tablet1 kernel: Key type big_key registered
Mar 06 11:22:24 daniel-tablet1 kernel: Key type trusted registered
Mar 06 11:22:24 daniel-tablet1 kernel: Freeing initrd memory: 80528K
Mar 06 11:22:24 daniel-tablet1 kernel: Key type encrypted registered
Mar 06 11:22:24 daniel-tablet1 kernel: AppArmor: AppArmor sha256 policy hashing enabled
Mar 06 11:22:24 daniel-tablet1 kernel: integrity: Loading X.509 certificate: UEFI:db
Mar 06 11:22:24 daniel-tablet1 kernel: integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
Mar 06 11:22:24 daniel-tablet1 kernel: integrity: Loading X.509 certificate: UEFI:db
Mar 06 11:22:24 daniel-tablet1 kernel: integrity: Loaded X.509 cert 'Microsoft Corporation: Windows UEFI CA 2023: aefc5fbbbe055d8f8daa585473499417ab5a5272'
Mar 06 11:22:24 daniel-tablet1 kernel: integrity: Loading X.509 certificate: UEFI:db
Mar 06 11:22:24 daniel-tablet1 kernel: integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
Mar 06 11:22:24 daniel-tablet1 kernel: integrity: Loading X.509 certificate: UEFI:db
Mar 06 11:22:24 daniel-tablet1 kernel: integrity: Loaded X.509 cert 'Microsoft UEFI CA 2023: 81aa6b3244c935bce0d6628af39827421e32497d'
Mar 06 11:22:24 daniel-tablet1 kernel: blacklist: Duplicate blacklisted hash bin:c452ab846073df5ace25cca64d6b7a09d906308a1a65eb5240e3c4ebcaa9cc0c
Mar 06 11:22:24 daniel-tablet1 kernel: blacklist: Duplicate blacklisted hash bin:47ff1b63b140b6fc04ed79131331e651da5b2e2f170f5daef4153dc2fbc532b1
Mar 06 11:22:24 daniel-tablet1 kernel: integrity: Loading X.509 certificate: UEFI:MokListRT (MOKvar table)
Mar 06 11:22:24 daniel-tablet1 kernel: integrity: Loaded X.509 cert 'Canonical Ltd. Master Certificate Authority: ad91990bc22ab1f517048c23b6655a268e345a63'
Mar 06 11:22:24 daniel-tablet1 kernel: integrity: Loading X.509 certificate: UEFI:MokListRT (MOKvar table)
Mar 06 11:22:24 daniel-tablet1 kernel: integrity: Loaded X.509 cert 'Default Company Ltd: linux-surface: 24ef5c444499ba0aa6f2a8bea4258f065fea4ec6'
Mar 06 11:22:24 daniel-tablet1 kernel: integrity: Loading X.509 certificate: UEFI:MokListRT (MOKvar table)
Mar 06 11:22:24 daniel-tablet1 kernel: integrity: Loaded X.509 cert 'daniel-tablet1 Secure Boot Module Signature key: acf364063669bbb41a0f75bb4970bd70ac30e272'
Mar 06 11:22:24 daniel-tablet1 kernel: Loading compiled-in module X.509 certificates
Mar 06 11:22:24 daniel-tablet1 kernel: Loaded X.509 cert 'Build time autogenerated kernel key: 48f65da3e1ba40b8962cdc3b181bebcc065f2fe1'
Mar 06 11:22:24 daniel-tablet1 kernel: ima: Allocated hash algorithm: sha256
Mar 06 11:22:24 daniel-tablet1 kernel: evm: Initialising EVM extended attributes:
Mar 06 11:22:24 daniel-tablet1 kernel: evm: security.selinux
Mar 06 11:22:24 daniel-tablet1 kernel: evm: security.SMACK64
Mar 06 11:22:24 daniel-tablet1 kernel: evm: security.SMACK64EXEC
Mar 06 11:22:24 daniel-tablet1 kernel: evm: security.SMACK64TRANSMUTE
Mar 06 11:22:24 daniel-tablet1 kernel: evm: security.SMACK64MMAP
Mar 06 11:22:24 daniel-tablet1 kernel: evm: security.apparmor
Mar 06 11:22:24 daniel-tablet1 kernel: evm: security.ima
Mar 06 11:22:24 daniel-tablet1 kernel: evm: security.capability
Mar 06 11:22:24 daniel-tablet1 kernel: evm: HMAC attrs: 0x1
Mar 06 11:22:24 daniel-tablet1 kernel: audit: type=1807 audit(1772814141.724:2): action=measure func=KEXEC_KERNEL_CHECK res=1
Mar 06 11:22:24 daniel-tablet1 kernel: audit: type=1807 audit(1772814141.724:3): action=measure func=MODULE_CHECK res=1
Mar 06 11:22:24 daniel-tablet1 kernel: PM:   Magic number: 2:950:387
Mar 06 11:22:24 daniel-tablet1 kernel: thermal cooling_device2: hash matches
Mar 06 11:22:24 daniel-tablet1 kernel: RAS: Correctable Errors collector initialized.
Mar 06 11:22:24 daniel-tablet1 kernel: clk: Disabling unused clocks
Mar 06 11:22:24 daniel-tablet1 kernel: PM: genpd: Disabling unused power domains
Mar 06 11:22:24 daniel-tablet1 kernel: usb 3-8: new full-speed USB device number 2 using xhci_hcd
Mar 06 11:22:24 daniel-tablet1 kernel: Freeing unused decrypted memory: 2028K
Mar 06 11:22:24 daniel-tablet1 kernel: Freeing unused kernel image (initmem) memory: 5000K
Mar 06 11:22:24 daniel-tablet1 kernel: Write protecting the kernel read-only data: 32768k
Mar 06 11:22:24 daniel-tablet1 kernel: Freeing unused kernel image (text/rodata gap) memory: 1988K
Mar 06 11:22:24 daniel-tablet1 kernel: Freeing unused kernel image (rodata/data gap) memory: 1624K
Mar 06 11:22:24 daniel-tablet1 kernel: x86/mm: Checked W+X mappings: passed, no W+X pages found.
Mar 06 11:22:24 daniel-tablet1 kernel: Run /init as init process
Mar 06 11:22:24 daniel-tablet1 kernel:   with arguments:
Mar 06 11:22:24 daniel-tablet1 kernel:     /init
Mar 06 11:22:24 daniel-tablet1 kernel:     splash
Mar 06 11:22:24 daniel-tablet1 kernel:   with environment:
Mar 06 11:22:24 daniel-tablet1 kernel:     HOME=/
Mar 06 11:22:24 daniel-tablet1 kernel:     TERM=linux
Mar 06 11:22:24 daniel-tablet1 kernel: usb 3-8: New USB device found, idVendor=045e, idProduct=09c0, bcdDevice= 0.07
Mar 06 11:22:24 daniel-tablet1 kernel: usb 3-8: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Mar 06 11:22:24 daniel-tablet1 kernel: usb 3-8: Product: Surface Type Cover
Mar 06 11:22:24 daniel-tablet1 kernel: usb 3-8: Manufacturer: Microsoft
Mar 06 11:22:24 daniel-tablet1 kernel: intel_oc_wdt INT3F0D:00: probe with driver intel_oc_wdt failed with error -13
Mar 06 11:22:24 daniel-tablet1 kernel: intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
Mar 06 11:22:24 daniel-tablet1 kernel: idma64 idma64.0: Found Intel integrated DMA 64-bit
Mar 06 11:22:24 daniel-tablet1 kernel: intel-lpss 0000:00:15.2: enabling device (0000 -> 0002)
Mar 06 11:22:24 daniel-tablet1 kernel: idma64 idma64.1: Found Intel integrated DMA 64-bit
Mar 06 11:22:24 daniel-tablet1 kernel: Key type psk registered
Mar 06 11:22:24 daniel-tablet1 kernel: intel-lpss 0000:00:15.3: enabling device (0000 -> 0002)
Mar 06 11:22:24 daniel-tablet1 kernel: idma64 idma64.2: Found Intel integrated DMA 64-bit
Mar 06 11:22:24 daniel-tablet1 kernel: input: gpio-keys as /devices/platform/MSHW0040:00/gpio-keys.1.auto/input/input1
Mar 06 11:22:24 daniel-tablet1 kernel: input: gpio-keys as /devices/platform/MSHW0040:00/gpio-keys.2.auto/input/input2
Mar 06 11:22:24 daniel-tablet1 kernel: intel-lpss 0000:00:19.0: enabling device (0000 -> 0002)
Mar 06 11:22:24 daniel-tablet1 kernel: intel-lpss 0000:00:1e.0: enabling device (0000 -> 0002)
Mar 06 11:22:24 daniel-tablet1 kernel: idma64 idma64.4: Found Intel integrated DMA 64-bit
Mar 06 11:22:24 daniel-tablet1 kernel: nvme nvme0: pci function 0000:01:00.0
Mar 06 11:22:24 daniel-tablet1 kernel: nvme nvme0: missing or invalid SUBNQN field.
Mar 06 11:22:24 daniel-tablet1 kernel: nvme nvme0: 8/0/0 default/read/poll queues
Mar 06 11:22:24 daniel-tablet1 kernel:  nvme0n1: p1 p2 p3 p4 p5 p6 p7 p8 p9
Mar 06 11:22:24 daniel-tablet1 kernel: dw-apb-uart.4: ttyS4 at MMIO 0x4010004000 (irq = 20, base_baud = 7500000) is a 16550A
Mar 06 11:22:24 daniel-tablet1 kernel: serial serial0: tty port ttyS4 registered
Mar 06 11:22:24 daniel-tablet1 kernel: surface_serial_hub serial0-0: SAM firmware version: 14.800.139
Mar 06 11:22:24 daniel-tablet1 kernel: usb 3-10: new full-speed USB device number 3 using xhci_hcd
Mar 06 11:22:24 daniel-tablet1 kernel: usb 3-10: New USB device found, idVendor=8087, idProduct=0026, bcdDevice= 0.02
Mar 06 11:22:24 daniel-tablet1 kernel: usb 3-10: New USB device strings: Mfr=0, Product=0, SerialNumber=0
Mar 06 11:22:24 daniel-tablet1 kernel: hid: raw HID events driver (C) Jiri Kosina
Mar 06 11:22:24 daniel-tablet1 kernel: usbcore: registered new interface driver usbhid
Mar 06 11:22:24 daniel-tablet1 kernel: usbhid: USB HID core driver
Mar 06 11:22:24 daniel-tablet1 kernel: input: Microsoft Surface Type Cover Keyboard as /devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:045E:09C0.0001/input/input3
Mar 06 11:22:24 daniel-tablet1 kernel: input: Microsoft Surface Type Cover Mouse as /devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:045E:09C0.0001/input/input4
Mar 06 11:22:24 daniel-tablet1 kernel: input: Microsoft Surface Type Cover as /devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:045E:09C0.0001/input/input5
Mar 06 11:22:24 daniel-tablet1 kernel: input: Microsoft Surface Type Cover Touchpad as /devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:045E:09C0.0001/input/input6
Mar 06 11:22:24 daniel-tablet1 kernel: input: Microsoft Surface Type Cover as /devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:045E:09C0.0001/input/input7
Mar 06 11:22:24 daniel-tablet1 kernel: input: Microsoft Surface Type Cover as /devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:045E:09C0.0001/input/input8
Mar 06 11:22:24 daniel-tablet1 kernel: input: Microsoft Surface Type Cover as /devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:045E:09C0.0001/input/input9
Mar 06 11:22:24 daniel-tablet1 kernel: hid-generic 0003:045E:09C0.0001: input,hiddev0,hidraw0: USB HID v1.11 Keyboard [Microsoft Surface Type Cover] on usb-0000:00:14.0-8/input0
Mar 06 11:22:24 daniel-tablet1 kernel: input: Microsoft Surface Type Cover Keyboard as /devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:045E:09C0.0001/input/input11
Mar 06 11:22:24 daniel-tablet1 kernel: input: Microsoft Surface Type Cover Mouse as /devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:045E:09C0.0001/input/input12
Mar 06 11:22:24 daniel-tablet1 kernel: input: Microsoft Surface Type Cover Consumer Control as /devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:045E:09C0.0001/input/input13
Mar 06 11:22:24 daniel-tablet1 kernel: input: Microsoft Surface Type Cover UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:045E:09C0.0001/input/input14
Mar 06 11:22:24 daniel-tablet1 kernel: input: Microsoft Surface Type Cover Touchpad as /devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:045E:09C0.0001/input/input15
Mar 06 11:22:24 daniel-tablet1 kernel: input: Microsoft Surface Type Cover UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:045E:09C0.0001/input/input16
Mar 06 11:22:24 daniel-tablet1 kernel: input: Microsoft Surface Type Cover UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:045E:09C0.0001/input/input17
Mar 06 11:22:24 daniel-tablet1 kernel: input: Microsoft Surface Type Cover UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:045E:09C0.0001/input/input18
Mar 06 11:22:24 daniel-tablet1 kernel: input: Microsoft Surface Type Cover Tablet Mode Switch as /devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:045E:09C0.0001/input/input19
Mar 06 11:22:24 daniel-tablet1 kernel: input: Microsoft Surface Type Cover Tablet Mode Switch as /devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:045E:09C0.0001/input/input20
Mar 06 11:22:24 daniel-tablet1 kernel: input: Microsoft Surface Type Cover Tablet Mode Switch as /devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:045E:09C0.0001/input/input21
Mar 06 11:22:24 daniel-tablet1 kernel: input: Microsoft Surface Type Cover Tablet Mode Switch as /devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:045E:09C0.0001/input/input22
Mar 06 11:22:24 daniel-tablet1 kernel: input: Microsoft Surface Type Cover Tablet Mode Switch as /devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:045E:09C0.0001/input/input23
Mar 06 11:22:24 daniel-tablet1 kernel: input: Microsoft Surface Type Cover Tablet Mode Switch as /devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:045E:09C0.0001/input/input24
Mar 06 11:22:24 daniel-tablet1 kernel: input: Microsoft Surface Type Cover Tablet Mode Switch as /devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:045E:09C0.0001/input/input25
Mar 06 11:22:24 daniel-tablet1 kernel: input: Microsoft Surface Type Cover Tablet Mode Switch as /devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:045E:09C0.0001/input/input26
Mar 06 11:22:24 daniel-tablet1 kernel: input: Microsoft Surface Type Cover Tablet Mode Switch as /devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:045E:09C0.0001/input/input27
Mar 06 11:22:24 daniel-tablet1 kernel: input: Microsoft Surface Type Cover Tablet Mode Switch as /devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:045E:09C0.0001/input/input28
Mar 06 11:22:24 daniel-tablet1 kernel: hid-multitouch 0003:045E:09C0.0001: input,hiddev0,hidraw0: USB HID v1.11 Keyboard [Microsoft Surface Type Cover] on usb-0000:00:14.0-8/input0
Mar 06 11:22:24 daniel-tablet1 kernel: ish-hid {33AECD58-B679-4E54-9BD9-A04D34F0C226}: [hid-ish]: enum_devices_done OK, num_hid_devices=1
Mar 06 11:22:24 daniel-tablet1 kernel: hid-generic 001F:8087:0AC2.0002: hidraw1: SENSOR HUB HID v2.00 Device [hid-ishtp 8087:0AC2] on
Mar 06 11:22:24 daniel-tablet1 kernel: hid-sensor-hub 001F:8087:0AC2.0002: hidraw1: SENSOR HUB HID v2.00 Device [hid-ishtp 8087:0AC2] on
Mar 06 11:22:24 daniel-tablet1 kernel: EXT4-fs (nvme0n1p8): orphan cleanup on readonly fs
Mar 06 11:22:24 daniel-tablet1 kernel: EXT4-fs (nvme0n1p8): mounted filesystem 36fa67db-bdeb-4537-a4b0-4b001d623ccf ro with ordered data mode. Quota mode: none.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Inserted module 'autofs4'
Mar 06 11:22:24 daniel-tablet1 systemd[1]: systemd 257.9-0ubuntu2.1 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +IPE +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF -XKBCOMMON -UTMP +SYSVINIT +LIBARCHIVE)
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Detected architecture x86-64.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Hostname set to <daniel-tablet1>.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: bpf-restrict-fs: BPF LSM hook not enabled in the kernel, BPF LSM not supported.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Queued start job for default target graphical.target.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Created slice machine.slice - Virtual Machine and Container Slice.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Created slice system-modprobe.slice - Slice /system/modprobe.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Created slice system-systemd\x2dcryptsetup.slice - Encrypted Volume Units Service Slice.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Created slice system-systemd\x2dfsck.slice - Slice /system/systemd-fsck.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Created slice user.slice - User and Session Slice.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Started systemd-ask-password-wall.path - Forward Password Requests to Wall Directory Watch.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Set up automount proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats File System Automount Point.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Expecting device dev-disk-by\x2duuid-0ffa31a8\x2d58f7\x2d48a5\x2dae99\x2d71f40d376bd6.device - /dev/disk/by-uuid/0ffa31a8-58f7-48a5-ae99-71f40d376bd6...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Expecting device dev-disk-by\x2duuid-46916dcd\x2dc245\x2d4384\x2dbbaf\x2d2f9460979425.device - /dev/disk/by-uuid/46916dcd-c245-4384-bbaf-2f9460979425...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Expecting device dev-disk-by\x2duuid-69452394\x2d6e8e\x2d4a5b\x2d9116\x2d0a8402d66401.device - /dev/disk/by-uuid/69452394-6e8e-4a5b-9116-0a8402d66401...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Expecting device dev-disk-by\x2duuid-C4B7\x2d85E2.device - /dev/disk/by-uuid/C4B7-85E2...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Expecting device dev-disk-by\x2duuid-b36382aa\x2d72e5\x2d4584\x2d8066\x2dd8250cb1c86b.device - /dev/disk/by-uuid/b36382aa-72e5-4584-8066-d8250cb1c86b...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Expecting device dev-mapper-homecrypt.device - /dev/mapper/homecrypt...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Reached target integritysetup.target - Local Integrity Protected Volumes.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Reached target nss-user-lookup.target - User and Group Name Lookups.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Reached target remote-fs.target - Remote File Systems.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Reached target slices.target - Slice Units.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Reached target swap.target - Swaps.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Reached target veritysetup.target - Local Verity Protected Volumes.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Reached target virt-guest-shutdown.target - libvirt guests shutdown target.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Listening on dm-event.socket - Device-mapper event daemon FIFOs.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Listening on lvm2-lvmpolld.socket - LVM2 poll daemon socket.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Listening on systemd-creds.socket - Credential Encryption/Decryption.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Listening on systemd-initctl.socket - initctl Compatibility Named Pipe.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Listening on systemd-journald-dev-log.socket - Journal Socket (/dev/log).
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Listening on systemd-journald.socket - Journal Sockets.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Listening on systemd-oomd.socket - Userspace Out-Of-Memory (OOM) Killer Socket.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: systemd-pcrextend.socket - TPM PCR Measurements was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
Mar 06 11:22:24 daniel-tablet1 systemd[1]: systemd-pcrlock.socket - Make TPM PCR Policy was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Listening on systemd-udevd-control.socket - udev Control Socket.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Listening on systemd-udevd-kernel.socket - udev Kernel Socket.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Mounting dev-hugepages.mount - Huge Pages File System...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Mounting dev-mqueue.mount - POSIX Message Queue File System...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Mounting run-lock.mount - Legacy Locks Directory /run/lock...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debug File System...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Mounting sys-kernel-tracing.mount - Kernel Trace File System...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Starting systemd-journald.service - Journal Service...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Starting blk-availability.service - Availability of block devices...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Starting keyboard-setup.service - Set the console keyboard layout...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Starting kmod-static-nodes.service - Create List of Static Device Nodes...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Starting lvm2-monitor.service - Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Starting modprobe@configfs.service - Load Kernel Module configfs...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Starting modprobe@drm.service - Load Kernel Module drm...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Starting modprobe@efi_pstore.service - Load Kernel Module efi_pstore...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Starting modprobe@fuse.service - Load Kernel Module fuse...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Starting modprobe@nvme_fabrics.service - Load Kernel Module nvme_fabrics...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: systemd-fsck-root.service - File System Check on Root Device was skipped because of an unmet condition check (ConditionPathExists=!/run/initramfs/fsck-root).
Mar 06 11:22:24 daniel-tablet1 systemd[1]: systemd-hibernate-clear.service - Clear Stale Hibernate Storage Info was skipped because of an unmet condition check (ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Starting systemd-modules-load.service - Load Kernel Modules...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: systemd-pcrmachine.service - TPM PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Starting systemd-remount-fs.service - Remount Root and Kernel File Systems...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: systemd-tpm2-setup-early.service - Early TPM SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Starting systemd-udev-load-credentials.service - Load udev Rules from Credentials...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Starting systemd-udev-trigger.service - Coldplug All udev Devices...
Mar 06 11:22:24 daniel-tablet1 kernel: pstore: Using crash dump compression: deflate
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Mounted dev-hugepages.mount - Huge Pages File System.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Mounted dev-mqueue.mount - POSIX Message Queue File System.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Mounted run-lock.mount - Legacy Locks Directory /run/lock.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Mounted sys-kernel-debug.mount - Kernel Debug File System.
Mar 06 11:22:24 daniel-tablet1 kernel: pstore: Registered efi_pstore as persistent store backend
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Mounted sys-kernel-tracing.mount - Kernel Trace File System.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Finished blk-availability.service - Availability of block devices.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Finished kmod-static-nodes.service - Create List of Static Device Nodes.
Mar 06 11:22:24 daniel-tablet1 systemd-journald[335]: Collecting audit messages is disabled.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: modprobe@configfs.service: Deactivated successfully.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Finished modprobe@configfs.service - Load Kernel Module configfs.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: modprobe@drm.service: Deactivated successfully.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Finished modprobe@drm.service - Load Kernel Module drm.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: modprobe@efi_pstore.service: Deactivated successfully.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Finished modprobe@efi_pstore.service - Load Kernel Module efi_pstore.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: modprobe@fuse.service: Deactivated successfully.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Finished modprobe@fuse.service - Load Kernel Module fuse.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Mounting sys-fs-fuse-connections.mount - FUSE Control File System...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Mounting sys-kernel-config.mount - Kernel Configuration File System...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Starting systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: modprobe@nvme_fabrics.service: Deactivated successfully.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Finished modprobe@nvme_fabrics.service - Load Kernel Module nvme_fabrics.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Mounted sys-fs-fuse-connections.mount - FUSE Control File System.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Mounted sys-kernel-config.mount - Kernel Configuration File System.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Finished systemd-udev-load-credentials.service - Load udev Rules from Credentials.
Mar 06 11:22:24 daniel-tablet1 kernel: EXT4-fs (nvme0n1p8): re-mounted 36fa67db-bdeb-4537-a4b0-4b001d623ccf.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Finished systemd-remount-fs.service - Remount Root and Kernel File Systems.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: systemd-hwdb-update.service - Rebuild Hardware Database was skipped because of an unmet condition check (ConditionNeedsUpdate=/etc).
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Finished keyboard-setup.service - Set the console keyboard layout.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Finished systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: systemd-sysusers.service - Create System Users was skipped because no trigger condition checks were met.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Starting systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in /dev...
Mar 06 11:22:24 daniel-tablet1 kernel: lp: driver loaded but no devices found
Mar 06 11:22:24 daniel-tablet1 systemd-journald[335]: Journal started
Mar 06 11:22:24 daniel-tablet1 systemd-journald[335]: Runtime Journal (/run/log/journal/a835234b12cd40638672f45525ee8e4f) is 8M, max 155.8M, 147.8M free.
Mar 06 11:22:24 daniel-tablet1 systemd-modules-load[351]: Inserted module 'uhid'
Mar 06 11:22:24 daniel-tablet1 systemd-modules-load[351]: Inserted module 'lp'
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Started systemd-journald.service - Journal Service.
Mar 06 11:22:24 daniel-tablet1 systemd-modules-load[351]: Inserted module 'ppdev'
Mar 06 11:22:24 daniel-tablet1 kernel: ppdev: user-space parallel port driver
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Finished systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in /dev.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Starting systemd-udevd.service - Rule-based Manager for Device Events and Files...
Mar 06 11:22:24 daniel-tablet1 systemd-modules-load[351]: Inserted module 'parport_pc'
Mar 06 11:22:24 daniel-tablet1 systemd-modules-load[351]: Module 'i2c_dev' is built in
Mar 06 11:22:24 daniel-tablet1 kernel: acpi_tad: loading out-of-tree module taints kernel.
Mar 06 11:22:24 daniel-tablet1 systemd-modules-load[351]: Inserted module 'surface_acpi_tad_rtc'
Mar 06 11:22:24 daniel-tablet1 kernel: platform surfaceacpitadrtc.0: registered as rtc1
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Finished lvm2-monitor.service - Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling.
Mar 06 11:22:24 daniel-tablet1 systemd-modules-load[351]: Inserted module 'intel_rapl_msr'
Mar 06 11:22:24 daniel-tablet1 kernel: intel_rapl_msr: PL4 support detected.
Mar 06 11:22:24 daniel-tablet1 kernel: intel_rapl_common: Found RAPL domain package
Mar 06 11:22:24 daniel-tablet1 kernel: intel_rapl_common: Found RAPL domain core
Mar 06 11:22:24 daniel-tablet1 kernel: intel_rapl_common: Found RAPL domain uncore
Mar 06 11:22:24 daniel-tablet1 kernel: intel_rapl_common: Found RAPL domain psys
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Finished systemd-modules-load.service - Load Kernel Modules.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Starting systemd-sysctl.service - Apply Kernel Variables...
Mar 06 11:22:24 daniel-tablet1 systemd-udevd[392]: Using default interface naming scheme 'v257'.
Mar 06 11:22:24 daniel-tablet1 systemd-sysctl[396]: Couldn't write '1' to 'kernel/apparmor_restrict_unprivileged_userns', ignoring: No such file or directory
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Finished systemd-sysctl.service - Apply Kernel Variables.
Mar 06 11:22:24 daniel-tablet1 systemd-udevd[392]: /usr/lib/udev/rules.d/90-alsa-restore.rules:18 GOTO="alsa_restore_std" has no matching label, ignoring.
Mar 06 11:22:24 daniel-tablet1 systemd-udevd[392]: /usr/lib/udev/rules.d/90-alsa-restore.rules:18 The line has no effect any more, dropping.
Mar 06 11:22:24 daniel-tablet1 systemd-udevd[392]: /usr/lib/udev/rules.d/90-alsa-restore.rules:22 GOTO="alsa_restore_std" has no matching label, ignoring.
Mar 06 11:22:24 daniel-tablet1 systemd-udevd[392]: /usr/lib/udev/rules.d/90-alsa-restore.rules:22 The line has no effect any more, dropping.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Started systemd-udevd.service - Rule-based Manager for Device Events and Files.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: nvmefc-boot-connections.service - Auto-connect to subsystems on FC-NVME devices found during boot was skipped because of an unmet condition check (ConditionPathExists=/sys/class/fc/fc_udev_device/nvme_discovery).
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Reached target local-fs-pre.target - Preparation for Local File Systems.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Finished systemd-udev-trigger.service - Coldplug All udev Devices.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Starting plymouth-start.service - Show Plymouth Boot Screen...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Reached target tpm2.target - Trusted Platform Module.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Started plymouth-start.service - Show Plymouth Boot Screen.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: systemd-ask-password-console.path - Dispatch Password Requests to Console Directory Watch was skipped because of an unmet condition check (ConditionPathExists=!/run/plymouth/pid).
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Started systemd-ask-password-plymouth.path - Forward Password Requests to Plymouth Directory Watch.
Mar 06 11:22:24 daniel-tablet1 (udev-worker)[426]: 3-8: Process '/sbin/modprobe -r i2c_hid && /sbin/modprobe i2c_hid' failed with exit code 1.
Mar 06 11:22:24 daniel-tablet1 (udev-worker)[411]: 3-8:1.0: Process '/sbin/modprobe -r i2c_hid && /sbin/modprobe i2c_hid' failed with exit code 1.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Found device dev-disk-by\x2duuid-0ffa31a8\x2d58f7\x2d48a5\x2dae99\x2d71f40d376bd6.device - HFB1M8MH331C0MR homecrypt.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Found device dev-disk-by\x2duuid-69452394\x2d6e8e\x2d4a5b\x2d9116\x2d0a8402d66401.device - HFB1M8MH331C0MR 6.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Found device dev-disk-by\x2duuid-C4B7\x2d85E2.device - HFB1M8MH331C0MR SYSTEM.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Found device dev-disk-by\x2duuid-b36382aa\x2d72e5\x2d4584\x2d8066\x2dd8250cb1c86b.device - HFB1M8MH331C0MR 5.
Mar 06 11:22:24 daniel-tablet1 kernel: intel_pmc_core INT33A1:00:  initialized
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Found device dev-disk-by\x2duuid-46916dcd\x2dc245\x2d4384\x2dbbaf\x2d2f9460979425.device - HFB1M8MH331C0MR 7.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Starting systemd-cryptsetup@homecrypt.service - Cryptography Setup for homecrypt...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Starting systemd-fsck@dev-disk-by\x2duuid-46916dcd\x2dc245\x2d4384\x2dbbaf\x2d2f9460979425.service - File System Check on /dev/disk/by-uuid/46916dcd-c245-4384-bbaf-2f9460979425...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Starting systemd-fsck@dev-disk-by\x2duuid-69452394\x2d6e8e\x2d4a5b\x2d9116\x2d0a8402d66401.service - File System Check on /dev/disk/by-uuid/69452394-6e8e-4a5b-9116-0a8402d66401...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Starting systemd-fsck@dev-disk-by\x2duuid-C4B7\x2d85E2.service - File System Check on /dev/disk/by-uuid/C4B7-85E2...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Starting systemd-fsck@dev-disk-by\x2duuid-b36382aa\x2d72e5\x2d4584\x2d8066\x2dd8250cb1c86b.service - File System Check on /dev/disk/by-uuid/b36382aa-72e5-4584-8066-d8250cb1c86b...
Mar 06 11:22:24 daniel-tablet1 systemd-fsck[478]: /dev/nvme0n1p6: recovering journal
Mar 06 11:22:24 daniel-tablet1 systemd-fsck[477]: /dev/nvme0n1p7: recovering journal
Mar 06 11:22:24 daniel-tablet1 systemd-fsck[478]: fsck.ext4: Invalid argument while recovering journal of /dev/nvme0n1p6
Mar 06 11:22:24 daniel-tablet1 systemd[1]: systemd-ask-password-console.path - Dispatch Password Requests to Console Directory Watch was skipped because of an unmet condition check (ConditionPathExists=!/run/plymouth/pid).
Mar 06 11:22:24 daniel-tablet1 systemd-fsck[477]: fsck.ext4: Invalid argument while recovering journal of /dev/nvme0n1p7
Mar 06 11:22:24 daniel-tablet1 systemd-fsck[480]: /dev/nvme0n1p5: clean, 624/64000 files, 88178/256000 blocks
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Starting modprobe@efi_pstore.service - Load Kernel Module efi_pstore...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Started systemd-ask-password-plymouth.service - Forward Password Requests to Plymouth.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: systemd-fsck-root.service - File System Check on Root Device was skipped because of an unmet condition check (ConditionPathExists=!/run/initramfs/fsck-root).
Mar 06 11:22:24 daniel-tablet1 systemd-fsck[481]: fsck.fat 4.2 (2021-01-31)
Mar 06 11:22:24 daniel-tablet1 systemd-fsck[481]: /dev/nvme0n1p1: 196 files, 8180/65772 clusters
Mar 06 11:22:24 daniel-tablet1 systemd[1]: systemd-hibernate-clear.service - Clear Stale Hibernate Storage Info was skipped because of an unmet condition check (ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
Mar 06 11:22:24 daniel-tablet1 systemd-fsck[478]: /dev/nvme0n1p6 was not cleanly unmounted, check forced.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: systemd-hwdb-update.service - Rebuild Hardware Database was skipped because of an unmet condition check (ConditionNeedsUpdate=/etc).
Mar 06 11:22:24 daniel-tablet1 systemd[1]: systemd-pcrmachine.service - TPM PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
Mar 06 11:22:24 daniel-tablet1 systemd[1]: systemd-sysusers.service - Create System Users was skipped because no trigger condition checks were met.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: systemd-tpm2-setup-early.service - Early TPM SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Finished systemd-fsck@dev-disk-by\x2duuid-C4B7\x2d85E2.service - File System Check on /dev/disk/by-uuid/C4B7-85E2.
Mar 06 11:22:24 daniel-tablet1 systemd-fsck[477]: /dev/nvme0n1p7 was not cleanly unmounted, check forced.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Finished systemd-fsck@dev-disk-by\x2duuid-b36382aa\x2d72e5\x2d4584\x2d8066\x2dd8250cb1c86b.service - File System Check on /dev/disk/by-uuid/b36382aa-72e5-4584-8066-d8250cb1c86b.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: modprobe@efi_pstore.service: Deactivated successfully.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Finished modprobe@efi_pstore.service - Load Kernel Module efi_pstore.
Mar 06 11:22:24 daniel-tablet1 systemd-fsck[478]: /dev/nvme0n1p6: Entry '..' in /systemd-private-2ac25c3c792244da8d6763e4dfb3bc55-systemd-logind.service-REqt6a/??? (17) has deleted/unused inode 13.  CLEARED.
Mar 06 11:22:24 daniel-tablet1 systemd-fsck[478]: /dev/nvme0n1p6: Entry '4953' in /.ICE-unix (129793) has deleted/unused inode 129802.  CLEARED.
Mar 06 11:22:24 daniel-tablet1 systemd-fsck[478]: /dev/nvme0n1p6: Entry 'systemd-private-2ac25c3c792244da8d6763e4dfb3bc55-iio-sensor-proxy.service-O76Oan' in / (2) has deleted/unused inode 129796.  CLEARED.
Mar 06 11:22:24 daniel-tablet1 systemd-fsck[478]: /dev/nvme0n1p6: Entry 'systemd-private-2ac25c3c792244da8d6763e4dfb3bc55-systemd-logind.service-REqt6a' in / (2) has deleted/unused inode 13.  CLEARED.
Mar 06 11:22:24 daniel-tablet1 systemd-fsck[478]: /dev/nvme0n1p6: Entry 'systemd-private-2ac25c3c792244da8d6763e4dfb3bc55-colord.service-iWjS5d' in / (2) has deleted/unused inode 129800.  CLEARED.
Mar 06 11:22:24 daniel-tablet1 systemd-fsck[478]: /dev/nvme0n1p6: Entry 'plasma-csd-generator.xHyouV' in / (2) has deleted/unused inode 129803.  CLEARED.
Mar 06 11:22:24 daniel-tablet1 systemd-fsck[478]: /dev/nvme0n1p6: Entry 'systemd-private-2ac25c3c792244da8d6763e4dfb3bc55-bluetooth.service-q0u0uT' in / (2) has deleted/unused inode 129794.  CLEARED.
Mar 06 11:22:24 daniel-tablet1 systemd-fsck[478]: /dev/nvme0n1p6: Unconnected directory inode 17 (was in /???)
Mar 06 11:22:24 daniel-tablet1 systemd-fsck[478]: /dev/nvme0n1p6: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.
Mar 06 11:22:24 daniel-tablet1 systemd-fsck[478]:         (i.e., without -a or -p options)
Mar 06 11:22:24 daniel-tablet1 kernel: proc_thermal 0000:00:04.0: enabling device (0000 -> 0002)
Mar 06 11:22:24 daniel-tablet1 systemd-fsck[470]: fsck failed with exit status 4.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: systemd-fsck@dev-disk-by\x2duuid-69452394\x2d6e8e\x2d4a5b\x2d9116\x2d0a8402d66401.service: Main process exited, code=exited, status=1/FAILURE
Mar 06 11:22:24 daniel-tablet1 systemd[1]: systemd-fsck@dev-disk-by\x2duuid-69452394\x2d6e8e\x2d4a5b\x2d9116\x2d0a8402d66401.service: Failed with result 'exit-code'.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Failed to start systemd-fsck@dev-disk-by\x2duuid-69452394\x2d6e8e\x2d4a5b\x2d9116\x2d0a8402d66401.service - File System Check on /dev/disk/by-uuid/69452394-6e8e-4a5b-9116-0a8402d66401.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Dependency failed for tmp.mount - /tmp.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Dependency failed for local-fs.target - Local File Systems.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: local-fs.target: Job local-fs.target/start failed with result 'dependency'.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: local-fs.target: Triggering OnFailure= dependencies.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: tmp.mount: Job tmp.mount/start failed with result 'dependency'.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Reached target timers.target - Timer Units.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Listening on systemd-sysext.socket - System Extension Image Management.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Starting console-setup.service - Set console font and keymap...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Reached target getty.target - Login Prompts.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Starting qemu-kvm.service - QEMU KVM preparation - module, ksm, hugepages...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: systemd-ask-password-wall.path: Deactivated successfully.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Stopped systemd-ask-password-wall.path - Forward Password Requests to Wall Directory Watch.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Starting setvtrgb.service - Set console scheme...
Mar 06 11:22:24 daniel-tablet1 kernel: intel_rapl_common: Found RAPL domain package
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Starting ufw.service - Uncomplicated firewall...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Reached target paths.target - Path Units.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Listening on dbus.socket - D-Bus System Message Bus Socket.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Starting dbus.service - D-Bus System Message Bus...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Started emergency.service - Emergency Shell.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Reached target emergency.target - Emergency Mode.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Starting plymouth-read-write.service - Tell Plymouth To Write Out Runtime Data...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Starting systemd-binfmt.service - Set Up Additional Binary Formats...
Mar 06 11:22:24 daniel-tablet1 systemd[1]: systemd-pcrphase-sysinit.service - TPM PCR Barrier (Initialization) was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Finished setvtrgb.service - Set console scheme.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Finished console-setup.service - Set console font and keymap.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Finished ufw.service - Uncomplicated firewall.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Created slice system-getty.slice - Slice /system/getty.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Reached target network-pre.target - Preparation for Network.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: proc-sys-fs-binfmt_misc.automount: Got automount request for /proc/sys/fs/binfmt_misc, triggered by 499 (systemd-binfmt)
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Received SIGRTMIN+20 from PID 257 (plymouthd).
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Finished plymouth-read-write.service - Tell Plymouth To Write Out Runtime Data.
Mar 06 11:22:24 daniel-tablet1 kernel: mc: Linux media interface: v0.10
Mar 06 11:22:24 daniel-tablet1 dbus-daemon[494]: dbus[494]: Unknown group "power" in message bus configuration file
Mar 06 11:22:24 daniel-tablet1 dbus-daemon[494]: dbus[494]: Unknown group "power" in message bus configuration file
Mar 06 11:22:24 daniel-tablet1 dbus-daemon[494]: [system] AppArmor D-Bus mediation is enabled
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Started dbus.service - D-Bus System Message Bus.
Mar 06 11:22:24 daniel-tablet1 kernel: videodev: Linux video capture interface: v2.00
Mar 06 11:22:24 daniel-tablet1 systemd-fsck[477]: /dev/nvme0n1p7: Entry '..' in /tmp/systemd-private-2ac25c3c792244da8d6763e4dfb3bc55-systemd-logind.service-uX0hHv/??? (137) has deleted/unused inode 120.  CLEARED.
Mar 06 11:22:24 daniel-tablet1 systemd-fsck[477]: /dev/nvme0n1p7: Entry '..' in /tmp/systemd-private-2ac25c3c792244da8d6763e4dfb3bc55-colord.service-gmpbvG/??? (195) has deleted/unused inode 167.  CLEARED.
Mar 06 11:22:24 daniel-tablet1 systemd[1]: Finished qemu-kvm.service - QEMU KVM preparation - module, ksm, hugepages.
Mar 06 11:22:25 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dvdd not found, using dummy regulator
Mar 06 11:22:25 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dovdd not found, using dummy regulator
Mar 06 11:22:25 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dvdd not found, using dummy regulator
Mar 06 11:22:25 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dovdd not found, using dummy regulator
Mar 06 11:22:25 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dvdd not found, using dummy regulator
Mar 06 11:22:25 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dovdd not found, using dummy regulator
Mar 06 11:22:25 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dvdd not found, using dummy regulator
Mar 06 11:22:25 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dovdd not found, using dummy regulator
Mar 06 11:22:25 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dvdd not found, using dummy regulator
Mar 06 11:22:25 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dovdd not found, using dummy regulator
Mar 06 11:22:25 daniel-tablet1 systemd-fsck[477]: /dev/nvme0n1p7: Entry 'systemd-private-2ac25c3c792244da8d6763e4dfb3bc55-colord.service-gmpbvG' in /tmp (13) has deleted/unused inode 167.  CLEARED.
Mar 06 11:22:25 daniel-tablet1 systemd-fsck[477]: /dev/nvme0n1p7: Entry 'systemd-private-2ac25c3c792244da8d6763e4dfb3bc55-systemd-logind.service-uX0hHv' in /tmp (13) has deleted/unused inode 120.  CLEARED.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: Mounting boot.mount - /boot...
Mar 06 11:22:25 daniel-tablet1 systemd[1]: media.mount: Directory /media to mount over is not empty, mounting anyway.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: Mounting media.mount - /media...
Mar 06 11:22:25 daniel-tablet1 systemd[1]: Mounting proc-sys-fs-binfmt_misc.mount - Arbitrary Executable File Formats File System...
Mar 06 11:22:25 daniel-tablet1 systemd[1]: Mounted media.mount - /media.
Mar 06 11:22:25 daniel-tablet1 kernel: EXT4-fs (nvme0n1p5): orphan cleanup on readonly fs
Mar 06 11:22:25 daniel-tablet1 kernel: EXT4-fs (nvme0n1p5): mounted filesystem b36382aa-72e5-4584-8066-d8250cb1c86b ro with ordered data mode. Quota mode: none.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: Mounted boot.mount - /boot.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: Mounting boot-efi.mount - /boot/efi...
Mar 06 11:22:25 daniel-tablet1 systemd-fsck[477]: /dev/nvme0n1p7: Unconnected directory inode 137 (was in /tmp/???)
Mar 06 11:22:25 daniel-tablet1 systemd-fsck[477]: /dev/nvme0n1p7: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.
Mar 06 11:22:25 daniel-tablet1 systemd-fsck[477]:         (i.e., without -a or -p options)
Mar 06 11:22:25 daniel-tablet1 systemd-fsck[469]: fsck failed with exit status 4.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: systemd-fsck@dev-disk-by\x2duuid-46916dcd\x2dc245\x2d4384\x2dbbaf\x2d2f9460979425.service: Main process exited, code=exited, status=1/FAILURE
Mar 06 11:22:25 daniel-tablet1 systemd[1]: systemd-fsck@dev-disk-by\x2duuid-46916dcd\x2dc245\x2d4384\x2dbbaf\x2d2f9460979425.service: Failed with result 'exit-code'.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: Failed to start systemd-fsck@dev-disk-by\x2duuid-46916dcd\x2dc245\x2d4384\x2dbbaf\x2d2f9460979425.service - File System Check on /dev/disk/by-uuid/46916dcd-c245-4384-bbaf-2f9460979425.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: Dependency failed for var.mount - /var.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: Dependency failed for var-lib-gdm3.mount - /var/lib/gdm3.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: var-lib-gdm3.mount: Job var-lib-gdm3.mount/start failed with result 'dependency'.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: Dependency failed for var-lib-machines.mount - Virtual Machine and Container Storage (Compatibility).
Mar 06 11:22:25 daniel-tablet1 systemd[1]: var-lib-machines.mount: Job var-lib-machines.mount/start failed with result 'dependency'.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: Dependency failed for systemd-oomd.service - Userspace Out-Of-Memory (OOM) Killer.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: systemd-oomd.service: Job systemd-oomd.service/start failed with result 'dependency'.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: Dependency failed for systemd-random-seed.service - Load/Save OS Random Seed.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: systemd-random-seed.service: Job systemd-random-seed.service/start failed with result 'dependency'.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: Dependency failed for systemd-tpm2-setup.service - TPM SRK Setup.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: systemd-tpm2-setup.service: Job systemd-tpm2-setup.service/start failed with result 'dependency'.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: Dependency failed for systemd-journal-flush.service - Flush Journal to Persistent Storage.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: systemd-journal-flush.service: Job systemd-journal-flush.service/start failed with result 'dependency'.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: Dependency failed for apparmor.service - Load AppArmor profiles.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: apparmor.service: Job apparmor.service/start failed with result 'dependency'.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: Dependency failed for systemd-resolved.service - Network Name Resolution.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: systemd-resolved.service: Job systemd-resolved.service/start failed with result 'dependency'.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: Dependency failed for systemd-pstore.service - Platform Persistent Storage Archival.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: systemd-pstore.service: Job systemd-pstore.service/start failed with result 'dependency'.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: var.mount: Job var.mount/start failed with result 'dependency'.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: Reached target machines.target - Containers.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: Reached target network.target - Network.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: Reached target network-online.target - Network is Online.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: Reached target nss-lookup.target - Host and Network Name Lookups.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: Listening on systemd-importd.socket - Disk Image Download Service Socket.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: Reached target sockets.target - Socket Units.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: Starting systemd-tmpfiles-setup.service - Create System Files and Directories...
Mar 06 11:22:25 daniel-tablet1 systemd-tmpfiles[525]: /usr/lib/tmpfiles.d/legacy.conf:14: Duplicate line for path "/run/lock", ignoring.
Mar 06 11:22:25 daniel-tablet1 systemd-tmpfiles[525]: Failed to create directory or subvolume "/var/lib": Read-only file system
Mar 06 11:22:25 daniel-tablet1 systemd-tmpfiles[525]: Failed to open path '/var/lib': No such file or directory
Mar 06 11:22:25 daniel-tablet1 systemd-tmpfiles[525]: Failed to open path '/var/lib/apport': No such file or directory
Mar 06 11:22:25 daniel-tablet1 systemd-tmpfiles[525]: Failed to create directory or subvolume "/var/log": Read-only file system
Mar 06 11:22:25 daniel-tablet1 systemd-tmpfiles[525]: Failed to open path '/var/log': No such file or directory
Mar 06 11:22:25 daniel-tablet1 systemd-tmpfiles[525]: Failed to open path '/var/lib': No such file or directory
Mar 06 11:22:25 daniel-tablet1 systemd-tmpfiles[525]: Failed to open path '/var/lib/colord': No such file or directory
Mar 06 11:22:25 daniel-tablet1 systemd-tmpfiles[525]: Failed to create directory or subvolume "/var/spool": Read-only file system
Mar 06 11:22:25 daniel-tablet1 systemd-tmpfiles[525]: Failed to open path '/var/spool/cron': No such file or directory
Mar 06 11:22:25 daniel-tablet1 systemd-tmpfiles[525]: Failed to open path '/var/lib': No such file or directory
Mar 06 11:22:25 daniel-tablet1 systemd-tmpfiles[525]: Failed to open path '/var/lib/dbus': No such file or directory
Mar 06 11:22:25 daniel-tablet1 systemd-tmpfiles[525]: Failed to create symlink '/var/lock': Read-only file system
Mar 06 11:22:25 daniel-tablet1 systemd-tmpfiles[525]: Failed to open path '/var/log': No such file or directory
Mar 06 11:22:25 daniel-tablet1 systemd-tmpfiles[525]: Failed to create directory or subvolume "/var/cache": Read-only file system
Mar 06 11:22:25 daniel-tablet1 systemd-tmpfiles[525]: Failed to open path '/var/cache': No such file or directory
Mar 06 11:22:25 daniel-tablet1 systemd-tmpfiles[525]: Failed to open path '/var/lib': No such file or directory
Mar 06 11:22:25 daniel-tablet1 systemd-tmpfiles[525]: Failed to open path '/var/lib': No such file or directory
Mar 06 11:22:25 daniel-tablet1 systemd-tmpfiles[525]: Failed to open path '/var/lib/systemd': No such file or directory
Mar 06 11:22:25 daniel-tablet1 systemd-tmpfiles[525]: Failed to open path '/var/lib': No such file or directory
Mar 06 11:22:25 daniel-tablet1 systemd-tmpfiles[525]: Failed to open path '/var/lib/systemd': No such file or directory
Mar 06 11:22:25 daniel-tablet1 systemd-tmpfiles[525]: Failed to open path '/var/lib/systemd': No such file or directory
Mar 06 11:22:25 daniel-tablet1 systemd-tmpfiles[525]: Failed to open path '/var/lib/systemd': No such file or directory
Mar 06 11:22:25 daniel-tablet1 systemd-tmpfiles[525]: Failed to open path '/var/lib': No such file or directory
Mar 06 11:22:25 daniel-tablet1 systemd-tmpfiles[525]: Failed to open path '/var/log': No such file or directory
Mar 06 11:22:25 daniel-tablet1 systemd-tmpfiles[525]: Failed to open path '/var/cache': No such file or directory
Mar 06 11:22:25 daniel-tablet1 systemd-tmpfiles[525]: Failed to create directory or subvolume "/var/tmp": Read-only file system
Mar 06 11:22:25 daniel-tablet1 systemd-tmpfiles[525]: Failed to open path '/var/lib': No such file or directory
Mar 06 11:22:25 daniel-tablet1 systemd-tmpfiles[525]: Failed to create symlink '/var/run': Read-only file system
Mar 06 11:22:25 daniel-tablet1 systemd-tmpfiles[525]: Failed to create directory or subvolume "/tmp/.X11-unix": Read-only file system
Mar 06 11:22:25 daniel-tablet1 systemd-tmpfiles[525]: Failed to create directory or subvolume "/tmp/.ICE-unix": Read-only file system
Mar 06 11:22:25 daniel-tablet1 systemd-tmpfiles[525]: Failed to create directory or subvolume "/tmp/.XIM-unix": Read-only file system
Mar 06 11:22:25 daniel-tablet1 systemd-tmpfiles[525]: Failed to create directory or subvolume "/tmp/.font-unix": Read-only file system
Mar 06 11:22:25 daniel-tablet1 systemd[1]: Finished systemd-tmpfiles-setup.service - Create System Files and Directories.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: Starting audit-rules.service - Load Audit Rules...
Mar 06 11:22:25 daniel-tablet1 systemd[1]: ldconfig.service - Rebuild Dynamic Linker Cache was skipped because no trigger condition checks were met.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: systemd-firstboot.service - First Boot Wizard was skipped because of an unmet condition check (ConditionFirstBoot=yes).
Mar 06 11:22:25 daniel-tablet1 systemd[1]: first-boot-complete.target - First Boot Complete was skipped because of an unmet condition check (ConditionFirstBoot=yes).
Mar 06 11:22:25 daniel-tablet1 systemd[1]: systemd-journal-catalog-update.service - Rebuild Journal Catalog was skipped because of an unmet condition check (ConditionNeedsUpdate=/var).
Mar 06 11:22:25 daniel-tablet1 systemd[1]: systemd-machine-id-commit.service - Save Transient machine-id to Disk was skipped because of an unmet condition check (ConditionPathIsMountPoint=/etc/machine-id).
Mar 06 11:22:25 daniel-tablet1 systemd[1]: systemd-update-done.service - Update is Completed was skipped because no trigger condition checks were met.
Mar 06 11:22:25 daniel-tablet1 augenrules[529]: mktemp: Read-only file system (os error 30) at path "/tmp/aurules.A80dE7gA"
Mar 06 11:22:25 daniel-tablet1 augenrules[528]: /usr/sbin/augenrules: 85: cannot create : Directory nonexistent
Mar 06 11:22:25 daniel-tablet1 augenrules[534]: /usr/sbin/augenrules: 88: cannot create : Directory nonexistent
Mar 06 11:22:25 daniel-tablet1 augenrules[528]: /usr/sbin/augenrules: No rules
Mar 06 11:22:25 daniel-tablet1 augenrules[537]: No rules
Mar 06 11:22:25 daniel-tablet1 augenrules[537]: enabled 0
Mar 06 11:22:25 daniel-tablet1 augenrules[537]: failure 1
Mar 06 11:22:25 daniel-tablet1 augenrules[537]: pid 0
Mar 06 11:22:25 daniel-tablet1 augenrules[537]: rate_limit 0
Mar 06 11:22:25 daniel-tablet1 augenrules[537]: backlog_limit 8192
Mar 06 11:22:25 daniel-tablet1 augenrules[537]: lost 0
Mar 06 11:22:25 daniel-tablet1 augenrules[537]: backlog 0
Mar 06 11:22:25 daniel-tablet1 augenrules[537]: backlog_wait_time 60000
Mar 06 11:22:25 daniel-tablet1 augenrules[537]: backlog_wait_time_actual 0
Mar 06 11:22:25 daniel-tablet1 augenrules[537]: enabled 0
Mar 06 11:22:25 daniel-tablet1 augenrules[537]: failure 1
Mar 06 11:22:25 daniel-tablet1 augenrules[537]: pid 0
Mar 06 11:22:25 daniel-tablet1 augenrules[537]: rate_limit 0
Mar 06 11:22:25 daniel-tablet1 augenrules[537]: backlog_limit 8192
Mar 06 11:22:25 daniel-tablet1 augenrules[537]: lost 0
Mar 06 11:22:25 daniel-tablet1 augenrules[537]: backlog 0
Mar 06 11:22:25 daniel-tablet1 augenrules[537]: backlog_wait_time 60000
Mar 06 11:22:25 daniel-tablet1 augenrules[537]: backlog_wait_time_actual 0
Mar 06 11:22:25 daniel-tablet1 augenrules[537]: enabled 0
Mar 06 11:22:25 daniel-tablet1 augenrules[537]: failure 1
Mar 06 11:22:25 daniel-tablet1 augenrules[537]: pid 0
Mar 06 11:22:25 daniel-tablet1 augenrules[537]: rate_limit 0
Mar 06 11:22:25 daniel-tablet1 augenrules[537]: backlog_limit 8192
Mar 06 11:22:25 daniel-tablet1 augenrules[537]: lost 0
Mar 06 11:22:25 daniel-tablet1 augenrules[537]: backlog 0
Mar 06 11:22:25 daniel-tablet1 augenrules[537]: backlog_wait_time 60000
Mar 06 11:22:25 daniel-tablet1 augenrules[537]: backlog_wait_time_actual 0
Mar 06 11:22:25 daniel-tablet1 systemd[1]: audit-rules.service: Deactivated successfully.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: Finished audit-rules.service - Load Audit Rules.
Mar 06 11:22:25 daniel-tablet1 kernel: i915 0000:00:02.0: [drm] Found icelake/port_f (device ID 8a52) integrated display version 11.00 stepping D0
Mar 06 11:22:25 daniel-tablet1 kernel: surface_serial_hub serial0-0: event: unhandled event (rqid: 0x02, tc: 0x02, tid: 0x01, cid: 0x53, iid: 0x01)
Mar 06 11:22:25 daniel-tablet1 kernel: i915 0000:00:02.0: [drm] VT-d active for gfx access
Mar 06 11:22:25 daniel-tablet1 kernel: i915 0000:00:02.0: vgaarb: deactivate vga console
Mar 06 11:22:25 daniel-tablet1 kernel: i915 0000:00:02.0: [drm] Using Transparent Hugepages
Mar 06 11:22:25 daniel-tablet1 kernel: i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=io+mem:owns=io+mem
Mar 06 11:22:25 daniel-tablet1 kernel: i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/icl_dmc_ver1_09.bin (v1.9)
Mar 06 11:22:25 daniel-tablet1 kernel: Bluetooth: Core ver 2.22
Mar 06 11:22:25 daniel-tablet1 kernel: NET: Registered PF_BLUETOOTH protocol family
Mar 06 11:22:25 daniel-tablet1 kernel: Bluetooth: HCI device and connection manager initialized
Mar 06 11:22:25 daniel-tablet1 kernel: Bluetooth: HCI socket layer initialized
Mar 06 11:22:25 daniel-tablet1 kernel: Bluetooth: L2CAP socket layer initialized
Mar 06 11:22:25 daniel-tablet1 kernel: Bluetooth: SCO socket layer initialized
Mar 06 11:22:25 daniel-tablet1 kernel: i915 0000:00:02.0: [drm] Registered 3 planes with drm panic
Mar 06 11:22:25 daniel-tablet1 kernel: [drm] Initialized i915 1.6.0 for 0000:00:02.0 on minor 1
Mar 06 11:22:25 daniel-tablet1 kernel: ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
Mar 06 11:22:25 daniel-tablet1 kernel: input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input30
Mar 06 11:22:25 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dvdd not found, using dummy regulator
Mar 06 11:22:25 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dovdd not found, using dummy regulator
Mar 06 11:22:25 daniel-tablet1 kernel: fbcon: i915drmfb (fb0) is primary device
Mar 06 11:22:25 daniel-tablet1 kernel: fbcon: Deferring console take-over
Mar 06 11:22:25 daniel-tablet1 kernel: i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
Mar 06 11:22:25 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dvdd not found, using dummy regulator
Mar 06 11:22:25 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dovdd not found, using dummy regulator
Mar 06 11:22:25 daniel-tablet1 kernel: cfg80211: Loading compiled-in X.509 certificates for regulatory database
Mar 06 11:22:25 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dvdd not found, using dummy regulator
Mar 06 11:22:25 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dovdd not found, using dummy regulator
Mar 06 11:22:25 daniel-tablet1 kernel: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
Mar 06 11:22:25 daniel-tablet1 kernel: Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
Mar 06 11:22:25 daniel-tablet1 systemd[1]: Mounted proc-sys-fs-binfmt_misc.mount - Arbitrary Executable File Formats File System.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: Finished systemd-binfmt.service - Set Up Additional Binary Formats.
Mar 06 11:22:25 daniel-tablet1 systemd[1]: Mounted boot-efi.mount - /boot/efi.
Mar 06 11:22:25 daniel-tablet1 kernel: mei_me 0000:00:16.0: enabling device (0000 -> 0002)
Mar 06 11:22:25 daniel-tablet1 (udev-worker)[423]: input13: Process '/bin/input-remapper-control --command autoload --device ' failed with exit code 2.
Mar 06 11:22:25 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dvdd not found, using dummy regulator
Mar 06 11:22:25 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dovdd not found, using dummy regulator
Mar 06 11:22:25 daniel-tablet1 (udev-worker)[431]: input22: Process '/bin/input-remapper-control --command autoload --device ' failed with exit code 2.
Mar 06 11:22:25 daniel-tablet1 kernel: mei_me 0000:00:16.4: enabling device (0000 -> 0002)
Mar 06 11:22:25 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dvdd not found, using dummy regulator
Mar 06 11:22:25 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dovdd not found, using dummy regulator
Mar 06 11:22:25 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dvdd not found, using dummy regulator
Mar 06 11:22:25 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dovdd not found, using dummy regulator
Mar 06 11:22:25 daniel-tablet1 (udev-worker)[424]: input23: Process '/bin/input-remapper-control --command autoload --device ' failed with exit code 2.
Mar 06 11:22:25 daniel-tablet1 kernel: usbcore: registered new interface driver btusb
Mar 06 11:22:25 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dvdd not found, using dummy regulator
Mar 06 11:22:25 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dovdd not found, using dummy regulator
Mar 06 11:22:25 daniel-tablet1 kernel: Bluetooth: hci0: Bootloader revision 0.4 build 0 week 11 2017
Mar 06 11:22:25 daniel-tablet1 kernel: Bluetooth: hci0: Device revision is 2
Mar 06 11:22:25 daniel-tablet1 kernel: Bluetooth: hci0: Secure boot is enabled
Mar 06 11:22:25 daniel-tablet1 kernel: Bluetooth: hci0: OTP lock is enabled
Mar 06 11:22:25 daniel-tablet1 kernel: Bluetooth: hci0: API lock is enabled
Mar 06 11:22:25 daniel-tablet1 kernel: Bluetooth: hci0: Debug lock is disabled
Mar 06 11:22:25 daniel-tablet1 kernel: Bluetooth: hci0: Minimum firmware build 1 week 10 2014
Mar 06 11:22:25 daniel-tablet1 (udev-worker)[407]: input19: Process '/bin/input-remapper-control --command autoload --device ' failed with exit code 2.
Mar 06 11:22:25 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dvdd not found, using dummy regulator
Mar 06 11:22:25 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dovdd not found, using dummy regulator
Mar 06 11:22:25 daniel-tablet1 kernel: Bluetooth: hci0: Found device firmware: intel/ibt-19-32-4.sfi
Mar 06 11:22:25 daniel-tablet1 kernel: Bluetooth: hci0: Boot Address: 0x24800
Mar 06 11:22:25 daniel-tablet1 kernel: Bluetooth: hci0: Firmware Version: 193-33.24
Mar 06 11:22:25 daniel-tablet1 (udev-worker)[413]: input26: Process '/bin/input-remapper-control --command autoload --device ' failed with exit code 2.
Mar 06 11:22:25 daniel-tablet1 kernel: iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
Mar 06 11:22:25 daniel-tablet1 (udev-worker)[406]: input20: Process '/bin/input-remapper-control --command autoload --device ' failed with exit code 2.
Mar 06 11:22:25 daniel-tablet1 (udev-worker)[427]: input2: Process '/bin/input-remapper-control --command autoload --device ' failed with exit code 2.
Mar 06 11:22:25 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dvdd not found, using dummy regulator
Mar 06 11:22:25 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dovdd not found, using dummy regulator
Mar 06 11:22:25 daniel-tablet1 kernel: iwlwifi 0000:00:14.3: Detected crf-id 0x3617, cnv-id 0x2000300 wfpm id 0x80000000
Mar 06 11:22:25 daniel-tablet1 kernel: iwlwifi 0000:00:14.3: PCI dev 34f0/0074, rev=0x332, rfid=0x10a100
Mar 06 11:22:25 daniel-tablet1 kernel: iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX201 160MHz
Mar 06 11:22:25 daniel-tablet1 kernel: iwlwifi 0000:00:14.3: loaded firmware version 77.6eaf654b.0 Qu-c0-hr-b0-77.ucode op_mode iwlmvm
Mar 06 11:22:25 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dvdd not found, using dummy regulator
Mar 06 11:22:25 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dovdd not found, using dummy regulator
Mar 06 11:22:25 daniel-tablet1 (udev-worker)[416]: input12: Process '/bin/input-remapper-control --command autoload --device ' failed with exit code 2.
Mar 06 11:22:25 daniel-tablet1 (udev-worker)[429]: input28: Process '/bin/input-remapper-control --command autoload --device ' failed with exit code 2.
Mar 06 11:22:25 daniel-tablet1 (udev-worker)[408]: input27: Process '/bin/input-remapper-control --command autoload --device ' failed with exit code 2.
Mar 06 11:22:25 daniel-tablet1 (udev-worker)[417]: input1: Process '/bin/input-remapper-control --command autoload --device ' failed with exit code 2.
Mar 06 11:22:25 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dvdd not found, using dummy regulator
Mar 06 11:22:25 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dovdd not found, using dummy regulator
Mar 06 11:22:26 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dvdd not found, using dummy regulator
Mar 06 11:22:26 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dovdd not found, using dummy regulator
Mar 06 11:22:26 daniel-tablet1 (udev-worker)[420]: input16: Process '/bin/input-remapper-control --command autoload --device ' failed with exit code 2.
Mar 06 11:22:26 daniel-tablet1 (udev-worker)[403]: input24: Process '/bin/input-remapper-control --command autoload --device ' failed with exit code 2.
Mar 06 11:22:26 daniel-tablet1 (udev-worker)[411]: input11: Process '/bin/input-remapper-control --command autoload --device ' failed with exit code 2.
Mar 06 11:22:26 daniel-tablet1 (udev-worker)[419]: input21: Process '/bin/input-remapper-control --command autoload --device ' failed with exit code 2.
Mar 06 11:22:26 daniel-tablet1 (udev-worker)[418]: input0: Process '/bin/input-remapper-control --command autoload --device ' failed with exit code 2.
Mar 06 11:22:26 daniel-tablet1 (udev-worker)[422]: input14: Process '/bin/input-remapper-control --command autoload --device ' failed with exit code 2.
Mar 06 11:22:26 daniel-tablet1 (udev-worker)[421]: input25: Process '/bin/input-remapper-control --command autoload --device ' failed with exit code 2.
Mar 06 11:22:26 daniel-tablet1 kernel: RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
Mar 06 11:22:26 daniel-tablet1 kernel: RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
Mar 06 11:22:26 daniel-tablet1 kernel: RAPL PMU: hw unit of domain package 2^-14 Joules
Mar 06 11:22:26 daniel-tablet1 kernel: RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
Mar 06 11:22:26 daniel-tablet1 kernel: RAPL PMU: hw unit of domain psys 2^-14 Joules
Mar 06 11:22:26 daniel-tablet1 (udev-worker)[426]: input18: Process '/bin/input-remapper-control --command autoload --device ' failed with exit code 2.
Mar 06 11:22:26 daniel-tablet1 (udev-worker)[414]: input17: Process '/bin/input-remapper-control --command autoload --device ' failed with exit code 2.
Mar 06 11:22:26 daniel-tablet1 kernel: intel_tcc_cooling: Programmable TCC Offset detected
Mar 06 11:22:26 daniel-tablet1 (udev-worker)[430]: input15: Process '/bin/input-remapper-control --command autoload --device ' failed with exit code 2.
Mar 06 11:22:26 daniel-tablet1 kernel: iwlwifi 0000:00:14.3: Detected RF HR B3, rfid=0x10a100
Mar 06 11:22:26 daniel-tablet1 (udev-worker)[437]: mice: Process '/bin/input-remapper-control --command autoload --device /dev/input/mice' failed with exit code 5.
Mar 06 11:22:26 daniel-tablet1 kernel: iwlwifi 0000:00:14.3: base HW address: 28:7f:cf:5a:36:f6
Mar 06 11:22:26 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dvdd not found, using dummy regulator
Mar 06 11:22:26 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dovdd not found, using dummy regulator
Mar 06 11:22:26 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dvdd not found, using dummy regulator
Mar 06 11:22:26 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dovdd not found, using dummy regulator
Mar 06 11:22:26 daniel-tablet1 systemd[1]: Starting systemd-fsck@dev-disk-by\x2duuid-46916dcd\x2dc245\x2d4384\x2dbbaf\x2d2f9460979425.service - File System Check on /dev/disk/by-uuid/46916dcd-c245-4384-bbaf-2f9460979425...
Mar 06 11:22:26 daniel-tablet1 systemd-fsck[640]: /dev/nvme0n1p7 contains a file system with errors, check forced.
Mar 06 11:22:26 daniel-tablet1 systemd[1]: Stopped target emergency.target - Emergency Mode.
Mar 06 11:22:26 daniel-tablet1 systemd[1]: Starting modprobe@efi_pstore.service - Load Kernel Module efi_pstore...
Mar 06 11:22:26 daniel-tablet1 systemd[1]: systemd-fsck-root.service - File System Check on Root Device was skipped because of an unmet condition check (ConditionPathExists=!/run/initramfs/fsck-root).
Mar 06 11:22:26 daniel-tablet1 systemd[1]: Starting systemd-fsck@dev-disk-by\x2duuid-69452394\x2d6e8e\x2d4a5b\x2d9116\x2d0a8402d66401.service - File System Check on /dev/disk/by-uuid/69452394-6e8e-4a5b-9116-0a8402d66401...
Mar 06 11:22:26 daniel-tablet1 systemd[1]: systemd-hibernate-clear.service - Clear Stale Hibernate Storage Info was skipped because of an unmet condition check (ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
Mar 06 11:22:26 daniel-tablet1 systemd[1]: systemd-hwdb-update.service - Rebuild Hardware Database was skipped because of an unmet condition check (ConditionNeedsUpdate=/etc).
Mar 06 11:22:26 daniel-tablet1 systemd[1]: systemd-pcrmachine.service - TPM PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
Mar 06 11:22:26 daniel-tablet1 systemd[1]: systemd-sysusers.service - Create System Users was skipped because no trigger condition checks were met.
Mar 06 11:22:26 daniel-tablet1 systemd[1]: systemd-firstboot.service - First Boot Wizard was skipped because of an unmet condition check (ConditionFirstBoot=yes).
Mar 06 11:22:26 daniel-tablet1 systemd[1]: systemd-tpm2-setup-early.service - Early TPM SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
Mar 06 11:22:26 daniel-tablet1 systemd[1]: emergency.service: Deactivated successfully.
Mar 06 11:22:26 daniel-tablet1 systemd[1]: Stopped emergency.service - Emergency Shell.
Mar 06 11:22:26 daniel-tablet1 systemd-fsck[675]: /dev/nvme0n1p6 contains a file system with errors, check forced.
Mar 06 11:22:26 daniel-tablet1 kernel: acpi PNP0A05:00: No SoundWire links detected
Mar 06 11:22:26 daniel-tablet1 systemd-fsck[675]: /dev/nvme0n1p6: Entry '..' in /???/??? (17) has deleted/unused inode 13.  CLEARED.
Mar 06 11:22:26 daniel-tablet1 systemd-fsck[675]: /dev/nvme0n1p6: Unconnected directory inode 17 (was in /???)
Mar 06 11:22:26 daniel-tablet1 systemd-fsck[675]: /dev/nvme0n1p6: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.
Mar 06 11:22:26 daniel-tablet1 systemd-fsck[675]:         (i.e., without -a or -p options)
Mar 06 11:22:26 daniel-tablet1 systemd-fsck[666]: fsck failed with exit status 4.
Mar 06 11:22:26 daniel-tablet1 (udev-worker)[408]: event19: Process '/bin/input-remapper-control --command autoload --device /dev/input/event19' failed with exit code 5.
Mar 06 11:22:26 daniel-tablet1 kernel: ipts: unknown parameter 'gen7mt' ignored
Mar 06 11:22:26 daniel-tablet1 (udev-worker)[429]: event20: Process '/bin/input-remapper-control --command autoload --device /dev/input/event20' failed with exit code 5.
Mar 06 11:22:26 daniel-tablet1 kernel: ipts 0000:00:16.4-3e8d0870-271a-4208-8eb5-9acb9402ae04: Starting IPTS
Mar 06 11:22:26 daniel-tablet1 kernel: ipts 0000:00:16.4-3e8d0870-271a-4208-8eb5-9acb9402ae04: IPTS EDS Version: 2
Mar 06 11:22:26 daniel-tablet1 kernel: ipts 0000:00:16.4-3e8d0870-271a-4208-8eb5-9acb9402ae04: IPTS running in poll mode
Mar 06 11:22:26 daniel-tablet1 kernel: input: IPTS 045E:099F Touchscreen as /devices/pci0000:00/0000:00:16.4/0000:00:16.4-3e8d0870-271a-4208-8eb5-9acb9402ae04/0000:045E:099F.0003/input/input31
Mar 06 11:22:26 daniel-tablet1 kernel: mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
Mar 06 11:22:26 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dvdd not found, using dummy regulator
Mar 06 11:22:26 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dovdd not found, using dummy regulator
Mar 06 11:22:26 daniel-tablet1 kernel: input: IPTS 045E:099F as /devices/pci0000:00/0000:00:16.4/0000:00:16.4-3e8d0870-271a-4208-8eb5-9acb9402ae04/0000:045E:099F.0003/input/input32
Mar 06 11:22:26 daniel-tablet1 kernel: input: IPTS 045E:099F as /devices/pci0000:00/0000:00:16.4/0000:00:16.4-3e8d0870-271a-4208-8eb5-9acb9402ae04/0000:045E:099F.0003/input/input33
Mar 06 11:22:26 daniel-tablet1 kernel: input: IPTS 045E:099F as /devices/pci0000:00/0000:00:16.4/0000:00:16.4-3e8d0870-271a-4208-8eb5-9acb9402ae04/0000:045E:099F.0003/input/input34
Mar 06 11:22:26 daniel-tablet1 kernel: input: IPTS 045E:099F as /devices/pci0000:00/0000:00:16.4/0000:00:16.4-3e8d0870-271a-4208-8eb5-9acb9402ae04/0000:045E:099F.0003/input/input35
Mar 06 11:22:26 daniel-tablet1 kernel: input: IPTS 045E:099F Stylus as /devices/pci0000:00/0000:00:16.4/0000:00:16.4-3e8d0870-271a-4208-8eb5-9acb9402ae04/0000:045E:099F.0003/input/input36
Mar 06 11:22:26 daniel-tablet1 kernel: input: IPTS 045E:099F as /devices/pci0000:00/0000:00:16.4/0000:00:16.4-3e8d0870-271a-4208-8eb5-9acb9402ae04/0000:045E:099F.0003/input/input37
Mar 06 11:22:26 daniel-tablet1 kernel: input: IPTS 045E:099F as /devices/pci0000:00/0000:00:16.4/0000:00:16.4-3e8d0870-271a-4208-8eb5-9acb9402ae04/0000:045E:099F.0003/input/input38
Mar 06 11:22:27 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dvdd not found, using dummy regulator
Mar 06 11:22:27 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dovdd not found, using dummy regulator
Mar 06 11:22:27 daniel-tablet1 systemd-fsck[640]: /dev/nvme0n1p7: Entry '..' in /tmp/???/??? (137) has deleted/unused inode 120.  CLEARED.
Mar 06 11:22:27 daniel-tablet1 systemd-fsck[640]: /dev/nvme0n1p7: Entry '..' in /tmp/???/??? (195) has deleted/unused inode 167.  CLEARED.
Mar 06 11:22:27 daniel-tablet1 kernel: iwlwifi 0000:00:14.3 wlp0s20f3: renamed from wlan0
Mar 06 11:22:27 daniel-tablet1 (udev-worker)[405]: input30: Process '/bin/input-remapper-control --command autoload --device ' failed with exit code 2.
Mar 06 11:22:27 daniel-tablet1 kernel: spi-nor spi0.0: supply vcc not found, using dummy regulator
Mar 06 11:22:27 daniel-tablet1 kernel: hid-generic 0000:045E:099F.0003: input,hidraw2: <UNKNOWN> HID v0.00 Device [IPTS 045E:099F] on
Mar 06 11:22:27 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dvdd not found, using dummy regulator
Mar 06 11:22:27 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dovdd not found, using dummy regulator
Mar 06 11:22:27 daniel-tablet1 kernel: Creating 1 MTD partitions on "0000:00:1f.5":
Mar 06 11:22:27 daniel-tablet1 kernel: 0x000000000000-0x000001000000 : "BIOS"
Mar 06 11:22:27 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dvdd not found, using dummy regulator
Mar 06 11:22:27 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dovdd not found, using dummy regulator
Mar 06 11:22:27 daniel-tablet1 (udev-worker)[403]: event16: Process '/bin/input-remapper-control --command autoload --device /dev/input/event16' failed with exit code 5.
Mar 06 11:22:27 daniel-tablet1 kernel: Bluetooth: hci0: Waiting for firmware download to complete
Mar 06 11:22:27 daniel-tablet1 kernel: Bluetooth: hci0: Firmware loaded in 1606261 usecs
Mar 06 11:22:27 daniel-tablet1 kernel: Bluetooth: hci0: Waiting for device to boot
Mar 06 11:22:27 daniel-tablet1 kernel: Bluetooth: hci0: Device booted in 14624 usecs
Mar 06 11:22:27 daniel-tablet1 kernel: Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-19-32-4.ddc
Mar 06 11:22:27 daniel-tablet1 kernel: Bluetooth: hci0: Applying Intel DDC parameters completed
Mar 06 11:22:27 daniel-tablet1 kernel: Bluetooth: hci0: Firmware revision 0.4 build 193 week 33 2024
Mar 06 11:22:27 daniel-tablet1 kernel: Bluetooth: hci0: HCI LE Coded PHY feature bit is set, but its usage is not supported.
Mar 06 11:22:27 daniel-tablet1 kernel: acpi PNP0A05:00: No SoundWire links detected
Mar 06 11:22:27 daniel-tablet1 kernel: acpi PNP0A05:00: No SoundWire links detected
Mar 06 11:22:27 daniel-tablet1 kernel: snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
Mar 06 11:22:27 daniel-tablet1 kernel: snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops intel_audio_component_bind_ops [i915])
Mar 06 11:22:27 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dvdd not found, using dummy regulator
Mar 06 11:22:27 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dovdd not found, using dummy regulator
Mar 06 11:22:27 daniel-tablet1 (udev-worker)[410]: input37: Process '/bin/input-remapper-control --command autoload --device ' failed with exit code 2.
Mar 06 11:22:27 daniel-tablet1 (udev-worker)[428]: input35: Process '/bin/input-remapper-control --command autoload --device ' failed with exit code 2.
Mar 06 11:22:27 daniel-tablet1 kernel: snd_hda_codec_alc269 hdaudioC0D0: autoconfig for ALC274: line_outs=1 (0x1b/0x0/0x0/0x0/0x0) type:speaker
Mar 06 11:22:27 daniel-tablet1 kernel: snd_hda_codec_alc269 hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
Mar 06 11:22:27 daniel-tablet1 kernel: snd_hda_codec_alc269 hdaudioC0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
Mar 06 11:22:27 daniel-tablet1 kernel: snd_hda_codec_alc269 hdaudioC0D0:    mono: mono_out=0x0
Mar 06 11:22:27 daniel-tablet1 kernel: snd_hda_codec_alc269 hdaudioC0D0:    inputs:
Mar 06 11:22:27 daniel-tablet1 kernel: snd_hda_codec_alc269 hdaudioC0D0:      Internal Mic=0x12
Mar 06 11:22:27 daniel-tablet1 kernel: snd_hda_codec_alc269 hdaudioC0D0:      Mic=0x19
Mar 06 11:22:27 daniel-tablet1 systemd-fsck[640]: /dev/nvme0n1p7: Unconnected directory inode 137 (was in /tmp/???)
Mar 06 11:22:27 daniel-tablet1 systemd-fsck[640]: /dev/nvme0n1p7: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.
Mar 06 11:22:27 daniel-tablet1 systemd-fsck[640]:         (i.e., without -a or -p options)
Mar 06 11:22:27 daniel-tablet1 systemd-fsck[636]: fsck failed with exit status 4.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: systemd-fsck@dev-disk-by\x2duuid-46916dcd\x2dc245\x2d4384\x2dbbaf\x2d2f9460979425.service: Main process exited, code=exited, status=1/FAILURE
Mar 06 11:22:27 daniel-tablet1 systemd[1]: systemd-fsck@dev-disk-by\x2duuid-46916dcd\x2dc245\x2d4384\x2dbbaf\x2d2f9460979425.service: Failed with result 'exit-code'.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: Failed to start systemd-fsck@dev-disk-by\x2duuid-46916dcd\x2dc245\x2d4384\x2dbbaf\x2d2f9460979425.service - File System Check on /dev/disk/by-uuid/46916dcd-c245-4384-bbaf-2f9460979425.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: Dependency failed for var.mount - /var.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: Dependency failed for local-fs.target - Local File Systems.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: local-fs.target: Job local-fs.target/start failed with result 'dependency'.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: local-fs.target: Triggering OnFailure= dependencies.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: Dependency failed for var-lib-gdm3.mount - /var/lib/gdm3.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: var-lib-gdm3.mount: Job var-lib-gdm3.mount/start failed with result 'dependency'.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: Dependency failed for systemd-random-seed.service - Load/Save OS Random Seed.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: systemd-random-seed.service: Job systemd-random-seed.service/start failed with result 'dependency'.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: Dependency failed for systemd-tpm2-setup.service - TPM SRK Setup.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: systemd-tpm2-setup.service: Job systemd-tpm2-setup.service/start failed with result 'dependency'.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: Dependency failed for systemd-rfkill.socket - Load/Save RF Kill Switch Status /dev/rfkill Watch.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: systemd-rfkill.socket: Job systemd-rfkill.socket/start failed with result 'dependency'.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: Dependency failed for systemd-journal-flush.service - Flush Journal to Persistent Storage.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: systemd-journal-flush.service: Job systemd-journal-flush.service/start failed with result 'dependency'.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: Dependency failed for apparmor.service - Load AppArmor profiles.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: apparmor.service: Job apparmor.service/start failed with result 'dependency'.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: Dependency failed for systemd-resolved.service - Network Name Resolution.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: systemd-resolved.service: Job systemd-resolved.service/start failed with result 'dependency'.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: Dependency failed for systemd-pstore.service - Platform Persistent Storage Archival.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: systemd-pstore.service: Job systemd-pstore.service/start failed with result 'dependency'.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: var.mount: Job var.mount/start failed with result 'dependency'.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: modprobe@efi_pstore.service: Deactivated successfully.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: Finished modprobe@efi_pstore.service - Load Kernel Module efi_pstore.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: systemd-fsck@dev-disk-by\x2duuid-69452394\x2d6e8e\x2d4a5b\x2d9116\x2d0a8402d66401.service: Main process exited, code=exited, status=1/FAILURE
Mar 06 11:22:27 daniel-tablet1 systemd[1]: systemd-fsck@dev-disk-by\x2duuid-69452394\x2d6e8e\x2d4a5b\x2d9116\x2d0a8402d66401.service: Failed with result 'exit-code'.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: Failed to start systemd-fsck@dev-disk-by\x2duuid-69452394\x2d6e8e\x2d4a5b\x2d9116\x2d0a8402d66401.service - File System Check on /dev/disk/by-uuid/69452394-6e8e-4a5b-9116-0a8402d66401.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: Dependency failed for tmp.mount - /tmp.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: tmp.mount: Job tmp.mount/start failed with result 'dependency'.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: Requested transaction contradicts existing jobs: Resource deadlock avoided
Mar 06 11:22:27 daniel-tablet1 systemd[1]: Requested transaction contradicts existing jobs: Resource deadlock avoided
Mar 06 11:22:27 daniel-tablet1 (udev-worker)[408]: input31: Process '/bin/input-remapper-control --command autoload --device ' failed with exit code 2.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: Created slice system-systemd\x2dbacklight.slice - Slice /system/systemd-backlight.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: Reached target bluetooth.target - Bluetooth Support.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: first-boot-complete.target - First Boot Complete was skipped because of an unmet condition check (ConditionFirstBoot=yes).
Mar 06 11:22:27 daniel-tablet1 systemd[1]: Starting systemd-fsck@dev-disk-by\x2duuid-46916dcd\x2dc245\x2d4384\x2dbbaf\x2d2f9460979425.service - File System Check on /dev/disk/by-uuid/46916dcd-c245-4384-bbaf-2f9460979425...
Mar 06 11:22:27 daniel-tablet1 systemd[1]: systemd-machine-id-commit.service - Save Transient machine-id to Disk was skipped because of an unmet condition check (ConditionPathIsMountPoint=/etc/machine-id).
Mar 06 11:22:27 daniel-tablet1 systemd[1]: Started emergency.service - Emergency Shell.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: Reached target emergency.target - Emergency Mode.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: ldconfig.service - Rebuild Dynamic Linker Cache was skipped because no trigger condition checks were met.
Mar 06 11:22:27 daniel-tablet1 systemd[1]: systemd-journal-catalog-update.service - Rebuild Journal Catalog was skipped because of an unmet condition check (ConditionNeedsUpdate=/var).
Mar 06 11:22:27 daniel-tablet1 systemd[1]: systemd-pcrphase-sysinit.service - TPM PCR Barrier (Initialization) was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
Mar 06 11:22:27 daniel-tablet1 systemd[1]: systemd-update-done.service - Update is Completed was skipped because no trigger condition checks were met.
Mar 06 11:22:27 daniel-tablet1 systemd-fsck[764]: /dev/nvme0n1p7 contains a file system with errors, check forced.
Mar 06 11:22:27 daniel-tablet1 (udev-worker)[437]: input32: Process '/bin/input-remapper-control --command autoload --device ' failed with exit code 2.
Mar 06 11:22:27 daniel-tablet1 (udev-worker)[402]: input38: Process '/bin/input-remapper-control --command autoload --device ' failed with exit code 2.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[401]: event4: Process '/bin/input-remapper-control --command autoload --device /dev/input/event4' failed with exit code 5.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[424]: event15: Process '/bin/input-remapper-control --command autoload --device /dev/input/event15' failed with exit code 5.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[429]: input36: Process '/bin/input-remapper-control --command autoload --device ' failed with exit code 2.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[426]: event10: Process '/bin/input-remapper-control --command autoload --device /dev/input/event10' failed with exit code 5.
Mar 06 11:22:28 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dvdd not found, using dummy regulator
Mar 06 11:22:28 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dovdd not found, using dummy regulator
Mar 06 11:22:28 daniel-tablet1 kernel: input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input39
Mar 06 11:22:28 daniel-tablet1 kernel: input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input40
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[412]: event5: Process '/bin/input-remapper-control --command autoload --device /dev/input/event5' failed with exit code 5.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[412]: controlC0: Process '/usr/sbin/alsactl -E HOME=/run/alsa -E XDG_RUNTIME_DIR=/run/alsa/runtime restore 0' failed with exit code 2.
Mar 06 11:22:28 daniel-tablet1 systemd[1]: Reached target sound.target - Sound Card.
Mar 06 11:22:28 daniel-tablet1 systemd-fsck[764]: /dev/nvme0n1p7: Entry '..' in /tmp/???/??? (137) has deleted/unused inode 120.  CLEARED.
Mar 06 11:22:28 daniel-tablet1 systemd-fsck[764]: /dev/nvme0n1p7: Entry '..' in /tmp/???/??? (195) has deleted/unused inode 167.  CLEARED.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[415]: mouse1: Process '/bin/input-remapper-control --command autoload --device /dev/input/mouse1' failed with exit code 5.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[414]: event9: Process '/bin/input-remapper-control --command autoload --device /dev/input/event9' failed with exit code 5.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[419]: event13: Process '/bin/input-remapper-control --command autoload --device /dev/input/event13' failed with exit code 5.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[405]: event21: Process '/bin/input-remapper-control --command autoload --device /dev/input/event21' failed with exit code 5.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[417]: event1: Process '/bin/input-remapper-control --command autoload --device /dev/input/event1' failed with exit code 5.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[418]: event0: Process '/bin/input-remapper-control --command autoload --device /dev/input/event0' failed with exit code 5.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[413]: event18: Process '/bin/input-remapper-control --command autoload --device /dev/input/event18' failed with exit code 5.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[423]: input34: Process '/bin/input-remapper-control --command autoload --device ' failed with exit code 2.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[422]: event6: Process '/bin/input-remapper-control --command autoload --device /dev/input/event6' failed with exit code 5.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[420]: event8: Process '/bin/input-remapper-control --command autoload --device /dev/input/event8' failed with exit code 5.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[430]: event7: Process '/bin/input-remapper-control --command autoload --device /dev/input/event7' failed with exit code 5.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[416]: mouse0: Process '/bin/input-remapper-control --command autoload --device /dev/input/mouse0' failed with exit code 5.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[406]: event12: Process '/bin/input-remapper-control --command autoload --device /dev/input/event12' failed with exit code 5.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[425]: input33: Process '/bin/input-remapper-control --command autoload --device ' failed with exit code 2.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[411]: event3: Process '/bin/input-remapper-control --command autoload --device /dev/input/event3' failed with exit code 5.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[421]: event17: Process '/bin/input-remapper-control --command autoload --device /dev/input/event17' failed with exit code 5.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[407]: event11: Process '/bin/input-remapper-control --command autoload --device /dev/input/event11' failed with exit code 5.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[431]: event14: Process '/bin/input-remapper-control --command autoload --device /dev/input/event14' failed with exit code 5.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[427]: event2: Process '/bin/input-remapper-control --command autoload --device /dev/input/event2' failed with exit code 5.
Mar 06 11:22:28 daniel-tablet1 systemd-fsck[764]: /dev/nvme0n1p7: Unconnected directory inode 137 (was in /tmp/???)
Mar 06 11:22:28 daniel-tablet1 systemd-fsck[764]: /dev/nvme0n1p7: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.
Mar 06 11:22:28 daniel-tablet1 systemd-fsck[764]:         (i.e., without -a or -p options)
Mar 06 11:22:28 daniel-tablet1 systemd-fsck[755]: fsck failed with exit status 4.
Mar 06 11:22:28 daniel-tablet1 systemd[1]: systemd-fsck@dev-disk-by\x2duuid-46916dcd\x2dc245\x2d4384\x2dbbaf\x2d2f9460979425.service: Main process exited, code=exited, status=1/FAILURE
Mar 06 11:22:28 daniel-tablet1 systemd[1]: systemd-fsck@dev-disk-by\x2duuid-46916dcd\x2dc245\x2d4384\x2dbbaf\x2d2f9460979425.service: Failed with result 'exit-code'.
Mar 06 11:22:28 daniel-tablet1 systemd[1]: Failed to start systemd-fsck@dev-disk-by\x2duuid-46916dcd\x2dc245\x2d4384\x2dbbaf\x2d2f9460979425.service - File System Check on /dev/disk/by-uuid/46916dcd-c245-4384-bbaf-2f9460979425.
Mar 06 11:22:28 daniel-tablet1 systemd[1]: Dependency failed for var.mount - /var.
Mar 06 11:22:28 daniel-tablet1 systemd[1]: Dependency failed for systemd-backlight@backlight:intel_backlight.service - Load/Save Screen Backlight Brightness of backlight:intel_backlight.
Mar 06 11:22:28 daniel-tablet1 systemd[1]: systemd-backlight@backlight:intel_backlight.service: Job systemd-backlight@backlight:intel_backlight.service/start failed with result 'dependency'.
Mar 06 11:22:28 daniel-tablet1 systemd[1]: var.mount: Job var.mount/start failed with result 'dependency'.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[402]: event29: Process '/bin/input-remapper-control --command autoload --device /dev/input/event29' failed with exit code 5.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[409]: event28: Process '/bin/input-remapper-control --command autoload --device /dev/input/event28' failed with exit code 5.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[401]: mouse3: Process '/bin/input-remapper-control --command autoload --device /dev/input/mouse3' failed with exit code 5.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[428]: event26: Process '/bin/input-remapper-control --command autoload --device /dev/input/event26' failed with exit code 5.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[410]: event22: Process '/bin/input-remapper-control --command autoload --device /dev/input/event22' failed with exit code 5.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[437]: event23: Process '/bin/input-remapper-control --command autoload --device /dev/input/event23' failed with exit code 5.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[424]: event27: Process '/bin/input-remapper-control --command autoload --device /dev/input/event27' failed with exit code 5.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[426]: input40: Process '/bin/input-remapper-control --command autoload --device ' failed with exit code 2.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[404]: input39: Process '/bin/input-remapper-control --command autoload --device ' failed with exit code 2.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[408]: mouse2: Process '/bin/input-remapper-control --command autoload --device /dev/input/mouse2' failed with exit code 5.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[418]: event25: Process '/bin/input-remapper-control --command autoload --device /dev/input/event25' failed with exit code 5.
Mar 06 11:22:28 daniel-tablet1 (udev-worker)[403]: event24: Process '/bin/input-remapper-control --command autoload --device /dev/input/event24' failed with exit code 5.
Mar 06 11:22:29 daniel-tablet1 (udev-worker)[411]: event31: Process '/bin/input-remapper-control --command autoload --device /dev/input/event31' failed with exit code 5.
Mar 06 11:22:29 daniel-tablet1 (udev-worker)[426]: event30: Process '/bin/input-remapper-control --command autoload --device /dev/input/event30' failed with exit code 5.
Mar 06 11:22:32 daniel-tablet1 systemd[1]: Received SIGRTMIN+21 from PID 257 (plymouthd).
Mar 06 11:22:32 daniel-tablet1 systemd-tty-ask-password-agent[483]: Failed to query password: Input/output error
Mar 06 11:22:32 daniel-tablet1 systemd-tty-ask-password-agent[483]: Failed to process password, ignoring: Input/output error
Mar 06 11:22:32 daniel-tablet1 kernel: fbcon: Taking over console
Mar 06 11:22:33 daniel-tablet1 kernel: Console: switching to colour frame buffer device 171x57
Mar 06 11:22:38 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dvdd not found, using dummy regulator
Mar 06 11:22:38 daniel-tablet1 kernel: ov8865 i2c-INT347A:00: supply dovdd not found, using dummy regulator
Mar 06 11:22:38 daniel-tablet1 kernel: i2c i2c-INT347A:00: deferred probe pending: ov8865: waiting for fwnode graph endpoint
Mar 06 11:22:38 daniel-tablet1 kernel: i2c i2c-INT33BE:00: deferred probe pending: ov5693: waiting for fwnode graph endpoint
Mar 06 11:22:38 daniel-tablet1 kernel: i2c i2c-INT347E:00: deferred probe pending: ov7251: waiting for fwnode graph endpoint
Mar 06 11:23:41 daniel-tablet1 kernel: EXT4-fs (nvme0n1p8): re-mounted 36fa67db-bdeb-4537-a4b0-4b001d623ccf r/w.

--nextPart3413652.mvXUDI8C0e
Content-Type: application/octet-stream; name=""
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=""


--nextPart3413652.mvXUDI8C0e--

--nextPart2937681.3ZeAukHxDK
Content-Type: application/octet-stream; name=""
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=""


--nextPart2937681.3ZeAukHxDK--

--nextPart2828550.3Lj2Plt8kZ
Content-Disposition: attachment; filename="logdump202603061245390001.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8";
 name="logdump202603061245390001.txt"

Journal starts at block 0, transaction 6986

*** Fast Commit Area ***
tag HEAD, features 0x0, tid 7009
tag ADD_RANGE, inode 471162, lblk 0, pblk 6492160, len 25
tag INODE, inode 471162
tag TAIL, tid 7009
tag ADD_ENTRY, parent 451, ino 471162, name "qqpc_opengl.qdbFsX"
tag DEL_ENTRY, parent 451, ino 408852, name "qqpc_opengl"
tag ADD_ENTRY, parent 451, ino 471162, name "qqpc_opengl"
tag DEL_ENTRY, parent 451, ino 471162, name "qqpc_opengl.qdbFsX"
tag INODE, inode 471162
tag ADD_RANGE, inode 408852, lblk 0, pblk 6307264, len 25
tag INODE, inode 408852
tag TAIL, tid 7009
tag ADD_ENTRY, parent 451, ino 408852, name "qqpc_opengl.biaKqC"
tag DEL_ENTRY, parent 451, ino 471162, name "qqpc_opengl"
tag ADD_ENTRY, parent 451, ino 408852, name "qqpc_opengl"
tag DEL_ENTRY, parent 451, ino 408852, name "qqpc_opengl.biaKqC"
tag INODE, inode 408852
tag ADD_RANGE, inode 471162, lblk 0, pblk 6494304, len 25
tag INODE, inode 471162
tag TAIL, tid 7009
tag ADD_ENTRY, parent 451, ino 471162, name "qqpc_opengl.oWYZQg"
tag DEL_ENTRY, parent 451, ino 408852, name "qqpc_opengl"
tag ADD_ENTRY, parent 451, ino 471162, name "qqpc_opengl"
tag DEL_ENTRY, parent 451, ino 471162, name "qqpc_opengl.oWYZQg"
tag INODE, inode 471162
tag ADD_RANGE, inode 125, lblk 0, pblk 4286035, len 2
tag DEL_RANGE, inode 125, lblk 2, len 2147483647
tag DEL_RANGE, inode 125, lblk -2147483647, len 2147483646
tag INODE, inode 125
tag ADD_RANGE, inode 438344, lblk 0, pblk 5707842, len 1
tag INODE, inode 438344
tag ADD_RANGE, inode 408852, lblk 0, pblk 6307680, len 25
tag INODE, inode 408852
tag TAIL, tid 7009
tag ADD_ENTRY, parent 451, ino 408852, name "qqpc_opengl.PDhvmH"
tag DEL_ENTRY, parent 451, ino 471162, name "qqpc_opengl"
tag ADD_ENTRY, parent 451, ino 408852, name "qqpc_opengl"
tag DEL_ENTRY, parent 451, ino 408852, name "qqpc_opengl.PDhvmH"
tag INODE, inode 408852
tag ADD_RANGE, inode 471162, lblk 0, pblk 6508576, len 25
tag INODE, inode 471162
tag TAIL, tid 7009
tag INODE, inode 478143
tag ADD_RANGE, inode 438346, lblk 0, pblk 5702656, len 41
tag INODE, inode 438346
tag ADD_RANGE, inode 478144, lblk 0, pblk 5704704, len 45
tag INODE, inode 478144
tag ADD_RANGE, inode 478146, lblk 0, pblk 5706112, len 44
tag INODE, inode 478146
tag ADD_RANGE, inode 477211, lblk 0, pblk 5704429, len 4
tag INODE, inode 477211
tag ADD_RANGE, inode 466851, lblk 0, pblk 5704433, len 4
tag INODE, inode 466851
tag ADD_RANGE, inode 466286, lblk 0, pblk 5704437, len 4
tag INODE, inode 466286
tag ADD_RANGE, inode 408852, lblk 0, pblk 2684416, len 25
tag INODE, inode 408852
tag TAIL, tid 7007
tag ADD_ENTRY, parent 451, ino 408852, name "qqpc_opengl.NTRAgI"
tag DEL_ENTRY, parent 451, ino 471746, name "qqpc_opengl"
tag ADD_ENTRY, parent 451, ino 408852, name "qqpc_opengl"
tag DEL_ENTRY, parent 451, ino 408852, name "qqpc_opengl.NTRAgI"
tag INODE, inode 408852
tag ADD_RANGE, inode 471162, lblk 0, pblk 6508608, len 25
tag INODE, inode 471162
tag TAIL, tid 7007
tag ADD_ENTRY, parent 451, ino 471162, name "qqpc_opengl.xTQtml"
tag DEL_ENTRY, parent 451, ino 408852, name "qqpc_opengl"
tag ADD_ENTRY, parent 451, ino 471162, name "qqpc_opengl"
tag DEL_ENTRY, parent 451, ino 471162, name "qqpc_opengl.xTQtml"
tag INODE, inode 471162
tag INODE, inode 469266
tag ADD_RANGE, inode 408852, lblk 0, pblk 6307264, len 25
tag INODE, inode 408852
tag TAIL, tid 7007
tag ADD_ENTRY, parent 25, ino 478153, name "plasma-org.kde.plasma.desktop-appletsrc.iiUTGN"
tag DEL_ENTRY, parent 25, ino 471829, name "plasma-org.kde.plasma.desktop-appletsrc"
tag ADD_ENTRY, parent 25, ino 478153, name "plasma-org.kde.plasma.desktop-appletsrc"
tag DEL_ENTRY, parent 25, ino 478153, name "plasma-org.kde.plasma.desktop-appletsrc.iiUTGN"
tag DEL_ENTRY, parent 25, ino 471162, name "plasma-org.kde.plasma.desktop-appletsrc.lock"
tag DEL_ENTRY, parent 406471, ino 408928, name ".startup-incomplete"
tag INODE, inode 408928
tag ADD_RANGE, inode 408928, lblk 0, pblk 5703695, len 5
tag CREAT_DENTRY, parent 406467, ino 408928, name "prefs-1.js"
tag INODE, inode 478153
tag ADD_RANGE, inode 125, lblk 0, pblk 4286015, len 2
tag DEL_RANGE, inode 125, lblk 2, len 2147483647
tag DEL_RANGE, inode 125, lblk -2147483647, len 2147483646
tag INODE, inode 125
tag INODE, inode 408928
tag TAIL, tid 7006
tag ADD_ENTRY, parent 406670, ino 477194, name "9279c232-606b-4e79-8cd4-5064bc02c3b0"
tag DEL_ENTRY, parent 406673, ino 477194, name "9279c232-606b-4e79-8cd4-5064bc02c3b0"
tag DEL_ENTRY, parent 406667, ino 477190, name "data.safe.bin"
tag ADD_ENTRY, parent 406667, ino 477211, name "data.safe.bin"
tag DEL_ENTRY, parent 406667, ino 477211, name "data.safe.tmp"
tag DEL_ENTRY, parent 406667, ino 477211, name "data.safe.bin"
tag ADD_ENTRY, parent 406667, ino 477190, name "data.safe.bin"
tag DEL_ENTRY, parent 406667, ino 477190, name "data.safe.tmp"
tag DEL_ENTRY, parent 406667, ino 477190, name "data.safe.bin"
tag ADD_ENTRY, parent 406667, ino 477211, name "data.safe.bin"
tag DEL_ENTRY, parent 406667, ino 477211, name "data.safe.tmp"
tag DEL_ENTRY, parent 406667, ino 477211, name "data.safe.bin"
tag ADD_ENTRY, parent 406667, ino 477190, name "data.safe.bin"
tag DEL_ENTRY, parent 406667, ino 477190, name "data.safe.tmp"
tag DEL_ENTRY, parent 406667, ino 477190, name "data.safe.bin"
tag ADD_ENTRY, parent 406667, ino 477211, name "data.safe.bin"
tag DEL_ENTRY, parent 406667, ino 477211, name "data.safe.tmp"
tag DEL_ENTRY, parent 406667, ino 477211, name "data.safe.bin"
tag ADD_ENTRY, parent 406667, ino 477190, name "data.safe.bin"
tag DEL_ENTRY, parent 406667, ino 477190, name "data.safe.tmp"
tag DEL_ENTRY, parent 406667, ino 477190, name "data.safe.bin"
tag ADD_ENTRY, parent 406667, ino 477211, name "data.safe.bin"
tag DEL_ENTRY, parent 406667, ino 477211, name "data.safe.tmp"
tag DEL_ENTRY, parent 406667, ino 477211, name "data.safe.bin"
tag ADD_ENTRY, parent 406667, ino 477190, name "data.safe.bin"
tag DEL_ENTRY, parent 406667, ino 477190, name "data.safe.tmp"
tag DEL_ENTRY, parent 406667, ino 477190, name "data.safe.bin"
tag ADD_ENTRY, parent 406667, ino 477211, name "data.safe.bin"
tag DEL_ENTRY, parent 406667, ino 477211, name "data.safe.tmp"
tag DEL_ENTRY, parent 406667, ino 477211, name "data.safe.bin"
tag ADD_ENTRY, parent 406667, ino 477190, name "data.safe.bin"
tag DEL_ENTRY, parent 406667, ino 477190, name "data.safe.tmp"
tag DEL_ENTRY, parent 406667, ino 477190, name "data.safe.bin"
tag ADD_ENTRY, parent 406667, ino 477211, name "data.safe.bin"
tag DEL_ENTRY, parent 406667, ino 477211, name "data.safe.tmp"
tag DEL_ENTRY, parent 406667, ino 477211, name "data.safe.bin"
tag ADD_ENTRY, parent 406667, ino 477190, name "data.safe.bin"
tag DEL_ENTRY, parent 406667, ino 477190, name "data.safe.tmp"
tag INODE, inode 477211
tag CREAT_DENTRY, parent 406673, ino 477211, name "3f1609f1-1484-488b-9d8f-35a86fb74ecd"
tag ADD_ENTRY, parent 406670, ino 477211, name "3f1609f1-1484-488b-9d8f-35a86fb74ecd"
tag DEL_ENTRY, parent 406673, ino 477211, name "3f1609f1-1484-488b-9d8f-35a86fb74ecd"
tag DEL_ENTRY, parent 406667, ino 477190, name "data.safe.bin"
tag ADD_ENTRY, parent 406667, ino 477362, name "data.safe.bin"
tag DEL_ENTRY, parent 406667, ino 477362, name "data.safe.tmp"
tag DEL_ENTRY, parent 406667, ino 477362, name "data.safe.bin"
tag ADD_ENTRY, parent 406667, ino 477190, name "data.safe.bin"
tag DEL_ENTRY, parent 406667, ino 477190, name "data.safe.tmp"
tag DEL_ENTRY, parent 406667, ino 477190, name "data.safe.bin"
tag ADD_ENTRY, parent 406667, ino 477362, name "data.safe.bin"
tag DEL_ENTRY, parent 406667, ino 477362, name "data.safe.tmp"
tag DEL_ENTRY, parent 406667, ino 477362, name "data.safe.bin"
tag ADD_ENTRY, parent 406667, ino 477190, name "data.safe.bin"
tag DEL_ENTRY, parent 406667, ino 477190, name "data.safe.tmp"
tag DEL_ENTRY, parent 406667, ino 477190, name "data.safe.bin"
tag ADD_ENTRY, parent 406667, ino 477362, name "data.safe.bin"
tag DEL_ENTRY, parent 406667, ino 477362, name "data.safe.tmp"
tag DEL_ENTRY, parent 406667, ino 477362, name "data.safe.bin"
tag ADD_ENTRY, parent 406667, ino 477190, name "data.safe.bin"
tag DEL_ENTRY, parent 406667, ino 477190, name "data.safe.tmp"
tag DEL_ENTRY, parent 406667, ino 477190, name "data.safe.bin"
tag ADD_ENTRY, parent 406667, ino 477362, name "data.safe.bin"
tag DEL_ENTRY, parent 406667, ino 477362, name "data.safe.tmp"
tag DEL_ENTRY, parent 406667, ino 477362, name "data.safe.bin"
tag ADD_ENTRY, parent 406667, ino 477190, name "data.safe.bin"
tag DEL_ENTRY, parent 406667, ino 477190, name "data.safe.tmp"
tag DEL_ENTRY, parent 406667, ino 477190, name "data.safe.bin"
tag ADD_ENTRY, parent 406667, ino 477362, name "data.safe.bin"
tag DEL_ENTRY, parent 406667, ino 477362, name "data.safe.tmp"
tag DEL_ENTRY, parent 406667, ino 477362, name "data.safe.bin"
tag ADD_ENTRY, parent 406667, ino 477190, name "data.safe.bin"
tag DEL_ENTRY, parent 406667, ino 477190, name "data.safe.tmp"
tag INODE, inode 477362
tag ADD_RANGE, inode 477362, lblk 0, pblk 5703289, len 11
tag CREAT_DENTRY, parent 406667, ino 477362, name "data.safe.tmp"
tag DEL_ENTRY, parent 406667, ino 477190, name "data.safe.bin"
tag ADD_ENTRY, parent 406667, ino 477362, name "data.safe.bin"
tag DEL_ENTRY, parent 406667, ino 477362, name "data.safe.tmp"
tag INODE, inode 477190
tag CREAT_DENTRY, parent 406673, ino 477190, name "c87d2c7b-7b74-428a-855f-43a38f35de05"
tag ADD_ENTRY, parent 406670, ino 477190, name "c87d2c7b-7b74-428a-855f-43a38f35de05"
tag DEL_ENTRY, parent 406673, ino 477190, name "c87d2c7b-7b74-428a-855f-43a38f35de05"
tag INODE, inode 477413
tag ADD_RANGE, inode 477413, lblk 0, pblk 5707805, len 5
tag CREAT_DENTRY, parent 406467, ino 477413, name "prefs-1.js"
tag INODE, inode 471159
tag INODE, inode 438496
tag INODE, inode 469075
tag INODE, inode 406600
tag INODE, inode 2175
tag PAD
tag INODE, inode 471161
tag INODE, inode 476683
tag INODE, inode 476877
tag INODE, inode 469266
tag INODE, inode 475128
tag INODE, inode 477194
tag INODE, inode 477211
tag INODE, inode 477362
tag INODE, inode 477190
tag INODE, inode 477413
tag TAIL, tid 6996
tag DEL_ENTRY, parent 406467, ino 471159, name "prefs.js"
tag ADD_ENTRY, parent 406467, ino 477413, name "prefs.js"
tag DEL_ENTRY, parent 406467, ino 477413, name "prefs-1.js"
tag ADD_ENTRY, parent 407760, ino 478456, name "1299932866"
tag DEL_ENTRY, parent 406487, ino 478456, name "BB95D0607349D05725D5FE01D4FB300E319072AD"
tag INODE, inode 471159
tag CREAT_DENTRY, parent 406487, ino 471159, name "BB95D0607349D05725D5FE01D4FB300E319072AD"
tag INODE, inode 477502
tag DEL_RANGE, inode 477502, lblk 0, len 1
tag CREAT_DENTRY, parent 406467, ino 477502, name "AlternateServices.bin"
tag DEL_ENTRY, parent 406670, ino 438496, name "fe6c2bd5-805a-4ce6-a249-5f6ba8fcafd8"
tag INODE, inode 438496
tag CREAT_DENTRY, parent 406487, ino 438496, name "5E463A77EE0989DC7CA40D1018188AAC496D9FE8"
tag INODE, inode 477543
tag CREAT_DENTRY, parent 406487, ino 477543, name "3190790D82B4FA8996DC085419D9B134861B6EC9"
tag INODE, inode 477813
tag CREAT_DENTRY, parent 406471, ino 477813, name "safebrowsing-updating"
tag INODE, inode 477815
tag CREAT_DENTRY, parent 477813, ino 477815, name "google-trackwhite-digest256.sbstore"
tag INODE, inode 477953
tag CREAT_DENTRY, parent 477813, ino 477953, name "social-tracking-protection-facebook-digest256.sbstore"
tag INODE, inode 477959
tag CREAT_DENTRY, parent 477813, ino 477959, name "google4"
tag INODE, inode 478008
tag CREAT_DENTRY, parent 477959, ino 478008, name "goog-downloadwhite-proto.vlpset"
tag INODE, inode 478009
tag CREAT_DENTRY, parent 477959, ino 478009, name "goog-badbinurl-proto.vlpset"
tag INODE, inode 478012
tag CREAT_DENTRY, parent 477959, ino 478012, name "goog-unwanted-proto.vlpset"
tag INODE, inode 478014
tag CREAT_DENTRY, parent 477959, ino 478014, name "goog-phish-proto.vlpset"
tag INODE, inode 478129
tag CREAT_DENTRY, parent 477959, ino 478129, name "goog-malware-proto.metadata"
tag INODE, inode 478139
tag CREAT_DENTRY, parent 477959, ino 478139, name "goog-phish-proto.metadata"
tag INODE, inode 478224
tag CREAT_DENTRY, parent 477959, ino 478224, name "goog-unwanted-proto.metadata"
tag INODE, inode 478225
tag CREAT_DENTRY, parent 477959, ino 478225, name "goog-badbinurl-proto.metadata"
tag PAD
tag INODE, inode 478228
tag CREAT_DENTRY, parent 477959, ino 478228, name "goog-malware-proto.vlpset"
tag INODE, inode 478232
tag CREAT_DENTRY, parent 477959, ino 478232, name "goog-downloadwhite-proto.metadata"
tag INODE, inode 478235
tag CREAT_DENTRY, parent 477813, ino 478235, name "anti-fraud-track-digest256.vlpset"
tag INODE, inode 478286
tag CREAT_DENTRY, parent 477813, ino 478286, name "base-cryptomining-track-digest256.vlpset"
tag INODE, inode 478471
tag CREAT_DENTRY, parent 477813, ino 478471, name "social-tracking-protection-linkedin-digest256.vlpset"
tag INODE, inode 478475
tag CREAT_DENTRY, parent 477813, ino 478475, name "social-tracking-protection-twitter-digest256.vlpset"
tag INODE, inode 478494
tag CREAT_DENTRY, parent 477813, ino 478494, name "base-fingerprinting-track-digest256.vlpset"
tag INODE, inode 478497
tag CREAT_DENTRY, parent 477813, ino 478497, name "anti-fraud-track-digest256.sbstore"
tag INODE, inode 478498
tag CREAT_DENTRY, parent 477813, ino 478498, name "mozstd-trackwhite-digest256.vlpset"
tag INODE, inode 478499
tag CREAT_DENTRY, parent 477813, ino 478499, name "social-track-digest256.vlpset"
tag INODE, inode 478500
tag CREAT_DENTRY, parent 477813, ino 478500, name "social-tracking-protection-twitter-digest256.sbstore"
tag INODE, inode 478501
tag CREAT_DENTRY, parent 477813, ino 478501, name "consent-manager-track-digest256.sbstore"
tag INODE, inode 478502
tag CREAT_DENTRY, parent 477813, ino 478502, name "content-track-digest256.vlpset"
tag INODE, inode 478503
tag CREAT_DENTRY, parent 477813, ino 478503, name "base-fingerprinting-track-digest256.sbstore"
tag INODE, inode 478504
tag CREAT_DENTRY, parent 477813, ino 478504, name "analytics-track-digest256.vlpset"
tag INODE, inode 478505
tag CREAT_DENTRY, parent 477813, ino 478505, name "google-trackwhite-digest256.vlpset"
tag INODE, inode 478506
tag CREAT_DENTRY, parent 477813, ino 478506, name "ads-track-digest256.vlpset"
tag INODE, inode 478507
tag CREAT_DENTRY, parent 477813, ino 478507, name "content-email-track-digest256.sbstore"
tag PAD
tag INODE, inode 478508
tag CREAT_DENTRY, parent 477813, ino 478508, name "ads-track-digest256.sbstore"
tag INODE, inode 478509
tag CREAT_DENTRY, parent 477813, ino 478509, name "consent-manager-track-digest256.vlpset"
tag INODE, inode 478510
tag CREAT_DENTRY, parent 477813, ino 478510, name "base-email-track-digest256.sbstore"
tag INODE, inode 478511
tag CREAT_DENTRY, parent 477813, ino 478511, name "mozstd-trackwhite-digest256.sbstore"
tag INODE, inode 478512
tag CREAT_DENTRY, parent 477813, ino 478512, name "base-email-track-digest256.vlpset"
tag INODE, inode 478513
tag CREAT_DENTRY, parent 477813, ino 478513, name "social-tracking-protection-linkedin-digest256.sbstore"
tag INODE, inode 478514
tag CREAT_DENTRY, parent 477813, ino 478514, name "content-track-digest256.sbstore"
tag INODE, inode 478515
tag CREAT_DENTRY, parent 477813, ino 478515, name "analytics-track-digest256.sbstore"
tag INODE, inode 478516
tag CREAT_DENTRY, parent 477813, ino 478516, name "base-cryptomining-track-digest256.sbstore"
tag INODE, inode 478517
tag CREAT_DENTRY, parent 477813, ino 478517, name "social-tracking-protection-facebook-digest256.vlpset"
tag INODE, inode 478518
tag CREAT_DENTRY, parent 477813, ino 478518, name "content-email-track-digest256.vlpset"
tag INODE, inode 478519
tag CREAT_DENTRY, parent 477813, ino 478519, name "social-track-digest256.sbstore"
tag INODE, inode 478520
tag CREAT_DENTRY, parent 406487, ino 478520, name "5A76623F431A12FE401D6D72B8CA6E446BDE9569"
tag ADD_ENTRY, parent 407760, ino 477821, name "807541140"
tag DEL_ENTRY, parent 406487, ino 477821, name "6E7C72B58DD19446CD32AC5809F9CF381FDD9B9B"
tag DEL_ENTRY, parent 406670, ino 469075, name "ff0de406-128c-4b90-ba70-a4eec9ac0c1d"
tag INODE, inode 469075
tag CREAT_DENTRY, parent 406487, ino 469075, name "D5005E4197D927545AFDD21200E1F159D54CD20F"
tag INODE, inode 478521
tag CREAT_DENTRY, parent 406487, ino 478521, name "6E7C72B58DD19446CD32AC5809F9CF381FDD9B9B"
tag INODE, inode 477413
tag INODE, inode 470650
tag INODE, inode 406600
tag PAD
tag INODE, inode 478456
tag INODE, inode 471159
tag INODE, inode 406685
tag INODE, inode 406658
tag INODE, inode 477502
tag INODE, inode 438496
tag INODE, inode 477543
tag INODE, inode 477815
tag INODE, inode 477953
tag INODE, inode 478008
tag INODE, inode 478009
tag INODE, inode 478012
tag INODE, inode 478014
tag INODE, inode 478129
tag INODE, inode 478139
tag INODE, inode 478224
tag INODE, inode 478225
tag INODE, inode 478228
tag INODE, inode 478232
tag INODE, inode 478235
tag PAD
tag INODE, inode 478286
tag INODE, inode 478471
tag INODE, inode 478475
tag INODE, inode 478494
tag INODE, inode 478497
tag INODE, inode 478498
tag INODE, inode 478499
tag INODE, inode 478500
tag INODE, inode 478501
tag INODE, inode 478502
tag INODE, inode 478503
tag INODE, inode 478504
tag INODE, inode 478505
tag INODE, inode 478506
tag INODE, inode 478507
tag INODE, inode 478508
tag INODE, inode 478509
tag INODE, inode 478510
tag INODE, inode 478511
tag INODE, inode 478512
tag INODE, inode 478513
tag INODE, inode 478514
tag INODE, inode 478515
tag INODE, inode 478516
tag PAD
tag INODE, inode 478517
tag INODE, inode 478518
tag INODE, inode 478519
tag INODE, inode 478520
tag INODE, inode 477821
tag INODE, inode 469075
tag INODE, inode 478521
tag ADD_RANGE, inode 406498, lblk 0, pblk 4310012, len 1
tag INODE, inode 406498
tag TAIL, tid 6996
tag ADD_ENTRY, parent 393, ino 540, name "close-backdrop-active.svg"
tag DEL_ENTRY, parent 393, ino 541, name "close-backdrop-hover.svg"
tag INODE, inode 540
tag ADD_RANGE, inode 541, lblk 0, pblk 5707780, len 1
tag INODE, inode 541
tag TAIL, tid 6989
tag ADD_ENTRY, parent 393, ino 541, name "close-backdrop-hover.svg"
tag DEL_ENTRY, parent 393, ino 554, name "maximize-normal.svg"
tag INODE, inode 541
tag ADD_RANGE, inode 554, lblk 0, pblk 5707781, len 1
tag INODE, inode 554
tag TAIL, tid 6989
tag ADD_ENTRY, parent 393, ino 554, name "maximize-normal.svg"
tag DEL_ENTRY, parent 393, ino 556, name "maximize-active.svg"
tag INODE, inode 554
tag ADD_RANGE, inode 556, lblk 0, pblk 5707782, len 1
tag INODE, inode 556
tag TAIL, tid 6989
tag ADD_ENTRY, parent 393, ino 556, name "maximize-active.svg"
tag DEL_ENTRY, parent 393, ino 560, name "maximize-hover.svg"
tag INODE, inode 556
tag ADD_RANGE, inode 560, lblk 0, pblk 5707783, len 1
tag INODE, inode 560
tag TAIL, tid 6989
tag ADD_ENTRY, parent 393, ino 560, name "maximize-hover.svg"
tag DEL_ENTRY, parent 393, ino 698, name "maximize-backdrop-normal.svg"
tag INODE, inode 560
tag ADD_RANGE, inode 698, lblk 0, pblk 5707784, len 1
tag INODE, inode 698
tag TAIL, tid 6989
tag ADD_ENTRY, parent 393, ino 698, name "maximize-backdrop-normal.svg"
tag DEL_ENTRY, parent 393, ino 700, name "maximize-backdrop-active.svg"
tag INODE, inode 698
tag ADD_RANGE, inode 700, lblk 0, pblk 5707785, len 1
tag INODE, inode 700
tag TAIL, tid 6989
tag ADD_ENTRY, parent 393, ino 700, name "maximize-backdrop-active.svg"
tag DEL_ENTRY, parent 393, ino 701, name "maximize-backdrop-hover.svg"
tag INODE, inode 700
tag ADD_RANGE, inode 701, lblk 0, pblk 5707786, len 1
tag INODE, inode 701
tag TAIL, tid 6989
tag ADD_ENTRY, parent 393, ino 701, name "maximize-backdrop-hover.svg"
tag DEL_ENTRY, parent 393, ino 438103, name "maximized-normal.svg"
tag INODE, inode 701
tag ADD_RANGE, inode 438103, lblk 0, pblk 5707787, len 1
tag INODE, inode 438103
tag TAIL, tid 6989
tag ADD_ENTRY, parent 393, ino 438103, name "maximized-normal.svg"
tag DEL_ENTRY, parent 393, ino 703, name "maximized-active.svg"
tag INODE, inode 438103
tag ADD_RANGE, inode 703, lblk 0, pblk 5707788, len 1
tag INODE, inode 703
tag TAIL, tid 6989
tag ADD_ENTRY, parent 393, ino 703, name "maximized-active.svg"
tag DEL_ENTRY, parent 393, ino 704, name "maximized-hover.svg"
tag INODE, inode 703
tag ADD_RANGE, inode 704, lblk 0, pblk 5707789, len 1
tag INODE, inode 704
tag TAIL, tid 6989
tag ADD_ENTRY, parent 393, ino 704, name "maximized-hover.svg"
tag DEL_ENTRY, parent 393, ino 705, name "maximized-backdrop-normal.svg"
tag INODE, inode 704
tag ADD_RANGE, inode 705, lblk 0, pblk 5707790, len 1
tag INODE, inode 705
tag TAIL, tid 6989
tag ADD_ENTRY, parent 393, ino 705, name "maximized-backdrop-normal.svg"
tag DEL_ENTRY, parent 393, ino 706, name "maximized-backdrop-active.svg"
tag INODE, inode 705
tag ADD_RANGE, inode 706, lblk 0, pblk 5707791, len 1
tag INODE, inode 706
tag TAIL, tid 6989
tag ADD_ENTRY, parent 393, ino 706, name "maximized-backdrop-active.svg"
tag DEL_ENTRY, parent 393, ino 707, name "maximized-backdrop-hover.svg"
tag INODE, inode 706
tag ADD_RANGE, inode 707, lblk 0, pblk 5707792, len 1
tag INODE, inode 707
tag TAIL, tid 6989
tag ADD_ENTRY, parent 393, ino 707, name "maximized-backdrop-hover.svg"
tag DEL_ENTRY, parent 393, ino 708, name "minimize-normal.svg"
tag INODE, inode 707
tag ADD_RANGE, inode 708, lblk 0, pblk 5707793, len 1
tag INODE, inode 708
tag TAIL, tid 6989
tag ADD_ENTRY, parent 393, ino 708, name "minimize-normal.svg"
tag DEL_ENTRY, parent 393, ino 709, name "minimize-active.svg"
tag INODE, inode 708
tag ADD_RANGE, inode 709, lblk 0, pblk 5704193, len 1
tag INODE, inode 709
tag TAIL, tid 6989
tag ADD_ENTRY, parent 393, ino 709, name "minimize-active.svg"
tag DEL_ENTRY, parent 393, ino 710, name "minimize-hover.svg"
tag INODE, inode 709
tag ADD_RANGE, inode 710, lblk 0, pblk 5707794, len 1
tag INODE, inode 710
tag TAIL, tid 6989
tag ADD_ENTRY, parent 393, ino 710, name "minimize-hover.svg"
tag DEL_ENTRY, parent 393, ino 711, name "minimize-backdrop-normal.svg"
tag INODE, inode 710
tag ADD_RANGE, inode 711, lblk 0, pblk 5708288, len 1
tag INODE, inode 711
tag TAIL, tid 6989
tag ADD_ENTRY, parent 393, ino 711, name "minimize-backdrop-normal.svg"
tag DEL_ENTRY, parent 393, ino 712, name "minimize-backdrop-active.svg"
tag INODE, inode 711
tag ADD_RANGE, inode 712, lblk 0, pblk 5708289, len 1
tag INODE, inode 712
tag TAIL, tid 6989
tag ADD_ENTRY, parent 393, ino 712, name "minimize-backdrop-active.svg"
tag DEL_ENTRY, parent 393, ino 713, name "minimize-backdrop-hover.svg"
tag INODE, inode 712
tag ADD_RANGE, inode 713, lblk 0, pblk 5708290, len 1
tag INODE, inode 713
tag TAIL, tid 6989
tag ADD_ENTRY, parent 393, ino 713, name "minimize-backdrop-hover.svg"
tag DEL_ENTRY, parent 424, ino 715, name "window_decorations.css"
tag INODE, inode 713
tag ADD_RANGE, inode 715, lblk 0, pblk 5708291, len 1
tag INODE, inode 715
tag TAIL, tid 6989
tag ADD_ENTRY, parent 424, ino 715, name "window_decorations.css"
tag DEL_ENTRY, parent 426, ino 716, name "window_decorations.css"
tag INODE, inode 715
tag ADD_RANGE, inode 716, lblk 0, pblk 5708292, len 1
tag INODE, inode 716
tag TAIL, tid 6989
tag ADD_ENTRY, parent 426, ino 716, name "window_decorations.css"
tag DEL_ENTRY, parent 413, ino 308, name "xsettingsd.conf"
tag DEL_ENTRY, parent 13, ino 126, name ".gtkrc-2.0"
tag INODE, inode 126
tag CREAT_DENTRY, parent 13, ino 126, name ".gtkrc-2.0"
tag DEL_ENTRY, parent 413, ino 308, name "xsettingsd.conf"
tag DEL_ENTRY, parent 413, ino 308, name "xsettingsd.conf"
tag DEL_ENTRY, parent 413, ino 308, name "xsettingsd.conf"
tag DEL_ENTRY, parent 413, ino 308, name "xsettingsd.conf"
tag INODE, inode 308
tag CREAT_DENTRY, parent 413, ino 308, name "xsettingsd.conf"
tag INODE, inode 471161
tag CREAT_DENTRY, parent 145, ino 471161, name "UserFeedback.org.kde.plasmashell.lock"
tag INODE, inode 716
tag INODE, inode 126
tag INODE, inode 308
tag INODE, inode 471161
tag TAIL, tid 6989
tag ADD_RANGE, inode 473064, lblk 0, pblk 5703169, len 1
tag INODE, inode 473064
tag TAIL, tid 6989
tag ADD_ENTRY, parent 145, ino 473064, name "UserFeedback.org.kde.plasmashell.mwPNna"
tag DEL_ENTRY, parent 145, ino 472941, name "UserFeedback.org.kde.plasmashell"
tag ADD_ENTRY, parent 145, ino 473064, name "UserFeedback.org.kde.plasmashell"
tag DEL_ENTRY, parent 145, ino 473064, name "UserFeedback.org.kde.plasmashell.mwPNna"
tag DEL_ENTRY, parent 145, ino 471161, name "UserFeedback.org.kde.plasmashell.lock"
tag DEL_ENTRY, parent 424, ino 461, name "gtk.css"
tag INODE, inode 461
tag CREAT_DENTRY, parent 424, ino 461, name "gtk.css"
tag DEL_ENTRY, parent 426, ino 714, name "gtk.css"
tag INODE, inode 714
tag CREAT_DENTRY, parent 426, ino 714, name "gtk.css"
tag DEL_ENTRY, parent 21, ino 469266, name "plasma_theme_default.kcache"
tag INODE, inode 469266
tag ADD_RANGE, inode 469266, lblk 0, pblk 6504448, len 4121
tag CREAT_DENTRY, parent 21, ino 469266, name "plasma_theme_default.kcache"
tag INODE, inode 471161
tag CREAT_DENTRY, parent 25, ino 471161, name "kglobalshortcutsrc.lock"
tag INODE, inode 473064
tag ADD_RANGE, inode 126, lblk 0, pblk 4285960, len 1
tag DEL_RANGE, inode 126, lblk 1, len 2147483647
tag DEL_RANGE, inode 126, lblk -2147483648, len 2147483647
tag INODE, inode 126
tag INODE, inode 461
tag INODE, inode 714
tag ADD_RANGE, inode 463, lblk 0, pblk 5704194, len 2
tag DEL_RANGE, inode 463, lblk 2, len 2147483647
tag DEL_RANGE, inode 463, lblk -2147483647, len 2147483646
tag INODE, inode 463
tag ADD_RANGE, inode 727, lblk 0, pblk 5704196, len 2
tag DEL_RANGE, inode 727, lblk 2, len 2147483647
tag DEL_RANGE, inode 727, lblk -2147483647, len 2147483646
tag INODE, inode 727
tag INODE, inode 469266
tag INODE, inode 471161
tag TAIL, tid 6989
tag ADD_RANGE, inode 472941, lblk 0, pblk 4285961, len 4
tag INODE, inode 472941
tag TAIL, tid 6989
tag ADD_ENTRY, parent 25, ino 472941, name "kglobalshortcutsrc.zpzIFv"
tag DEL_ENTRY, parent 25, ino 471149, name "kglobalshortcutsrc"
tag ADD_ENTRY, parent 25, ino 472941, name "kglobalshortcutsrc"
tag DEL_ENTRY, parent 25, ino 472941, name "kglobalshortcutsrc.zpzIFv"
tag DEL_ENTRY, parent 25, ino 471161, name "kglobalshortcutsrc.lock"
tag INODE, inode 472941
tag ADD_RANGE, inode 471149, lblk 0, pblk 5707795, len 7
tag INODE, inode 471149
tag TAIL, tid 6989
tag ADD_ENTRY, parent 392, ino 471149, name "qqpc_opengl.tThTit"
tag DEL_ENTRY, parent 392, ino 469076, name "qqpc_opengl"
tag ADD_ENTRY, parent 392, ino 471149, name "qqpc_opengl"
tag DEL_ENTRY, parent 392, ino 471149, name "qqpc_opengl.tThTit"
tag INODE, inode 469076
tag ADD_RANGE, inode 469076, lblk 0, pblk 5708800, len 1
tag CREAT_DENTRY, parent 447, ino 469076, name "a835234b12cd40638672f45525ee8e4f-unix-0_8RPiJq"
tag INODE, inode 471149
tag INODE, inode 469076
tag TAIL, tid 6989
tag DEL_ENTRY, parent 447, ino 2364, name "a835234b12cd40638672f45525ee8e4f-unix-0"
tag ADD_ENTRY, parent 447, ino 469076, name "a835234b12cd40638672f45525ee8e4f-unix-0"
tag DEL_ENTRY, parent 447, ino 469076, name "a835234b12cd40638672f45525ee8e4f-unix-0_8RPiJq"
tag INODE, inode 2364
tag ADD_RANGE, inode 2364, lblk 0, pblk 5703170, len 1
tag CREAT_DENTRY, parent 447, ino 2364, name "a835234b12cd40638672f45525ee8e4f-unix-wayland-0_ZD7QfY"
tag INODE, inode 469076
tag INODE, inode 2364
tag TAIL, tid 6989
tag DEL_ENTRY, parent 447, ino 409035, name "a835234b12cd40638672f45525ee8e4f-unix-wayland-0"
tag ADD_ENTRY, parent 447, ino 2364, name "a835234b12cd40638672f45525ee8e4f-unix-wayland-0"
tag DEL_ENTRY, parent 447, ino 2364, name "a835234b12cd40638672f45525ee8e4f-unix-wayland-0_ZD7QfY"
tag INODE, inode 409035
tag ADD_RANGE, inode 409035, lblk 0, pblk 5703171, len 1
tag CREAT_DENTRY, parent 25, ino 409035, name "kxkbrc_4vqHuQ"
tag INODE, inode 2364
tag INODE, inode 409035
tag TAIL, tid 6989
tag DEL_ENTRY, parent 25, ino 438016, name "kxkbrc"
tag ADD_ENTRY, parent 25, ino 409035, name "kxkbrc"
tag DEL_ENTRY, parent 25, ino 409035, name "kxkbrc_4vqHuQ"
tag INODE, inode 409035
tag ADD_RANGE, inode 125, lblk 0, pblk 4285967, len 2
tag DEL_RANGE, inode 125, lblk 2, len 2147483647
tag DEL_RANGE, inode 125, lblk -2147483647, len 2147483646
tag INODE, inode 125
tag ADD_RANGE, inode 438016, lblk 0, pblk 5709312, len 2
tag INODE, inode 438016
tag TAIL, tid 6989
tag ADD_ENTRY, parent 423, ino 438016, name "5b7bbfd96267d74c2fdae847420d463d51481b0a.qmlc.sEmkhp"
tag DEL_ENTRY, parent 423, ino 407142, name "5b7bbfd96267d74c2fdae847420d463d51481b0a.qmlc"
tag ADD_ENTRY, parent 423, ino 438016, name "5b7bbfd96267d74c2fdae847420d463d51481b0a.qmlc"
tag DEL_ENTRY, parent 423, ino 438016, name "5b7bbfd96267d74c2fdae847420d463d51481b0a.qmlc.sEmkhp"
tag INODE, inode 471161
tag CREAT_DENTRY, parent 25, ino 471161, name "kglobalshortcutsrc.lock"
tag INODE, inode 438016
tag INODE, inode 407142
tag INODE, inode 471161
tag TAIL, tid 6989
tag ADD_RANGE, inode 473065, lblk 0, pblk 4285969, len 4
tag INODE, inode 473065
tag TAIL, tid 6989
tag ADD_ENTRY, parent 25, ino 473065, name "kglobalshortcutsrc.pjLxAb"
tag DEL_ENTRY, parent 25, ino 472941, name "kglobalshortcutsrc"
tag ADD_ENTRY, parent 25, ino 473065, name "kglobalshortcutsrc"
tag DEL_ENTRY, parent 25, ino 473065, name "kglobalshortcutsrc.pjLxAb"
tag DEL_ENTRY, parent 25, ino 471161, name "kglobalshortcutsrc.lock"
tag INODE, inode 471161
tag CREAT_DENTRY, parent 145, ino 471161, name "kickerstaterc.lock"
tag INODE, inode 473065
tag INODE, inode 471161
tag TAIL, tid 6989
tag ADD_RANGE, inode 472941, lblk 0, pblk 5708293, len 4
tag INODE, inode 472941
tag TAIL, tid 6989
tag ADD_ENTRY, parent 145, ino 472941, name "kickerstaterc.ftwxWx"
tag DEL_ENTRY, parent 145, ino 471159, name "kickerstaterc"
tag ADD_ENTRY, parent 145, ino 472941, name "kickerstaterc"
tag DEL_ENTRY, parent 145, ino 472941, name "kickerstaterc.ftwxWx"
tag DEL_ENTRY, parent 145, ino 471161, name "kickerstaterc.lock"
tag DEL_ENTRY, parent 129, ino 408928, name ".#lk0x000056d0558793b0.daniel-tablet1.5001"
tag ADD_ENTRY, parent 129, ino 408928, name ".#lk0x00006316313c53b0.daniel-tablet1.5341x"
tag DEL_ENTRY, parent 129, ino 408928, name ".#lk0x00006316313c53b0.daniel-tablet1.5341x"
tag ADD_ENTRY, parent 129, ino 408928, name "pubring.kbx.lock"
tag DEL_ENTRY, parent 129, ino 471159, name "pubring.kbx.tmp"
tag DEL_ENTRY, parent 129, ino 408928, name "pubring.kbx.lock"
tag DEL_ENTRY, parent 129, ino 408928, name ".#lk0x00006316313c53b0.daniel-tablet1.5341"
tag DEL_ENTRY, parent 150, ino 449, name "Akonadi.error.old"
tag INODE, inode 472941
tag INODE, inode 469266
tag ADD_RANGE, inode 449, lblk 0, pblk 5703172, len 1
tag INODE, inode 449
tag TAIL, tid 6989
tag ADD_ENTRY, parent 150, ino 449, name "Akonadi.error.old"
tag INODE, inode 408928
tag CREAT_DENTRY, parent 600, ino 408928, name "accounts.db-wal"
tag INODE, inode 471159
tag DEL_RANGE, inode 471159, lblk 0, len 1
tag CREAT_DENTRY, parent 600, ino 471159, name "accounts.db-shm"
tag DEL_ENTRY, parent 150, ino 449, name "Akonadi.error.old"
tag DEL_RANGE, inode 457, lblk 0, len 1
tag DEL_RANGE, inode 457, lblk 1, len 2147483647
tag DEL_RANGE, inode 457, lblk -2147483648, len 2147483647
tag INODE, inode 457
tag INODE, inode 408928
tag INODE, inode 471159
tag ADD_RANGE, inode 449, lblk 0, pblk 5708801, len 1
tag INODE, inode 449
tag TAIL, tid 6989
tag INODE, inode 478825
tag INODE, inode 478826
tag INODE, inode 478827
tag INODE, inode 478828
tag INODE, inode 478829
tag INODE, inode 478830
tag INODE, inode 478831
tag INODE, inode 478832
tag INODE, inode 478833
tag INODE, inode 478834
tag INODE, inode 478835
tag INODE, inode 478836
tag INODE, inode 478837
tag INODE, inode 478838
tag INODE, inode 478839
tag INODE, inode 478840
tag INODE, inode 478841
tag INODE, inode 478842
tag INODE, inode 478843
tag INODE, inode 478844
tag TAIL, tid 6507

--nextPart2828550.3Lj2Plt8kZ--




