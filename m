Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3BD812ABA0
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Dec 2019 11:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfLZKZY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Dec 2019 05:25:24 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:36855 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfLZKZY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Dec 2019 05:25:24 -0500
Received: by mail-wm1-f49.google.com with SMTP id p17so5780400wma.1
        for <linux-ext4@vger.kernel.org>; Thu, 26 Dec 2019 02:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=xORsCmYUimkT0HwPyrDa3btDVAA2C/Dc6leiyByEhfA=;
        b=wOUF4n5gCJhSe55G0X5NsdV/q/pE0tgq0VIECDjT9PHTPmRxtjwDCtcPwrVv3X3CEE
         mDi06AxB/5PcQtcfosPQrXV3qi26jJirXNQtI33VpC1PVFzUmsxjs325+40FDV1CAaOx
         1yMzlxxodmrU905clJ0komQELAaaVhpLvAIi9BEq22ekaxho6PtYoyHCOj0S7osTT9e1
         Ml/9PN4jC/dVvWMXZhAlS0exIcH5pqgsblk7MkQL+r796kv6fVpC9XJxo1dMg6sWwFV9
         c5Irr7L5lPl47KmC9ahfYIuGALV/n/SceoeU5aZ2IwF986Hn9mT4jxkzWeLyfVM22+xv
         o5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=xORsCmYUimkT0HwPyrDa3btDVAA2C/Dc6leiyByEhfA=;
        b=iBT2ds3jyXqXhVPVRSxhw6D9YgG7ipqJzRI8vLNpmou+9gEydtmYo75kyVZXPJPPRU
         i6PGIq8dIVZ8ugxFBw1CJdk7wBIRvoootT5W9kqwGRxryey67qFKws6rXIyD+PJYqd0y
         Q0UjT82Z2W9dBzXmDRDUC5tU/FAws0D9NWkYkg2RPYQjVOr7mHR07VZwkkLGXZwp3yjn
         HrvPrirryFHwEPwgtO6lcvZg+o5Efy+E+1EN4sZzAZhP20mD70WRnGn5H2DKjjjjgHRb
         Kp2NZQCKuM2UiJMYpWooBW/UBMj/bMgVAbJRS8JNFT32OJHxpNZB5rAIF2WTYO2QgY17
         a0+g==
X-Gm-Message-State: APjAAAUIFo2CcHQI00Se+vSTqFc7v4b2huvei8Z+0qVjVUj49Kb0t+Kg
        5ONQMtvlIfYzethz8VlW3cAnErjokhJnpVnEOBjrZQhELv0BPw==
X-Google-Smtp-Source: APXvYqyWYepzHQpLwgrtZNKzOg4nP7u8/RjSokkkio6dxmAEQfy1dtzqqLXM5kWbX2HtVCA33X942TrFU2mahdbBwJg=
X-Received: by 2002:a1c:f008:: with SMTP id a8mr13109401wmb.81.1577355921837;
 Thu, 26 Dec 2019 02:25:21 -0800 (PST)
MIME-Version: 1.0
From:   xiaohui li <lixiaohui1@xiaomi.corp-partner.google.com>
Date:   Thu, 26 Dec 2019 18:25:01 +0800
Message-ID: <CAAJeciUWm9W-AyFwJdUqC3W6n4bBDHMrzBF=V2d_iMywDW2+uQ@mail.gmail.com>
Subject: the side effect of enlarger max mount count in ext4 superblock
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

hi ted:

we have found the e2fsck full check cost-so-much-time problem in
android booting phase, especially it will spend 120 seconds on doing
this e2fsck full check in ext4 rw partition which has large storage
capacity and serious fragmentation related with used extents.

so we want to reduce the numbers of the called work of e2fsck full check.

condition 1:
and then we have find when encountering the metadata error or
inconsistent problems, ext4 will has put an error flag in its
superblock.
when the next e2fsck data check begin, it will check if there is an
error flag in partition superblock, and will do the full check work
automatically if has this error flag.

condition 2:
meanwhile, in android code, when ext4 partition has been mounted
unsuccessfully, it will also do e2fsck full check subsequently.

according to above two showed conditions on which e2fsck full check
can be called automatically,
the e2fsck full check has not to be called periodically when the ext4
partition mount times is above max mount times we set in ext4 super
block.
when ext4 data or medata error has happened, e2fsck full check will be
called automatically during next e2fsck data checking.

so i wonder the reason why set EXT4_DFL_MAX_MNT_COUNT value to 20 in
fs/ext4/ext4.h and not set a large value to it ?
is there any reason or any condition when file system data error or
stability problems happens and ext4 can't get this information, can't
set the error flag in superblock, and so will not call the e2fsck full
check during next e2fsck check=EF=BC=9F
and because of this reason or condition, it will have to do periodic
e2fsck full check.

many thanks if you and any other people can give me advise on the
above question.
