Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2369DFDFEA
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Nov 2019 15:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfKOOUm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Nov 2019 09:20:42 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39708 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727417AbfKOOUm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 Nov 2019 09:20:42 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xAFEKYRc016159
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Nov 2019 09:20:34 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0F7EE4202FD; Fri, 15 Nov 2019 09:20:34 -0500 (EST)
Date:   Fri, 15 Nov 2019 09:20:33 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 20/25] jbd2: Reserve space for revoke descriptor blocks
Message-ID: <20191115142033.GA23689@mit.edu>
References: <20191003215523.7313-1-jack@suse.cz>
 <20191105164437.32602-20-jack@suse.cz>
 <20191115075223.GA152352@sol.localdomain>
 <20191115100222.GC9043@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115100222.GC9043@quack2.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Nov 15, 2019 at 11:02:22AM +0100, Jan Kara wrote:
> On Thu 14-11-19 23:52:23, Eric Biggers wrote:
> > On Tue, Nov 05, 2019 at 05:44:26PM +0100, Jan Kara wrote:
> > >  static inline int jbd2_handle_buffer_credits(handle_t *handle)
> > >  {
> > > -	return handle->h_buffer_credits;
> > > +	journal_t *journal = handle->h_transaction->t_journal;
> > > +
> > > +	return handle->h_buffer_credits -
> > > +		DIV_ROUND_UP(handle->h_revoke_credits_requested,
> > > +			     journal->j_revoke_records_per_block);
> > >  }
> > 
> > This patch is causing a crash with 'kvm-xfstests -c dioread_nolock ext4/024'.
> > Looks like this code incorrectly assumes that h_transaction is always valid
> > rather than the other member of the union, h_journal.
> 
> Right, thanks for the report! Just out of curiosity: You have to have that
> tracepoint enabled for the crash to trigger, don't you? Because I'm pretty
> sure I did dioread_nolock runs...

I've been *definitely* been doing dioread_nolock runs (including two
last night), with no failures.

ext4/dioread_nolock: 485 tests, 40 skipped, 5142 seconds

		     	 	   	    - Ted
