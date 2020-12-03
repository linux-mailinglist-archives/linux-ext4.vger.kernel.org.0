Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA7C2CDFCE
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Dec 2020 21:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbgLCUkL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Dec 2020 15:40:11 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42132 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726597AbgLCUkL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Dec 2020 15:40:11 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B3KdGeL011944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Dec 2020 15:39:16 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0E357420136; Thu,  3 Dec 2020 15:39:16 -0500 (EST)
Date:   Thu, 3 Dec 2020 15:39:15 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Cc:     Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Updated locking documentation for transaction_t
Message-ID: <20201203203915.GN441757@mit.edu>
References: <20190408083500.66759-1-alexander.lochmann@tu-dortmund.de>
 <10cfbef1-994c-c604-f8a6-b1042fcc622f@tu-dortmund.de>
 <20201203140405.GC441757@mit.edu>
 <29d6de5d-4abc-e836-7b14-bb67d782a752@tu-dortmund.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29d6de5d-4abc-e836-7b14-bb67d782a752@tu-dortmund.de>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 03, 2020 at 03:38:40PM +0100, Alexander Lochmann wrote:
> 
> 
> On 03.12.20 15:04, Theodore Y. Ts'o wrote:
> > On Thu, Oct 15, 2020 at 03:26:28PM +0200, Alexander Lochmann wrote:
> > > Hi folks,
> > > 
> > > I've updated the lock documentation according to our finding for
> > > transaction_t.
> > > Does this patch look good to you?
> > 
> > I updated the annotations to match with the local usage, e.g:
> > 
> > 	 * When commit was requested [journal_t.j_state_lock]
> > 
> > became:
> > 
> > 	 * When commit was requested [j_state_lock]What do you mean by local usage?
> The annotations of other members of transaction_t?

Yes, I'd like the annotations of the other objects to be consistent,
and just use j_state_lock, j_list_lock, etc., for the other annotations.

> Shouldn't the annotation look like this?
> [t_journal->j_state_lock]
> It would be more precise.

It's more precise, but it's also unnecessary in this case, since all
of the elements of the journal have a j_ prefix, elements of a
transaction_t have a t_ prefix, etc.  There is also no other structure
element which has a j_state_lock name *other* than in journal_t.

Cheers,

						- Ted
