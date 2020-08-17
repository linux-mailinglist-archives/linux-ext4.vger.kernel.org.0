Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A15245B41
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Aug 2020 05:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgHQDyo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 16 Aug 2020 23:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgHQDyn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 16 Aug 2020 23:54:43 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141F9C061388
        for <linux-ext4@vger.kernel.org>; Sun, 16 Aug 2020 20:54:42 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k8so12740869wma.2
        for <linux-ext4@vger.kernel.org>; Sun, 16 Aug 2020 20:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ime-usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=WzEP0AhyZ6x1IlLUJetI5h1m46d2gV3P5oj8NnH+hhQ=;
        b=Gzs1CnMF43zJWDBCVRXsRqqM0ch3khcL+UDiPrhlQVB/xPirQ7Pmy01PGJUr/25fLx
         OBawAeOQc19V6/WSJqL+JW0Doz9iNhtRiCs62i0Ni0Cjobc7PX9s15w5uBzaipp0nUfJ
         QY4PzXT1KB1FszPDIt74QpYT0VEs+Hkn58zfBn0ayh6gzMz36cKn5B3qAU/mXcpmcSML
         cl7BlhRLBfWsLvYuNaK1g1Lg0I4hipcm6ayzw7LO8+mfi5gVaFVgD9Dn3eGfFbQ8JYT5
         1uCmnPHqsLs/tgosMz7mqnaXW1cFfe00DVYncnFDzxpFzcrFuhmCuqH3UE9XjL7s+mzw
         IoRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=WzEP0AhyZ6x1IlLUJetI5h1m46d2gV3P5oj8NnH+hhQ=;
        b=AmvzvnB8KX6VpF1Ad5KEqI53Pq+YMxsL7nxCSxCq/pSkzKZFDpesMGrEMbhbv1KUHZ
         fezBqis4Eokq/qDfHLILAx5/QmWkP89i5vwiZ/S3D4d9lhfL+8oBWmwK/AenLkXMHn7v
         R4f9PJ0IKGY8Iq/odztvaOOtlcpdRvDp/RqmqG4alPUqZVbv0LWTMMdj60NChutkVT07
         6Ycap7lCVyLN/9nZr27NbNRL4slfnwvKualYD5UjEk8XgnMI66MDCiK9vmKRiKI5JrZN
         6XtYXytlqOmJHpKIlvLWaFhGxBc15IlXZKHWaxD6l1S6mX80535UhM9CjMGzbAWYcUz3
         vkPg==
X-Gm-Message-State: AOAM532cpN9WChBQr6rkGnBsEbxKMFvDsgQXhxiZisoFnsfg3Q59ioY6
        Qvte33oKoC4CHlYiIbjtUhMcrrkVlv/rlZKFQtbAWhH5a+g=
X-Google-Smtp-Source: ABdhPJzp/f/JOtWx9ncbjJnSb0bxPgeEmrff2FLbH0++nEuuON+mMZC1UTXndu44mafRhL3owKW+8o6mh28jUvevoQQ=
X-Received: by 2002:a7b:c74b:: with SMTP id w11mr12268375wmk.81.1597636481014;
 Sun, 16 Aug 2020 20:54:41 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Rog=C3=A9rio_Brito?= <rbrito@ime.usp.br>
Date:   Mon, 17 Aug 2020 03:54:29 +0000
Message-ID: <CAOtrxKPMpNh7MZ2wX2wxju15rrY9rzrjNAwFneyAwCy2Z7DVMQ@mail.gmail.com>
Subject: Generic questions about ext4
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Dear developers,

I have been using ext4 for quite some time and I have some ext4
filesystems that led me to some questions.

I have at least 2 "large" filesystems (with 2TB each, both almost
full) dating back from 2011 and 2010. I believe that I even converted
one of them from ext3 to ext4, but my memory is not that clear after
almost a decade. As such, they were created without some useful
features that are useful nowadays, like inline files. With that in
mind, here are some questions:

1 - I know that some features can be enabled with tune2fs, but, in
particular, inline files don't seem to be. I've seen some people
indicate that using debugfs, I can mark the superblock as having
support for it. Would that really work? I don't plan on booting old
kernels. One of those filesystems is running on an armel device that
is quite slow and I would really like to avoid copying all the files
to an external HD, recreating the filesystem and, then, copying back
the files to the system.

2 - Is there any way to get transparent compression with ext4? That
would really, really rock and is, perhaps, one of the features that
some users like me would greatly benefit from.


Thanks for any pointers,

Rog=C3=A9rio Brito.

--=20
Rog=C3=A9rio Brito : rbrito@{ime.usp.br,gmail.com} : GPG key 4096R/BCFCAAAA
http://cynic.cc/blog/ : github.com/rbrito : profiles.google.com/rbrito
DebianQA: http://qa.debian.org/developer.php?login=3Drbrito%40ime.usp.br
