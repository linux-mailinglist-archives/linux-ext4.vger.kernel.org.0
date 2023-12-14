Return-Path: <linux-ext4+bounces-448-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AE6813326
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Dec 2023 15:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59F9281D46
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Dec 2023 14:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C52559E57;
	Thu, 14 Dec 2023 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wYpi3irB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TgyKssAI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DoHozmNA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SrX/PnBn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1742CA7
	for <linux-ext4@vger.kernel.org>; Thu, 14 Dec 2023 06:31:11 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 819B31FDB4;
	Thu, 14 Dec 2023 14:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702564269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sxNHRqpzv6OsvHKHb9vPAOYEhajh0DREFcvCYq71nGI=;
	b=wYpi3irBcK4vxIi6n2Dqm/KOnLOhpSe1qUD4KrNaXOEP8dxB1HlpZZx0jOQEbTQreKOg/h
	gQ/1lR8c+4rCQXu2ezEKKpslAinmSYOCg/BCqyElYuDpv+36eAnvLEg0CizFb/IwUd5h7F
	ITocYnHXgOgO/SqT2gJ3YLZJm1W2x4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702564269;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sxNHRqpzv6OsvHKHb9vPAOYEhajh0DREFcvCYq71nGI=;
	b=TgyKssAIN2n4dSRMOm80YwEDAfm5ZR0v1JhXbuEBPh7xk4w26Pqwh2Tese151aTNwEC2+j
	Cd8NVwraXbHJcxBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702564268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sxNHRqpzv6OsvHKHb9vPAOYEhajh0DREFcvCYq71nGI=;
	b=DoHozmNA5TGWYe2gEfevKNrfgvqXhqlmOTCUf8J+34hI8enA7xOfJaEtjgNlv7h7mQ0j69
	3KFinMZBI+EP6Sh4hZwdxLgGMIcjoYh8PxYPD3PKb/TKvwWzEO6TY41RQZxsbidvu/w1Yq
	3G1i4dAIcJHxtedAMcUvU92V3xuy78U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702564268;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sxNHRqpzv6OsvHKHb9vPAOYEhajh0DREFcvCYq71nGI=;
	b=SrX/PnBnVeMekptYYZUn1qdboAErigG1/OOo9GupKFfWVpaTzvYEyCozqCSpW49GRATtOM
	BSbMcCcoC5nheLAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7210A134B0;
	Thu, 14 Dec 2023 14:31:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id KrzVG6wRe2VnGQAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 14 Dec 2023 14:31:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 10162A07E0; Thu, 14 Dec 2023 15:31:08 +0100 (CET)
Date: Thu, 14 Dec 2023 15:31:08 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [RFC PATCH 3/6] ext4: correct the hole length returned by
 ext4_map_blocks()
Message-ID: <20231214143108.36ywegeshzv4j2ut@quack3>
References: <20231121093429.1827390-1-yi.zhang@huaweicloud.com>
 <20231121093429.1827390-4-yi.zhang@huaweicloud.com>
 <20231213182114.tzwsqpeonr5ok3j2@quack3>
 <52f6786a-b936-9f79-bea0-ed54a57efd62@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52f6786a-b936-9f79-bea0-ed54a57efd62@huaweicloud.com>
X-Spam-Score: -0.05
X-Spam-Level: 
X-Spam-Score: -0.05
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.05 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 NEURAL_SPAM_SHORT(2.05)[0.684];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,mit.edu,dilger.ca,gmail.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Thu 14-12-23 17:18:45, Zhang Yi wrote:
> On 2023/12/14 2:21, Jan Kara wrote:
> > On Tue 21-11-23 17:34:26, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> In ext4_map_blocks(), if we can't find a range of mapping in the
> >> extents cache, we are calling ext4_ext_map_blocks() to search the real
> >> path. But if the querying range was tail overlaped by a delayed extent,
> >> we can't find it on the real extent path, so the returned hole length
> >> could be larger than it really is.
> >>
> >>       |          querying map          |
> >>       v                                v
> >>       |----------{-------------}{------|----------------}-----...
> >>       ^          ^             ^^                       ^
> >>       | uncached | hole extent ||     delayed extent    |
> >>
> >> We have to adjust the mapping length to the next not hole extent's
> >> lblk before searching the extent path.
> >>
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> > 
> > So I agree the ext4_ext_determine_hole() does return a hole that does not
> > reflect possible delalloc extent (it doesn't even need to be straddling the
> > end of looked up range, does it?). But ext4_ext_put_gap_in_cache() does
> 
> Yeah.
> 
> > actually properly trim the hole length in the status tree so I think the
> > problem rather is that the trimming should happen in
> > ext4_ext_determine_hole() instead of ext4_ext_put_gap_in_cache() and that
> > will also make ext4_map_blocks() return proper hole length? And then
> > there's no need for this special handling? Or am I missing something?
> > 
> 
> Thanks for your suggestions. Yeah, we can trim the hole length in
> ext4_ext_determine_hole(), but I'm a little uneasy about the race condition.
> ext4_da_map_blocks() only hold inode lock and i_data_sem read lock while
> inserting delay extents, and not all query path of ext4_map_blocks() hold
> inode lock.

That is a good point! I think something like following could happen already
now:

Suppose we have a file 8192 bytes large containing just a hole.

Task1					Task2
pread(f, buf, 4096, 0)			pwrite(f, buf, 4096, 4096)
  filemap_read()
    filemap_get_pages()
      filemap_create_folio()
        filemap_read_folio()
          ext4_mpage_readpages()
            ext4_map_blocks()
	      down_read(&EXT4_I(inode)->i_data_sem);
              ext4_ext_map_blocks()
		- finds hole 0..8192
	        ext4_ext_put_gap_in_cache()
		  ext4_es_find_extent_range()
		    - finds no delalloc extent
					  ext4_da_write_begin()
					    ext4_da_get_block_prep()
					      ext4_da_map_blocks()
					        down_read(&EXT4_I(inode)->i_data_sem);
					        ext4_ext_map_blocks()
						  - nothing found
						ext4_insert_delayed_block()
						  - inserts delalloc extent
						    to 4096-8192
		  ext4_es_insert_extent()
		    - inserts 0..8192 a hole overwriting delalloc extent

> I guess the hole/delayed range could be raced by another new
> delay allocation and changed after we first check in ext4_map_blocks(),
> the querying range could be overlapped and became all or partial delayed,
> so we also need to recheck the map type here if the start querying block
> has became delayed, right?

I don't think think you can fix this just by rechecking. I think we need to
hold i_data_sem in exclusive mode when inserting delalloc extents. Because
that operation is in fact changing state of allocation tree (although not
on disk yet). And that will fix this race because holding i_data_sem shared
is then enough so that delalloc state cannot change.

Please do this as a separate patch because this will need to be backported
to stable tree. Thanks!

								Honza

> >> ---
> >>  fs/ext4/inode.c | 24 ++++++++++++++++++++++--
> >>  1 file changed, 22 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> >> index 4ce35f1c8b0a..94e7b8500878 100644
> >> --- a/fs/ext4/inode.c
> >> +++ b/fs/ext4/inode.c
> >> @@ -479,6 +479,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
> >>  		    struct ext4_map_blocks *map, int flags)
> >>  {
> >>  	struct extent_status es;
> >> +	ext4_lblk_t next;
> >>  	int retval;
> >>  	int ret = 0;
> >>  #ifdef ES_AGGRESSIVE_TEST
> >> @@ -502,8 +503,10 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
> >>  		return -EFSCORRUPTED;
> >>  
> >>  	/* Lookup extent status tree firstly */
> >> -	if (!(EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY) &&
> >> -	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
> >> +	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> >> +		goto uncached;
> >> +
> >> +	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
> >>  		if (ext4_es_is_written(&es) || ext4_es_is_unwritten(&es)) {
> >>  			map->m_pblk = ext4_es_pblock(&es) +
> >>  					map->m_lblk - es.es_lblk;
> >> @@ -532,6 +535,23 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
> >>  #endif
> >>  		goto found;
> >>  	}
> >> +	/*
> >> +	 * Not found, maybe a hole, need to adjust the map length before
> >> +	 * seraching the real extent path. It can prevent incorrect hole
> >> +	 * length returned if the following entries have delayed only
> >> +	 * ones.
> >> +	 */
> >> +	if (!(flags & EXT4_GET_BLOCKS_CREATE) && es.es_lblk > map->m_lblk) {
> >> +		next = es.es_lblk;
> >> +		if (ext4_es_is_hole(&es))
> >> +			next = ext4_es_skip_hole_extent(inode, map->m_lblk,
> >> +							map->m_len);
> >> +		retval = next - map->m_lblk;
> >> +		if (map->m_len > retval)
> >> +			map->m_len = retval;
> >> +	}
> >> +
> >> +uncached:
> >>  	/*
> >>  	 * In the query cache no-wait mode, nothing we can do more if we
> >>  	 * cannot find extent in the cache.
> >> -- 
> >> 2.39.2
> >>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

