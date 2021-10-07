Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A046425569
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Oct 2021 16:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242077AbhJGOan (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Oct 2021 10:30:43 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38419 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S242060AbhJGOam (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Oct 2021 10:30:42 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 197ESeS4024772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Oct 2021 10:28:41 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CDF5415C3E70; Thu,  7 Oct 2021 10:28:40 -0400 (EDT)
Date:   Thu, 7 Oct 2021 10:28:40 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] ext4: docs: switch away from list-table
Message-ID: <YV8EGFcPtM9u+ihl@mit.edu>
References: <20210902220854.198850-1-corbet@lwn.net>
 <20210902220854.198850-2-corbet@lwn.net>
 <20210916095455.GE10610@quack2.suse.cz>
 <877df9tt5d.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877df9tt5d.fsf@meer.lwn.net>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 21, 2021 at 05:18:06PM -0600, Jonathan Corbet wrote:
> Jan Kara <jack@suse.cz> writes:
> 
> > On Thu 02-09-21 16:08:53, Jonathan Corbet wrote:
> >> Commit 3a6541e97c03 (Add documentation about the orphan file feature) added
> >> a new document on orphan files, which is great.  But the use of
> >> "list-table" results in documents that are absolutely unreadable in their
> >> plain-text form.  Switch this file to the regular RST table format instead;
> >> the rendered (HTML) output is identical.
> >> 
> >> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> >
> > Thanks! Definitely looks more readable :). You can add:
> >
> > Reviewed-by: Jan Kara <jack@suse.cz>
> 
> Thanks for having a look!  I'll ahead and apply these, then.

Hey Jon,

I don't see these patches in linux-next.  I'm guessing because you
were busy with some silly thing like LPC.  :-)

Do you want to take them, or I can take them through the ext4 tree.

	       	       	    	       	   - Ted
