Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87D2C95DED
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2019 13:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbfHTLzS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 20 Aug 2019 07:55:18 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37499 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbfHTLzS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 20 Aug 2019 07:55:18 -0400
Received: by mail-qt1-f195.google.com with SMTP id y26so5630262qto.4
        for <linux-ext4@vger.kernel.org>; Tue, 20 Aug 2019 04:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cjWne9JJX/bamk/BsyOJB8Qocb+2jJnD/6EfxMqzNUc=;
        b=F8bCgYAmAkUxSVlSTscXxlQRELIsOQnZmrvm1sUjW95CUd0khTshKRxwCuLjyokKev
         BO8QDllptp/4vv0c5+22/EhhQN7BANX7GXbwhmoL4l4ncCnzuvcFIBhtQofbuqTX6nsg
         zwql74Buzj9teOKUbKfj5TE3uHNM/5fbApiO0JHQMUUYJ/unQvJimJ2vf/e7eXWfu4Qr
         e3qKOUbeDxtQCKEEnBFIKa+Y83F0ozkYPvP+sRDb4zW7tz+74GJgY/PNJGOy+FAsmX1f
         luk7Y3QQ++vwxmyoZVrHTbe9U0I/Qk1BqrxGPfTC0MFEGoh/lly24xPvz/0fT0h+OEJy
         qwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cjWne9JJX/bamk/BsyOJB8Qocb+2jJnD/6EfxMqzNUc=;
        b=aemvS88NgxxOSkRbhqnNE84zdYAKGPFo6df9ZBh/zZx663qmryL377RderODh5NtxL
         nmd8Qs/xjncPkGXq1SEMxqehfLL0Nj8YLRqD8M59GktkIjb+VrNZ02zZ3+x2AYfz/iTg
         wlVRyV6iIpymq3hcA+ZbM1NjFUfaro3HhiZ7QC7ZWp6bZu+/2P6y8fhxmos2nhIdbmf9
         b2uaEAufn5usvbT7iN0iNg3GiyiZ9B9YQHy7vn+mkbnO1M/65aiFlqcn7YEv+Khol8aw
         VGVXul919eFsoYEIebkeqy14UpPM3zS2t5h2HGjHOsxtms6ii1VOXgK6oor6dUfuSsTW
         e08A==
X-Gm-Message-State: APjAAAUXNEDq3xdKWVp511KHoZRc6aByT9jhBwVcBr0HN4Z1d7oQqUCE
        RDVbK/PsW/IrEpKOsmbn8GLKGA==
X-Google-Smtp-Source: APXvYqz2loiM8+YcMWhCUXDCstClokgbXoeINv82DptJXTepeIjclfvYpo9S265xpxsrLBOY09rJbg==
X-Received: by 2002:a0c:d251:: with SMTP id o17mr14202195qvh.109.1566302116866;
        Tue, 20 Aug 2019 04:55:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id f23sm8218362qkk.80.2019.08.20.04.55.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Aug 2019 04:55:16 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i02jL-0007t8-HZ; Tue, 20 Aug 2019 08:55:15 -0300
Date:   Tue, 20 Aug 2019 08:55:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, linux-xfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 00/19] RDMA/FS DAX truncate proposal V1,000,002 ;-)
Message-ID: <20190820115515.GA29246@ziepe.ca>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190814101714.GA26273@quack2.suse.cz>
 <20190814180848.GB31490@iweiny-DESK2.sc.intel.com>
 <20190815130558.GF14313@quack2.suse.cz>
 <20190816190528.GB371@iweiny-DESK2.sc.intel.com>
 <20190817022603.GW6129@dread.disaster.area>
 <20190819063412.GA20455@quack2.suse.cz>
 <20190819092409.GM7777@dread.disaster.area>
 <20190819123841.GC5058@ziepe.ca>
 <20190820011210.GP7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820011210.GP7777@dread.disaster.area>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 20, 2019 at 11:12:10AM +1000, Dave Chinner wrote:
> On Mon, Aug 19, 2019 at 09:38:41AM -0300, Jason Gunthorpe wrote:
> > On Mon, Aug 19, 2019 at 07:24:09PM +1000, Dave Chinner wrote:
> > 
> > > So that leaves just the normal close() syscall exit case, where the
> > > application has full control of the order in which resources are
> > > released. We've already established that we can block in this
> > > context.  Blocking in an interruptible state will allow fatal signal
> > > delivery to wake us, and then we fall into the
> > > fatal_signal_pending() case if we get a SIGKILL while blocking.
> > 
> > The major problem with RDMA is that it doesn't always wait on close() for the
> > MR holding the page pins to be destoyed. This is done to avoid a
> > deadlock of the form:
> > 
> >    uverbs_destroy_ufile_hw()
> >       mutex_lock()
> >        [..]
> >         mmput()
> >          exit_mmap()
> >           remove_vma()
> >            fput();
> >             file_operations->release()
> 
> I think this is wrong, and I'm pretty sure it's an example of why
> the final __fput() call is moved out of line.

Yes, I think so too, all I can say is this *used* to happen, as we
have special code avoiding it, which is the code that is messing up
Ira's lifetime model.

Ira, you could try unraveling the special locking, that solves your
lifetime issues?

Jason
