Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 485B013BC48
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jan 2020 10:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgAOJTd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Jan 2020 04:19:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:42446 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729270AbgAOJTd (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 15 Jan 2020 04:19:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5EE8FAEFF;
        Wed, 15 Jan 2020 09:19:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EA9E31E0CBC; Wed, 15 Jan 2020 10:19:25 +0100 (CET)
Date:   Wed, 15 Jan 2020 10:19:25 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [RFC 1/2] iomap: direct-io: Move inode_dio_begin before
 filemap_write_and_wait_range
Message-ID: <20200115091925.GC31450@quack2.suse.cz>
References: <cover.1578907890.git.riteshh@linux.ibm.com>
 <27607a16327fe9664f32d09abe565af0d1ae56c9.1578907891.git.riteshh@linux.ibm.com>
 <20200113215159.GA8235@magnolia>
 <20200114090507.GA6466@quack2.suse.cz>
 <20200114163818.GB7127@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114163818.GB7127@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 14-01-20 08:38:18, Christoph Hellwig wrote:
> On Tue, Jan 14, 2020 at 10:05:07AM +0100, Jan Kara wrote:
> > 
> > Well, XFS always performs buffered writeback using unwritten extents so at
> > least the immediate problem of stale data exposure ext4 has does not happen
> > there AFAICT. 
> 
> Currently XFS never uses unwritten extents when converting delalloc
> extents.

I see, it is a long time since I last looked at that part of XFS code. So
then I think XFS might be prone to the same kind of race and data exposure
as I outlined in [1]...

								Honza

[1] https://lore.kernel.org/linux-ext4/20200114094741.GC6466@quack2.suse.cz

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
