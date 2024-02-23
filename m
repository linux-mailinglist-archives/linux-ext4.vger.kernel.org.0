Return-Path: <linux-ext4+bounces-1377-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 969F786123D
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Feb 2024 14:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA980286125
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Feb 2024 13:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAABC7E595;
	Fri, 23 Feb 2024 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y3IdjOZC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OCcpkhuv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y3IdjOZC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OCcpkhuv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBC81DA26
	for <linux-ext4@vger.kernel.org>; Fri, 23 Feb 2024 13:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693677; cv=none; b=HAPS9L+b10ZnEdlvt/9nvmxfEvLz+9nvpsW9gxQSotoZhgxh5GWnREDTSO/PaHSkuohy0uCEowlgrkiDEeR/rNtU6yv15yvR9pVrh5qAXL5pYlwsjQErySEC6qmA6KyQOHNqhihJahWtLgpzlFULHij6vOhQrP0QG4L0N1TKRf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693677; c=relaxed/simple;
	bh=zn9uQuyEX7txlwbSXWGdj8zxBpBEpfvbrAsghdUsigA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdh6vCvcDKzose9noXPj9tGFB/5cQDOzsxjyYpCYsvvCbRGxupPAiUHQi4BPxK9X3isPv3VLXYFpeh5/5s2+OnkVEYCc9BgxqBOC/1kbguwZU7asCXpoXJrXbFexBC3CJd0qTGqHD3IeZ/OBYCgya29GAso5w7gtFy5Y2Y+D9mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y3IdjOZC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OCcpkhuv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y3IdjOZC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OCcpkhuv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 698FE1FC0A;
	Fri, 23 Feb 2024 13:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708693673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KmZ6I4GhxwyZIfulEpCtItz+J/91AmC7k1rH37f25LY=;
	b=Y3IdjOZCm7+xKgJSGNx5d3vJmjkaIk95ePjEsYudgM2B7ZJPFna5HAw1nB342KCJa6Nxvi
	sKubjV21dkVPZyculHASIsB/AktiSIB+1NAro1HKswTw4tO03loWYxA39khzboaEpC3LlQ
	Jgcm0Jo3o+53wc96uTwrlZONNqzEsnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708693673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KmZ6I4GhxwyZIfulEpCtItz+J/91AmC7k1rH37f25LY=;
	b=OCcpkhuvqlSaICC6K3K34oGg/XNP6GUj8fuFgd2mWbgBpbwNDahjPOiiGejvlH2lPYleDj
	UQe7r42JVAmV1yBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708693673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KmZ6I4GhxwyZIfulEpCtItz+J/91AmC7k1rH37f25LY=;
	b=Y3IdjOZCm7+xKgJSGNx5d3vJmjkaIk95ePjEsYudgM2B7ZJPFna5HAw1nB342KCJa6Nxvi
	sKubjV21dkVPZyculHASIsB/AktiSIB+1NAro1HKswTw4tO03loWYxA39khzboaEpC3LlQ
	Jgcm0Jo3o+53wc96uTwrlZONNqzEsnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708693673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KmZ6I4GhxwyZIfulEpCtItz+J/91AmC7k1rH37f25LY=;
	b=OCcpkhuvqlSaICC6K3K34oGg/XNP6GUj8fuFgd2mWbgBpbwNDahjPOiiGejvlH2lPYleDj
	UQe7r42JVAmV1yBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D32B13776;
	Fri, 23 Feb 2024 13:07:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id gWezFqmY2GVpcwAAn2gu4w
	(envelope-from <jack@suse.cz>); Fri, 23 Feb 2024 13:07:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 01250A07D1; Fri, 23 Feb 2024 14:07:52 +0100 (CET)
Date: Fri, 23 Feb 2024 14:07:52 +0100
From: Jan Kara <jack@suse.cz>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Don't report EOPNOTSUPP errors from discard
Message-ID: <20240223130752.5borutcggb53i3m2@quack3>
References: <20240213101601.17463-1-jack@suse.cz>
 <4AC7AEC3-25FC-4147-9C62-2CE5A1686199@dilger.ca>
 <20240215094635.p5anw5w36snmqwsh@quack3>
 <AF20B4C9-57F1-40B6-B095-621B59D9B2E7@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AF20B4C9-57F1-40B6-B095-621B59D9B2E7@dilger.ca>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

On Thu 22-02-24 14:23:38, Andreas Dilger wrote:
> On Feb 15, 2024, at 2:46 AM, Jan Kara <jack@suse.cz> wrote:
> > 
> > On Wed 14-02-24 16:01:57, Andreas Dilger wrote:
> >> On Feb 13, 2024, at 3:16 AM, Jan Kara <jack@suse.cz> wrote:
> >>> 
> >>> When ext4 is mounted without journal, with discard mount option, and on
> >>> a device not supporting trim, we print error for each and every freed
> >>> extent. This is not only useless but actively harmful. Instead ignore
> >>> the EOPNOTSUPP error. Trim is only advisory anyway and when the
> >>> filesystem has journal we silently ignore trim error as well.
> >>> 
> >> 
> >>> Signed-off-by: Jan Kara <jack@suse.cz>
> >>> ---
> >>> fs/ext4/mballoc.c | 8 +++++++-
> >>> 1 file changed, 7 insertions(+), 1 deletion(-)
> >>> 
> >>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> >>> index e4f7cf9d89c4..aed620cf4d40 100644
> >>> --- a/fs/ext4/mballoc.c
> >>> +++ b/fs/ext4/mballoc.c
> >>> @@ -6488,7 +6488,13 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
> >>> 		if (test_opt(sb, DISCARD)) {
> >>> 			err = ext4_issue_discard(sb, block_group, bit,
> >>> 						 count_clusters, NULL);
> >>> -			if (err && err != -EOPNOTSUPP)
> >>> +			/*
> >>> +			 * Ignore EOPNOTSUPP error. This is consistent with
> >>> +			 * what happens when using journal.
> >>> +			 */
> >>> +			if (err == -EOPNOTSUPP)
> >>> +				err = 0;
> >>> +			if (err)
> >> 
> >> I don't see how this patch is actually changing whether the error message
> >> is printed?  Previously, if "err" was set and err was -EOPNOTSUPP the
> >> message was skipped.  Now it is doing the same thing in a different way?
> >> 
> >> The "err" value is overwritten 50 lines later on without being used:
> >> 
> >>        err = ext4_handle_dirty_metadata(handle, NULL, bitmap_bh);
> >> 
> >> so the setting "err = 0" doesn't really affect the later code either.
> >> What am I missing?
> > 
> > Yeah, the code flow is a bit contrived. The error message gets printed by
> > ext4_std_error() at the end of ext4_mb_clear_bb(). I don't think there's
> > any ext4_handle_dirty_metadata() call in the current version of
> > ext4_mb_clear_bb()...
> 
> I had meant to reply on this thread sooner...
> 
> Does this mean that no error will be returned at all from FSTRIM?

This path is not about FITRIM ioctl but about 'discard' mount option. So in
this case there's nobody to return error to.

> That means userspace will just keep pounding this ioctl indefinitely
> and never get a notification that it is the wrong thing to do.
> 
> I'd think it would instead be better to also skip the ext4_std_error()
> in case of -EOPNOTSUPP but still return the error code to the caller
> so that they can make a better decision next time.

I agree this might make sense.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

