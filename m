Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC1ABB2DC5
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2019 04:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfIOCMD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 14 Sep 2019 22:12:03 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36603 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfIOCMD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 Sep 2019 22:12:03 -0400
Received: by mail-lf1-f65.google.com with SMTP id x80so24821647lff.3
        for <linux-ext4@vger.kernel.org>; Sat, 14 Sep 2019 19:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4rYFEB2K43HNknGCuNtqwY11d7jNo13i6prZjBn/RDM=;
        b=IFLavFfBEECvUaRBp/EiSvd06bt8SLP7qdIU8LhowKpuB244awAuNyT4xXKNmN8XsF
         qKdO4HiiFlSNQQjo59uVaTwlCPHmxYMbqFjOi4brsClvtwRtIGCqxPsJvahupKarYSzE
         nprKJDuzUk/SMYuio6GVb4ZLDckKb7XB7gnLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4rYFEB2K43HNknGCuNtqwY11d7jNo13i6prZjBn/RDM=;
        b=A/vVagqhqB53H3hJDsfys8M4dZCbvfdzn4mklsQw1dEPMsSRzXUE3U6RH/6QAw/CwN
         BD4S/Z/Ht7A6igTlWvItZJGx15Ir/Ca4mi4HR1M9OSa0ZKk61EhiQjCLy7qhMlbauZwK
         grzdxhyDf7eQpk2BkbFPAD0npJhQF6XLfmy2VoyBzFmcsRgeRs7P1P8gdZtGlVptmvgV
         ajeYHbbeZ31JDscDE+5jzsajjXLYqV7WTlKaTnXxQNY4zN9gqYQUN++27BhfS1YZYLfk
         CL1KVEh911S1KLyUzuadNWxFKgal7gXnpKaDrlNCvD8ejEYD/r16C9aGV+8JnQWfO+tV
         rNUQ==
X-Gm-Message-State: APjAAAVydL/N+ta3kX4s0QIrx5HZI/rGOBRqrfqn/a3zgU7qvI3y3daW
        HBV7dH6Ve6CGduafwLaeav/esLWGmxI=
X-Google-Smtp-Source: APXvYqwwL79oN6msGMPtilJTcv1yifqz/hqIozn0vVAZlx73dhllFutYPV5sB6Sw4bukpnfXgDcZTw==
X-Received: by 2002:a19:7413:: with SMTP id v19mr34542367lfe.176.1568513520415;
        Sat, 14 Sep 2019 19:12:00 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id z7sm2591635ljc.9.2019.09.14.19.11.58
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2019 19:11:59 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id a22so30529565ljd.0
        for <linux-ext4@vger.kernel.org>; Sat, 14 Sep 2019 19:11:58 -0700 (PDT)
X-Received: by 2002:a2e:814d:: with SMTP id t13mr34727113ljg.72.1568513518572;
 Sat, 14 Sep 2019 19:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190912034421.GA2085@darwi-home-pc> <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc> <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <20190914211126.GA4355@darwi-home-pc> <20190914222432.GC19710@mit.edu>
 <CAHk-=wi-y26j4yX5JtwqwXc7zKX1K8FLQGVcx49aSYuW8JwM+w@mail.gmail.com>
 <20190915010037.GE19710@mit.edu> <CAHk-=wjGTV0e_P73V0B3cPVrfeoSZcV6CjQMgj-+yL-s38DKaw@mail.gmail.com>
 <20190915020521.GF19710@mit.edu>
In-Reply-To: <20190915020521.GF19710@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 14 Sep 2019 19:11:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg5BPZeH+wBdgWbDNYuHwiPN+GR-VBhUMjRsYuqEit6Ag@mail.gmail.com>
Message-ID: <CAHk-=wg5BPZeH+wBdgWbDNYuHwiPN+GR-VBhUMjRsYuqEit6Ag@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Sep 14, 2019 at 7:05 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> I'd be willing to let it take at least 2 minutes, since that's slow
> enough to be annoying.

Have you ever met a real human being?

A boot that blocks will result in people pressing the big red button
in less than 30 seconds, unless it talks very much about _why_ it
blocks and gives an estimate of how long.

Please go out and actually interact with real people some day.

            Linus
