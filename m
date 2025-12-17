Return-Path: <linux-ext4+bounces-12384-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2C8CC84BD
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Dec 2025 15:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D01C311F155
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Dec 2025 14:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05C01E9919;
	Wed, 17 Dec 2025 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GM6BOhoy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2974C346E4C
	for <linux-ext4@vger.kernel.org>; Wed, 17 Dec 2025 13:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979543; cv=none; b=WrXW/KkJtOLuR6TfyMZIafJ1erCWqVTrHwg2ZW3bBKDOoN7tNsqRlo5G2lUQY39KwAvaQSaYmwiz+JvWJQYr51l7oLQthRiXB2sHe2y8PmfWMJEGchIRFDH2+QTqau6C1fzQ/4MySAclsz6DwdiuXisdZIqno35IfPCCxq2vEVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979543; c=relaxed/simple;
	bh=R2ek4QCI3O0vdSEfVt+FhruFza6s8UoZ6D1XoGnG+1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sk/VRqFcnkticOCa4/cIPanOZKHGX6zLSd+8jXDRGOBc0ypg7Bmz1VZxpb8XZAgPtnWufHoS3X/vg01tBS1ffGbiOllyHoAAHhT1FFU3un3Du5qsCSJbKxzhppbVTrJ6wGm9040W5ljDrRsTlTNsxdXcv+AYGerY/5cdxawx6ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GM6BOhoy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765979537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YvHo3DruybSwHnCGMW7ttmK9eQVDupdoKKFTyz/Gkzo=;
	b=GM6BOhoyXoYN84egj6z6F29jbrg/Dk2v0hWJBgzP22cmiNDQYHiWqjdQS+8VYLaxUo7dO4
	FNBKUoisjaxbpQDD08a8kELXuXOMihKuGRi9q4/i6KdM8rpJFCjbD5+49PjhO4XBozgGTT
	3WpJIOuvqRYbZfrPN3AcGoAXzrkTBZo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-oADYrfukO4GsMjfit70YWQ-1; Wed,
 17 Dec 2025 08:52:13 -0500
X-MC-Unique: oADYrfukO4GsMjfit70YWQ-1
X-Mimecast-MFC-AGG-ID: oADYrfukO4GsMjfit70YWQ_1765979532
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 85898180028B;
	Wed, 17 Dec 2025 13:52:12 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.2])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D07A51800576;
	Wed, 17 Dec 2025 13:52:11 +0000 (UTC)
Date: Wed, 17 Dec 2025 08:52:09 -0500
From: Brian Foster <bfoster@redhat.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ext4: fix dirtyclusters double decrement on fs shutdown
Message-ID: <aUK1iZdcYjXfowIB@bfoster>
References: <20251212154735.512651-1-bfoster@redhat.com>
 <ef906e19-04b9-4793-998e-81c34ebf9126@huawei.com>
 <aUApNS_YnY2Oa_93@bfoster>
 <106ba6fe-4f94-4ed4-a53a-98a1f3ad30ab@huawei.com>
 <aUGAf_NLbIt_sktF@bfoster>
 <5e580bd0-519d-4bd0-93f5-9a2c532380ec@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e580bd0-519d-4bd0-93f5-9a2c532380ec@huawei.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Dec 17, 2025 at 12:05:18PM +0800, Baokun Li wrote:
> On 2025-12-16 23:53, Brian Foster wrote:
> > On Tue, Dec 16, 2025 at 12:01:41PM +0800, Baokun Li wrote:
> >> On 2025-12-15 23:28, Brian Foster wrote:
> >>> On Sat, Dec 13, 2025 at 09:46:23AM +0800, Baokun Li wrote:
> >>>> Hi Brian,
> >>>>
> >>>> Thanks for the patch.
> >>>>
> >>> Hi Baokun,
> >>>
> >>> Thanks for reviewing..
> >>>
> >>>> On 2025-12-12 23:47, Brian Foster wrote:
> >>>>> fstests test generic/388 occasionally reproduces a warning in
> >>>>> ext4_put_super() associated with the dirty clusters count:
> >>>>>
> >>>>>   WARNING: CPU: 7 PID: 76064 at fs/ext4/super.c:1324 ext4_put_super+0x48c/0x590 [ext4]
> >>>>>
> >>>>> Tracing the failure shows that the warning fires due to an
> >>>>> s_dirtyclusters_counter value of -1. IOW, this appears to be a
> >>>>> spurious decrement as opposed to some sort of leak. Further tracing
> >>>>> of the dirty cluster count deltas and an LLM scan of the resulting
> >>>>> output identified the cause as a double decrement in the error path
> >>>>> between ext4_mb_mark_diskspace_used() and the caller
> >>>>> ext4_mb_new_blocks().
> >>>>>
> >>>>> First, note that generic/388 is a shutdown vs. fsstress test and so
> >>>>> produces a random set of operations and shutdown injections. In the
> >>>>> problematic case, the shutdown triggers an error return from the
> >>>>> ext4_handle_dirty_metadata() call(s) made from
> >>>>> ext4_mb_mark_context(). The changed value is non-zero at this point,
> >>>>> so ext4_mb_mark_diskspace_used() does not exit after the error
> >>>>> bubbles up from ext4_mb_mark_context(). Instead, the former
> >>>>> decrements both cluster counters and returns the error up to
> >>>>> ext4_mb_new_blocks(). The latter falls into the !ar->len out path
> >>>>> which decrements the dirty clusters counter a second time, creating
> >>>>> the inconsistency.
> >>>>>
> >>>>> AFAICT the solution here is to exit immediately from
> >>>>> ext4_mb_mark_diskspace_used() on error, regardless of the changed
> >>>>> value. This leaves the caller responsible for clearing the block
> >>>>> reservation at the same level it is acquired. This also skips the
> >>>>> free clusters update, but the caller also calls into
> >>>>> ext4_discard_allocated_blocks() to free the blocks back into the
> >>>>> group. This survives an overnight loop test of generic/388 on an
> >>>>> otherwise reproducing system and survives a local regression run.
> >>>>>
> >>>>> Signed-off-by: Brian Foster <bfoster@redhat.com>
> >>>>> ---
> >>>>>
> >>>>> Hi all,
> >>>>>
> >>>>> I've thrown some testing at this and poked around the area enough that I
> >>>>> _think_ it is reasonably sane, but the error paths are hairy and I could
> >>>>> certainly be missing some details. I'm happy to try a different approach
> >>>>> if there are any thoughts around that.. thanks.
> >>>>>
> >>>>> Brian
> >>>>>
> >>>>>  fs/ext4/mballoc.c | 2 +-
> >>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> >>>>> index 56d50fd3310b..224abfd6a42b 100644
> >>>>> --- a/fs/ext4/mballoc.c
> >>>>> +++ b/fs/ext4/mballoc.c
> >>>>> @@ -4234,7 +4234,7 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
> >>>>>  				   ac->ac_b_ex.fe_start, ac->ac_b_ex.fe_len,
> >>>>>  				   flags, &changed);
> >>>>>  
> >>>>> -	if (err && changed == 0)
> >>>>> +	if (err)
> >>>>>  		return err;
> >>>>>  
> >>>>>  #ifdef AGGRESSIVE_CHECK
> >>>> I think we might need to swap that && for an ||.
> >>>>
> >>>> Basically, we should only proceed with the following logic if there's
> >>>> no error and the bitmap was actually changed. If we hit an error or
> >>>> if the section we intended to modify was already fully handled,
> >>>> we should just bail out early. Otherwise, the err could get quietly
> >>>> ignored unless we hit a duplicate allocation that happens to result in
> >>>> 'changed' being zero.
> >>>>
> >>> Hmm.. to make sure I understand, are you referring to an inconsistency
> >>> case where we allocated blocks that were already marked as such in the
> >>> group on disk..?
> >> Yes.
> >>> I'm a little uneasy about this because it seems to conflict with the
> >>> surrounding code. AFAICT the only way we can hit something like !err &&
> >>> !changed is via EXT4_MB_BITMAP_MARKED_CHECK, which causes
> >>> _mark_context() to check the bitmap for "already modified" bits up
> >>> front.
> >>>
> >>> If this scenario plays out, the caller has a BUG check just after the
> >>> return (also under the aggressive check macro). So ISTM that this sort
> >>> of (err || !changed) logic would bypass the aggressive checks and let
> >>> the fs carry on when it probably shouldn't. Hm?
> >> Regarding ext4_mb_mark_context, if the passed ret_changed pointer is
> >> non-NULL, we initialize *ret_changed to 0. After updating the bitmap_bh,
> >> we then update *ret_changed with the actual number of blocks modified
> >> (changed).
> >>
> >> Therefore, the original intention was for changed == 0 to signify that
> >> an error occurred in ext4_mb_mark_context() before ret_changed could be
> >> updated. However, as you pointed out, we also get changed == 0 when the
> >> target extent has already been fully marked as allocated within bitmap_bh.
> >>
> >> Crucially, we only genuinely check the bitmap to modify changed when
> >> EXT4_MB_BITMAP_MARKED_CHECK is set (i.e., when AGGRESSIVE_CHECK is defined,
> >> or during fast commit or resize operations). Otherwise, changed is always
> >> set to the target length. This means that, in the general case, errors
> >> returned after the point where ret_changed is updated (e.g., the error
> >> from ext4_handle_dirty_metadata()) are usually ignored.
> >>
> >> In summary:
> >>
> >>  * (err && changed == 0) only concerns errors that occur before ret_changed
> >>    is updated.
> >>  * (err || changed == 0) concerns whether there was an error OR if any
> >>    modification actually took place.
> >>
> >> If we only care about err, we could move the update of ret_changed inside
> >> ext4_mb_mark_context() to just before the successful return.
> >>
> > Yeah, I think the _mark_context() logic is reasonably straightforward
> > from the code. What is less clear is why the allocation path only cares
> > about errors prior to ret_changed being set.
> >
> > It looks to me that this is just wrong. I suspect either due to
> > copy/paste error in the mark_diskspace_used() path at some point in the
> > past, or an attempt to filter out the BUG case from an obvious case
> > where changed will be 0 on certain error returns.
> >
> > I don't think the mark_context() logic alone tells the full story here.
> > I think what's relevant is the high level error handling of the
> > !delalloc allocation path:
> >
> > 1. ext4_mb_new_blocks() reserves blocks and attempts physical allocation
> > in memory. On success, it calls into ext4_mb_mark_diskspace_used() to
> > update on-disk structures.
> >
> > 2a. If ext4_mb_mark_diskspace_used() is successful, it decrements the
> > freeclusters counter and releases res from the dirtyclusers counter
> > (i.e. transfer the block from dirty to used). ext4_mb_new_blocks()
> > basically just returns the result.
> >
> > 2b. If ext4_mb_mark_diskspace_used() fails, ext4_mb_new_blocks()
> > receives the error. In the error exit path, it frees the blocks back
> > into the incore structures and releases the reservation it acquired in
> > step 1.  
> >
> > However the bug this patch is trying to fix is that
> > ext4_mb_mark_diskspace_used() runs the counter updates regardless of
> > error in some cases. If the on-disk update fails, _new_blocks() will
> > release its reservation and return the blocks, so _mark_diskspace_used()
> > shouldn't account that block from the dirty and free counters.
> >
> > What isn't quite clear to me is how this is expected to deal with the
> > modified buffer. This particular case is a shutdown and journal abort,
> > so I suspect the buffer can't write back.
> 
> These are actually two separate issues, so let's focus on the
> dirtyclusters problem first, as it's more straightforward.
> 

Agreed.

> In ext4_mb_new_blocks(), when nodealloc is active, we increment
> s_dirtyclusters_counter via ext4_claim_free_clusters() to ensure
> there is enough free space to satisfy the current allocation request.
> 
> Once the block allocation finishes—regardless of whether it succeeded
> or failed—we should return the incremented dirtyclusters count.
> Therefore, we don't need to pass the reserv_clstrs parameter to
> ext4_mb_mark_diskspace_used() just to update the counter there.
> Instead, we can completely remove the dirtyclusters update logic from
> that function.
> 
> A better approach would be to decrement the dirtyclusters count in
> ext4_mb_new_blocks() whenever (!(ar->flags & EXT4_MB_DELALLOC_RESERVED)),
> regardless of whether ar->len is 0.
> 

Sure I think we could do something like that.

> This makes the code logic much clearer and helps prevent counter anomalies.
> 
> >
> >>>> By the way, I spotted two other spots with similar error logic:
> >>>> ext4_mb_clear_bb() and ext4_group_add_blocks().
> >>>>
> >>> Yeah, I saw those as well but didn't think they needed changing. My high
> >>> level understanding of the alloc case is that ext4_mb_new_blocks()
> >>> acquires res (!delalloc), allocs blocks out of in-core structures, then
> >>> calls down into _mark_diskspace_used() to update/journal on-disk
> >>> structures with the pending alloc. If the latter fails, we release res
> >>> and feed blocks back into the in-core structures. So IOW, if we return
> >>> directly from _mark_diskspace_used() the counters/state end up
> >>> consistent afaict.
> >>>
> >>> For the ext4_free_blocks() case, we call _mark_context() and if it fails
> >>> with changed != 0 (and don't otherwise BUG), we still go ahead and free
> >>> the blocks in the e4b and return the error. It does look like the
> >>> discard code can clobber the error though, so perhaps that should be
> >>> fixed. But otherwise it's not clear to me why we might want to exit
> >>> early there. Am I missing something else?
> >> The core issue is that they risk ignoring certain errors, which can
> >> result in inconsistency.
> >>
> > Hmm.. I'm not sure it's that simple in the free path. It looks like
> > things are ordered differently there. We modify the on-disk struct and
> > if it changes something, then even it fails we go ahead and proceed with
> > the in-core updates, and then return the error. Modulo the discard logic
> > thing, the error is then passed into the standard error handling code,
> > so it isn't really ignored.
> >
> > Though again I'm not quite sure what the expected result is here in the
> > case where it's the ext4_handle_dirty_metadata() call that fails. Is
> > this a guaranteed shutdown/abort situation? Perhaps Jan or somebody
> > familiar with the journaling code could chime in on this..? Thanks.
> >
> >>>> Since this issue popped up in the last couple of years, we should
> >>>> probably add a Fixes: tag to make backporting easier.
> >>>>
> >>> Do you have a target patch in mind? I made a pass through historical
> >>> changes and it looked like this was a longer standing issue through
> >>> various bits of refactoring..
> >>>
> >> No, I haven't, but I suspect it was introduced when
> >> (err && changed == 0) was added.
> >>
> > Making another pass.. that code is introduced in commit 2f94711b098b
> > ("ext4: call ext4_mb_mark_context in ext4_mb_mark_diskspace_used"), but
> > that just refactors things and doesn't appear to introduce the problem.
> > It looks like it still double decrements due to how the code is ordered.
> 
> Yes, that is a separate issue.
> 
> >
> > Going back further.. commit 0087d9fb3f29 ("ext4: Fix
> > s_dirty_blocks_counter if block allocation failed with nodelalloc") adds
> > the release in ext4_mb_new_blocks(), so that appears to be where the
> > logic wart was first introduced.
> 
> Yes, it does appear that this commit introduced the issue. 
> 
> Thanks for finding the exact commit where it was introduced!
> 
> >
> > That said, that one goes back to 2009 and the current fix wouldn't
> > apply. TBH given how old the bug is and that it's basically just a
> > warning in a shutdown case, I'm not sure it's really worth the risk of
> > backporting at all.. I'll defer to the community on that however and can
> > at least mention the commit in the changelog if we don't ultimately tag
> > it.
> 
> I think it's essential to have this fixed.
> Thank you for your effort on this.
> 

Ack, thanks.

Brian

> 
> Cheers,
> Baokun
> 


