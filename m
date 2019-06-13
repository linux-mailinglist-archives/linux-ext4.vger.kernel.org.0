Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD6FE43B88
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Jun 2019 17:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfFMPaE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Jun 2019 11:30:04 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46020 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731696AbfFMP3z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 Jun 2019 11:29:55 -0400
Received: by mail-qt1-f196.google.com with SMTP id j19so23007005qtr.12
        for <linux-ext4@vger.kernel.org>; Thu, 13 Jun 2019 08:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zI+cml8WbrmbJ9toyFXRrApWdKeWP1klnItjSAKRPGg=;
        b=ez3y4b43vsN45W2H2bDstmo6Om2wBZpYtJKgMMjQ9NBoecm8EqzxMc/rNSpmMUBedy
         80Ex/NCrVk0GjamXc8tFY6oZxMeqGSAa2XxliMKTTtJWm/Hdv+7/O2TlnSRLVmYLMjc1
         8QLaCJlqlQNIG4Wtw5O1fja9ybK4S3vwEG6x4PLpKGnKhfBKyUDjUSuJ7Daf2FmV0ukB
         Fiy/FGLk6V0O5Od1WI6hEe1YQb2rKTshssT0ZDeknDIfsjbY9xOSOCaaERP1VJPOdnB9
         Me1HNUVA3ivb0wrw4Jz0PdvTbXzAgXVoN/LwODHkV6bcRV7ByakROGDgfhqlpDrkzCce
         zwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zI+cml8WbrmbJ9toyFXRrApWdKeWP1klnItjSAKRPGg=;
        b=PViMIYv6Wem1Zc9lr6roYA+SNLggBMsmvgr1slrkYIOespOcwsCcL1vFiDgMfblG2x
         tLwlhP/IV1CNTwqWAI3VqV1rRJPJN68clWWSR5sOEu4OUsOjXbBm04jiJuhmk4BNKGqV
         SNPWxy1J/oaVYpvBdBA9v3TH+QSI9l0N3K746N0N5fkgE6asV51ikq9JqfVkBtAOD5n7
         3+dfQ5dzhYnRQ92uwEzDPsGtqj67ydYGTPZn/kKUxdza4nxcEfLohPMbcvbIC8pJlKci
         YurXwx32ZnaDrwr2D0hbej+v+B/tWqOlZ8s1bHnSSpTAiLtz2G5j/Oqf7FNtNLSMUT3+
         UgMw==
X-Gm-Message-State: APjAAAV+/rPbezGwOOKoLQQmAqDaMNT/fIzjo2EOAFIrpZBU11gWzjm7
        AndN43Bb8V4pwfWjb/5ao6y/kw==
X-Google-Smtp-Source: APXvYqxumou76h8DgPuXHGACUFtVz1bj3RAtdr2UUPeKh8lpCv3ZK4QnjNs+8s/8x74HDjzAfBeu7Q==
X-Received: by 2002:a0c:b163:: with SMTP id r32mr4246320qvc.169.1560439794791;
        Thu, 13 Jun 2019 08:29:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id s66sm1645906qkh.17.2019.06.13.08.29.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 08:29:54 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hbRfl-0001zA-RQ; Thu, 13 Jun 2019 12:29:53 -0300
Date:   Thu, 13 Jun 2019 12:29:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Jeff Layton <jlayton@kernel.org>, linux-xfs@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
Message-ID: <20190613152953.GD22901@ziepe.ca>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606220329.GA11698@iweiny-DESK2.sc.intel.com>
 <20190607110426.GB12765@quack2.suse.cz>
 <20190607182534.GC14559@iweiny-DESK2.sc.intel.com>
 <20190608001036.GF14308@dread.disaster.area>
 <20190612123751.GD32656@bombadil.infradead.org>
 <20190613002555.GH14363@dread.disaster.area>
 <20190613032320.GG32656@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613032320.GG32656@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 12, 2019 at 08:23:20PM -0700, Matthew Wilcox wrote:
> On Thu, Jun 13, 2019 at 10:25:55AM +1000, Dave Chinner wrote:
> > On Wed, Jun 12, 2019 at 05:37:53AM -0700, Matthew Wilcox wrote:
> > > That's rather different from the normal meaning of 'exclusive' in the
> > > context of locks, which is "only one user can have access to this at
> > > a time".
> > 
> > Layout leases are not locks, they are a user access policy object.
> > It is the process/fd which holds the lease and it's the process/fd
> > that is granted exclusive access.  This is exactly the same semantic
> > as O_EXCL provides for granting exclusive access to a block device
> > via open(), yes?
> 
> This isn't my understanding of how RDMA wants this to work, so we should
> probably clear that up before we get too far down deciding what name to
> give it.
> 
> For the RDMA usage case, it is entirely possible that both process A
> and process B which don't know about each other want to perform RDMA to
> file F.  So there will be two layout leases active on this file at the
> same time.  It's fine for IOs to simultaneously be active to both leases.
> But if the filesystem wants to move blocks around, it has to break
> both leases.
> 
> If Process C tries to do a write to file F without a lease, there's no
> problem, unless a side-effect of the write would be to change the block
> mapping, in which case either the leases must break first, or the write
> must be denied.
> 
> Jason, please correct me if I've misunderstood the RDMA needs here.

Yes, I think you've captured it

Based on Dave's remarks how frequently a filesystem needs to break the
lease will determine if it is usuable to be combined with RDMA or
not...

Jason
