Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB5812DEE3
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Jan 2020 13:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgAAMa3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Jan 2020 07:30:29 -0500
Received: from mail-il1-f180.google.com ([209.85.166.180]:35056 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgAAMa2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Jan 2020 07:30:28 -0500
Received: by mail-il1-f180.google.com with SMTP id g12so32190932ild.2;
        Wed, 01 Jan 2020 04:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=yB3IxjdeAPGo3BtXnHx+p79i2MjCs6PKJlRI7SaucIA=;
        b=DIZ7cqn3RmXcPFNwhwfGt+jovCxDFvEOOYM3+17K9OCe9cCfwnBWMqonbG9XLTwWlB
         ANvQ0SKZmQLq4o0vKQWSUnoCulNPVU8IJWpQD7lKSrUINhkrkJ2PkP4ZHhKKJsxKAMuB
         QVR6TicDn9P8jbeCzS4Zv/2xxW8xBIb3+bZVQ+Gz1jwtnmoL3EVSSPJELbYGpH79VlYJ
         PjJcOJ4V+LzP1kF3EeRpLti90mQYo5XnoAEo+0phfB5uDCQSkuqaOxZDXzelE5t3MwW0
         RTx5ig3Z0xkGTbDS3VzAM4xbhRpgYlZoDlGkgTM/lKDov72X6Mhb230qCNMjVf6pBzHG
         8GoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=yB3IxjdeAPGo3BtXnHx+p79i2MjCs6PKJlRI7SaucIA=;
        b=GJ6RI6XIbCF8dbc3QSjojE2YQTJNPiJhodyKs65ImjEXdwFZTKhXGCcrUntRtdzONS
         LH6jrw3JNQOaekPZqlwJDi2d3GCOoEhFSjCpVVV74sOZP902XMzlySOiNHGNVBcxQpaK
         8aER6cGthKgjtueFyQ+ZDwCQyh0cqDk6+ilNo9jnYH6H3jL71u5DgQOWDgGieWkawzl5
         TBQafonuI0Nw+Z+yV5cFLQyc73YZUGW9c3y6benn9NaFXvZEtsX2mPVayswL01+u2CZe
         28lDPXwjotT6CuEpm5ementxh426qp0Fk0R4xKNGYfmy0pnkI+NNNH006ViUnjIGlc9i
         JVoA==
X-Gm-Message-State: APjAAAVT5F2O5Q6sHK/4yEAuZeqEPMHAFDaojsgDSRXkP9E8VJ3vOiNu
        v18s6vsHiAcNbhDPByR2mlagMelnBQVVx0/OsRfhfxHx4T0JJg==
X-Google-Smtp-Source: APXvYqzKqmBpYPk+Je3efervoPwV1RR6XF4yAjgfTTfK6imm+6j6sFyHoTIEpSG+bAbcU7zVuGlvP732Q/DoMq/Y8eA=
X-Received: by 2002:a92:b6d1:: with SMTP id m78mr48666889ill.245.1577881827600;
 Wed, 01 Jan 2020 04:30:27 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsODr3tMpQxJ_nhWQQg5WGakFt4Yu5B8ev6ErOkc+zv9kA@mail.gmail.com>
In-Reply-To: <CABXGCsODr3tMpQxJ_nhWQQg5WGakFt4Yu5B8ev6ErOkc+zv9kA@mail.gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Wed, 1 Jan 2020 17:30:16 +0500
Message-ID: <CABXGCsPqoDnZnZJZi9VobFiSxD9MuquS=txKntrJ1B9dJeYVQQ@mail.gmail.com>
Subject: Re: [bugreport] Ext4 automatically checked at each boot
To:     linux-ext4@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Maybe important:
This start happens since I upgraded motherboard to "ROG Strix X570-I
Gaming" on my previous motherboard "ROG STRIX X470-I GAMING" the
values "last checked", "mount time",  "mount count" was correctly
updated and displayed. And auto-check not started each boot.

On Wed, 1 Jan 2020 at 15:58, Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> Hi folks.
>
> Strange things happen with my ext4 lately:
> - At each boot, the file system is checked.
> - When I launch fsck manually it didn't found any issue.
> - But tune2fs report that last checked and mount time is Sun Dec 15,
> but this is incorrect.
>
> I don=E2=80=99t know where to look further so I ask here for help.
>
>
> Here is tune2fs report: https://pastebin.com/PZPbAuHS
>
> # cat /etc/fstab
>
> #
> # /etc/fstab
> # Created by anaconda on Mon Sep  9 19:36:53 2019
> #
> # Accessible filesystems, by reference, are maintained under '/dev/disk/'=
.
> # See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more in=
fo.
> #
> # After editing this file, run 'systemctl daemon-reload' to update system=
d
> # units generated from this file.
> #
> UUID=3Db3e2e027-c39d-4266-871f-22d313ac419b /                       ext4
>    defaults        1 1
> UUID=3DE8A2-F389          /boot/efi               vfat
> umask=3D0077,shortname=3Dwinnt 0 2
> UUID=3Dbf3e9504-8000-42a1-adb4-226658ec7a5d /home                   ext4
>    defaults        1 2
> UUID=3Df47f69e1-61f8-4024-960a-b3981d3b1d02 none                    swap
>    defaults        0 0
>
>
> --
> Best Regards,
> Mike Gavrilov.
