Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210BA65BED9
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Jan 2023 12:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbjACLXG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Jan 2023 06:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbjACLXG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Jan 2023 06:23:06 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B57FFFF
        for <linux-ext4@vger.kernel.org>; Tue,  3 Jan 2023 03:23:05 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id l184so2739799vsc.0
        for <linux-ext4@vger.kernel.org>; Tue, 03 Jan 2023 03:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qymjN3ujIci8QkJahnuWyEwypRWjm8vIMiyD3hCE2XE=;
        b=pCkQOR73NHA5kMDVdKeBPobVfVBQu0yDy9iSHpK0fEZ8eLqg3chkvWhYRneaHGmTYf
         0CdNeRQEp6yUg992g6SPR1oEh9VGflRKlEncZu6JuN7dkzJ16ppVxaOwRGp5r5g8wA7C
         +FSYHFgqzHO0LYtWR+vxPoYRgVfFf8hnv0rROQqqg3KPMdjyKqZx5rq1UUcLsAlDRavB
         GO8/SYJa641nS4nM8cDlFmWl+tUY7JIhLaauvt3oCm1700B9qzocHeLReCcw+hGIMDNQ
         DYkMt8Lf6HHMkFtpd13o5MZKFIC3tjIFZZe6k3Y6cLhv4nZcEcEndufA/evxk97IFayp
         LNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qymjN3ujIci8QkJahnuWyEwypRWjm8vIMiyD3hCE2XE=;
        b=s2Cu/U1U6Vk8SjeOF3f5ORkiMB0gTvPntltGN5ruWmoqOdrOzqxEY43394K8LzDSYW
         +xRYubJddLuG7w/Pz8wv377XCl2RzWNr3VwuoRJpsK663P+LrBVTS9iDD5K4AfT4zbUp
         ACa46XySYIFN+x1ebTgkcO4PuflIj3QzVrhWqDvlY+5sx6jMS0HEaspKl1DDXAjfNVTw
         P+cNG8MQmY0oQ6W/gtBh7Igl7C0nkiy+CokEwC4fgTjm00aDH6QWVe9ciPoEV1/18Hat
         jCcufSYK5ld1dm8v8C5EwC0wW81GtNaRRq1sqsyTq6k7k3G36cJVscaHTyNbmwlgn8lr
         SGBg==
X-Gm-Message-State: AFqh2kr+lz3iZkJRgJT393KSFRjopW08IK3RUTQQNkbCY2lkXpBBHpMJ
        MeVRo9l9NKN+q9ucAc5C08lp/topwBzpG839693zBw==
X-Google-Smtp-Source: AMrXdXsTmHtB0EK6xoRW7OhHg11NHnMNoEKbDRPiJpULGh0kuIcHf3NOlZjTvLpP7nB99SHwnJDvQDhanyajiENlXMo=
X-Received: by 2002:a67:f642:0:b0:3c4:ec4b:b943 with SMTP id
 u2-20020a67f642000000b003c4ec4bb943mr4847879vso.17.1672744984229; Tue, 03 Jan
 2023 03:23:04 -0800 (PST)
MIME-Version: 1.0
References: <000000000000e6c7b005f0e90bf1@google.com> <Y6zN/Q3glUcbty+c@mit.edu>
In-Reply-To: <Y6zN/Q3glUcbty+c@mit.edu>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Tue, 3 Jan 2023 12:22:53 +0100
Message-ID: <CANp29Y7yH6LeeHMX-joXgr7duZzs2p3j08qZzS6WGwBJDDq+PA@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] kernel panic: EXT4-fs (device loop0): panic
 forced after error (2)
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     syzbot <syzbot+3c45794f522ad93b0eb6@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted,

Syzkaller already tries to avoid such situations, but in this
particular case, it has corrupted the mount options[1] and did not
recognize the problem. Though, as I understand, this string was
nevertheless valid to the kernel. Otherwise it would have aborted the
mount early (?).

I've sent a PR that should make the syzkaller logic more robust to
such broken options strings:
https://github.com/google/syzkaller/pull/3604

[1] grpjquota=Jnoinit_itable(errors=remount-ro,minixdf,jqfmt=vfsv0,usrjquota=."

--
Aleksandr

On Thu, Dec 29, 2022 at 12:14 AM Theodore Ts'o <tytso@mit.edu> wrote:
>
> So this is a totally bogus Syzbot report.  If you use the mount option
> "errors=panic", and you feed ext4 a corrupted file system, then it
> *will* issue an "Ext4-fs error" message, and if you tell it to panic,
> it will panic.
>
> So *please* let's not have some crazy Red Hat principal engineer try
> to file this as a high severity CVE....
>
> This is Working As Intended.  And it is Not A Bug.
>
>                                         - Ted
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/Y6zN/Q3glUcbty%2Bc%40mit.edu.
