Return-Path: <linux-ext4+bounces-7156-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 891DAA81C1F
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 07:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322F119E850E
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 05:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9346B1DB124;
	Wed,  9 Apr 2025 05:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="2VSortwh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC2C1D90C8
	for <linux-ext4@vger.kernel.org>; Wed,  9 Apr 2025 05:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744176635; cv=none; b=MLYA/jIa60xB9bE74f7OaKsYROjKNDoeCbSIuVFpmLgJQvWo5sdiV8gRn9QwrG/iYGetmsp19dbFSQTiUpOLsZa4C37/WJvqdSG2+EeoB3OXU04j6zuEUI/+w6xRDwqBP9UoJXtu/c3/Q3/1QdP8/1g5fyTHt2acmojXsAfEE+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744176635; c=relaxed/simple;
	bh=R7hiJCkatJysWFE6sFi+boDLQC0QCBTx8/v67EiLvO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3TiVny7W5yFd0EB+hERrvP8RHXLC/uv7gE66VkAzaTe8EQN5oEFE5N216KP+9arroOJHXh7wA0+37gfJopoUKRpPYCGi0n9VIPcUgFj73V8o6MvNbOAZiA6xz5b2/TYwejrRHdj0hZhQYc1TNnMbCcfnaGbKya3/QlUov7a3P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=2VSortwh; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-736c1138ae5so6281169b3a.3
        for <linux-ext4@vger.kernel.org>; Tue, 08 Apr 2025 22:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744176632; x=1744781432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aA07albMhL3fFH5QzUo/KeZ0yw8nrVP+2r3FD61bWYo=;
        b=2VSortwhnJjEW2ZWRYsN5FPlEqgseal3/1e84GQirIoBdTratk/mLbOxehfARk13Az
         sZ92L1Ia86zsnNRqEbS8O0joZTvVBJoaYB+nFGgf5rq/covf60Tc0vhmxaixhY/+ZtUb
         WALnPmEnAcpiJxU2kNbckvgdzGR6b2TgSUMVFwlloUrqf7nG/GJEVAqf/cY234LsB614
         gJm9akfNmGIPLHioaG0sOg8iC9F/isBNY9MgzCCy0nS07HBLLgYMaftjq+02YgUF1VGv
         ZOYjeILGat/yC9vcaloZwOyT6CCqE9nnw22UD3rTLVQNNvH6NdRzxv2bC03LFjlk73Y3
         XYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744176632; x=1744781432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aA07albMhL3fFH5QzUo/KeZ0yw8nrVP+2r3FD61bWYo=;
        b=BIpfxFjE1Zrn/DgddTDd1wpQGnBugZU2gpwJm316g+4vfRlLzlyJ2WseF7TyaXQ2zv
         RNAan2r13/4j3rOcmdzcydMMwRrLr1k84umgiKpnveqqqBj2MsRQNCwUXLHTopHnVmvk
         V7qVgoV7J48y4g4JMGuXuh3utHDIZfGEHZxuCLeT8xWrWLrtB0vH0Ym1cf9e0k5EwBjx
         CL1HPSSE/KnktvHGMC12ONeqiq2msem0O+3HHlPcWNgXvgBr0NdZMoWw4z+UtB7o5Pem
         aNogKmMXK/MiPrmNRUUvuAxeEDj0MQ4hPBj2Eh7eam8Lp3zg2mRSMp6yxe0EJEwk2DuK
         3Q8w==
X-Forwarded-Encrypted: i=1; AJvYcCVx9Z0ZNaubDSnd4vjEpxMD15Q5adzNwds+1YFul4GU3u3eyimHDuy/A8I8/xQDnBgpPQjXf/KTkDKa@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsff8DqcW9uIwLy12AqI5fn4LQSiJB9FshMSlDNLf0qcYvfyXO
	2KnJr7EtaUAFyOW9BgsRj2p6NIkYkab4AMWo9xvO+2j4iE6/SEoOmsYfIl6uARU=
X-Gm-Gg: ASbGncvwdizTY7I+i9whiQ2x9iS/vyUJtqI0A2lyFC+xvYc6p41h+kq4jp0n6YC72mJ
	cnve2roERi8xyVgpJbbxy1hAA8WUFpNjk9Fj8yU2E8hNH+tlVdgtBFF7SidiSfgxY6D1pzP0xWO
	Xg+rwsKML23Y6M+3xzZpyCKOBvULeLhPrQ63tkHKxLBknV27NXvV5yMOsZ6dJsi1cGwZ2alJvae
	qpwI+ieqte0vXz7WQUEYZ9JIp6+D3ZkhKVlJFchMn5u1JF73+yIBQCD3DNSc6oAzyFLaNzZgAxX
	qrSVSbRUD+0hKWnXS4RfVutHz0CGtOv43Vk/UoNPxPdHGWn3ym90mj8TMV6tE+NZQBEGh2HqF62
	/BjCNReTRr/KhDrJl0A==
X-Google-Smtp-Source: AGHT+IFZgHcaCsesio4fOj1pttogbZE5YtveLF4WEKUpmqgVHeONG2Il5NKIs/SWKZoNNmD8aQrvmQ==
X-Received: by 2002:a05:6a00:e12:b0:736:a973:748 with SMTP id d2e1a72fcca58-73bafd6a4a1mr1539346b3a.22.1744176632136;
        Tue, 08 Apr 2025 22:30:32 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1e66c6csm361081b3a.158.2025.04.08.22.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 22:30:31 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1u2O16-00000006MBb-1BzD;
	Wed, 09 Apr 2025 15:30:28 +1000
Date: Wed, 9 Apr 2025 15:30:28 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, brauner@kernel.org, hch@lst.de,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com
Subject: Re: [PATCH v6 11/12] xfs: add xfs_compute_atomic_write_unit_max()
Message-ID: <Z_YF9HpdbkJDLeuR@dread.disaster.area>
References: <20250408104209.1852036-1-john.g.garry@oracle.com>
 <20250408104209.1852036-12-john.g.garry@oracle.com>
 <Z_WnbfRhKR6RQsSA@dread.disaster.area>
 <20250409004156.GL6307@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409004156.GL6307@frogsfrogsfrogs>

On Tue, Apr 08, 2025 at 05:41:56PM -0700, Darrick J. Wong wrote:
> On Wed, Apr 09, 2025 at 08:47:09AM +1000, Dave Chinner wrote:
> > On Tue, Apr 08, 2025 at 10:42:08AM +0000, John Garry wrote:
> > > Now that CoW-based atomic writes are supported, update the max size of an
> > > atomic write for the data device.
> > > 
> > > The limit of a CoW-based atomic write will be the limit of the number of
> > > logitems which can fit into a single transaction.
> > 
> > I still think this is the wrong way to define the maximum
> > size of a COW-based atomic write because it is going to change from
> > filesystem to filesystem and that variability in supported maximum
> > length will be exposed to userspace...
> > 
> > i.e. Maximum supported atomic write size really should be defined as
> > a well documented fixed size (e.g. 16MB). Then the transaction
> > reservations sizes needed to perform that conversion can be
> > calculated directly from that maximum size and optimised directly
> > for the conversion operation that atomic writes need to perform.
> 
> I'll get to this below...

I'll paste it here so it's all in one context.

> This is why I don't agree with adding a static 16MB limit -- we clearly
> don't need it to emulate current hardware, which can commit up to 64k
> atomically.  Future hardware can increase that by 64x and we'll still be
> ok with using the existing tr_write transaction type.
> 
> By contrast, adding a 16MB limit would result in a much larger minimum
> log size.  If we add that to struct xfs_trans_resv for all filesystems
> then we run the risk of some ancient filesystem with a 12M log failing
> suddenly failing to mount on a new kernel.
> 
> I don't see the point.

You've got stuck on ithe example size of 16MB I gave, not
the actual reason I gave that example.

That is: we should not be exposing some unpredictable, filesystem
geometry depending maximum atomic size to a userspace API.  We need
to define a maximum size that we support, that we can clearly
document and guarantee will work on all filesystem geometries.

What size that is needs to be discussed - all you've done is
demonstrate that 16MB would require a larger minimum log size for a
small set of historic/legacy filesystem configs.

I'm actually quite fine with adding new reservations that change
minimum required log sizes - this isn't a show-stopper in any way.

Atomic writes are optional functionality, so if the log size is too
small for the atomic write transaction requirements, then we don't
enable the atomic write functionality on that filesystem. Hence the
minimum required log size for the filesystem -does not change- and
the filesystem mounts as normal..

i.e. the user hasn't lost anything on these tiny log filesystems
when the kernel is upgraded to support software atomic writes.
All that happens is that the legacy filesystem will never support
atomic writes....

Such a mount time check allows us to design the atomic write
functionality around a fixed upper size bound that we can guarantee
will work correctly. i.e. the size of the transaction reservation
needed for it is irrelevant because we guarantee to only run that
transaction on filesytsems with logs large enough to support it.

Having a consistent maximum atomic write size makes it easier for
userspace to create logic and algorithms around, and it makes it
much easier for us to do boundary condition testing as we don't have
to reverse engineer the expected boundaries from filesysetm geometry
in test code. Fixed sizes make API verification and testing a whole
lot simpler.

And, finally, if everything is sized from an single API constant, it
makes it easy to modify the supported size in future. The 64MB
minimum log size gives us lots of headroom to increase supported
atomic write sizes, so if userspace finds that it really needs
larger sizes than what we initially support, it's trivial to change
both the kernel and the test code to support a larger size...

> > > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > > index b2dd0c0bf509..42b2b7540507 100644
> > > --- a/fs/xfs/xfs_super.c
> > > +++ b/fs/xfs/xfs_super.c
> > > @@ -615,6 +615,28 @@ xfs_init_mount_workqueues(
> > >  	return -ENOMEM;
> > >  }
> > >  
> > > +unsigned int
> > > +xfs_atomic_write_logitems(
> > > +	struct xfs_mount	*mp)
> > > +{
> > > +	unsigned int		efi = xfs_efi_item_overhead(1);
> > > +	unsigned int		rui = xfs_rui_item_overhead(1);
> > > +	unsigned int		cui = xfs_cui_item_overhead(1);
> > > +	unsigned int		bui = xfs_bui_item_overhead(1);
> > > +	unsigned int		logres = M_RES(mp)->tr_write.tr_logres;
> > > +
> > > +	/*
> > > +	 * Maximum overhead to complete an atomic write ioend in software:
> > > +	 * remove data fork extent + remove cow fork extent +
> > > +	 * map extent into data fork
> > > +	 */
> > > +	unsigned int		atomic_logitems =
> > > +		(bui + cui + rui + efi) + (cui + rui) + (bui + rui);
> > 
> > This seems wrong. Unmap from the data fork only logs a (bui + cui)
> > pair, we don't log a RUI or an EFI until the transaction that
> > processes the BUI or CUI actually frees an extent from the the BMBT
> > or removes a block from the refcount btree.
> 
> This is tricky -- the first transaction in the chain creates a BUI and a
> CUI and that's all it needs.
> 
> Then we roll to finish the BUI.  The second transaction needs space for
> the BUD, an RUI, and enough space to relog the CUI (== CUI + CUD).
> 
> Then we roll again to finish the RUI.  This third transaction needs
> space for the RUD and space to relog the CUI.
> 
> Roll again, fourth transaction needs space for the CUD and possibly a
> new EFI.
> 
> Roll again, fifth transaction needs space for an EFD.

Yes, that is exactly the point I was making.

> > > +
> > > +	/* atomic write limits are always a power-of-2 */
> > > +	return rounddown_pow_of_two(logres / (2 * atomic_logitems));
> > 
> > What is the magic 2 in that division?
> 
> That's handwaving the lack of a computation involving
> xfs_allocfree_block_count.  A better version would be to figure out the
> log space needed:
> 
> 	/* Overhead to finish one step of each intent item type */
> 	const unsigned int	f1 = libxfs_calc_finish_efi_reservation(mp, 1);
> 	const unsigned int	f2 = libxfs_calc_finish_rui_reservation(mp, 1);

Yup, those should be a single call to xfs_calc_buf_res(xfs_allocfree_block_count())

> 	const unsigned int	f3 = libxfs_calc_finish_cui_reservation(mp, 1);

Similarly, xfs_calc_refcountbt_reservation().

> 	const unsigned int	f4 = libxfs_calc_finish_bui_reservation(mp, 1);

xfs_calc_write_reservation() but for a single extent instead of 2.
Also, I think the bui finish needs to take into account dquots, too.

> 	/* We only finish one item per transaction in a chain */
> 	const unsigned int	step_size = max(f4, max3(f1, f2, f3));

And that is xfs_calc_itruncate_reservation(), except it reserves
space for 1 extent to be processed instead of 4.

FWIW, I'd suggest that these helpers make for a better way of
calculating high level reservations such as
xfs_calc_write_reservation() and xfs_calc_itruncate_reservation()
because those functions currently don't take into account how
intents are relogged during those operations.

> and then you have what you need to figure out the logres needed to
> support a given awu_max, or vice versa:
> 
> 	if (desired_max) {
> 		dbprintf(
>  "desired_max: %u\nstep_size: %u\nper_intent: %u\nlogres: %u\n",
> 				desired_max, step_size, per_intent,
> 				(desired_max * per_intent) + step_size);
> 	} else if (logres) {
> 		dbprintf(
>  "logres: %u\nstep_size: %u\nper_intent: %u\nmax_awu: %u\n",
> 				logres, step_size, per_intent,
> 				logres >= step_size ? (logres - step_size) / per_intent : 0);
> 	}
> 
> I hacked this into xfs_db so that I could compute a variety of
> scenarios.  Let's pretend I have a 10T filesystem with 4k fsblocks and
> the default configuration.
> 
> # xfs_db /dev/mapper/moo -c logres -c "untorn_max -b $(( (16 * 1048576) / 4096 ))" -c "untorn_max -l 244216"
> type 0 logres 244216 logcount 5 flags 0x4
> type 1 logres 428928 logcount 5 flags 0x4
> <snip>
> minlogsize logres 648576 logcount 8
> 
> To emulate a 16MB untorn write, you'd need a logres of:
> 
> desired_max: 4096
> step_size: 107520
> per_intent: 208
> logres: 959488
>
> 959488 > 648576, which would alter the minlogsize calculation.  I know
> we banned tiny filesystems a few years ago, but there's still a risk in
> increasing it.

Yeah, it's a bit under a megabyte of reservation space. That's no
big deal, as log reservations get much larger than this as block
size and log stripe units are increased.

<snip the rest, they all show roughly the same thing>

Ok, these numbers pretty much prove my point - that a fixed max
atomic write size somewhere around 16MB isn't going to be a problem
for any filesystem that uses the historic small fs default log size
(10MB) or larger.

Let's avoid the internal XFS minlogsize problems by disabling the
atomic write functionality on the increasingly rare legacy
filesystems where the log is too small. That allows us to design and
implement sane userspace API bounds and guarantees for atomic writes
and not expose internal filesystem constraints and inconsistencies
to applications...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

