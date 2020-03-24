Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5FBD19195D
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Mar 2020 19:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgCXSnt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Mar 2020 14:43:49 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45309 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727379AbgCXSns (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Mar 2020 14:43:48 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02OIhPC4017362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Mar 2020 14:43:25 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3E068420EBA; Tue, 24 Mar 2020 14:43:25 -0400 (EDT)
Date:   Tue, 24 Mar 2020 14:43:25 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/2] writeback, xfs: call dirty_inode() with
 I_DIRTY_TIME_EXPIRED when appropriate
Message-ID: <20200324184325.GF53396@mit.edu>
References: <20200320024639.GH1067245@mit.edu>
 <20200320025255.1705972-1-tytso@mit.edu>
 <20200320025255.1705972-2-tytso@mit.edu>
 <20200323175838.GA7133@mit.edu>
 <20200324083759.GA32036@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324083759.GA32036@infradead.org>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Mar 24, 2020 at 01:37:59AM -0700, Christoph Hellwig wrote:
> On Mon, Mar 23, 2020 at 01:58:38PM -0400, Theodore Y. Ts'o wrote:
> > Christoph, Dave --- does this give you the notification that you were
> > looking such that XFS could get the notification desired that it was
> > the timestamps need to be written back?
> 
> I need to look at it in more detail as it seems convoluted.  Also the
> order seems like you regress XFS in patch 1 and then fix it in patch 2?

In patch one we send I_DIRTY_SYNC as we had been doing as before.  So
I don't believe that patch #1 would regress XFS; can you confirm?

My thinking was to move ahead with patch 1 so that it fixed the bug
which Eric Biffers had reported for f2fs, but only to move forward
with patch #2 if it would be useful for XFS.

Cheers,

     	      	    	     	    - Ted
