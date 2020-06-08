Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2F81F1A00
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Jun 2020 15:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgFHN0y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 Jun 2020 09:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbgFHN0w (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 Jun 2020 09:26:52 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3650FC08C5C2;
        Mon,  8 Jun 2020 06:26:52 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id l6so16738106ilo.2;
        Mon, 08 Jun 2020 06:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=1VTe6QD10qeK3f5ORVEMmvTZZXrwqWHxxRrcVFjOKgk=;
        b=iY23vHiRhJKWHF9e18SRE6wivlOh7n6YL+aIIYGc1sxLdQK6ETcf8srOCfcXUJmgBN
         Q2nR0VsJveM+6n2NC1MOSQ3r2fcsLcbopnB0DtJE3edQs7X8CfTvdihjaynjqYOLx8B4
         6su2sDYsPc44I+5iqjv2uoZ2BEzFRe8yqokYGD048xcfNxLc363Tqzudv9NP6Ry8x6uD
         wC41xJvpXdN+ruBT7pBAijBiSRAvxisG13RpGUiGqLOZMDkFiPuv9LzpPGw71wkGbugK
         XN2IX1sB7m3Bbt6CRFxkXpqVXj7BlgrHtdTFcXMc1gVQhn+jGDI4OQmNSPmi/wII+u3C
         xnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=1VTe6QD10qeK3f5ORVEMmvTZZXrwqWHxxRrcVFjOKgk=;
        b=JIzfoppbg+TwFAx9TcqfSJNyVPmvXoKN1jdZU8vvksQka+VTaANvHfscKmYAjxrvG2
         1R3pi23q6Xj8JU14Jr0OssbeLQFLQP5FCLHLqW7dXOdLrq82B1zeYAcgWcP/k6GF6iei
         0TobJwi1xpxyegsjtFfsEh70iZQ0DUn/iXFANJHhUUZxjmIWgQxLL5kbjuhDdMzBSYzb
         M7gjqs8yMjvtaxC+SaCYooXureMuWpRyu+M1TB07tIVyISphIos6z78Xq6erUZlui2Qp
         HzXQx8ca8QadIXa+LbJF25U8A0C+0DlTzXS5oZubkBc6sdQUf/pd9HUnRvcH+e8aBl/9
         DWLA==
X-Gm-Message-State: AOAM531HUObLjiVZ22ePwUggEuzp3hl8jB6dyNE+1gmrrQdc7YtJymAS
        O9SSdHQrrjwYhGUIbrxFiYqi7pWL1xUwkAJnl3o=
X-Google-Smtp-Source: ABdhPJwSZHlY0w6BQ6C3WXda+REX24eUNOG8zVeufHitbbf/EeJN/O0AVbQ6yoe8LixSeiQHS+jbuZ/Ugq1WwyRKW3o=
X-Received: by 2002:a92:9603:: with SMTP id g3mr22722282ilh.204.1591622811516;
 Mon, 08 Jun 2020 06:26:51 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 8 Jun 2020 15:26:40 +0200
Message-ID: <CA+icZUWuds-wNr+NDVPDaxJ83cmCTPPTZ8qL8U5by2FC1uTHYw@mail.gmail.com>
Subject: Linux v5.7.1: Ext4-FS and systemd-journald errors after suspend + resume
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

for a long time I did not try suspend + resume.

So, with Linux v5.7.1 I tried it.

As I upgraded my systemd to version 245.6-1 I suspected this change,
see my report to Debian/systemd team.

Second, as I saw read-only filesystem problems in the logs I changed
in /etc/fstab:

-UUID=<UUID-of-rootfs> /   ext4 errors=remount-ro 0 1
+UUID=<UUID-of-rootfs> / ext4 defaults 0 1

That did not help.

I have one single / root-fs partition.

What I still see after suspend (45 secs) and resume:

Ext4: ... unable to read itable block ...
Ext4: ... dx_probe:768 ... error read-only directory block ...
Ext4: ... ext4_get_inode_loc ...
systemd-journald: Failed to write entry - Read-only file system <---
Also kded5 etc.

The system is in an awful and unusable situation.
Typing any command in konsole shows command not known/found.
I have not found a way to debug this.

What informations do you need?
Any hints on how to debug this?

Thanks.

Regards,
- Sedat -

[1] https://alioth-lists.debian.net/pipermail/pkg-systemd-maintainers/2020-June/041057.html
