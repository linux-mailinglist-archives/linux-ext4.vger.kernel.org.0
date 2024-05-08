Return-Path: <linux-ext4+bounces-2395-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B0B8BFECA
	for <lists+linux-ext4@lfdr.de>; Wed,  8 May 2024 15:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 209851C2183B
	for <lists+linux-ext4@lfdr.de>; Wed,  8 May 2024 13:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7320B79DD4;
	Wed,  8 May 2024 13:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIhpTii/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28EB5B1E4
	for <linux-ext4@vger.kernel.org>; Wed,  8 May 2024 13:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175237; cv=none; b=ApPpR7jJjQETLit4L+sYh0rEdcAabnqa9Sz/8xHGwZ3okNYUlqfBtvXOC76/sDxMIZ820Wo3uzT8CC0dKXzxrGFcw3QojGQz5IVSACnClXTLStE4uzDz/XmeHNInaNNnU4eGpqdnDPNCMzq8tB/oB35ywQl+SYe7OxaXLQzHVx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175237; c=relaxed/simple;
	bh=H/F1BuQlOAQYpDxDWmRZP2hdg93ICxm/w+kqOMyAM1s=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ASMd9qUSrcW4jAE9nadcUnejgTyBC96Wg6SX2EK1vfNr7NbTkl2pq5xNjFr2d8Euc7V0G4pO5IR2LwSdORO2AHIdFRkF0RRodltgTkWbNgfqnu7KML6YLZpBTE/twJR7RMKoyBdvT4bjYj8tX6wxS2OvMq6GoXc+XP8YUy7iwRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIhpTii/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B3A7C4AF17
	for <linux-ext4@vger.kernel.org>; Wed,  8 May 2024 13:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715175236;
	bh=H/F1BuQlOAQYpDxDWmRZP2hdg93ICxm/w+kqOMyAM1s=;
	h=From:To:Subject:Date:From;
	b=YIhpTii/P6e4Pfcc5h0KgvgxC4UqH4vcIc0K25MENeZzrQeGTKmlhPLa5K1eDZyFZ
	 iG1MHXRS8ft4B0gvVYWvQPZQkaP9kEXE1CQInRqPSs11+4ObACIq81Xm+dJzG6BZ1J
	 4FAPIgolDCPPpTlVTjQT9b4r5uzkLqKn7DipIit1GLFHxUjEBxzu4eLSUlkejEFL9S
	 E89KBNApXbShe+MJrUJ2yn5UjOJhj9pmJKXfeTUxfavCcLeNvKfQDaFN6y7nIteD2O
	 DPXh1PvyVPF5YPSY+rrVWEj50PbuY7x6BdJ7pXZj8DeeVx0z9Av0OrGSMrWpg6viTk
	 oUuhJHBHwr0Rg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7F79DC53B6A; Wed,  8 May 2024 13:33:56 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218820] New: The empty file occupies incorrect blocks
Date: Wed, 08 May 2024 13:33:56 +0000
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
Message-ID: <bug-218820-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218820

            Bug ID: 218820
           Summary: The empty file occupies incorrect blocks
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

Created attachment 306275
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306275&action=3Dedit
reproduce.c

Hi,

I mounted an ext4 image, created a file, and wrote to it, but the blocks
occupied by this file were incorrect after I `truncate` it. I can reproduce
this with the latest linux kernel
https://git.kernel.org/torvalds/t/linux-6.9-rc7.tar.gz


The following is the triggering script:
```
dd if=3D/dev/zero of=3Dext4-0.img bs=3D1M count=3D120
mkfs.ext4 ext4-0.img
g++ -static reproduce.c
losetup /dev/loop0 ext4-0.img
mkdir /root/mnt
./a.out
stat /root/mnt/a
```

After run the script, you will get the following outputs:
```
  File: /root/mnt/a
  Size: 0               Blocks: 82         IO Block: 1024   regular empty f=
ile
Device: 700h/1792d      Inode: 12          Links: 1
Access: (0755/-rwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
Context: system_u:object_r:unlabeled_t:s0
Access: 2024-05-08 11:47:48.000000000 +0000
Modify: 2024-05-08 11:47:48.000000000 +0000
Change: 2024-05-08 11:47:48.000000000 +0000
 Birth: -
```

The size of file `a` is 0, yet it occupies 82 blocks. Normally, it should o=
nly
occupy 2 blocks.

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

    creat("/root/mnt/a", S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
    int fd =3D open("/root/mnt/a", O_RDWR);
    mount(NULL, "/root/mnt/", NULL, MS_REMOUNT, "nodelalloc");
    sync();

    char *buf =3D (char*)align_alloc(4096*20);
    memset(buf, 'a' + 15, 4096*20);
    write(fd, buf, 4096*10);

    truncate("/root/mnt/a", 0);
    close(fd);
    return 0;
}
```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

