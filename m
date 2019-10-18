Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70618DBA76
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Oct 2019 02:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441868AbfJRAMK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Oct 2019 20:12:10 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:44891 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbfJRAMK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Oct 2019 20:12:10 -0400
Received: by mail-qt1-f180.google.com with SMTP id u40so6433761qth.11
        for <linux-ext4@vger.kernel.org>; Thu, 17 Oct 2019 17:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qlq0IBiJL0VWJaCjGOCVLXHXeTcQVmXh3XXXt8eG1zQ=;
        b=OnY/jB02QlN859S24vGJBoK4ibrxELgo8ZrWRymSY5IyrxS7/rucba8CYiQY/ytBbj
         0f7mg+YQZAqF9qNRsAfUbdCG+L4S9+BA5V5CstZLGkUwR41tu/WbEp2Z+5ZbawMsbH8W
         G3CtwTt1FZiqHrWwKuN89rlvCuSxnkXbd9QqYtjVda8zlbQXNOfzbu6e+mwWwJmG/z4t
         Vw4BkndsfvVTUvXZJGN4wBTKSLJWdTNJH5TuzgRI87iftvJzOAxkfbUeF45XllwwpGxt
         yj5fTii+SfJKvAOoBP2clqqoZjhmYy0JT7z73lVw3LnHZM5z84LMR/IZF7KLDBscWvBX
         pQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qlq0IBiJL0VWJaCjGOCVLXHXeTcQVmXh3XXXt8eG1zQ=;
        b=UB03TXxpUXyNgqa3uzMCWvQaqT3FxPAWcQXVSbC6/KWyzZSfLODJxB6TcIGnZINBON
         6PWL1/NqU6m8SQWYzROcAOhhYkeZXLVUEQCXow+qvaNikIf5Boo6MOIGZCs93Wzb+QQV
         bDHaKk6QBTCsAnIpEbkRdmBkOw++jEgad8NTz+p+6QpbLrmV+6jUYkQRrruF0c6vfLCD
         2E7Sq9RJh9706EV7vJDy55feVFtCylTAj0qlwEKYwTK1uVkMtv0OXxaQTgkjGBu6q6So
         pGpPKTHwVTSfykZSDjxN5a90x4up6d1+6M3WbSVLeHlQLui4z6lDGFwKbAJ9ZEbWXEPS
         duWw==
X-Gm-Message-State: APjAAAWyrek3WbNJFeSRBU8Gg0fKtXR7vGzN3Xlk4rLGsKk29TjOWUXY
        1DngJgx1tnckj6zeWh5vvlYIjMEuh4NHow9OA5My
X-Google-Smtp-Source: APXvYqzSSMaJzwQe/BcWiaYKohAlQjCz1k+BmS4OfRilFXDbIOi5CgMQM6qGy9vR+wk2MO4LlQWbYrwHLDSwRBqYG1M=
X-Received: by 2002:ac8:5147:: with SMTP id h7mr6874621qtn.160.1571357529021;
 Thu, 17 Oct 2019 17:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20191010023931.230475-1-yzaikin@google.com> <2f2ea7b0-f683-1cdd-f3f2-ecdf44cb4a97@linuxfoundation.org>
 <CAAXuY3qtSHENgy3S168_03ju_JwAucOAt5WEJGQ+pi5PfurP6g@mail.gmail.com>
 <CAFd5g46RcFV0FACuoF=jCSLzf7UFmEYn4gddaijUZ+zR_CFZBQ@mail.gmail.com>
 <20191011131902.GC16225@mit.edu> <CAFd5g45s1-=Z4JwJn4A1VDGu4oEGBisQ_0RFp4otUU3rKf1XpQ@mail.gmail.com>
 <1e6611e6-2fa6-6f7d-bc7f-0bc2243d9342@linuxfoundation.org>
 <20191017120833.GA25548@mit.edu> <957434b6-32cc-487f-f48e-f9c4416b3f60@linuxfoundation.org>
 <CAAXuY3r7Eu+o-td8MRvexGYmONPgd8FvHr+7mF84Q4ni1G3URg@mail.gmail.com>
 <40073fc9-1de1-9253-e2f9-9cf9ee4308d4@linuxfoundation.org>
 <CAAXuY3r7QKSuwVYDQhF8-zC75ZRVHr+4pzpGXeNbPaEdbM3h4Q@mail.gmail.com> <ECADFF3FD767C149AD96A924E7EA6EAF977D00C3@USCULXMSG01.am.sony.com>
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF977D00C3@USCULXMSG01.am.sony.com>
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Thu, 17 Oct 2019 17:11:32 -0700
Message-ID: <CAAXuY3oS=fzH0hpdjUpp_tUyypfAs=TaJxtw9L2=feUkLH2sUA@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v2] ext4: add kunit test for decoding
 extended timestamps
To:     "Bird, Timothy" <Tim.Bird@sony.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Oct 17, 2019 at 4:54 PM <Tim.Bird@sony.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Iurii Zaikin
> >
> > > You can do all of this and allow users to supply another set of data.
> > > It doesn't gave to be one or the other.
> > >
> > What is the use case for running a unit test on a different data set than
> > what it comes with?
>
> I just gave some ideas in another message (our emails crossed),
> but one use case is to allow someone besides the test author
> to inject additional data points, and to do so without having to re-compile
> the code.
>
> They might do this for multiple reasons:
>  - to experiment with additional data points
>  - to try to diagnose a problem they are seeing
>  - to fill gaps they see in existing data points
>
> Whether this makes sense depends on a lot of factors.  I suspect
> the timestamp test code is not a good candidate for this, as the code
> is simple enough that adding a new test case is pretty trivial.  For some
> other types of tests, adding the data via an external file could be easier
> than changing the code of the test.

I think feeding test data without recompiling looks attractive right now because
in order to run a single test you need to compile and link the whole kernel.
I believe KUnit's strategic goal is the ability to only compile the
relevant bits,
which is admittedly very far off.
Normally, in application programming the amount of code that needs to be
recompiled in order to run a test suite is small enough that the added
complexity
of enabling the test to get the data from external sources is not
warranted. Typically,
external files are used when something is not practical to include in
the source file
directly due to size or complexity, i.e. a large snippet of text, an
image file, some
binary data etc. Such needs are typically addressed by the test author
rather than
the core test framework.
Now, in application programming you can do a lot of things like
reading a file which
is trickier in kernel. But again we've come to supporting a use case
for test data which
has to be fabricated through some involved process or otherwise not
easily included
in the source file.
And if you come up with an additional test case, why not just add it
and leave it there?
Unit tests are cheap, even if a case proves to be redundant, the mere
fact that the
code under test made you think of such a case is sufficient to
permanently include
the test case into the test suite.
