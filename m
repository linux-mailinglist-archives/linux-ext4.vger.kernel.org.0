Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEC14393D
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Jun 2019 17:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732806AbfFMPMb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Jun 2019 11:12:31 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44914 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388153AbfFMPMU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 Jun 2019 11:12:20 -0400
Received: by mail-qk1-f195.google.com with SMTP id p144so845752qke.11
        for <linux-ext4@vger.kernel.org>; Thu, 13 Jun 2019 08:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R4sEx9DRCkbOcqkLsi6Jkv1GflPMZb75UMnrOJnbtJI=;
        b=JRz6imxOTGsNuMS76M162KvumiMVyYkKXhz/IAFwKjp3Igi0hICl/m4BUGOuw61YG6
         Pf3He7hg9Kt6x6X1WZuq8bUrqc1a1W2UmAo8VaUwVPA2GdvPEx7a5YMbLY0nfJoFWaQM
         YEbV9dRjW/drtmRraCujxYyThEP6QtwiSJs3iYcbutlXVk7Z5dASy1/Oy0G/oorjue0j
         RzaH6Drn7BTg39I+BUiwTL6fije0cyR1reQqzW1AIca5v1agyVprI5RgkLHLmKlYW9Fi
         0n1zTcJtV1luwZoUboeqFK2xDSzt81BhwHG/KONzmn78w16+WuqvsJOUxxwdcX8amTie
         g0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R4sEx9DRCkbOcqkLsi6Jkv1GflPMZb75UMnrOJnbtJI=;
        b=S4GXW9Gmtp+nZbd6kowt7nQq6yrL/HXVgpTEp5MeKqRfzjMA50PASqcHCL3KR/o5fc
         Z0LweGEpvgSvAUoqmOK9jiSgTTF3TDDA6wBplCV8XNxw8NYcfgQuv6tSYgqhFjUiF+i0
         O0F1dU/8CPbQkFUPCEs7H/Aqw5RqhxvVSsDrX5tNA4rpuiVSMeejpUSlIoXmLPA8TAK3
         QLMUEsLt9SYi+FAanRo0qJJYz8QIVunqTS3dWYpPUeHew17gXgaj0ASIh7HmuLoWtlv5
         QRxXHgs92sa0brq0xrAchvgwCUhIubCOzIP1iz/E8N+SmUEvp6JpcbLqjg1YsZU2rCC5
         eT2A==
X-Gm-Message-State: APjAAAVFfiU8o5LyxaFCBhlhQAJTdCeWdeFANoZTxi9KRH26cOf4iM+k
        EcCEcuwHehMxu1uCP6la6PyR8w==
X-Google-Smtp-Source: APXvYqzM9yCChTgMP3KlIhiG1BK19OOrfQlMOx6JZlNrolhLErYOjGfGuCWD8w4PBuxWllsDgHA6QA==
X-Received: by 2002:a37:e506:: with SMTP id e6mr3810214qkg.229.1560438740039;
        Thu, 13 Jun 2019 08:12:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id n10sm1577550qke.72.2019.06.13.08.12.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 08:12:19 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hbROk-0001qR-Po; Thu, 13 Jun 2019 12:12:18 -0300
Date:   Thu, 13 Jun 2019 12:12:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>,
        Jeff Layton <jlayton@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
Message-ID: <20190613151218.GB22901@ziepe.ca>
References: <20190606222228.GB11698@iweiny-DESK2.sc.intel.com>
 <20190607103636.GA12765@quack2.suse.cz>
 <20190607121729.GA14802@ziepe.ca>
 <20190607145213.GB14559@iweiny-DESK2.sc.intel.com>
 <20190612102917.GB14578@quack2.suse.cz>
 <20190612114721.GB3876@ziepe.ca>
 <20190612120907.GC14578@quack2.suse.cz>
 <20190612191421.GM3876@ziepe.ca>
 <20190612221336.GA27080@iweiny-DESK2.sc.intel.com>
 <CAPcyv4gkksnceCV-p70hkxAyEPJWFvpMezJA1rEj6TEhKAJ7qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gkksnceCV-p70hkxAyEPJWFvpMezJA1rEj6TEhKAJ7qQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 12, 2019 at 03:54:19PM -0700, Dan Williams wrote:
> > > My preference would be to avoid this scenario, but if it is really
> > > necessary, we could probably build it with some work.
> > >
> > > The only case we use it today is forced HW hot unplug, so it is rarely
> > > used and only for an 'emergency' like use case.
> >
> > I'd really like to avoid this as well.  I think it will be very confusing for
> > RDMA apps to have their context suddenly be invalid.  I think if we have a way
> > for admins to ID who is pinning a file the admin can take more appropriate
> > action on those processes.   Up to and including killing the process.
> 
> Can RDMA context invalidation, "device disassociate", be inflicted on
> a process from the outside? 

Yes, but it is currently only applied to the entire device - ie you do
'rmmod mlx5_ib' and all the running user space process see that their
FD has moved to some error and the device is broken.

Targetting the disassociate of only a single FD would be a new thing.

Jason
