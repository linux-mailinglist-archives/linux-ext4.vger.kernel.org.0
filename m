Return-Path: <linux-ext4+bounces-12124-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7650C9ACA1
	for <lists+linux-ext4@lfdr.de>; Tue, 02 Dec 2025 10:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFFC04E1303
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Dec 2025 09:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F383093D7;
	Tue,  2 Dec 2025 09:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4p0qMtN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DF13093AB
	for <linux-ext4@vger.kernel.org>; Tue,  2 Dec 2025 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764666350; cv=none; b=jzXJGkuTg8j7FmNU48gHHFHZnBQof9jnfuRWXBOHrAzQQeDtnP3d+tVzkcWJObtFaum7hq+viA+QiSfTd9ecPzbvzcDgwEVP6A0KyliWKAZ2Qjxe6zuFky+f6gTfwysEw2gHwBBzMCrZOaq+rhR+AokfA8Jetx7f8qmRa9ntcdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764666350; c=relaxed/simple;
	bh=O8ND+fPtRcyQqrBRkzvno/RKw/BlrgTFA7rXgVPyti0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VDBdLUFY5/phkOT8KINQru0+dY3iwKL2USbapQSJD5x08siGa0Om5/oNPP13SDvEPwc+4J2HTLyw8zu8s83s66HM+965iiVoIIElvLKOnbAM291uwq4S9Kn+JEIXvsbaDv89OwfEF1LCVF7mjVizJkNvtkKZBzkudvPOJN5W1ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4p0qMtN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89451C116D0
	for <linux-ext4@vger.kernel.org>; Tue,  2 Dec 2025 09:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764666347;
	bh=O8ND+fPtRcyQqrBRkzvno/RKw/BlrgTFA7rXgVPyti0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=k4p0qMtNwqm4Bu3ugYEG8fYrGquJJm3ttjW4R7O/eEFouei8Vp7RiyCptL+66adkj
	 1hPfJSV0wUWB9dbsVIg6H2kOrKPhzFIgKUDk8i8TF7/ryH1JE5HMFvSUOWj0AO244Y
	 iODy8R/eSMCaUZbMNyYWG7o5J23Rv1WVqO9v6EJ6lrNWvW8SGt1LbVhcOxv3ITBJ4h
	 NNSU9IdHnKqhpC8/M7YmcDFAzt2CDijYlFOxv8/ICclsYVrfPS1XXiPXtlIy8Vv5Rp
	 wkUdazVHQarcPaOAPWVYHIMAB6yKjm1poA0WvOFcWTAYNi3ueIWv6keUCgzVYxHJLz
	 Z3Cf7ef+IE0gg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 82702C41616; Tue,  2 Dec 2025 09:05:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Tue, 02 Dec 2025 09:05:46 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-nOWQuR3ZDX@https.bugzilla.kernel.org/>
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

--- Comment #74 from mingyu.he (mingyu.he@shopee.com) ---
(In reply to Ojaswin Mujoo from comment #73)

> I tried the replicator however I was unable to get to the high CPU util, =
but
> since you already have the setup, can you check if you are able to hit th=
is
> issue in v6.4 vs v6.5.

Using C program, it won't result in high CPU util. Also, its running time is
very short, as it only allocate a single block.

If you try C program, you should also start a BPF program to trace=20

'ext4_mb_scan_aligned' or 'mb_find_extent' or 'find_extent' and print key d=
ata
like this

 group_id=3D175542, block(i)=3D9744, needed(stripe)=3D30000, ret(max)=3D230=
24

Here is my BPF program:

#!/usr/bin/env bpftrace

struct ext4_buddy {
struct page *bd_buddy_page;
void *bd_buddy;
struct page *bd_bitmap_page;
void *bd_bitmap;
struct ext4_group_info *bd_info;
struct super_block *bd_sb;
__u16 bd_blkbits;
ext4_group_t bd_group;
};

BEGIN
{
    printf("Tracing ext4_mb_regular_allocator... Hit Ctrl-C to stop.\n");
}

kprobe:mb_find_extent
{
    @no_group[tid] =3D ((struct ext4_buddy *)arg0)->bd_group;
    @arg1[tid] =3D arg1;=20
    @arg2[tid] =3D arg2;
}

kretprobe:mb_find_extent
/@arg1[tid]/
{
    print(kstack(3));
    printf("find_ex, tid=3D%d, group_id=3D%d, block(i)=3D%d, needed(stripe)=
=3D%d,
ret(max)=3D%d\n",
           tid, @no_group[tid], @arg1[tid], @arg2[tid], retval);
    delete(@no_group[tid]);
    delete(@arg1[tid]);
    delete(@arg2[tid]);
}

At last, if you still can't reproduce, I can help you test it in 6.4 VS 6.5

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

