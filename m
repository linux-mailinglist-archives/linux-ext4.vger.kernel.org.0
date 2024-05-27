Return-Path: <linux-ext4+bounces-2649-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 313E48CFA19
	for <lists+linux-ext4@lfdr.de>; Mon, 27 May 2024 09:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5371F212A9
	for <lists+linux-ext4@lfdr.de>; Mon, 27 May 2024 07:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298B21B963;
	Mon, 27 May 2024 07:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FobwUBH7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EE217BA9
	for <linux-ext4@vger.kernel.org>; Mon, 27 May 2024 07:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716794919; cv=none; b=sG/5qSizIRO7NaEUlSHuVkiHkkA5ugYcH2qq2w82jBls728Um8aOE2VJYYphZ0OxM0T/d01MWwvnC+Y8qFEpKOFUNpwdlE+qFfciuQH/ySaV03sJXDlcuIWFikfqtJBVXwksNR2DatByDMc/11OmyKVVL8/Zm3ctLktS0OFYkeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716794919; c=relaxed/simple;
	bh=N0csDV3jXch1QmQ+6edFkKtxqXX+Ok4ntEHdeIvIl1Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QxsGAYn9NDdTPUZsl4HQeid0v5H3Madnj9uHAglkyJF3Z2mjewhYBJZqBUsj7xpCms3DicSDn5i1RKyFlDITEMwYeiGv13kJf2hWpfQ6Ie6ohU6+cAnJNajnSZhs9YDkrGFDIzmhGH4w8y8g4AiCfBi/HAFteS9mA4XlVkrTJU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FobwUBH7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DF81C32786
	for <linux-ext4@vger.kernel.org>; Mon, 27 May 2024 07:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716794919;
	bh=N0csDV3jXch1QmQ+6edFkKtxqXX+Ok4ntEHdeIvIl1Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FobwUBH7rrEFponL/nYb7llAbh2OVC2jUoH2pMJCNpE4YrQ4feDaEv5r/UFXEYQ2Z
	 +DnnKFExojuOpjrQUN0lmFSGyDuF+3RfVGA38YYwtAGd4nlBXIEtV8Uine5DOblwNM
	 S+O00ZtEx9sTjdWMbW39/RYnecljBja2EM1scDa50AP1T13TAR6MU8dnRltpO4LF9J
	 vHqrFwyw3FxLFgVTKgaVRuHZIa68sW2wVszDO2ujrs93WqlzC239ewr8TE87GpmKbq
	 FQpLvPfZVzeuFUY8ZZZFOA7MVJbLL7Ynz/BnNN5LAalWLvuW9J0TIyAK2fkljTGvQS
	 yl5Y6O8NXUG0A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1B1E3C53BA7; Mon, 27 May 2024 07:28:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218850] Unexpected failure when write to a file with two file
 descriptor
Date: Mon, 27 May 2024 07:28:38 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218850-13602-w8IOxcHbEX@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218850-13602@https.bugzilla.kernel.org/>
References: <bug-218850-13602@https.bugzilla.kernel.org/>
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

--- Comment #2 from Chi (zhangchi_seg@smail.nju.edu.cn) ---
Could you please help me review this report? I am still able to reproduce t=
he
issue with the following test case:

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

    mount("/dev/loop0", "/root/mnt", "ext4", 0, "");

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

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

