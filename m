Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A41BA292AA
	for <lists+linux-ext4@lfdr.de>; Fri, 24 May 2019 10:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389591AbfEXINK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 May 2019 04:13:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:42876 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389583AbfEXINK (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 24 May 2019 04:13:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3F03AE8A;
        Fri, 24 May 2019 08:13:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6B7341E1402; Fri, 24 May 2019 10:13:08 +0200 (CEST)
Date:   Fri, 24 May 2019 10:13:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 3/3] ext4: Gracefully handle ext4_break_layouts() failure
 during truncate
Message-ID: <20190524081308.GB28972@quack2.suse.cz>
References: <20190522090317.28716-1-jack@suse.cz>
 <20190522090317.28716-4-jack@suse.cz>
 <20190524041829.GD2532@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524041829.GD2532@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 24-05-19 00:18:29, Theodore Ts'o wrote:
> On Wed, May 22, 2019 at 11:03:17AM +0200, Jan Kara wrote:
> > ext4_break_layouts() may fail e.g. due to a signal being delivered.
> > Thus we need to handle its failure gracefully and not by taking the
> > filesystem down. Currently ext4_break_layouts() failure is rare but it
> > may become more common once RDMA uses layout leases for handling
> > long-term page pins for DAX mappings.
> > 
> > To handle the failure we need to move ext4_break_layouts() earlier
> > during setattr handling before we do hard to undo changes such as
> > modifying inode sizhe. To be able to do that we also have to move some
> > other checks which are better done uwithout holding i_mmap_sem earlier.
> > 
> > Reported-and-tested-by: Ira Weiny <ira.weiny@intel.com>
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Jan Kara <jack@suse.cz>hh
> 
> Thanks, applied.
> 
> What do people think about adding marking this for stable?  My take is
> that DAX is still not that common for most stable kernel users, and
> the patch moves enough stuff around that it's borderline for stable.
> I'm going to leave off marking for stable unless someone wants to make
> a case that we should so mark it.

Yeah, my take was that I'd care about backporting this patch for stable once
somebody complains that he has actually hit the problem...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
