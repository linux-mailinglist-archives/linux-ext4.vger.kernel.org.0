Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D80F28614D
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Oct 2020 16:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgJGOcY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Oct 2020 10:32:24 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36758 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728562AbgJGOcY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Oct 2020 10:32:24 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 097EWBGI001492
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Oct 2020 10:32:11 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1DE34420107; Wed,  7 Oct 2020 10:32:11 -0400 (EDT)
Date:   Wed, 7 Oct 2020 10:32:11 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org
Subject: Re: ext4 regression in v5.9-rc2 from e7bfb5c9bb3d on ro fs with
 overlapped bitmaps
Message-ID: <20201007143211.GA235506@mit.edu>
References: <CAHk-=wj-H5BYCU_kKiOK=B9sN3BtRzL4pnne2AJPyf54nQ+d=w@mail.gmail.com>
 <20201005081454.GA493107@localhost>
 <20201005173639.GA2311765@magnolia>
 <20201006003216.GB6553@localhost>
 <20201006025110.GJ49559@magnolia>
 <20201006031834.GA5797@mit.edu>
 <20201006050306.GA8098@localhost>
 <20201006133533.GC5797@mit.edu>
 <20201007080304.GB1112@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007080304.GB1112@localhost>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 07, 2020 at 01:03:04AM -0700, Josh Triplett wrote:
> > But can we *please* take your custom tool out back and shoot it in the
> > head?
> 
> Nope. As mentioned, this isn't about creating ext4 filesystem images,
> and it isn't even remotely similar to mke2fs.

Can you please tell us what your tool is for, then?  Why are you doing
this?  Why are you inflicting this on us?

And if the answer is nope, I can't, it's propietary, sorry....  then I
think we should treat this the same way we treat proprietary kernel
modules.

       	     	      	        - Ted
				
