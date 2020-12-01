Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC002CACFD
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Dec 2020 21:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404251AbgLAUF5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Dec 2020 15:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730556AbgLAUF5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Dec 2020 15:05:57 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46F5C0617A7
        for <linux-ext4@vger.kernel.org>; Tue,  1 Dec 2020 12:05:16 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id y16so5186130ljk.1
        for <linux-ext4@vger.kernel.org>; Tue, 01 Dec 2020 12:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HEphcGQwY2jeNYDME47hDdQV9bR2WcuThTyY8CTMagA=;
        b=f+XordXx1HtHQauAu4wnySGZ7GOsfsrQOPdsZpcQHvfL87zHN51ik0PwYfToHQidR0
         PlZ/E4mqzBriHmbzSkQser0B1m99iGnRC3rEB7nXytmUcWTvmQp/DGH5GienWzwN/RKd
         ej/bdilwW2TBGDr+jCbzKtRZ0888o0ynwCvig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HEphcGQwY2jeNYDME47hDdQV9bR2WcuThTyY8CTMagA=;
        b=Aa6pSwuRzSTYwpSnhYSZEnH78wpvgAKBE1/FwECVbxkDD+80A3GeOsi0X1skBZkOGy
         cNAY63SzE1p7OUsY0zrhU0ioKTrriFl3HKdNWp35xy7z/9ilhZeMz+SDgFCE0vQjdv9U
         sSuofUJWzrpz+6zr6T9vujzRXKXcjteEW13FErYl81H1N7o/9W1oWWhhpP/n5N6r3SRx
         GL4wnRcewVFqj4bK/DJuK9eo2TA/eNGOCJ2LJwsEkLFI1tj8JbRX5TMcO2eg8ZAiRjLG
         nd3YKsIgiZWEwXFdSVPbJtsi103vxBuVOHTlDce6FOjMC0M1qZnPv6v+8+eQCN828/oB
         uvfw==
X-Gm-Message-State: AOAM530DHzo5pSCH78B6r49Pksge+FlBxOvlugtE4NnZ2s0pl/X3YZNA
        9uTe9lWza8x+fn5INRs3FLKih08eOwp0Uw==
X-Google-Smtp-Source: ABdhPJzU8A9PMgTWi2WJNBbJDgQuDPjuvDMzPLr+695RnSeprXpfGDYqEF5SmkUey0CcTMo+PehKqg==
X-Received: by 2002:a2e:878c:: with SMTP id n12mr2151021lji.319.1606853114270;
        Tue, 01 Dec 2020 12:05:14 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id v17sm70077lfa.81.2020.12.01.12.05.13
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 12:05:13 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id v14so6961126lfo.3
        for <linux-ext4@vger.kernel.org>; Tue, 01 Dec 2020 12:05:13 -0800 (PST)
X-Received: by 2002:a19:5003:: with SMTP id e3mr1997442lfb.148.1606853112635;
 Tue, 01 Dec 2020 12:05:12 -0800 (PST)
MIME-Version: 1.0
References: <e388f379-cd11-a5d2-db82-aa1aa518a582@redhat.com> <05a0f4fd-7f62-8fbc-378d-886ccd5b3f11@redhat.com>
In-Reply-To: <05a0f4fd-7f62-8fbc-378d-886ccd5b3f11@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 1 Dec 2020 12:04:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgOu9vgUfOSsjO3hHHxGDn4BKhitC_8XCfgmGKiiSm_ag@mail.gmail.com>
Message-ID: <CAHk-=wgOu9vgUfOSsjO3hHHxGDn4BKhitC_8XCfgmGKiiSm_ag@mail.gmail.com>
Subject: Re: [PATCH 2/2] statx: move STATX_ATTR_DAX attribute handling to filesystems
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Xiaoli Feng <xifeng@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Dec 1, 2020 at 8:59 AM Eric Sandeen <sandeen@redhat.com> wrote:
>
> It's a bit odd to set STATX_ATTR_DAX into the statx attributes in the VFS;
> while the VFS can detect the current DAX state, it is the filesystem which
> actually sets S_DAX on the inode, and the filesystem is the place that
> knows whether DAX is something that the "filesystem actually supports" [1]
> so that the statx attributes_mask can be properly set.
>
> So, move STATX_ATTR_DAX attribute setting to the individual dax-capable
> filesystems, and update the attributes_mask there as well.

I'm not really understanding the logic behind this.

The whole IS_DAX(inode) thing exists in various places outside the
low-level filesystem, why shouldn't stat() do this?

If IS_DAX() is incorrect, then we have much bigger problems than some
stat results. We have core functions like generic_file_read_iter() etc
all making actual behavioral judgements on IS_DAX().

And if IS_DAX() is correct, then why shouldn't this just be done in
generic code? Why move it to every individual filesystem?

               Linus
