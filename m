Return-Path: <linux-ext4+bounces-2539-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F808C78DA
	for <lists+linux-ext4@lfdr.de>; Thu, 16 May 2024 17:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5261C22718
	for <lists+linux-ext4@lfdr.de>; Thu, 16 May 2024 15:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF02146D7F;
	Thu, 16 May 2024 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSbYOkGD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4308A14B952
	for <linux-ext4@vger.kernel.org>; Thu, 16 May 2024 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715871729; cv=none; b=Qip0RHyxC06k4dE2+krSjNwhoHPLnRPEy6O7O9LDIF+iXDksOv2EWglaa9xeHObcozE36PP++EDF25laet4h0bLvBobTMnVPf76l+iyN0p0tUumP3qiJNRfcT606+tbNRqofLuXGs448lsiRRlYDdp4ao0ykhqu7ls9Sbvka62I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715871729; c=relaxed/simple;
	bh=u5iHNoYMoj2AyYaBI1zdG+1bKwfPuCRaLdpRTKMiH/I=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FL7UjCXV5Q4J+yDXFT4f8pmCNoU+VQ7+usUiyrJq/aU+3df1n+WUzZpZ5esrJVij2BWkL5qRRXELxWxg4PcDbydLCFRnvEyyT/FH0v9Oaxwhy8yMIwL7QhuJgCjpBJCkRpj7j4IdsHtirC2OdzKCuvVL+h0By+b4Yx5bAGG37ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSbYOkGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1821DC32786
	for <linux-ext4@vger.kernel.org>; Thu, 16 May 2024 15:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715871729;
	bh=u5iHNoYMoj2AyYaBI1zdG+1bKwfPuCRaLdpRTKMiH/I=;
	h=From:To:Subject:Date:From;
	b=iSbYOkGDRYuxgS+FP3p/cpq+d1Y8c/Pnra72YO5ZRovOeJevF0vTrQCi/wyJGJvhV
	 gz7zvfsQiU4t5HsZf4rcynGyIMiA7hIirluOFa8ZMfSbtsZbco6bBflrD7GCThUTF7
	 zdvejJbdP+78epyB193+DNZIig+CiC4mSo0mRKbNg/5aMxC+5i86dvhOnqB41ruXJI
	 LfHpl8Rx1TrW0LK9PlZIpYl2gsMf40DSJgv2r3/Xfr/u9HE+m8quTjD7fLI79CXIiM
	 ALy1cOlhVst7sNNvnCs+2KasrpFjTyUFeyKIBNl0Evf7E8AlqdJuagE+eiTCstWrvL
	 pQUAhcieZWRHQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 02EE6C53B7F; Thu, 16 May 2024 15:02:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218850] New: Unexpected failure when write to a file with two
 file descriptor
Date: Thu, 16 May 2024 15:02:08 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: zhangchi_seg@smail.nju.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-218850-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218850

            Bug ID: 218850
           Summary: Unexpected failure when write to a file with two file
                    descriptor
           Product: File System
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: zhangchi_seg@smail.nju.edu.cn
        Regression: No

Created attachment 306300
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306300&action=3Dedit
reproduce.c

Hi,

I mounted an ext4 image, created a file, and created a link to it, then I w=
rote
to these two files, and I failed with a specific read and write order. I can
reproduce this with the latest linux kernel
https://git.kernel.org/torvalds/t/linux-6.9-rc7.tar.gz

The following is the triggering script:
```
dd if=3D/dev/zero of=3Dext4-0.img bs=3D1M count=3D120
mkfs.ext4 ext4-0.img
g++ -static reproduce.c
losetup /dev/loop0 ext4-0.img
mkdir /root/mnt
./a.out
```

After run the script, you will see the error message:

```
write failure
```

The contents of `reproduce.c` :
```
#include <assert.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include <stddef.h>
#include <unistd.h>
#include <pthread.h>
#include <errno.h>
#include <dirent.h>

#include <string>

#include <sys/mount.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <sys/wait.h>
#include <sys/xattr.h>
#include <sys/mount.h>
#include <sys/statfs.h>
#include <fcntl.h>

#define ALIGN 4096

void* align_alloc(size_t size) {
    void *ptr =3D NULL;
    int ret =3D posix_memalign(&ptr, ALIGN, size);
    if (ret) {
      printf("align error\n");
      exit(1);
    }
    return ptr;
}

int main()
{
    char *buf_15 =3D (char*)align_alloc(4096*20);
    memset(buf_15, 'a', 4096*20);

    char *buf_4 =3D (char*)align_alloc(4096*20);
    memset(buf_4, 'a', 4096*20);

    mount("/dev/loop0", "/root/mnt", "f2fs", 0, "");

    creat("/root/mnt/a", S_IRWXG);
    link("/root/mnt/a", "/root/mnt/b");
    int fd_a =3D open("/root/mnt/a", O_RDWR);
    int fd_b =3D open("/root/mnt/b", O_RDWR | O_DIRECT);

    lseek(fd_a, 100, SEEK_SET);=20
    write(fd_a, buf_15, 9900);=20

    read(fd_b, buf_4, 73728);=20

    int state =3D write(fd_b, buf_15, 65536);=20
    if (state =3D=3D -1) {
        printf("write failure\n");
    }

    return 0;
}

```

If I move the statement `read(fd_b, buf_4, 73728); ` before the first write
operation, or modify the size `73728` to a smaller one, such as `63728`, th=
en
this script will not fail.

Did I do anything wrong?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

