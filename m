Return-Path: <linux-ext4+bounces-11935-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42178C727EE
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Nov 2025 08:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C321B4E7C27
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Nov 2025 06:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C362F5A14;
	Thu, 20 Nov 2025 06:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6HrayT2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9C52EBDCD
	for <linux-ext4@vger.kernel.org>; Thu, 20 Nov 2025 06:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763621539; cv=none; b=S3Yr6TIuY5/jVc95e0KD74CnqtIJYrBwlUprRW3MHasJT65zKKgCQBCOrmXvR94em1eJavBGnbIbYbGIxlJnDyy7qtiDna2gLzjtw7ImodJb1ALxvYGIKwPASb5N0rHjyvttj0KoL968cLKTiR3z5pIBivWVySs0xUA4sOlZ7KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763621539; c=relaxed/simple;
	bh=mKyuYXclVNKpbsEcL8c26XvPOCQg5DVFB6A9iJdPqH8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nFFIQ3I5fy2iHC+KCWO3qE1LcQteFbFwGwZtoeNRtFRZzA3fF0DDMVVwu8rwJGoELl90xjOgh/hSr7aKOsZApPaLrx3X54+K7VF2XvnQ2BPiTo6zv40QhVb5KM1YwOYpPeU/xQ20+2R7VMU/Ih+2ShdV8VNSJUE//SinKeRueOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6HrayT2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1D7EC19421
	for <linux-ext4@vger.kernel.org>; Thu, 20 Nov 2025 06:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763621538;
	bh=mKyuYXclVNKpbsEcL8c26XvPOCQg5DVFB6A9iJdPqH8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=n6HrayT2D0pdc2LnwKAdrQpIQ4PyWFbAI27H5fOJkjt1ou/0Se3o7Ysjce43/vpWi
	 30+IOk5ZI8a+Zac39QsdQnOuU4ZKtw257L76IowH2uzIGB12NvaDkSZPYxPYE3K6Vf
	 l6p+Y/dCbvcBHWz1euGsYSiKG3MZwYg3Fs5O9YxCUHKnozIlDlku+/+lq9FgooMoCP
	 yTyhbNYKTtVbDHQ/hKWwFCCQ7wXXHKKeJOsMXbn1+ohPVAnJT3XtQ3A/je83z3CJuj
	 +XNEBlxFBhCI++aPm9XlYQ05uxhiYb9AepA+mocDQxxKmSJqaT9ON+9nrUXqCLV7AI
	 r/EAew/ZYgFTQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AEB53C41612; Thu, 20 Nov 2025 06:52:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220594] Online defragmentation has broken in 6.16
Date: Thu, 20 Nov 2025 06:52:18 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220594-13602-B787bQ83UU@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220594-13602@https.bugzilla.kernel.org/>
References: <bug-220594-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220594

--- Comment #10 from Artem S. Tashkinov (aros@gmx.com) ---
openat(AT_FDCWD, "/home/birdie/.config/google-chrome/Default/Sync
Data/LevelDB/000435.log", O_RDWR) =3D 3
ioctl(3, FS_IOC_FIEMAP, {fm_start=3D0, fm_length=3D18446744073709551615,
fm_flags=3DFIEMAP_FLAG_SYNC, fm_extent_count=3D512} =3D> {fm_flags=3DFIEMAP=
_FLAG_SYNC,
fm_mapped_extents=3D4, ...}) =3D 0
fstatfs(3, {f_type=3DEXT2_SUPER_MAGIC, f_bsize=3D4096, f_blocks=3D6177397,
f_bfree=3D4170566, f_bavail=3D3852103, f_files=3D1572864, f_ffree=3D1433202,
f_fsid=3D{val=3D[0xbbd03838, 0xb062f9ed]}, f_namelen=3D255, f_frsize=3D4096,
f_flags=3DST_VALID|ST_NOATIME}) =3D 0
fcntl(3, F_GETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D0, l_le=
n=3D0,
l_pid=3D0}) =3D 0
fsync(3)                                =3D 0
openat(AT_FDCWD, "/home/birdie/.config/google-chrome/Default/Sync
Data/LevelDB/000435.log.defrag", O_WRONLY|O_CREAT|O_EXCL, 0400) =3D 4
unlink("/home/birdie/.config/google-chrome/Default/Sync
Data/LevelDB/000435.log.defrag") =3D 0
fallocate(4, 0, 0, 139264)              =3D 0
ioctl(4, FS_IOC_FIEMAP, {fm_start=3D0, fm_length=3D18446744073709551615,
fm_flags=3DFIEMAP_FLAG_SYNC, fm_extent_count=3D512} =3D> {fm_flags=3DFIEMAP=
_FLAG_SYNC,
fm_mapped_extents=3D1, ...}) =3D 0
[1/1]/home/birdie/.config/google-chrome/Default/Sync Data/LevelDB/000435.lo=
g:=20=20
  0%) =3D 97
mmap(NULL, 139264, PROT_READ, MAP_SHARED, 3, 0) =3D 0x7f5541c99000
mincore(0x7f5541c99000, 139264, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, =
1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, ...]) =3D 0
munmap(0x7f5541c99000, 139264)          =3D 0
ioctl(3, EXT4_IOC_MOVE_EXT, 0x7ffd6bb8ac40) =3D -1 EBUSY (Device or resource
busy)
sync_file_range(3, 0, 139264,
SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE|SYNC_FILE_RANGE_WAIT_AFTE=
R) =3D
0
fadvise64(3, 0, 4096, POSIX_FADV_DONTNEED) =3D 0
fadvise64(3, 4096, 4096, POSIX_FADV_DONTNEED) =3D 0
fadvise64(3, 8192, 4096, POSIX_FADV_DONTNEED) =3D 0
fadvise64(3, 12288, 4096, POSIX_FADV_DONTNEED) =3D 0
fadvise64(3, 16384, 4096, POSIX_FADV_DONTNEED) =3D 0
fadvise64(3, 20480, 4096, POSIX_FADV_DONTNEED) =3D 0
fadvise64(3, 24576, 4096, POSIX_FADV_DONTNEED) =3D 0
fadvise64(3, 28672, 4096, POSIX_FADV_DONTNEED) =3D 0
fadvise64(3, 32768, 4096, POSIX_FADV_DONTNEED) =3D 0
fadvise64(3, 36864, 4096, POSIX_FADV_DONTNEED) =3D 0
fadvise64(3, 40960, 4096, POSIX_FADV_DONTNEED) =3D 0
fadvise64(3, 45056, 4096, POSIX_FADV_DONTNEED) =3D 0
fadvise64(3, 49152, 4096, POSIX_FADV_DONTNEED) =3D 0
fadvise64(3, 53248, 4096, POSIX_FADV_DONTNEED) =3D 0
fadvise64(3, 57344, 4096, POSIX_FADV_DONTNEED) =3D 0
fadvise64(3, 61440, 4096, POSIX_FADV_DONTNEED) =3D 0
fadvise64(3, 65536, 4096, POSIX_FADV_DONTNEED) =3D 0
fadvise64(3, 69632, 4096, POSIX_FADV_DONTNEED) =3D 0
fadvise64(3, 73728, 4096, POSIX_FADV_DONTNEED) =3D 0
fadvise64(3, 77824, 4096, POSIX_FADV_DONTNEED) =3D 0
fadvise64(3, 81920, 4096, POSIX_FADV_DONTNEED) =3D 0
fadvise64(3, 86016, 4096, POSIX_FADV_DONTNEED) =3D 0
fadvise64(3, 90112, 4096, POSIX_FADV_DONTNEED) =3D 0
fadvise64(3, 94208, 4096, POSIX_FADV_DONTNEED) =3D 0
write(1, "\n", 1
)                       =3D 1
write(2, "\tFailed to defrag with EXT4_IOC_"..., 62     Failed to defrag wi=
th
EXT4_IOC_MOVE_EXT ioctl:Success   [ NG ]
) =3D 62
ioctl(3, FS_IOC_FIEMAP, {fm_start=3D0, fm_length=3D18446744073709551615,
fm_flags=3DFIEMAP_FLAG_SYNC, fm_extent_count=3D0} =3D> {fm_flags=3DFIEMAP_F=
LAG_SYNC,
fm_mapped_extents=3D4, ...}) =3D 0



Device or resource busy? Why? Chrome is not open.

ps ax | grep -i chrome
 967139 pts/1    S+     0:00 grep --color=3Dauto -i chrome


Online defragmentation in both 6.16 and 6.17 is broken.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

