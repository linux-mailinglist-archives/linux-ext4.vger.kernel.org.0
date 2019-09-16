Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8A66B4165
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2019 21:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732696AbfIPTyH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Sep 2019 15:54:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36523 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbfIPTyH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Sep 2019 15:54:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id t3so593216wmj.1;
        Mon, 16 Sep 2019 12:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4PX9Kbdf/A/a4MaGAnVuIX5oyNGr0+JJhJb/XQGXlPk=;
        b=Pq/G5sgDBwqO7N/NZoHq6vAnLQdnmqWF3ActxfgcfBHmPcaay1k310KGeT+4zLnbtf
         e2VkRluXw2y5zJidKXyUAWYAncmIU6FJ4VI/aWaAxnyCkhGqW1Ka7fuUAVg0mCYfFtzx
         FeS9X3Iwq8Ap4EBLpRwCMPVzTLhnB9ZeflCrvj+cOzaMAMzsvvDDOcucbLp0sjc86aYT
         ZzUwBs+lqr2lf1VZSN+5yWugK6aXHW8mOoCnSFRXTzFfzkXDZdUKvTUju9KwPQhSR3lN
         iSXmY+qh8DxbLz1tDu1OmneYH5Uj1tpttrQmJQwxAFtx/HS7/9wLkRiEhurlvj/Zik7B
         7uyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4PX9Kbdf/A/a4MaGAnVuIX5oyNGr0+JJhJb/XQGXlPk=;
        b=E2/kGpa2REY6GI+62fRTmCCT/pWToguA8UrM7vIqxqIiEdPRboVKREdzCIQP1GjsIF
         JZsGyBYc6zvTUdpJiwYkYQnfvlrw362G4el2zsi5Zs7hZTVCNDbMc71ytNqoaHtHTXnr
         RfHkIdpRx4z7K658uMIG2cd3UqRTdflMMxAjH8K6a4JmGr/VCD24maEuM9gbi27+vE2r
         An1bldAGT5x7EmMjdsPVbI8tpDga7Y/9DpqyTK8bMzDvBS9b54hdzpFqCb4tEQT3oI7l
         QM88xb6YLCOGUxCNfy31/UMDyEj+a3obEgg6dg6kgNyNmgJBs3iaozQkQL2lGkEUvAZ9
         U/Sg==
X-Gm-Message-State: APjAAAXNW1V0RqHe+hQeZbNokJZDvC8kyiaIHAulaMILeXE+1LAOnj/P
        S8XTV8IRSUKKLP1C56GbLD0=
X-Google-Smtp-Source: APXvYqwBdY4uOu0ZFcdaEBrivR93S7OYkwCljwilX1W+IUtywSMOglf7NIj5IKWKDBba0+vqOt4kXQ==
X-Received: by 2002:a1c:4946:: with SMTP id w67mr537801wma.131.1568663644846;
        Mon, 16 Sep 2019 12:54:04 -0700 (PDT)
Received: from darwi-home-pc (p200300D06F2D148E24CC892DA859AC81.dip0.t-ipconnect.de. [2003:d0:6f2d:148e:24cc:892d:a859:ac81])
        by smtp.gmail.com with ESMTPSA id m18sm53826700wrg.97.2019.09.16.12.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 12:54:04 -0700 (PDT)
Date:   Mon, 16 Sep 2019 21:53:57 +0200
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>, Vito Caputo <vcaputo@pengaru.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190916195357.GA3312@darwi-home-pc>
References: <20190915065142.GA29681@gardel-login>
 <CAHk-=wiDNRPzuNE-eXs7QOpgPVLXsZOXEMQE9RmAWABiiZrSAQ@mail.gmail.com>
 <20190916014050.GA7002@darwi-home-pc>
 <20190916014833.cbetw4sqm3lq4x6m@shells.gnugeneration.com>
 <20190916024904.GA22035@mit.edu>
 <20190916042952.GB23719@1wt.eu>
 <CAHk-=wg4cONuiN32Tne28Cg2kEx6gsJCoOVroqgPFT7_Kg18Hg@mail.gmail.com>
 <20190916061252.GA24002@1wt.eu>
 <CAHk-=wjWSRzTjwN9F5gQcxtPkAgaRHJOOOTUjVakqP-Nzg9BXA@mail.gmail.com>
 <20190916172117.GB15263@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916172117.GB15263@mit.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Sep 16, 2019 at 01:21:17PM -0400, Theodore Y. Ts'o wrote:
> On Mon, Sep 16, 2019 at 09:17:10AM -0700, Linus Torvalds wrote:
> > So the semantics that getrandom() should have had are:
> > 
> >  getrandom(0) - just give me reasonable random numbers for any of a
> > million non-strict-long-term-security use (ie the old urandom)
> > 
> >     - the nonblocking flag makes no sense here and would be a no-op
> 
> That change is what I consider highly problematic.  There are a *huge*
> number of applications which use cryptography which assumes that
> getrandom(0) means, "I'm guaranteed to get something safe
> cryptographic use".  Changing his now would expose a very large number
> of applications to be insecure.  Part of the problem here is that
> there are many different actors.  There is the application or
> cryptographic library developer, who may want to be sure they have
> cryptographically secure random numbers.  They are the ones who will
> select getrandom(0).
> 
> Then you have the distribution or consumer-grade electronics
> developers who may choose to run them too early in some init script or
> systemd unit files.  And some of these people may do something stupid,
> like run things too early, or omit the a hardware random number
> generator in their design, even though it's for a security critical
> purpose (say, a digital wallet for bitcoin).

Ted, you're really the expert here. My apologies though, every time I
see the words "too early" I get a cramp... Please check my earlier
reply:

    https://lkml.kernel.org/r/20190912034421.GA2085@darwi-home-pc

Specifically the trace_printk log of all the getrandom(2) calls
during an standard Archlinux boot...

where is the "too early" boundary there? It's undefinable.

You either have entropy, or you don't. And if you don't, it will stay
like this forever, because if you had, you wouldn't have blocked in
the first place...

Thanks,

--
Ahmed Darwish
http://darwish.chasingpointers.com
