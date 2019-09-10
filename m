Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF1ACAEA34
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Sep 2019 14:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390331AbfIJMVm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Sep 2019 08:21:42 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35202 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732465AbfIJMVm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Sep 2019 08:21:42 -0400
Received: by mail-lj1-f196.google.com with SMTP id q22so11625984ljj.2
        for <linux-ext4@vger.kernel.org>; Tue, 10 Sep 2019 05:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3GxIwes7c12IDMkagZ1amMldsYg5ctDWa58fzZZ05I4=;
        b=brWJNeJGPrjnKz0dqpJab6tvBVljJnGRygk6NzTwBHyO68ltDx77g7v5Jq08Jw42+n
         lLdANR7DQAWsFhUR8rvAjcHV8o/1N6uJIKtpYMvYlBYws9XIyN4nAd/q3IoS2Q8ZIbOe
         rq2IbTwhbbvIt93IANqnbtX1919STSSOn0g+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3GxIwes7c12IDMkagZ1amMldsYg5ctDWa58fzZZ05I4=;
        b=BZyUpwLtLlaQnqj8nZkDdmx5dq7O1PJKANfLiMExygksxP4HLBlzQq5vN253fiVvlB
         1pOYy7YHSXGeuHqQULl2jjMwYZ+dY5HEQAyjdnFWb84CjvknR6j9/gsUK4S7RKDrRXAP
         eTAfkCet/krHxvXL6KM0BmEhSo4QRRSZ7kLlLUeTwnDu7KrtQrdEEMEUvulqcx4Np5e3
         Jp+ax0h/dC31cZr/lgVyzx9NaDEWmRfbtyyapJjPxpqppagmy4778Y/zer9n1G+FBWhF
         WrwTSYg27uvBc/U7IUXcJ4CHRk/q35C2qk0NpSULo/Roko+t8GpW4il/cVvHvaPlc0C/
         tSSA==
X-Gm-Message-State: APjAAAWoS3RJ1AoqEEnoVIbC+tM5CULn6r501WTYxCO7+u2I5HoGgRzT
        vDO7WzQXhDvDGB55IS4X60GklKOl5AUKGA==
X-Google-Smtp-Source: APXvYqzSGUL0QZI/Livyo0W+zrUreFmGNigRPDQal7d8Tu6T1ZMI9RBIuixNEp/mTI+qH4dH5JpEPw==
X-Received: by 2002:a2e:9a06:: with SMTP id o6mr20022071lji.230.1568118100062;
        Tue, 10 Sep 2019 05:21:40 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id q19sm4698427lfj.9.2019.09.10.05.21.38
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2019 05:21:39 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id a22so16240302ljd.0
        for <linux-ext4@vger.kernel.org>; Tue, 10 Sep 2019 05:21:38 -0700 (PDT)
X-Received: by 2002:a05:651c:1108:: with SMTP id d8mr11751783ljo.180.1568118097545;
 Tue, 10 Sep 2019 05:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whBQ+6c-h+htiv6pp8ndtv97+45AH9WvdZougDRM6M4VQ@mail.gmail.com>
 <20190910042107.GA1517@darwi-home-pc> <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
In-Reply-To: <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Sep 2019 13:21:21 +0100
X-Gmail-Original-Message-ID: <CAHk-=wgL47gCQFRkj7KYf4XVoWZW2zf3Lcmk6n-0w=3L-hmcLw@mail.gmail.com>
Message-ID: <CAHk-=wgL47gCQFRkj7KYf4XVoWZW2zf3Lcmk6n-0w=3L-hmcLw@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, zhangjs <zachary@baishancloud.com>,
        linux-ext4@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 10, 2019 at 12:33 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Are you sure it's entropy that is blocking, and not perhaps some odd
> "forgot to unplug" situation?

Looking at that code, it's all trivial, and it definitely unplugs properly.

Lack of entropy still sounds _very_ strange, and you . Are you doing
something odd at boot?

Does the boot continue if you press keys on the keyboard, or how did
you decide it was about entropy?

I guess sysrq-'t' followed by enough keyboard input to unblock the
boot process should give you something in dmesg that shows what is
blocked?

                Linus
