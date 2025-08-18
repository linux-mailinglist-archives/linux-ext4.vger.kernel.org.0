Return-Path: <linux-ext4+bounces-9392-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32951B2A837
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Aug 2025 16:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E124E1B63CE2
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Aug 2025 13:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556342882A7;
	Mon, 18 Aug 2025 13:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6LIEYri"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFEF27B358
	for <linux-ext4@vger.kernel.org>; Mon, 18 Aug 2025 13:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524885; cv=none; b=mCLyLvDWUYVPgcUlzBc/nCEl10BT8X5UE9lCs0wkoB3rqiA9rGg7HdtxwI+mPjGzVx1AyQzM/7Fv8VbxKm2+BEvAnjk5KU1DzNTgFvS8l9nVXVcRDzEZnkPdLKL0TxvUZ/KOlsCPA2bYnXlKfUhrBHN/HsKeEItdLtIjzERRrDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524885; c=relaxed/simple;
	bh=5Q8hBiHxgF7w8YFhHj/0g57/RM4x53jGhlaPv3Afe+I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nL/vaDWCFSjCmp/djsAzLYYD+t5d8g9Y/lVT9fo+lyaDzsEeW8MR5TqpJ1Ef94ljsbrhYf+UWkNdXYiywXoC49ZNZ670PxVp/lXcpEY4i9B4j0Ja0e2PeLetj3IWbGIfNZ8XspZHWzu0W1rnH9MArpCc4PDHMVNv60REiy5ZlPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6LIEYri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B51C1C19422
	for <linux-ext4@vger.kernel.org>; Mon, 18 Aug 2025 13:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755524884;
	bh=5Q8hBiHxgF7w8YFhHj/0g57/RM4x53jGhlaPv3Afe+I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=I6LIEYrium6TPzFXxK8BFsOAjP6cy83GUEavXmNXfJ/nPNaWHv1838xuXmWjPDdmF
	 TCXxXvxUpGU129TmCunD6RWJZ8dQsghBcsRnkN2d3tNRv6sxYyllRGSx/aGS8b6XdD
	 Ac+1KOHAc6pLnn2nkJx43B6dg6EUDKUhIv4mtb8QAsIWgl8dJ/bF/v4pelPgDzXaom
	 RKeKzhh2B6ABOHWDURt1379dfsX0LVKGO7kPyaFti102i0EhfVG4Fg2K+BhSAw7A2i
	 D5k+U3riTq7BaJBiu3UVIrxIq1SKaxzm4Ov+gzLEk1H2tFbzkLfFBVDmumr1N2KGP4
	 jJPMjHxMItjbQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id ACDD4C53BBF; Mon, 18 Aug 2025 13:48:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Mon, 18 Aug 2025 13:48:04 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mingyu.he@shopee.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217965-13602-t0GzJZ805s@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217965-13602@https.bugzilla.kernel.org/>
References: <bug-217965-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D217965

mingyu.he (mingyu.he@shopee.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |mingyu.he@shopee.com

--- Comment #72 from mingyu.he (mingyu.he@shopee.com) ---
I find out the root cause of this problem.
In previous discussion, we didn't find out an exact root cause of this prob=
lem.
But the Ojaswin Mujoo made an effective fallback solution.

Although this problem is some what an "old problem",
   I think it still meaningful to reply to you for root cause as it distrub=
ed
lots of users back then.

Here I will write the root cause first and then put an exact reproduce prog=
ram
for testing.

** Root Cause **
For some Newbies like me, perhaps we should know this first:
Raid will cut all the logic blocks into many intervals. The length of an
interval is stripe.
We can use `tune2fs -l /dev/sdX` to find or `mount` to see it.
The layout may looks like this
[stripe][stripe][stripe][stripe][stripe][stripe]
   [ group size ][ group size ][ group size ]

In function 'ext4_mb_scan_aligned', it try to find a start point of an raid
interval in a group.
And then calculate the remaining block length of this group.
If the remaining length(which should be free and continuous) is not enough =
for
a stripe,
   it will return, and then find a next group.
[ stripe ] [ stripe ]
          |  here
    [ group size ]

The core problem is the action of finding next group.
In function 'ext4_mb_choose_next_group', code changed since this patch '[PA=
TCH
v2 00/12] multiblock allocator improvements'
https://lore.kernel.org/all/cover.1685449706.git.ojaswin@linux.ibm.com/

The author changed the fragment order RB tree into list for better performa=
nce.
However, the function 'ext4_mb_find_good_group_avg_frag_lists' will always
returns the same group every time,
   which makes upper layer pass the same group to 'ext4_mb_scan_aligned'. A=
nd
thus aligned scan always fails.
So it will end until the loop var 'i' (in ext4_mb_regular_allocator) runs i=
nto
n_groups.

Here is the stats I collected in 'ext4_mb_scan_aligned' -> 'mb_find_extent'
I set stripe to 30000 for easilier reproduce the problem.
```
Attaching 5 probes...
Tracing ext4_mb_regular_allocator... Hit Ctrl-C to stop.
find_ex, tid=3D22280, group_id=3D175542, block(i)=3D9744, needed(stripe)=3D=
30000,
ret(max)=3D23024
find_ex, tid=3D22280, group_id=3D175543, block(i)=3D6976, needed(stripe)=3D=
30000,
ret(max)=3D25792
find_ex, tid=3D22280, group_id=3D175544, block(i)=3D4208, needed(stripe)=3D=
30000,
ret(max)=3D28560
find_ex, tid=3D22280, group_id=3D127, block(i)=3D8464, needed(stripe)=3D300=
00,
ret(max)=3D24304
find_ex, tid=3D22280, group_id=3D127, block(i)=3D8464, needed(stripe)=3D300=
00,
ret(max)=3D24304
find_ex, tid=3D22280, group_id=3D127, block(i)=3D8464, needed(stripe)=3D300=
00,
ret(max)=3D24304
find_ex, tid=3D22280, group_id=3D127, block(i)=3D8464, needed(stripe)=3D300=
00,
ret(max)=3D24304
find_ex, tid=3D22280, group_id=3D127, block(i)=3D8464, needed(stripe)=3D300=
00,
ret(max)=3D24304
...
countless same lines
```

The first few lines is the linear choose section. And later is avg_frag_lis=
t's
selections.
Also, it you are in multi-thread running env, the chooser will probably find
the same group.
But the mb_regular_allocator need to get the spin lock of this group, which
inflames high cpu usage.
(Thanks to Baokun Li, he made an optimization for spin lock in recent patch=
es
'ext4: better scalability for ext4 block allocation')

And in 5.15 version, the RB tree works fine.
```
find_ex, tid=3D17292, group_id=3D603069, block(i)=3D25008, needed(strip)=3D=
30000,
ret(max)=3D7760
...linear search
find_ex, tid=3D17292, group_id=3D603072, block(i)=3D16704, needed(strip)=3D=
30000,
ret(max)=3D16064

find_ex, tid=3D17292, group_id=3D278911, block(i)=3D24352, needed(strip)=3D=
30000,
ret(max)=3D8416
find_ex, tid=3D17292, group_id=3D279167, block(i)=3D5744, needed(strip)=3D3=
0000,
ret(max)=3D27024
...tree search
find_ex, tid=3D17292, group_id=3D280447, block(i)=3D2704, needed(strip)=3D3=
0000,
ret(max)=3D30064
```

And in latest version (6.17.0-rc2) still works fine (Baokun Li made some
optimization for allocator and frag order list)
Note that for observe the work of new data structure, I comment out the
fallback logic.
```
find_ex, tid=3D31612, group_id=3D1423, block(i)=3D9984, needed(stripe)=3D32=
752,
ret(max)=3D22784
find_ex, tid=3D31612, group_id=3D1425, block(i)=3D9952, needed(stripe)=3D32=
752,
ret(max)=3D22816
find_ex, tid=3D31612, group_id=3D1426, block(i)=3D9936, needed(stripe)=3D32=
752,
ret(max)=3D22832
find_ex, tid=3D31612, group_id=3D1427, block(i)=3D9920, needed(stripe)=3D32=
752,
ret(max)=3D22848
find_ex, tid=3D31612, group_id=3D1428, block(i)=3D9904, needed(stripe)=3D32=
752,
ret(max)=3D22864
find_ex, tid=3D31612, group_id=3D1429, block(i)=3D9888, needed(stripe)=3D32=
752,
ret(max)=3D22880
find_ex, tid=3D31612, group_id=3D1430, block(i)=3D9872, needed(stripe)=3D32=
752,
ret(max)=3D22896
find_ex, tid=3D31612, group_id=3D1431, block(i)=3D9856, needed(stripe)=3D32=
752,
ret(max)=3D22912
find_ex, tid=3D31612, group_id=3D1432, block(i)=3D9840, needed(stripe)=3D32=
752,
ret(max)=3D22928
find_ex, tid=3D31612, group_id=3D1433, block(i)=3D9824, needed(stripe)=3D32=
752,
ret(max)=3D22944
find_ex, tid=3D31612, group_id=3D1434, block(i)=3D9808, needed(stripe)=3D32=
752,
ret(max)=3D22960
find_ex, tid=3D31612, group_id=3D1435, block(i)=3D9792, needed(stripe)=3D32=
752,
ret(max)=3D22976
```



** Reproduce Method **
Before 6.8 (or you delete the fallback logic)
with ext4 and raid.
# higher stripe, higher probability. But lesser than 32768(the default of
blocks in a group as it will cut request length)
mount -o remount,stripe=3D35000 /dev/sdX

# request allocation for 35000 blocks. Need aligned to stripe.
./test_C_program 35000

the C program (I delete error checking for keeping simple):
```
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <sys/stat.h>
#include <sys/types.h>

#define BLOCK_SIZE 4096

int main(int argc, char **argv) {
   if (argc < 2) {
      fprintf(stderr, "Usage: %s <request blocks>\n", argv[0]);
      return 1;
   }

   int blocks =3D atoi(argv[1]);
   off_t FILE_SIZE =3D (off_t)blocks * BLOCK_SIZE;

   int fd =3D open("source_file.txt", O_CREAT | O_WRONLY | O_TRUNC, 0644);

   fallocate(fd, 0, 0, FILE_SIZE);

   char *data =3D malloc(FILE_SIZE);

   memset(data, 'A', FILE_SIZE);
   write(fd, data, FILE_SIZE);
   rename("source_file.txt", "target_file.txt");

   printf("rename succeeded\n");

   free(data);
   close(fd);
   return 0;
}
```

If your stripe is relatively small, here is the method from
carlos@fisica.ufpr.br.
https://marc.info/?l=3Dlinux-raid&m=3D170327844709957&w=3D2

This method may not be exact. But very simple to reproduce for small stripe.
However, I need to run the parallel version to reproduce in my machine to
reproduce. Here are they:
mkdir 1 2 3 4 5

xzcat linux-6.16.tar.xz | tar x -C ./1 -f - &
xzcat linux-6.16.tar.xz | tar x -C ./2 -f - &
xzcat linux-6.16.tar.xz | tar x -C ./3 -f - &
xzcat linux-6.16.tar.xz | tar x -C ./4 -f - &
xzcat linux-6.16.tar.xz | tar x -C ./5 -f - &

Wait for kworker to flush dirty pages. You can use `top` to see kworker use
100% cpu for a long time.

Best Regards,
Mingyu He

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

