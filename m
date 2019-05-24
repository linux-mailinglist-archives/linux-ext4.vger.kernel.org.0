Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2F3B28FDF
	for <lists+linux-ext4@lfdr.de>; Fri, 24 May 2019 06:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbfEXESn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 May 2019 00:18:43 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38051 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725828AbfEXESn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 24 May 2019 00:18:43 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4O4ITX9025986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 May 2019 00:18:30 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3A60A420481; Fri, 24 May 2019 00:18:29 -0400 (EDT)
Date:   Fri, 24 May 2019 00:18:29 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 3/3] ext4: Gracefully handle ext4_break_layouts() failure
 during truncate
Message-ID: <20190524041829.GD2532@mit.edu>
References: <20190522090317.28716-1-jack@suse.cz>
 <20190522090317.28716-4-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522090317.28716-4-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 22, 2019 at 11:03:17AM +0200, Jan Kara wrote:
> ext4_break_layouts() may fail e.g. due to a signal being delivered.
> Thus we need to handle its failure gracefully and not by taking the
> filesystem down. Currently ext4_break_layouts() failure is rare but it
> may become more common once RDMA uses layout leases for handling
> long-term page pins for DAX mappings.
> 
> To handle the failure we need to move ext4_break_layouts() earlier
> during setattr handling before we do hard to undo changes such as
> modifying inode sizhe. To be able to do that we also have to move some
> other checks which are better done uwithout holding i_mmap_sem earlier.
> 
> Reported-and-tested-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jan Kara <jack@suse.cz>hh

Thanks, applied.

What do people think about adding marking this for stable?  My take is
that DAX is still not that common for most stable kernel users, and
the patch moves enough stuff around that it's borderline for stable.
I'm going to leave off marking for stable unless someone wants to make
a case that we should so mark it.

       	       	     	       - Ted
			       
