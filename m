Return-Path: <linux-ext4+bounces-2472-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2AE8C3A3C
	for <lists+linux-ext4@lfdr.de>; Mon, 13 May 2024 04:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF58B1F211D3
	for <lists+linux-ext4@lfdr.de>; Mon, 13 May 2024 02:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCE6145B15;
	Mon, 13 May 2024 02:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHssM6z7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A2112AAEA
	for <linux-ext4@vger.kernel.org>; Mon, 13 May 2024 02:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715568000; cv=none; b=SIQ6a/PW2PgSqvpd9neq8aGiIacxTKOQ4UERSWD0EXEbRsl2o8uMx6FeLNDbRShP1L42E+o6qNmNG94opirYrhgGkrzGlvGJ1RwD5Onytd+UhGDU9vxE6qxV8Ylwp4YtLQxJ8yiP8pg6L3FIOU8RawEAWD9nnwgJ7yp0EYSpWBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715568000; c=relaxed/simple;
	bh=cU/U6y+2HtKzFVYW3ZOrvw+h41VWIY5Fg8wOOXN0RaY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Hl41z2/fP/s7+IFCUg79RCewCSAZU4tIp34ztju8QImNrioxiJng+2b67SR9wjdvwvTvqlKjbUQdwlNf63L1bxaQu/wrhfkJK4dc7d9q2NWVDmQfRBIW+nc4UDzkV2fA1ISU5G5rWk/tQU594DBSI1/jgIhAcXCKFaiddRWZTE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHssM6z7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58C40C32782
	for <linux-ext4@vger.kernel.org>; Mon, 13 May 2024 02:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715568000;
	bh=cU/U6y+2HtKzFVYW3ZOrvw+h41VWIY5Fg8wOOXN0RaY=;
	h=From:To:Subject:Date:From;
	b=YHssM6z7lK8vRup1qixMXUFMOxLD4prw5NprwudpiG8emSume8DmVy8T3GpWULlyT
	 8dFqkr0rFlvsnZXVvI1Gss8bPMIx+RElr16iDYjm8mLajxV0Lcl63zQIF6THmaaNYM
	 6jW8Q86OMs5ss4PH1/uOlu1LiMu1C2D14YbvlmAg9rKeYx0Yg0VnyAQYBKrXULhqAq
	 DKZh9usc0AKDOt86wMpzn18LMnctcgYUjsGIkXG3OoJLu771hMG6kvWLdK2V6bGnvX
	 bukIE/DGJXi5unTBp2DDX890P4Dh6OJ7mG8eh1RyecYUZqHvAG/I2yN4E2HO/p21Vr
	 o0rJw0YGJeeug==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4B89BC53B73; Mon, 13 May 2024 02:40:00 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218830] New: lseek on closed file does not trigger an error and
 affect other files
Date: Mon, 13 May 2024 02:39:59 +0000
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
Message-ID: <bug-218830-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218830

            Bug ID: 218830
           Summary: lseek on closed file does not trigger an error and
                    affect other files
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

Created attachment 306289
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306289&action=3Dedit
reproduce.c

Hi,

I have a file and lseek on it after calling the close(), but it dose not
trigger an EBADF error. Then I open and write to another file, but the write
operation trigger an "Invalid argument" error. I can reproduce this with the
latest linux kernel https://git.kernel.org/torvalds/t/linux-6.9-rc7.tar.gz

The following is the triggering script:
```
dd if=3D/dev/zero of=3Dext4-0.img bs=3D1M count=3D120
mkfs.ext4 ext4-0.img
g++ -static reproduce.c
losetup /dev/loop0 ext4-0.img
mkdir /root/mnt
./a.out
```
After running the script, you will see an error message:
```
write failure: (Invalid argument)
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
    mount("/dev/loop0", "/root/mnt", "ext4", 0, "");

    creat("/root/mnt/a", S_IRWXU);
    creat("/root/mnt/b", S_IRWXU);
    int fd_a =3D open("/root/mnt/a", O_RDWR);=20
    close(fd_a);=20
    int fd_b =3D open("/root/mnt/b", O_RDWR | O_DIRECT);=20
    int state =3D lseek(fd_a, 7208, SEEK_SET);=20
    if (state =3D=3D -1) {
      printf("lseek failure: (%s)\n", strerror(errno));
    }

    char *buf =3D (char*)align_alloc(4096);
    memset(buf, 'a', 4096);
    state =3D write(fd_b, buf, 4096);
    if (state =3D=3D -1) {
      printf("write failure: (%s)\n", strerror(errno));
    }

    close(fd_b);=20
    return 0;
}
```

I also found that if I remove the `O_DIRECT` flag of file b, the write
operation will not trigger an error, but the contents of b become garbled.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

