Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDA1C159ADD
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Feb 2020 21:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731903AbgBKU7w (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 11 Feb 2020 15:59:52 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45009 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729279AbgBKU7w (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 11 Feb 2020 15:59:52 -0500
Received: by mail-oi1-f193.google.com with SMTP id d62so14163800oia.11
        for <linux-ext4@vger.kernel.org>; Tue, 11 Feb 2020 12:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=extxsRRjmkIJZEh/sTfq/VSUaht64zLviDFgNerAR0E=;
        b=I1xwH6Byix/62gQ54cfQkAhK3Jz6DZUnPEusCbQQ20skEH7t7q1ersOxFM2h8eTjFq
         W7bs4biU+p5p2rBb8nacmQ+AyuU973vMUnU/taHRlqpu4s2LfDLV9nh68R67/9IHN54V
         Zh1uALOWVcrlvsNNTZj0JZWfKbx+OG02U4MDSQGMPZxKTRuUDEWL3k7FpR4YqEPKNedQ
         mbTRld4FShJFNSCJLfhgOHJtcCGpyJIJ05CACfqm36E8Iq18xxlsLL5OWXDS1sXJ/AEq
         eWX5eMKrKADz9NYuNYEImIqQzMkm5dSAeKK6nzyOMYNcJHbAsQb7Ua1pJrY91i0sa1G7
         ooQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=extxsRRjmkIJZEh/sTfq/VSUaht64zLviDFgNerAR0E=;
        b=bucNyrEZRefO/vC9+uYW5vcSYVq+O3AZY/b4qH2qkj31z9sXe6IT5EDS2JQOhxEf7+
         BCPca2VoqnhUTCt8dr8zOvACpgoDUu02CqEeSnHCNV4wIt/vCBSogezjgoxmSWgk4VQF
         yuEij1XQSAFfB/eph/GW2QXGDAwfgervlkqZFsl2LZIjuHnhU53saN7gj3e+BYN5ZGZB
         LzcMkrI9hQppq6B7XViC8md+y9z2uhkj+GRKkH1b+Kc84VQQv05hA8Ye/ahAgHv93JGK
         5rxVrlpW1k0gHd4hpXzWbZWUUqdsmwBOAQkKH3qSVKa418XLEeAZfIumemybrYTsXW+k
         TE/A==
X-Gm-Message-State: APjAAAXuydMwje0sKbV3kaJC/oQ/Ib2NLWrHSRnbZcadgA5lJwRkb+N9
        Qx/oQqURLicqtajQWIiqaDyPR/rFIXnU+p1Xl4vARg==
X-Google-Smtp-Source: APXvYqy2e6QuQme8tks+nFn6MGTK47SXBGcqgqEabGAFW6zHHoWaB1wrKQLyHPWb+JU7T/jGznd8vWOuaKeaLDE7Ygk=
X-Received: by 2002:aca:3f54:: with SMTP id m81mr3957419oia.73.1581454791852;
 Tue, 11 Feb 2020 12:59:51 -0800 (PST)
MIME-Version: 1.0
References: <20200208193445.27421-1-ira.weiny@intel.com> <20200208193445.27421-8-ira.weiny@intel.com>
 <20200211080035.GI10776@dread.disaster.area> <20200211201430.GE12866@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20200211201430.GE12866@iweiny-DESK2.sc.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 11 Feb 2020 12:59:40 -0800
Message-ID: <CAPcyv4hLTg+1dx2bE2S7sLRK17EP_gT5kutwhyUfVB7Ad8khgw@mail.gmail.com>
Subject: Re: [PATCH v3 07/12] fs: Add locking for a dynamic DAX state
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Feb 11, 2020 at 12:14 PM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Tue, Feb 11, 2020 at 07:00:35PM +1100, Dave Chinner wrote:
> > On Sat, Feb 08, 2020 at 11:34:40AM -0800, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > >
> > > DAX requires special address space operations but many other functions
> > > check the IS_DAX() state.
> > >
> > > While DAX is a property of the inode we perfer a lock at the super block
> > > level because of the overhead of a rwsem within the inode.
> > >
> > > Define a vfs per superblock percpu rs semaphore to lock the DAX state
> >
> > ????
>
> oops...  I must have forgotten to update the commit message when I did the
> global RW sem.  I implemented the per-SB, percpu rwsem first but it was
> suggested that the percpu nature of the lock combined with the anticipated
> infrequent use of the write side made using a global easier.
>
> But before I proceed on V4 I'd like to get consensus on which of the 2 locking
> models to go with.
>
>         1) percpu per superblock lock
>         2) per inode rwsem
>
> Depending on my mood I can convince myself of both being performant but the
> percpu is very attractive because I don't anticipate many changes of state
> during run time.  OTOH concurrent threads accessing the same file at run time
> may also be low so there is likely to be little read contention across CPU's on
> the per-inode lock?
>
> Opinions?

As one who thought a global lock would be reasonable relative to how
often dax address_space_operations are swapped out (on the order of
taking cgroup_threadgroup_rwsem for write), I think a per-superblock
lock is also an ok starting point. We can always go to finer grained
locking in the future if we see evidence that the benefits of percpu
are lost to stopping the world at the superblock level.
