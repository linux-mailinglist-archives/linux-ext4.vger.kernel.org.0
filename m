Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 955E813A362
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Jan 2020 10:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgANJFJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Jan 2020 04:05:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:45004 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgANJFJ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 14 Jan 2020 04:05:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EA9FBAC54;
        Tue, 14 Jan 2020 09:05:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8589F1E0D0E; Tue, 14 Jan 2020 10:05:07 +0100 (CET)
Date:   Tue, 14 Jan 2020 10:05:07 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>, linux-ext4@vger.kernel.org,
        tytso@mit.edu, jack@suse.cz
Subject: Re: [RFC 1/2] iomap: direct-io: Move inode_dio_begin before
 filemap_write_and_wait_range
Message-ID: <20200114090507.GA6466@quack2.suse.cz>
References: <cover.1578907890.git.riteshh@linux.ibm.com>
 <27607a16327fe9664f32d09abe565af0d1ae56c9.1578907891.git.riteshh@linux.ibm.com>
 <20200113215159.GA8235@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113215159.GA8235@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 13-01-20 13:51:59, Darrick J. Wong wrote:
> On Mon, Jan 13, 2020 at 04:34:21PM +0530, Ritesh Harjani wrote:
> > Some filesystems (e.g. ext4) need to know in it's writeback path, that
> > whether DIO is in progress or not. This info may be needed to avoid the
> > stale data exposure race with DIO reads.
> 
> Does XFS have this problem too?
> 
> Admittedly dio read during mmap write is probably not well supported. ;)

Well, XFS always performs buffered writeback using unwritten extents so at
least the immediate problem of stale data exposure ext4 has does not happen
there AFAICT. 

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
