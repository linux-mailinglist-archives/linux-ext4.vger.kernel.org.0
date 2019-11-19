Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F04BB101E5E
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Nov 2019 09:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfKSIro (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Nov 2019 03:47:44 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:46351 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfKSIro (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Nov 2019 03:47:44 -0500
Received: by mail-io1-f53.google.com with SMTP id i11so11284688iol.13
        for <linux-ext4@vger.kernel.org>; Tue, 19 Nov 2019 00:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qryD+UZbvajrRx8KM0r/AGaClFpTs9/Q6cVMZRSLjmA=;
        b=Im3hIog5rzipsAqAuItJ/bsEq257/zLuPOhO7SXCf8ozjSBhjbreHYc/GVfZaZb/vr
         ES7FAkA+/dOAFQJnxDwiPpOiatSZ0ghz34Sm0yU56lQvJyLbMXLvybZErjXJAOPouisR
         oTFLIw/48EPiSh8FlORN/A/f+whAl9VO55rcensxVHA9YUOV47oWbq66KYrhg0RsxHjM
         p6B8OUl/Fq0bytTB88Jo6zVaKNkenFKZ49lBirQtWy4ee3CokVlN8E8vO7N8TmlOMwZ6
         djQHCGGeNklD1VxxacBDmnhtzqihFYsqTHzEbX8hrzWTnjIxkdQBiPUfFEX3lMKDCEHx
         4vqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qryD+UZbvajrRx8KM0r/AGaClFpTs9/Q6cVMZRSLjmA=;
        b=Hk/p1JWqlLkxKH0Fu+LF8jnGuBjBZzl350If8Wz0sIzK/SrKLAtRu/BhMCig0uotYb
         NQWff1hgcHsOqtQKEFR2PTZTFQI51HKU0YcV31VwjkX2oQBRyXTX/g9tTw475oFXFoqd
         oyz/Zx5LKrks5D0BookrUdMsPMV4MKHUq2VEnOgsekp4PNXzBp05huWHOBinb7Jk6X/7
         2Bkne7lyGTcSSxtRP7KeI0VMtiU0xlXkvnkF2IYSrfYv1Rk6pboQe1x+e+ZvH653MAN3
         dRZSTejzAhCfotRQX/wRXnMjyjXydM5JxeswpCs6a/PUgenNjUZnwjzYWc3md+QdvXel
         SOJA==
X-Gm-Message-State: APjAAAVXRXLH055DHGHNZ46letftCffoHqIVjW92bfhdeREM830zPr8L
        vrfiwhlWTW38Z9MgWWGtA+IU+h8PQddtZUKabANEPlz95LA=
X-Google-Smtp-Source: APXvYqyiUlHE6DhufWfcv/cLj/gpbZRGwh2EnQnpw49Txwo3GrG3wb/BHzcYeaCXYCtpLWJ7mw/XpjmBzfcRoFohR1g=
X-Received: by 2002:a6b:fd0b:: with SMTP id c11mr8852607ioi.203.1574153262694;
 Tue, 19 Nov 2019 00:47:42 -0800 (PST)
MIME-Version: 1.0
From:   Paul Richards <paul.richards@gmail.com>
Date:   Tue, 19 Nov 2019 08:47:31 +0000
Message-ID: <CAMoswejffB4ys=2C5zL_j9SBrdka8MJWV3hpwber9cggo=1GQQ@mail.gmail.com>
Subject: Query about ext4 commit interval vs dirty_expire_centisecs
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello there,
I'm trying to understand the interaction between the ext4 `commit`
interval option, and the `vm.dirty_expire_centisecs` tuneable.

The ext4 `commit` documentation says:

> Ext4 can be told to sync all its data and metadata every 'nrsec' seconds.=
 The default value is 5 seconds. This means that if you lose your power, yo=
u will lose as much as the latest 5 seconds of work (your filesystem will n=
ot be damaged though, thanks to the journaling).

The `dirty_expire_centisecs` documentation says:

> This tunable is used to define when dirty data is old enough to be eligib=
le for writeout by the kernel flusher threads. It is expressed in 100'ths o=
f a second. Data which has been dirty in-memory for longer than this interv=
al will be written out next time a flusher thread wakes up.


Superficially these sound like they have a very similar effect.  They
periodically flush out data that hasn't been explicitly fsync'd by the
application.  I'd like to understand a bit more the interaction
between these.


What happens when the ext4 commit interval is shorter than the
dirty_expire_centisecs setting?  (Does the latter become "redundant"?)

What happens when the dirty_expire_centisecs setting is shorter than
the ext4 commit interval?

Thanks,
