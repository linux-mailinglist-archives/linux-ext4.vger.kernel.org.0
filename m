Return-Path: <linux-ext4+bounces-12368-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B3707CBEACC
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Dec 2025 16:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D708301D33F
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Dec 2025 15:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6261B33438F;
	Mon, 15 Dec 2025 15:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1/lWVtS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A7D3346A4
	for <linux-ext4@vger.kernel.org>; Mon, 15 Dec 2025 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765812542; cv=none; b=nVnPf4k5P7MEegyCAG4xHgTqBSFlkLjAaTtKq8NtvpP+d357zoVqz0G1URnEvzDsJAaK1Rtnj3RpQknO7higJSZWWKZrpXTcJelLCZH/hzvSxUjxNzNGsM4UsOkH3JUFoTOkZuQz8Gc1/qJcvHhaOrhCTI+OZhayAGJRo8LW/ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765812542; c=relaxed/simple;
	bh=Om8HUshlgNa//EKYAeRevY1acw5Oy0Tg1dtMZqOS7AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bN1zNX8M3N7CC8wB9e9xcW1LmGmFBwWMZa/BKyoFOTIThh+3xiAhzOpNymIeqQN8dhX+AVFPA9iz7OiZQOKEIbH6P4+m5hfIe4GLKt2N6+QOBw10eJgd9BxOUId2aodt/6b9GYwLY+U/MckK611upWq5/J7uxoSNAyQ/rU1Ix3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X1/lWVtS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765812538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Na6GUjcjRYSOYboJ8LvHOpkig7d53dsnTrFti+VwKMs=;
	b=X1/lWVtS7+SlZQ6t1BbgWYGBneM+n8UkL/Phq2okFoyQybUzmTjsAN4fKtzM+JuKpYMrS1
	r+UFWmI0J4lPQQ33MhW0XrPo+aw9sLGopnUzK5lR/bljLzztU+Uh0sUyy6YIN9awSUy4ad
	ASNBN21MFVHX9QhLL55SWodQ/FfpVVc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-4dBFy5UvMfO0aPahu0PUYQ-1; Mon,
 15 Dec 2025 10:28:57 -0500
X-MC-Unique: 4dBFy5UvMfO0aPahu0PUYQ-1
X-Mimecast-MFC-AGG-ID: 4dBFy5UvMfO0aPahu0PUYQ_1765812536
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6002F1956061;
	Mon, 15 Dec 2025 15:28:56 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.2])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D75F21800367;
	Mon, 15 Dec 2025 15:28:55 +0000 (UTC)
Date: Mon, 15 Dec 2025 10:28:53 -0500
From: Brian Foster <bfoster@redhat.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: fix dirtyclusters double decrement on fs shutdown
Message-ID: <aUApNS_YnY2Oa_93@bfoster>
References: <20251212154735.512651-1-bfoster@redhat.com>
 <ef906e19-04b9-4793-998e-81c34ebf9126@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef906e19-04b9-4793-998e-81c34ebf9126@huawei.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Sat, Dec 13, 2025 at 09:46:23AM +0800, Baokun Li wrote:
> Hi Brian,
> 
> Thanks for the patch.
> 

Hi Baokun,

Thanks for reviewing..

> On 2025-12-12 23:47, Brian Foster wrote:
> > fstests test generic/388 occasionally reproduces a warning in
> > ext4_put_super() associated with the dirty clusters count:
> >
> >   WARNING: CPU: 7 PID: 76064 at fs/ext4/super.c:1324 ext4_put_super+0x48c/0x590 [ext4]
> >
> > Tracing the failure shows that the warning fires due to an
> > s_dirtyclusters_counter value of -1. IOW, this appears to be a
> > spurious decrement as opposed to some sort of leak. Further tracing
> > of the dirty cluster count deltas and an LLM scan of the resulting
> > output identified the cause as a double decrement in the error path
> > between ext4_mb_mark_diskspace_used() and the caller
> > ext4_mb_new_blocks().
> >
> > First, note that generic/388 is a shutdown vs. fsstress test and so
> > produces a random set of operations and shutdown injections. In the
> > problematic case, the shutdown triggers an error return from the
> > ext4_handle_dirty_metadata() call(s) made from
> > ext4_mb_mark_context(). The changed value is non-zero at this point,
> > so ext4_mb_mark_diskspace_used() does not exit after the error
> > bubbles up from ext4_mb_mark_context(). Instead, the former
> > decrements both cluster counters and returns the error up to
> > ext4_mb_new_blocks(). The latter falls into the !ar->len out path
> > which decrements the dirty clusters counter a second time, creating
> > the inconsistency.
> >
> > AFAICT the solution here is to exit immediately from
> > ext4_mb_mark_diskspace_used() on error, regardless of the changed
> > value. This leaves the caller responsible for clearing the block
> > reservation at the same level it is acquired. This also skips the
> > free clusters update, but the caller also calls into
> > ext4_discard_allocated_blocks() to free the blocks back into the
> > group. This survives an overnight loop test of generic/388 on an
> > otherwise reproducing system and survives a local regression run.
> >
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> >
> > Hi all,
> >
> > I've thrown some testing at this and poked around the area enough that I
> > _think_ it is reasonably sane, but the error paths are hairy and I could
> > certainly be missing some details. I'm happy to try a different approach
> > if there are any thoughts around that.. thanks.
> >
> > Brian
> >
> >  fs/ext4/mballoc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > index 56d50fd3310b..224abfd6a42b 100644
> > --- a/fs/ext4/mballoc.c
> > +++ b/fs/ext4/mballoc.c
> > @@ -4234,7 +4234,7 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
> >  				   ac->ac_b_ex.fe_start, ac->ac_b_ex.fe_len,
> >  				   flags, &changed);
> >  
> > -	if (err && changed == 0)
> > +	if (err)
> >  		return err;
> >  
> >  #ifdef AGGRESSIVE_CHECK
> 
> I think we might need to swap that && for an ||.
> 
> Basically, we should only proceed with the following logic if there's
> no error and the bitmap was actually changed. If we hit an error or
> if the section we intended to modify was already fully handled,
> we should just bail out early. Otherwise, the err could get quietly
> ignored unless we hit a duplicate allocation that happens to result in
> 'changed' being zero.
> 

Hmm.. to make sure I understand, are you referring to an inconsistency
case where we allocated blocks that were already marked as such in the
group on disk..?

I'm a little uneasy about this because it seems to conflict with the
surrounding code. AFAICT the only way we can hit something like !err &&
!changed is via EXT4_MB_BITMAP_MARKED_CHECK, which causes
_mark_context() to check the bitmap for "already modified" bits up
front.

If this scenario plays out, the caller has a BUG check just after the
return (also under the aggressive check macro). So ISTM that this sort
of (err || !changed) logic would bypass the aggressive checks and let
the fs carry on when it probably shouldn't. Hm?

> By the way, I spotted two other spots with similar error logic:
> ext4_mb_clear_bb() and ext4_group_add_blocks().
> 

Yeah, I saw those as well but didn't think they needed changing. My high
level understanding of the alloc case is that ext4_mb_new_blocks()
acquires res (!delalloc), allocs blocks out of in-core structures, then
calls down into _mark_diskspace_used() to update/journal on-disk
structures with the pending alloc. If the latter fails, we release res
and feed blocks back into the in-core structures. So IOW, if we return
directly from _mark_diskspace_used() the counters/state end up
consistent afaict.

For the ext4_free_blocks() case, we call _mark_context() and if it fails
with changed != 0 (and don't otherwise BUG), we still go ahead and free
the blocks in the e4b and return the error. It does look like the
discard code can clobber the error though, so perhaps that should be
fixed. But otherwise it's not clear to me why we might want to exit
early there. Am I missing something else?

> Since this issue popped up in the last couple of years, we should
> probably add a Fixes: tag to make backporting easier.
> 

Do you have a target patch in mind? I made a pass through historical
changes and it looked like this was a longer standing issue through
various bits of refactoring..

Brian

> 
> Cheers,
> Baokun
> 
> 


