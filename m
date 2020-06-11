Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3248A1F65F3
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jun 2020 12:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgFKKuh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Jun 2020 06:50:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20543 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727097AbgFKKud (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 11 Jun 2020 06:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591872631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kSdiDpqI3jPoATNC/+3bJgMnBdq/VMgYcXdBesTmLZU=;
        b=ZdErC08X1/QiepzfTVEfh6DBBoq8+wNf3LkIbKScQZlYSvJ+oJRV+2ic+t1t5+a2y3HMc2
        q2sO+r/WV/0iYe1IXHysK5PWzwnQr6gK0E7iZjIxeRBdlbPWGtoqZPI9n7AGpvMgl6so0a
        cUsXbM6JZOAJCh/0SSP7GcmvICG1JvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-WQDdQtVxOnioec_cgbm-bg-1; Thu, 11 Jun 2020 06:50:29 -0400
X-MC-Unique: WQDdQtVxOnioec_cgbm-bg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3F4819200C0;
        Thu, 11 Jun 2020 10:50:28 +0000 (UTC)
Received: from work (unknown [10.40.192.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 02CA27F4E5;
        Thu, 11 Jun 2020 10:50:27 +0000 (UTC)
Date:   Thu, 11 Jun 2020 12:50:24 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: jbd2: can b_transaction be NULL in refile_buffer ?
Message-ID: <20200611105024.tjykjnjkswsar3ah@work>
References: <20200611083417.4akdykeubd7kfuuh@work>
 <20200611103709.GB19132@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611103709.GB19132@quack2.suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 11, 2020 at 12:37:09PM +0200, Jan Kara wrote:
> Hi!
> 
> On Thu 11-06-20 10:34:17, Lukas Czerner wrote:
> > I am tracking a rare and very hard to reproduce bug that ends up hittng
> > 
> > J_ASSERT_JH(jh, jh->b_transaction == NULL)
> > 
> > in __journal_remove_journal_head(). In fact we can get there with
> > b_next_transaction set and b_jlist == BJ_Forget so it's clear that we
> > should not have dropped the last JH reference at that point.
> > 
> > Most of the time that I've seen we get there from
> > __jbd2_journal_remove_checkpoint() called from
> > jbd2_journal_commit_transaction().
> > 
> > The locking in and around grabbing and putting the journal head
> > reference (b_jcount) looks solid as well as the use of j_list_lock. But
> > I have noticed a problem in logic of __jbd2_journal_refile_buffer().
> 
> Yeah, the trouble with refcounting bugs is that if *any* of the users
> releases a reference it should not, we will (much later) hit the problem you
> describe.
> 
> > The idea is that b_next_transaction will inherit the reference from
> > b_transaction so that we do not need to grab a new reference of
> > journal_head. However this will only be true if b_transaction is set.
> >
> > But if it is indeed NULL, then we will do
> > 
> > WRITE_ONCE(jh->b_transaction, jh->b_next_transaction);
> > 
> > and __jbd2_journal_file_buffer() will not grab the jh reference. AFAICT
> > the b_next_transaction is not holding it's own jh reference. This will
> > result in b_transaction _not_ holding it's own jh reference and we will
> > be able to drop the last jh reference at unexpected places - hence we can
> > hit the asserts in __journal_remove_journal_head().
> >
> > However I am not really sure if it is indeed possible to get into
> > __jbd2_journal_refile_buffer() with b_transaction == NULL and
> > b_next_transaction set. Jan do you have any idea if that's possible and
> > what would be the circumstances to lead us there ?
> 
> __jbd2_journal_refile_buffer() should always be called with b_transaction
> != NULL and as I've checked (all three) callers, that indeed seems to be
> the case. Feel free to add assert along those lines to
> __jbd2_journal_refile_buffer() to see whether it triggers...
> 
> > Regardless I still think this is a bug in the logic and we should either
> > make sure that b_transaction is _not_ NULL in
> > __jbd2_journal_refile_buffer(), or let __jbd2_journal_file_buffer() grab
> > the jh reference if b_transaction was indeen NULL. How about something
> > like the following untested patch ?
> 
> I'd rather got for the assert. It makes things simpler, also the "meaning"
> of __jbd2_journal_refile_buffer() is "jh is done in its current
> transaction, deal with it" and that doesn't have a great meaning if
> b_transaction is NULL.
> 
> And when you're adding asserts, then adding one in
> __jbd2_journal_unfile_buffer() checking b_transaction != NULL and
> b_next_transaction == NULL would be good as well because lot of callers
> assume this. I've checked the code and I didn't find any problematic one
> but that code is complex enough that I could have missed something.

Ok, thanks. I'll prepare a patch.

Regards,
-Lukas

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

