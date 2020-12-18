Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2719F2DE902
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Dec 2020 19:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbgLRSl3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Dec 2020 13:41:29 -0500
Received: from linux.microsoft.com ([13.77.154.182]:53996 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgLRSl0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Dec 2020 13:41:26 -0500
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by linux.microsoft.com (Postfix) with ESMTPSA id A566A20B717A
        for <linux-ext4@vger.kernel.org>; Fri, 18 Dec 2020 10:40:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A566A20B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1608316845;
        bh=WYXNwMFuAHHnoHmHMz194R/Kg3qgeVJMxIPuJIyKz5A=;
        h=From:Date:Subject:To:From;
        b=KDd6TL88VuU+WyMfjVbfn2b3dNGfTIPlzncHLgZZnnjmYp3jTgOX0aBvKHcJWn1nO
         aTZOZMhJJcnBhk7TIQ6yK1hndUjnaykfJKg8EDSyXXUTdwEldwGf0Yyg8Oqf0hgYDn
         aoLajlCbJqgY7/6fxPV02kSTGj805FUnAvKxFO5Q=
Received: by mail-pj1-f51.google.com with SMTP id b5so1810362pjk.2
        for <linux-ext4@vger.kernel.org>; Fri, 18 Dec 2020 10:40:45 -0800 (PST)
X-Gm-Message-State: AOAM53154rYbd2Ob0RM3V6uQdkA75UAAuAUDtVMW8tfqXHmAym6zvSG/
        bO/FgtP+b/GOWy1ewvY10cKgKzXyyYZIfhctb/4=
X-Google-Smtp-Source: ABdhPJzx/DFxwfCuFbXhoJa0DD92gVQ213WjW6YnyYWiMh5mf96SOITuET2hXm2S4gZp1x878ZbLnDjthY8aCaQnmZI=
X-Received: by 2002:a17:902:7d84:b029:db:feae:425e with SMTP id
 a4-20020a1709027d84b02900dbfeae425emr5675654plm.43.1608316845235; Fri, 18 Dec
 2020 10:40:45 -0800 (PST)
MIME-Version: 1.0
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Fri, 18 Dec 2020 19:40:09 +0100
X-Gmail-Original-Message-ID: <CAFnufp2zSthSbrOQ5JE6rKEANeFqvunCR3W5Bx2VgN_Q3NbLVg@mail.gmail.com>
Message-ID: <CAFnufp2zSthSbrOQ5JE6rKEANeFqvunCR3W5Bx2VgN_Q3NbLVg@mail.gmail.com>
Subject: discard and data=writeback
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

I noticed a big slowdown on file removal, so I tried to remove the
discard option, and it helped
a lot.
Obviously discarding blocks will have an overhead, but the strange
thing is that it only
does when using data=writeback:

Ordered:

$ dmesg |grep EXT4
[    0.243372] EXT4-fs (vda1): mounted filesystem with ordered data
mode. Opts: (null)

$ grep -w / /proc/mounts
/dev/root / ext4 rw,noatime 0 0
$ time rm -rf linux-5.10

real    0m0.454s
user    0m0.029s
sys     0m0.409s

$ grep -w / /proc/mounts
/dev/root / ext4 rw,noatime,discard 0 0
$ time rm -rf linux-5.10

real    0m0.554s
user    0m0.051s
sys     0m0.403s

Writeback:

$ dmesg |grep EXT4
[    0.243909] EXT4-fs (vda1): mounted filesystem with writeback data
mode. Opts: (null)

$ grep -w / /proc/mounts
/dev/root / ext4 rw,noatime 0 0
$ time rm -rf linux-5.10

real    0m0.440s
user    0m0.030s
sys     0m0.407s

$ grep -w / /proc/mounts
/dev/root / ext4 rw,noatime,discard 0 0
$ time rm -rf linux-5.10

real    0m3.763s
user    0m0.030s
sys     0m0.876s

It seems that ext4_issue_discard() is called ~300 times with data=ordered
and ~50k times with data=writeback.
I'm using vanilla 5.10.1 kernel.

Any thoughts?

Regards,
-- 
per aspera ad upstream
