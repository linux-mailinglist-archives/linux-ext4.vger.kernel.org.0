Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF9B1F7D34
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Jun 2020 20:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgFLSwZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Jun 2020 14:52:25 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42526 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726085AbgFLSwY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 Jun 2020 14:52:24 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 05CIq7oI020942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jun 2020 14:52:08 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A15D042026D; Fri, 12 Jun 2020 14:52:07 -0400 (EDT)
Date:   Fri, 12 Jun 2020 14:52:07 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     "zhangyi (F)" <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH v2] ext4, jbd2: ensure panic by fix a race between jbd2
 abort and ext4 error handlers
Message-ID: <20200612185207.GB2863913@mit.edu>
References: <20200609073540.3810702-1-yi.zhang@huawei.com>
 <20200609115026.GA12551@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609115026.GA12551@quack2.suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jun 09, 2020 at 01:50:26PM +0200, Jan Kara wrote:
> On Tue 09-06-20 15:35:40, zhangyi (F) wrote:
> > In the ext4 filesystem with errors=panic, if one process is recording
> > errno in the superblock when invoking jbd2_journal_abort() due to some
> > error cases, it could be raced by another __ext4_abort() which is
> > setting the SB_RDONLY flag but missing panic because errno has not been
> > recorded.
> > 
> > jbd2_journal_commit_transaction()
> >  jbd2_journal_abort()
> >   journal->j_flags |= JBD2_ABORT;
> >   jbd2_journal_update_sb_errno()
> >                                     | ext4_journal_check_start()
> >                                     |  __ext4_abort()
> >                                     |   sb->s_flags |= SB_RDONLY;
> >                                     |   if (!JBD2_REC_ERR)
> >                                     |        return;
> >   journal->j_flags |= JBD2_REC_ERR;
> > 
> > Finally, it will no longer trigger panic because the filesystem has
> > already been set read-only. Fix this by introduce j_abort_mutex to make
> > sure journal abort is completed before panic, and remove JBD2_REC_ERR
> > flag.
> > 
> > Fixes: 4327ba52afd03 ("ext4, jbd2: ensure entering into panic after recording an error in superblock")
> > Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> > Cc: <stable@vger.kernel.org>
> 
> Great, thanks! The patch looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Applied, thanks.

						- Ted
