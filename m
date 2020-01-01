Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6C9212DE9B
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Jan 2020 11:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgAAK6i (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Jan 2020 05:58:38 -0500
Received: from mail-il1-f178.google.com ([209.85.166.178]:39787 "EHLO
        mail-il1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgAAK6h (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Jan 2020 05:58:37 -0500
Received: by mail-il1-f178.google.com with SMTP id x5so32064669ila.6;
        Wed, 01 Jan 2020 02:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=gzNvL4kpiGHjLbymCAIxsTwkr5wPwrN3gdjDIGw+gB4=;
        b=aLbhqrXLe5rxkWXLfACvp63qn2VLF1iAzHK3t4ptLQTQH2BAYI/jnBA6n/2l6MlTiT
         TfuqkW193qxINM1QUOYOfZwWz7zl0BRLL2e74gHFeGfsZYfpcKjMYE2Eet7pjjNQo7If
         5SzfHk0Da9a2EFzrV0ZIAcbg48lJ4JDB8X9CQHtx0Fi6ReyuHX5Ul25EkiAvMN+VLYFe
         ihrB4w08Q/vMUPu4ndPWP34k+XUuW01Pp5OJeHZI5foLOZP39E63RnmlzRezQepO/huF
         5/ETUHNlUI4mZuftRFpIPkPb+DiSS1LYIlev+CHbLW7UmF3oPPoNgPZMHRSQHqJBHkf/
         4rAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=gzNvL4kpiGHjLbymCAIxsTwkr5wPwrN3gdjDIGw+gB4=;
        b=Cg4unMT6DtX9D0cLXDyJ2VVP7HTdFkjvzXLnuxhqoAuxf3Y05xrtIG3pH5EmtAL6A0
         NNCOgPc+z3M2VPNifFf6yGgB19nH38lqsqELKV//0aVl3QVOmVfEifHZ2XjJgm+l8J6Z
         cKvusV7Tv8Znnbgnsy2dAjOnr9YIKYuWrjP4CvMkkaLKLXj/tXHQIyvUKILZ9kI5LTQp
         ic3cdFskP/XB+JFauyHObh+aaRso9ytvLDfK+EWEptLy6tN1uUQPrOCPFunrieZQaL8A
         DRf43byqVSIZhYkpDSqK3X2m8jVWva4Gh0GG1dnaBjS4aQrW6UeyT9UuB6Dj7yCKTDJ5
         bZFQ==
X-Gm-Message-State: APjAAAVko1jRY8cInUm06rwWa5+4KI/gUG0t6yIxarevWrHagJo2aK62
        MGpLCA47NhVTAwxjcGBgKycViUoTGKvRL5X8VT4tCzJaeX2FAQ==
X-Google-Smtp-Source: APXvYqwK40RVo3peqrZKKLDt5yzCdXxeSimVkyCYMO0YQvNEU6V5VJVRbIQv+AIuIsVnKAW4V7LPHFfKRWAG5g5p2Ck=
X-Received: by 2002:a92:58d7:: with SMTP id z84mr62972119ilf.179.1577876316569;
 Wed, 01 Jan 2020 02:58:36 -0800 (PST)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Wed, 1 Jan 2020 15:58:25 +0500
Message-ID: <CABXGCsODr3tMpQxJ_nhWQQg5WGakFt4Yu5B8ev6ErOkc+zv9kA@mail.gmail.com>
Subject: [bugreport] Ext4 automatically checked at each boot
To:     linux-ext4@vger.kernel.org, nux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi folks.

Strange things happen with my ext4 lately:
- At each boot, the file system is checked.
- When I launch fsck manually it didn't found any issue.
- But tune2fs report that last checked and mount time is Sun Dec 15,
but this is incorrect.

I don=E2=80=99t know where to look further so I ask here for help.


Here is tune2fs report: https://pastebin.com/PZPbAuHS

# cat /etc/fstab

#
# /etc/fstab
# Created by anaconda on Mon Sep  9 19:36:53 2019
#
# Accessible filesystems, by reference, are maintained under '/dev/disk/'.
# See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info=
.
#
# After editing this file, run 'systemctl daemon-reload' to update systemd
# units generated from this file.
#
UUID=3Db3e2e027-c39d-4266-871f-22d313ac419b /                       ext4
   defaults        1 1
UUID=3DE8A2-F389          /boot/efi               vfat
umask=3D0077,shortname=3Dwinnt 0 2
UUID=3Dbf3e9504-8000-42a1-adb4-226658ec7a5d /home                   ext4
   defaults        1 2
UUID=3Df47f69e1-61f8-4024-960a-b3981d3b1d02 none                    swap
   defaults        0 0


--
Best Regards,
Mike Gavrilov.
