Return-Path: <linux-ext4+bounces-12448-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F897CD045C
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Dec 2025 15:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F2963064DF6
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Dec 2025 14:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D6E31D37B;
	Fri, 19 Dec 2025 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mevHreP0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UTvHdQzl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mevHreP0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UTvHdQzl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728ED1B85F8
	for <linux-ext4@vger.kernel.org>; Fri, 19 Dec 2025 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766154584; cv=none; b=iGJhAOs/RjNHApFZW2xv30k2r16HR/XnBANYSk+BELnGoLgJLcX4H4euI1cmgdPE8HmK38XilRxziAkonDJdbVhsRh7GvXUo8fvWoWG8gRw6fi3CJt/2XbaclUroy925iExCtrXTJP88Fw9ryL0+K2dubNOTpMLOrLwmLrnazo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766154584; c=relaxed/simple;
	bh=RO4YRhYHmhDDdxJoqAsKOm09J0zHn4O6tgGun1LyeCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j29M6ktRbuy0UGsHaTADNjpva92m0yuD7RIKPN/J2FdSFkQ25vwONYTD3GKBsKe56CVjZsH9N/LSU22pnWm4amAtJXZJvSu+TRl/GnNPFDrwzA11L5RtjjYnfAvSU2MiK3c/gh2CM57RjKQJS24rl1iMlwILiyc7KTTrUm678Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mevHreP0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UTvHdQzl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mevHreP0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UTvHdQzl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6F1DA336DB;
	Fri, 19 Dec 2025 14:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766154580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AlrYOSqTORqC/2r8dGzsTShTduotoaDV4EZOBn0Nei4=;
	b=mevHreP0s+xlJtPzGEKJb7uVk+mTpsJ80HimSBu0bHqdaXJo68h6FqVyQxkSsnG12jaxy6
	CTCCYggj+eXstc4ELamPZ0kpGxlawH5pY8RNAXWtjgv0Gg1NAWB+ZSk7+SRaaoCXE6tzRm
	osS9dMgBJhv+WWE+LiDaBHnvSJEm71I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766154580;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AlrYOSqTORqC/2r8dGzsTShTduotoaDV4EZOBn0Nei4=;
	b=UTvHdQzl2ZTPjfLOM0A79FORrxikA9YTOm7I2dNUAdR1ePhI3ezYMyzpPMSXnKdvELXwzc
	mTfdHTUW8xJLFgBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766154580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AlrYOSqTORqC/2r8dGzsTShTduotoaDV4EZOBn0Nei4=;
	b=mevHreP0s+xlJtPzGEKJb7uVk+mTpsJ80HimSBu0bHqdaXJo68h6FqVyQxkSsnG12jaxy6
	CTCCYggj+eXstc4ELamPZ0kpGxlawH5pY8RNAXWtjgv0Gg1NAWB+ZSk7+SRaaoCXE6tzRm
	osS9dMgBJhv+WWE+LiDaBHnvSJEm71I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766154580;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AlrYOSqTORqC/2r8dGzsTShTduotoaDV4EZOBn0Nei4=;
	b=UTvHdQzl2ZTPjfLOM0A79FORrxikA9YTOm7I2dNUAdR1ePhI3ezYMyzpPMSXnKdvELXwzc
	mTfdHTUW8xJLFgBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 636543EA63;
	Fri, 19 Dec 2025 14:29:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1ZQ+GFRhRWlgOgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 19 Dec 2025 14:29:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1D6ABA090B; Fri, 19 Dec 2025 15:29:25 +0100 (CET)
Date: Fri, 19 Dec 2025 15:29:25 +0100
From: Jan Kara <jack@suse.cz>
To: Brian Foster <bfoster@redhat.com>
Cc: Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ext4: fix dirtyclusters double decrement on fs shutdown
Message-ID: <orgqlda7os4r3qakcd5r755bpxczg5ylry55aykzo3mgpmgesu@x7labfsncpsp>
References: <20251212154735.512651-1-bfoster@redhat.com>
 <ef906e19-04b9-4793-998e-81c34ebf9126@huawei.com>
 <aUApNS_YnY2Oa_93@bfoster>
 <106ba6fe-4f94-4ed4-a53a-98a1f3ad30ab@huawei.com>
 <aUGAf_NLbIt_sktF@bfoster>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aUGAf_NLbIt_sktF@bfoster>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.987];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]

On Tue 16-12-25 10:53:35, Brian Foster wrote:
> On Tue, Dec 16, 2025 at 12:01:41PM +0800, Baokun Li wrote:
> > On 2025-12-15 23:28, Brian Foster wrote:
> > > On Sat, Dec 13, 2025 at 09:46:23AM +0800, Baokun Li wrote:
> > >> Hi Brian,
> > >>
> > >> Thanks for the patch.
> > >>
> > > Hi Baokun,
> > >
> > > Thanks for reviewing..
> > >
> > >> On 2025-12-12 23:47, Brian Foster wrote:
> > >>> fstests test generic/388 occasionally reproduces a warning in
> > >>> ext4_put_super() associated with the dirty clusters count:
> > >>>
> > >>>   WARNING: CPU: 7 PID: 76064 at fs/ext4/super.c:1324 ext4_put_super+0x48c/0x590 [ext4]
> > >>>
> > >>> Tracing the failure shows that the warning fires due to an
> > >>> s_dirtyclusters_counter value of -1. IOW, this appears to be a
> > >>> spurious decrement as opposed to some sort of leak. Further tracing
> > >>> of the dirty cluster count deltas and an LLM scan of the resulting
> > >>> output identified the cause as a double decrement in the error path
> > >>> between ext4_mb_mark_diskspace_used() and the caller
> > >>> ext4_mb_new_blocks().
> > >>>
> > >>> First, note that generic/388 is a shutdown vs. fsstress test and so
> > >>> produces a random set of operations and shutdown injections. In the
> > >>> problematic case, the shutdown triggers an error return from the
> > >>> ext4_handle_dirty_metadata() call(s) made from
> > >>> ext4_mb_mark_context(). The changed value is non-zero at this point,
> > >>> so ext4_mb_mark_diskspace_used() does not exit after the error
> > >>> bubbles up from ext4_mb_mark_context(). Instead, the former
> > >>> decrements both cluster counters and returns the error up to
> > >>> ext4_mb_new_blocks(). The latter falls into the !ar->len out path
> > >>> which decrements the dirty clusters counter a second time, creating
> > >>> the inconsistency.
> > >>>
> > >>> AFAICT the solution here is to exit immediately from
> > >>> ext4_mb_mark_diskspace_used() on error, regardless of the changed
> > >>> value. This leaves the caller responsible for clearing the block
> > >>> reservation at the same level it is acquired. This also skips the
> > >>> free clusters update, but the caller also calls into
> > >>> ext4_discard_allocated_blocks() to free the blocks back into the
> > >>> group. This survives an overnight loop test of generic/388 on an
> > >>> otherwise reproducing system and survives a local regression run.
> > >>>
> > >>> Signed-off-by: Brian Foster <bfoster@redhat.com>
> > >>> ---
> > >>>
> > >>> Hi all,
> > >>>
> > >>> I've thrown some testing at this and poked around the area enough that I
> > >>> _think_ it is reasonably sane, but the error paths are hairy and I could
> > >>> certainly be missing some details. I'm happy to try a different approach
> > >>> if there are any thoughts around that.. thanks.
> > >>>
> > >>> Brian
> > >>>
> > >>>  fs/ext4/mballoc.c | 2 +-
> > >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > >>> index 56d50fd3310b..224abfd6a42b 100644
> > >>> --- a/fs/ext4/mballoc.c
> > >>> +++ b/fs/ext4/mballoc.c
> > >>> @@ -4234,7 +4234,7 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
> > >>>  				   ac->ac_b_ex.fe_start, ac->ac_b_ex.fe_len,
> > >>>  				   flags, &changed);
> > >>>  
> > >>> -	if (err && changed == 0)
> > >>> +	if (err)
> > >>>  		return err;
> > >>>  
> > >>>  #ifdef AGGRESSIVE_CHECK
> > >> I think we might need to swap that && for an ||.
> > >>
> > >> Basically, we should only proceed with the following logic if there's
> > >> no error and the bitmap was actually changed. If we hit an error or
> > >> if the section we intended to modify was already fully handled,
> > >> we should just bail out early. Otherwise, the err could get quietly
> > >> ignored unless we hit a duplicate allocation that happens to result in
> > >> 'changed' being zero.
> > >>
> > > Hmm.. to make sure I understand, are you referring to an inconsistency
> > > case where we allocated blocks that were already marked as such in the
> > > group on disk..?
> > Yes.
> > > I'm a little uneasy about this because it seems to conflict with the
> > > surrounding code. AFAICT the only way we can hit something like !err &&
> > > !changed is via EXT4_MB_BITMAP_MARKED_CHECK, which causes
> > > _mark_context() to check the bitmap for "already modified" bits up
> > > front.
> > >
> > > If this scenario plays out, the caller has a BUG check just after the
> > > return (also under the aggressive check macro). So ISTM that this sort
> > > of (err || !changed) logic would bypass the aggressive checks and let
> > > the fs carry on when it probably shouldn't. Hm?
> > 
> > Regarding ext4_mb_mark_context, if the passed ret_changed pointer is
> > non-NULL, we initialize *ret_changed to 0. After updating the bitmap_bh,
> > we then update *ret_changed with the actual number of blocks modified
> > (changed).
> > 
> > Therefore, the original intention was for changed == 0 to signify that
> > an error occurred in ext4_mb_mark_context() before ret_changed could be
> > updated. However, as you pointed out, we also get changed == 0 when the
> > target extent has already been fully marked as allocated within bitmap_bh.
> > 
> > Crucially, we only genuinely check the bitmap to modify changed when
> > EXT4_MB_BITMAP_MARKED_CHECK is set (i.e., when AGGRESSIVE_CHECK is defined,
> > or during fast commit or resize operations). Otherwise, changed is always
> > set to the target length. This means that, in the general case, errors
> > returned after the point where ret_changed is updated (e.g., the error
> > from ext4_handle_dirty_metadata()) are usually ignored.
> > 
> > In summary:
> > 
> >  * (err && changed == 0) only concerns errors that occur before ret_changed
> >    is updated.
> >  * (err || changed == 0) concerns whether there was an error OR if any
> >    modification actually took place.
> > 
> > If we only care about err, we could move the update of ret_changed inside
> > ext4_mb_mark_context() to just before the successful return.
> > 
> 
> Yeah, I think the _mark_context() logic is reasonably straightforward
> from the code. What is less clear is why the allocation path only cares
> about errors prior to ret_changed being set.
> 
> It looks to me that this is just wrong. I suspect either due to
> copy/paste error in the mark_diskspace_used() path at some point in the
> past, or an attempt to filter out the BUG case from an obvious case
> where changed will be 0 on certain error returns.
> 
> I don't think the mark_context() logic alone tells the full story here.
> I think what's relevant is the high level error handling of the
> !delalloc allocation path:
> 
> 1. ext4_mb_new_blocks() reserves blocks and attempts physical allocation
> in memory. On success, it calls into ext4_mb_mark_diskspace_used() to
> update on-disk structures.
> 
> 2a. If ext4_mb_mark_diskspace_used() is successful, it decrements the
> freeclusters counter and releases res from the dirtyclusers counter
> (i.e. transfer the block from dirty to used). ext4_mb_new_blocks()
> basically just returns the result.
> 
> 2b. If ext4_mb_mark_diskspace_used() fails, ext4_mb_new_blocks()
> receives the error. In the error exit path, it frees the blocks back
> into the incore structures and releases the reservation it acquired in
> step 1.  
> 
> However the bug this patch is trying to fix is that
> ext4_mb_mark_diskspace_used() runs the counter updates regardless of
> error in some cases. If the on-disk update fails, _new_blocks() will
> release its reservation and return the blocks, so _mark_diskspace_used()
> shouldn't account that block from the dirty and free counters.
> 
> What isn't quite clear to me is how this is expected to deal with the
> modified buffer. This particular case is a shutdown and journal abort,
> so I suspect the buffer can't write back.
> 
> > >> By the way, I spotted two other spots with similar error logic:
> > >> ext4_mb_clear_bb() and ext4_group_add_blocks().
> > >>
> > > Yeah, I saw those as well but didn't think they needed changing. My high
> > > level understanding of the alloc case is that ext4_mb_new_blocks()
> > > acquires res (!delalloc), allocs blocks out of in-core structures, then
> > > calls down into _mark_diskspace_used() to update/journal on-disk
> > > structures with the pending alloc. If the latter fails, we release res
> > > and feed blocks back into the in-core structures. So IOW, if we return
> > > directly from _mark_diskspace_used() the counters/state end up
> > > consistent afaict.
> > >
> > > For the ext4_free_blocks() case, we call _mark_context() and if it fails
> > > with changed != 0 (and don't otherwise BUG), we still go ahead and free
> > > the blocks in the e4b and return the error. It does look like the
> > > discard code can clobber the error though, so perhaps that should be
> > > fixed. But otherwise it's not clear to me why we might want to exit
> > > early there. Am I missing something else?
> > 
> > The core issue is that they risk ignoring certain errors, which can
> > result in inconsistency.
> 
> Hmm.. I'm not sure it's that simple in the free path. It looks like
> things are ordered differently there. We modify the on-disk struct and
> if it changes something, then even it fails we go ahead and proceed with
> the in-core updates, and then return the error. Modulo the discard logic
> thing, the error is then passed into the standard error handling code,
> so it isn't really ignored.
> 
> Though again I'm not quite sure what the expected result is here in the
> case where it's the ext4_handle_dirty_metadata() call that fails. Is
> this a guaranteed shutdown/abort situation? Perhaps Jan or somebody
> familiar with the journaling code could chime in on this..? Thanks.

Yes, at the moment ext4_handle_dirty_metadata() or
ext4_journal_get_write_access() returns error the journal is dead and no
modifications can make it to the disk. *But* this applies only to
filesystems with the journal. If we don't have a journal,
ext4_handle_dirty_metadata() can fail also due to simple IO error when
writing out the buffer. OTOH without a journal you're expected to run
e2fsck once error like this happens so we just strive not to loose more
data than necessary and not to crash the kernel...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

