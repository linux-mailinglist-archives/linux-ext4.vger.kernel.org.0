Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE76916C3A6
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Feb 2020 15:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbgBYORX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Feb 2020 09:17:23 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:47096 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730478AbgBYORX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 Feb 2020 09:17:23 -0500
Received: by mail-il1-f193.google.com with SMTP id t17so1427210ilm.13
        for <linux-ext4@vger.kernel.org>; Tue, 25 Feb 2020 06:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jv5c5LXoG9g5yRO+OixJLRTnRGPRBiLVL4S6lEJwqPU=;
        b=Zo0jrRpiiyUzkvYLsp1Q5GrZDcP5YdfYNgbW+SescRTA6MLU7acUT6CIBq1tTHeb6s
         2VlvzyZEk13CHU224wkG5kKxn2tX2XYOWZrstHodhsTKe0/R3Hrz0/DxLert2NyjAr4V
         QZ3gMmPmFlOm45vjwhfanS8YzlV2cIN3mX+yY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jv5c5LXoG9g5yRO+OixJLRTnRGPRBiLVL4S6lEJwqPU=;
        b=d3obvc42x+KiV8HQigcClmdRSGrhh2hTAjMvpcWFdluf/THD8iA2lY+3t/IwvZvBR1
         N9TGwb+jA9lO7cR9+TfGCWGaxXuqLMR0LcHWxLVDUXwpPIY9HsX2DnsEpBnffuvtW2Rs
         moZw2uu5hE7fz1/6c89Gb3uWjGxnGn4454OMiZH40NHWwxpfAq6/ETL0gLi4DeVgfavN
         T7Or7CLok8RvByMmX/ok5llGz2xJ27qWBqQXdoxERWAZApDGdlfhxX/Yf22d02cUE4Yv
         WDC8aCA10FHHvnIc/+eRBxVPsUREow3pMjsUsFhqAz66bXV3kMnKkdzWDmWJ+DK+JSg8
         Z8kw==
X-Gm-Message-State: APjAAAV8HqwF4MpvVgmMJlGU1BDGh6G24hIWsba1lWT8TnOcjQG9JUoe
        Qw46ogTIFlGen0O2AqfmN1reEo+95cY/oz18aqFmew==
X-Google-Smtp-Source: APXvYqx2G1UiiQHlaZm9+ZCojsU629t4LuXTiUCWFpeJA1s2BONyb8B82mAO7djG1+xbOGv9TyYXbqJImVE3NA0YLrU=
X-Received: by 2002:a92:5a59:: with SMTP id o86mr52888923ilb.171.1582640242301;
 Tue, 25 Feb 2020 06:17:22 -0800 (PST)
MIME-Version: 1.0
References: <20200217193314.GA12604@mit.edu> <20200218170857.GA28774@pc636>
 <20200220045233.GC476845@mit.edu> <20200221003035.GC2935@paulmck-ThinkPad-P72>
 <20200221131455.GA4904@pc636> <20200221202250.GK2935@paulmck-ThinkPad-P72>
 <20200222222415.GC191380@google.com> <20200223011018.GB2935@paulmck-ThinkPad-P72>
 <20200224174030.GA22138@pc636> <20200225020705.GA253171@google.com> <20200225035549.GU2935@paulmck-ThinkPad-P72>
In-Reply-To: <20200225035549.GU2935@paulmck-ThinkPad-P72>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 25 Feb 2020 09:17:11 -0500
Message-ID: <CAEXW_YQbiHW=yKiYAs0=8Mp84W6UunM6OOkHE66yXT6cSchm7A@mail.gmail.com>
Subject: Re: [PATCH RFC] ext4: fix potential race between online resizing and
 write operations
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Feb 24, 2020 at 10:55 PM Paul E. McKenney <paulmck@kernel.org> wrote:
[...]
> > > As for "task_struct's rcu_read_lock_nesting". Will it be enough just
> > > have a look at preempt_count of current process? If we have for example
> > > nested rcu_read_locks:
> > >
> > > <snip>
> > > rcu_read_lock()
> > >     rcu_read_lock()
> > >         rcu_read_lock()
> > > <snip>
> > >
> > > the counter would be 3.
> >
> > No, because preempt_count is not incremented during rcu_read_lock(). RCU
> > reader sections can be preempted, they just cannot goto sleep in a reader
> > section (unless the kernel is RT).
>
> You are both right.
>
> Vlad is correct for CONFIG_PREEMPT=n and CONFIG_DEBUG_ATOMIC_SLEEP=y
> and Joel is correct otherwise, give or take the possibility of other
> late-breaking corner cases.  ;-)

Oh yes, but even for PREEMPT=n, rcu_read_lock() is just a NOOP for
that configuration and doesn't really mess around with preempt_count
if I recall :-D. (doesn't need to mess with preempt_count because
being in kernel mode is non-preemptible for PREEMPT=n anyway).

thanks,

- Joel
