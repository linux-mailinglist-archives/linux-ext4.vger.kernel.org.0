Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A553EB942
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Aug 2021 17:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241211AbhHMP1R (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Aug 2021 11:27:17 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58363 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241182AbhHMP1R (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 13 Aug 2021 11:27:17 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17DFQj5V025411
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Aug 2021 11:26:45 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 404B115C37C1; Fri, 13 Aug 2021 11:26:45 -0400 (EDT)
Date:   Fri, 13 Aug 2021 11:26:45 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/5] ext4: Speedup ext4 orphan inode handling
Message-ID: <YRaPNaukNFEObAvJ@mit.edu>
References: <20210811101006.2033-1-jack@suse.cz>
 <20210811101925.6973-3-jack@suse.cz>
 <YRU3zjcP5hukrsyt@mit.edu>
 <20210813123434.GB11955@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813123434.GB11955@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 13, 2021 at 02:34:34PM +0200, Jan Kara wrote:
> Actually, in the orphan list code, we leave the inode in the on-disk list
> but remove it from the in-memory list - see how
> list_del_init(&ei->i_orphan) is called very early in ext4_orphan_del(). The
> reason for this unconditional deletion is that if we do not remove the
> inode from the in-memory orphan list, the filesystem will complain and
> corrupt memory on unmount.
> 
> Also note that leaving inode in the on-disk orphan list actually does no
> serious harm. Because the orphan cleanup code just checks i_nlink and
> i_disksize and truncates inode down to current i_disksize and removes inode
> completely if i_nlink is 0. So even if an inode on the orphan list gets
> reused, orphan cleanup will just do nothing for it. So the worst problem
> that will likely happen is that on-disk orphan linked list becomes
> corrupted but there's no data loss AFAICT.
> 
> Is it clearer now or am I missing something?

Yes, you're right, I misread the code.  Thanks for clarifying.

Can you send the final spin of this patch set?  I think we're all set
for this patch series.

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

						- Ted
