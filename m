Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B8D35B47C
	for <lists+linux-ext4@lfdr.de>; Sun, 11 Apr 2021 15:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbhDKNEz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 11 Apr 2021 09:04:55 -0400
Received: from braeburn.macports.org ([136.243.18.213]:40272 "EHLO
        braeburn.macports.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbhDKNEz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 11 Apr 2021 09:04:55 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Apr 2021 09:04:54 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ryandesign@macports.org)
        by braeburn.macports.org (Postfix) with ESMTPSA id 72AEB100194
        for <linux-ext4@vger.kernel.org>; Sun, 11 Apr 2021 12:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=macports.org;
        s=cc6b40dad66705baa1441067; t=1618145854;
        bh=MlXGUeqRJ04A5+adim4o+tgrVMaIwZJcgwK22RQjmD0=;
        h=From:Subject:Date:To:From;
        b=eRfy0JNWlOqU+cT9RlzTxeBYzij7n74tAnKmaTatUNzojqsKxrXsLH1S0M3CO1jZX
         Ll6j1alBRkYzwMkjDXrPyd5eiCV4uxieIOo3sh2Jo7/tmwYrkWvAfpWCZPVfTkVhlM
         sSI1qN8cBYwGADUk+cWZgBNCOxVyZTK1Rl9fWDn61JOYJE08YTu9gp6XnyMjrxmEa6
         z9LymVGPikbZBFArnLS0eZR0Bk8Ekd17/kcEOsoTzrK8HxISM70YMobOI4RnkTPtDP
         A0Yuju8kAsDDsfHuxDt5HrD2eP3uD8gAVHwDNAi6N+muplsgb+B11jQzJC3tCLvIwG
         8hKfkwnvg/7uA==
From:   Ryan Schmidt <ryandesign@macports.org>
Content-Type: multipart/mixed;
        boundary="Apple-Mail=_8FD380F2-F105-491A-803E-9641262A2A67"
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: e2fsprogs 1.46.2 needs #include <time.h> in probe.c
Message-Id: <A283A764-EBEB-4273-92D4-FC26129745E4@macports.org>
Date:   Sun, 11 Apr 2021 07:57:33 -0500
To:     linux-ext4@vger.kernel.org
X-Mailer: Apple Mail (2.3445.9.7)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_8FD380F2-F105-491A-803E-9641262A2A67
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi,

I am the maintainer of e2fsprogs in MacPorts. The developer of e2fsprogs =
has asked me to report patches for his program to this mailing list.

e2fsprogs 1.46.2 does not build on macOS when implicit declaration of =
functions is considered an error. This condition can be achieved either =
by adding -Werror=3Dimplicit-function-declaration to CFLAGS when =
configuring or by compiling with the version of clang included with =
Xcode 12 or later on macOS in which that behavior is the default.

The error messages are:


probe.c:285:16: error: implicit declaration of function 'time' is =
invalid in C99 [-Werror,-Wimplicit-function-declaration]
        time_t          now =3D time(0);
                              ^
probe.c:1677:9: error: implicit declaration of function 'difftime' is =
invalid in C99 [-Werror,-Wimplicit-function-declaration]
        diff =3D difftime(now, dev->bid_time);
               ^
2 errors generated.


The fix is to #include <time.h> in probe.c per the attached patch.

This problem and the fix were reported to MacPorts against e2fsprogs =
1.45.6 here: https://github.com/macports/macports-ports/pull/9137

Please Cc me on replies if you need further information.


--Apple-Mail=_8FD380F2-F105-491A-803E-9641262A2A67
Content-Disposition: attachment;
	filename=patch-probe.c.diff
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="patch-probe.c.diff"
Content-Transfer-Encoding: 7bit

--- lib/blkid/probe.c	2020-11-15 14:19:10.000000000 -0500
+++ lib/blkid/probe.c.fixed	2020-11-15 14:21:25.000000000 -0500
@@ -17,6 +17,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
+#include <time.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <ctype.h>

--Apple-Mail=_8FD380F2-F105-491A-803E-9641262A2A67--
