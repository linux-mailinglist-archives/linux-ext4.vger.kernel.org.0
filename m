Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1691140F17
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jan 2020 17:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgAQQg5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jan 2020 11:36:57 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38812 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726506AbgAQQg4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jan 2020 11:36:56 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00HGanJR015346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jan 2020 11:36:50 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7F7144207DF; Fri, 17 Jan 2020 11:36:49 -0500 (EST)
Date:   Fri, 17 Jan 2020 11:36:49 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        naoto.kobayashi4c@gmail.com
Subject: Re: [PATCH] ext4: drop ext4_kvmalloc()
Message-ID: <20200117163649.GC448999@mit.edu>
References: <20200116151239.GA253859@mit.edu>
 <20200116155031.266620-1-tytso@mit.edu>
 <20200117103048.GB17141@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117103048.GB17141@quack2.suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jan 17, 2020 at 11:30:48AM +0100, Jan Kara wrote:
> On Thu 16-01-20 10:50:31, Theodore Ts'o wrote:
> > As Jan pointed out[1], as of commit 81378da64de ("jbd2: mark the
> > transaction context with the scope GFP_NOFS context") we use
> > memalloc_nofs_{save,restore}() while a jbd2 handle is active.  So
> > ext4_kvmalloc() so we can call allocate using GFP_NOFS is no longer
> > necessary.
> > 
> > [1] https://lore.kernel.org/r/20200109100007.GC27035@quack2.suse.cz
> 
> Your signed-off-by is missing but otherwise the patch looks good to me. You
> can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks, applied with my signed-off-by and a Link: trailer.

		     		      	    - Ted
