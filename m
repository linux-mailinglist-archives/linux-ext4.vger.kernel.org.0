Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63C2C11066E
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Dec 2019 22:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfLCVVV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Dec 2019 16:21:21 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43208 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfLCVVV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Dec 2019 16:21:21 -0500
Received: by mail-lj1-f193.google.com with SMTP id a13so5469987ljm.10
        for <linux-ext4@vger.kernel.org>; Tue, 03 Dec 2019 13:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/2Pn+nUwTPiWQNmD6ZcUyBL9YYHx/8hYVUPPzlyrC1w=;
        b=YWt7tCChJawBH2mlGjm75VvKQF1n9lq0PB4WHZENSOIYbPbM+TMiv+A4sz31FIrIF+
         qv6rVeradhmwJ1y3LywV1hVUnY+3sdobJHBMSiCoBi14y0F23F0EVwMMAXxXELbrEtOr
         HkKcuRhQ3sww6TYp8jETEWeDjYOJ+2N3IyHRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/2Pn+nUwTPiWQNmD6ZcUyBL9YYHx/8hYVUPPzlyrC1w=;
        b=Yjue2SvdR6HZ3oZxQGylv7RRxcnTU7uZta0BHnayCn7qf4Ih7pgoi+b10j8UrKVmcZ
         Y5BAjzMpwsryfklJLMqr8wH2GM2WVxBiREYzn+vzLw2s6OiD5ODenXnIyftuhI3wE34Y
         C1jMptT2CZXk8SZJEHm4zgoelmiKLXITuNRFzIW+EvheHb1E5vEvITYIXnZmMqL9Ko2k
         gfFQrrfkpzHFjM9bTaUzKgUKS3klg7qTQ2f2RrR0BPZJi3AoPgV8+wyaSCSkt+pv3wf/
         JyocdQ4UTTF5WW5OhyQ3G8bFg/aKE6Lmyfqfjoj54JtALch9fKVu/TFjviKjMIAf9iUI
         CLDg==
X-Gm-Message-State: APjAAAWEaPGZ7C9CfDy6otC6rTQzMJ4kl3bzfBpm/W8EDUKkbmW0+m4H
        KiTMczsGys832LFXwkdiGIOETa1g01M=
X-Google-Smtp-Source: APXvYqw3bNxod+vdKSYcLyb3cPKuRSSwSMTT7F9rg0DT5NW+cLslimZW0B75YxJvbBI9l0qhjP1N0Q==
X-Received: by 2002:a2e:8745:: with SMTP id q5mr3841140ljj.208.1575408079049;
        Tue, 03 Dec 2019 13:21:19 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id w71sm2357455lff.0.2019.12.03.13.21.17
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2019 13:21:18 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id j6so5539318lja.2
        for <linux-ext4@vger.kernel.org>; Tue, 03 Dec 2019 13:21:17 -0800 (PST)
X-Received: by 2002:a2e:63dd:: with SMTP id s90mr3908645lje.48.1575408077519;
 Tue, 03 Dec 2019 13:21:17 -0800 (PST)
MIME-Version: 1.0
References: <20191203160856.GC7323@magnolia>
In-Reply-To: <20191203160856.GC7323@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 Dec 2019 13:21:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh3vin7WyMpBGWxZovGp51wa=U0T=TXqnQPVMBiEpdvsQ@mail.gmail.com>
Message-ID: <CAHk-=wh3vin7WyMpBGWxZovGp51wa=U0T=TXqnQPVMBiEpdvsQ@mail.gmail.com>
Subject: Re: [GIT PULL] iomap: small cleanups for 5.5
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Dec 3, 2019 at 8:09 AM Darrick J. Wong <djwong@kernel.org> wrote:
> Please pull this series containing some more new iomap code for 5.5.
> There's not much this time -- just removing some local variables that
> don't need to exist in the iomap directio code.

Hmm. The tag message (which was also in the email thanks to git
request-pull) is very misleading.

Pulled, but please check these things.

           Linus
