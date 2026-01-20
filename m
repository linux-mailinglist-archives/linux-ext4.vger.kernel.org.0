Return-Path: <linux-ext4+bounces-13106-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UK/7MeCBcWk1IAAAu9opvQ
	(envelope-from <linux-ext4+bounces-13106-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Jan 2026 02:48:16 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E95F607F0
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Jan 2026 02:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03CA482ABAA
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Jan 2026 11:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B2742669D;
	Tue, 20 Jan 2026 11:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwp4EibF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jlhb9xlL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFA8423A95
	for <linux-ext4@vger.kernel.org>; Tue, 20 Jan 2026 11:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768909469; cv=none; b=BsXvZBe2uhJypCodhKHCPHDR2P+AKFRpY6F+VDFE6SUkrgQHRloKNLDG3QrVq8ZPOSlBcnyGIITvf/LWGWQ18vJskwycJA84e+azxn+KanIXMIPcMW9pGzIP37Ay0VMrDFjUvrsmfDrAGwW4B0ETyCzKr2PO0LpsDhaMhht1uz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768909469; c=relaxed/simple;
	bh=TiiXYzQUqQAZpwrQs2Qyyc4v41VwLgKHuTM7jdyKi+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWUJRFfmhQF5y69qwENFf+JKul7r0i8IHH5mYWCCIrsowRYJ8Fgn/OuiyOzm8wmzpw1RIUzBUguF7o8pY9r1ZAoJCW+It+FV3Og7/NlyfZQPdxo24Do78CqLVDQyoa9tZWL4NJ/VBxM/9Xp/vwbiivlzYqmaex2pE/dNtz+xsC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cwp4EibF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jlhb9xlL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768909465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VXQVvpxNNsGjingzXc9wZFJEzzxIAdMJuzmc45mqLJ4=;
	b=cwp4EibFpIhVFhzbxPVz4wAndQQTXAzWNdvuDGrrzbZby5HXEyNUM1MHQvqqA6zeR88FY+
	QaY6eYQzCkcLdjTO0FKMpGHjsnr0MHDwjSkp/UP9J6Hf+s0UuW7SmTwstDWU5iB39Rwk2q
	2Ue37G3TWqInRLCEC0uSsJf6q6aKe84=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-qkku2yMrPkqcla-7NQwyAA-1; Tue, 20 Jan 2026 06:44:22 -0500
X-MC-Unique: qkku2yMrPkqcla-7NQwyAA-1
X-Mimecast-MFC-AGG-ID: qkku2yMrPkqcla-7NQwyAA_1768909462
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47ee71f0244so48349545e9.0
        for <linux-ext4@vger.kernel.org>; Tue, 20 Jan 2026 03:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768909462; x=1769514262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VXQVvpxNNsGjingzXc9wZFJEzzxIAdMJuzmc45mqLJ4=;
        b=Jlhb9xlLSsTj8aJQQ7cCewi2PV+zlb+TPM6H/HSJO9rSv3SNJ9zeUMEJhwLSsf17Oo
         hVavBbjxarROty7oHmlmdahE6Vpf+IgFmoKqD43GFNBqZBWZEt3jzrtYBQVyr/i0+oRF
         YD56el9nyAb8+5nukkqpRXaw+t1VgiEytE7kKVnpgZjwr3PPRb/IBejOX4xXNILTISVP
         AM/mMtF/J9MP9Bx4fwFhe7idzyX3Sg67l+5DTQfDzI8XsaQ0q9LOITgZanoU7MR0CiQ2
         t4cmfmAvg9PTXZsSKM4H0yQ02CeiFYmxY9GUbvY+C4RBuoXgwMX0H008aKaSVhyW51Ez
         5NHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768909462; x=1769514262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXQVvpxNNsGjingzXc9wZFJEzzxIAdMJuzmc45mqLJ4=;
        b=h7aLHG+WkJrn4fKCxY8ASc30QaLL1Zi73TOAOR1qcb8V7N1SADt6vwtO8GeLPffLqw
         838KBPG/ludwsdMfemXrW6IsdsyE1XiF93APKeHwe86f8o+4Do/FZNNUQ1V138Ug6n5u
         tXR/lUbcdYLYNlvmE1fKS5WfPfQWjaSxr51hkVtT24Nwqz4mtFHNNTG8ZK6HlrpfE+NG
         DunmAqlD2/RBlTuG2+6J0N1ajMV5/QcRzIG+t14K30dAz4SBdgF76rLk+Qql9KpJA9MN
         BzdxkZ0BQt8KEUEXjutwExwuEXlMhqFY+oq9XJ4/Up3kN76kpXzc5TFYGlNkgP09CQv3
         bGGg==
X-Forwarded-Encrypted: i=1; AJvYcCUKgcoC5P9eDAbQzZajEhwgQ9HRLnaHvwGfjT1O8MLH/p0FELSPGPQFyDSUOQbz2I3iZ4nIsVv1tLJN@vger.kernel.org
X-Gm-Message-State: AOJu0YzH4VcfY9WRzKH+YUJgDV1JrwvJjQGyUsLPclG5WWSfaOO6rXVc
	gToIOriInnAOyDiWFMJbQ/FLV9tOWmT/qogZkYSLVwjlWWTGGX3QhjLvWyNcAsKeleWN4fwDXiv
	y6W8t+sBSXu6SVNjwunovy+nLY3lSoCCxq2gea0waiW8J55874EtW1xtNtRZ81A==
X-Gm-Gg: AY/fxX5TCZ8cHGNlJdhwgTQuuK+hFKgYdVzZfKCynFPM40djwsz0FEmgS1ufMT3EIhE
	oId9YserN4zFKV/36ZDCFtXvhtulKMRvoUdEUZXMof294gO+1y4iP9jzxTIzVTkt2Aj54jH+MA6
	C6T0VNbdeq6Yh8YJMiUnSKCPu7mqaVxaFU8uq0xpdbCW1I0RxPmdvYhD314aENiGMiTZvWicZEF
	+8Sd2LAQrOzNJ9d3l0hFnOrJDpDt1CFL7eZelXxSRmyzOQyHNODlTuKqQFqiuU66KEnT9559mYU
	/oMnlADWwupczyNZbpsccIScFJGFsurHQlK1lSo8fmd+R6tDZmGL5R31WqgRUwPXfe98KRp4ne0
	=
X-Received: by 2002:a05:600c:4448:b0:47e:e20e:bbb4 with SMTP id 5b1f17b1804b1-4801e345c8amr179356725e9.26.1768909461647;
        Tue, 20 Jan 2026 03:44:21 -0800 (PST)
X-Received: by 2002:a05:600c:4448:b0:47e:e20e:bbb4 with SMTP id 5b1f17b1804b1-4801e345c8amr179356335e9.26.1768909461124;
        Tue, 20 Jan 2026 03:44:21 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f42907141sm300491595e9.9.2026.01.20.03.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 03:44:20 -0800 (PST)
Date: Tue, 20 Jan 2026 12:44:19 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>, Matthew Wilcox <willy@infradead.org>, fsverity@lists.linux.dev, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, aalbersh@kernel.org, 
	david@fromorbit.com, tytso@mit.edu, linux-ext4@vger.kernel.org, jaegeuk@kernel.org, 
	chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: fsverity metadata offset, was: Re: [PATCH v2 0/23] fs-verity
 support for XFS with post EOF merkle tree
Message-ID: <5tse47xskuaofuworccgwhyftyymx5xj3mc6opwz7nfxa225u6@uvbk4gc2rktd>
References: <aWZ0nJNVTnyuFTmM@casper.infradead.org>
 <op5poqkjoachiv2qfwizunoeg7h6w5x2rxdvbs4vhryr3aywbt@cul2yevayijl>
 <aWci_1Uu5XndYNkG@casper.infradead.org>
 <20260114061536.GG15551@frogsfrogsfrogs>
 <5z5r6jizgxqz5axvzwbdmtkadehgdf7semqy2oxsfytmzzu6ik@zfvhexcp3fz2>
 <6r24wj3o3gctl3vz4n3tdrfjx5ftkybdjmmye2hejdcdl6qseh@c2yvpd5d4ocf>
 <20260119063349.GA643@lst.de>
 <20260119193242.GB13800@sol>
 <20260119195816.GA15583@frogsfrogsfrogs>
 <20260120073218.GA6757@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120073218.GA6757@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	DATE_IN_PAST(1.00)[38];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13106-lists,linux-ext4=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@redhat.com,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E95F607F0
X-Rspamd-Action: no action

On 2026-01-20 08:32:18, Christoph Hellwig wrote:
> On Mon, Jan 19, 2026 at 11:58:16AM -0800, Darrick J. Wong wrote:
> > > >  a) not all architectures are reasonable.  As Darrick pointed out
> > > >     hexagon seems to support page size up to 1MiB.  While I don't know
> > > >     if they exist in real life, powerpc supports up to 256kiB pages,
> > > >     and I know they are used for real in various embedded settings
> > 
> > They *did* way back in the day, I worked with some seekrit PPC440s early
> > in my career.  I don't know that any of them still exist, but the code
> > is still there...
> 
> Sorry, I meant I don't really know how real the hexagon large page
> sizes are.  I know about the ppcs one personally, too.
> 
> > > If we do need to fix this, there are a couple things we could consider
> > > doing without changing the on-disk format in ext4 or f2fs: putting the
> > > data in the page cache at a different offset than it exists on-disk, or
> > > using "small" pages for EOF specifically.
> > 
> > I'd leave the ondisk offset as-is, but change the pagecache offset to
> > roundup(i_size_read(), mapping_max_folio_size_supported()) just to keep
> > file data and fsverity metadata completely separate.
> 
> Can we find a way to do that in common code and make ext4 and f2fs do
> the same?

hmm I don't see what else we could do except providing common offset
and then use it to map blocks

loff_t fsverity_metadata_offset(struct inode *inode)
{
	return roundup(i_size_read(), mapping_max_folio_size_supported());
}

-- 
- Andrey


