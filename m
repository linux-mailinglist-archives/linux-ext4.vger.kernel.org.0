Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 042BA189454
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Mar 2020 04:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgCRDQy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Mar 2020 23:16:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36003 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgCRDQx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Mar 2020 23:16:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id g62so1619263wme.1
        for <linux-ext4@vger.kernel.org>; Tue, 17 Mar 2020 20:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=c9h0Bpso1GC1+16vASrXUhcSKNnecfoSamnmKisQM8s=;
        b=QrzPgDmWM2oyMuGZI9Z0Nf2eWaADLuy0Togy1M6YoLo1CoG1Ggt7GxSAUTH0YCnlvJ
         SP47ftNK7Tsd6ydIvw9yWTCqK4jS5kaYxNN4jY/bsENZgo4lZ59IuwDPfI4c2/ppT84B
         p42D785WFjKJ7Osd1L6QwcKkX4fAaCfz0rtOuBGG+No0WfO0tAmsyJCFwxd4x1opIWmw
         Y9SOhOsRsiMJpJ34609/eOftmk642w4R9ylKaV0832U97DrKryrwYIvzjBUM2pgAcTzm
         s26/WubGQls/pXAnxEdb44A8lAGNG6YY09nw9AER0TawS4s5V0nQM1xDJTC8TeBCDqr2
         ZaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=c9h0Bpso1GC1+16vASrXUhcSKNnecfoSamnmKisQM8s=;
        b=m2RoKj+RyzAvF6A+xesPjLWjse0j/XL1NMOIBVYZKUOs5quKBlSZvd7V8YRbqvtT3z
         uHzCHrEiF3dp7jE1TCm3EXZDXaVlTgDt8AecPFllQet00H4gyfvhcEYNVIgGAKJ4XjQZ
         ft8FXaucnpA/28kMUUyDaCrqkZdYlqoSczrDQALn2GoJA34SNWOFgAD4Av3XWPH8yAqW
         RTjl1Wd+o+AayAQET2qDDl/9+ukt6EYnlU23+L2BiiRB8GYoet5CLuIaOQaZlmnQYE1W
         hkyaOCGPUtQVKWI314Zh5p6W4DhagYAvZEFi9pnl8je91gW9y3+g9/RsrvFLJBNOuqiU
         ik2w==
X-Gm-Message-State: ANhLgQ1+4TzWvCMJTW9CwuU9XKhIpylusdyjTHTt4bOc28jLwR5gLYbt
        GDCLspAsrb+NvgWB9DPSMId3hH6huPhqv6Qy7RhS5Q==
X-Google-Smtp-Source: ADFU+vsLaFmm+IDfniF73qmR3Npp7/g9y+bGQFNFluXs1JBhj8UQT4E5nLgc/cRY606baMILP3q7xUhdHb4cMyu/A9o=
X-Received: by 2002:a1c:1b0e:: with SMTP id b14mr2393102wmb.8.1584501412364;
 Tue, 17 Mar 2020 20:16:52 -0700 (PDT)
MIME-Version: 1.0
From:   xiaohui li <lixiaohui1@xiaomi.corp-partner.google.com>
Date:   Wed, 18 Mar 2020 11:16:32 +0800
Message-ID: <CAAJeciW-r=+90gMJvEZ8xFMFwUH+rD1Qf9DRmqatD51vMgHbJg@mail.gmail.com>
Subject: is there root_fs.arm32 used by xfstests?
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

hello ted:

many thanks for your xfstests-bld project which can be deployed on
android systems and make mobile phone more robust and stable.
but as is known, many low-end mobile phone=E2=80=99s cpu still use the arm3=
2
architecture.
and if these low-end mobile phone also can make full use of xfstests
to do fs tests,
there will be more fs bug will be found and our filesystem will become
more robust.

but from below link:
https://www.kernel.org/pub/linux/kernel/people/tytso/kvm-xfstests
there is not arm32 root_fs.

so if you or anyone can offer me a link which can download arm32
root_fs needed by xfstests=EF=BC=8C
i appreciate it very much.

best regards.
