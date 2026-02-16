Return-Path: <linux-ext4+bounces-13702-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ED9JCPYXk2nD1QEAu9opvQ
	(envelope-from <linux-ext4+bounces-13702-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Feb 2026 14:13:26 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8A0143B91
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Feb 2026 14:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E9A030028DF
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Feb 2026 13:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B419E2F0C79;
	Mon, 16 Feb 2026 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S721I7Z9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWf8iQ0A"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29594225A3B
	for <linux-ext4@vger.kernel.org>; Mon, 16 Feb 2026 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771247598; cv=none; b=oftgFtngg5F339ocDyYzXEWshudMdZSMI/OSO2t9tqvYn7tfCwiEa1Dyuf1PrCApDvBzBrqsqKHLGv3rTy9JX/EBjljs+pZ+iNJjNUvmXdSS1X+v0mFlAsRdWZp3CJ4k9whrxte/QwtHAmcYjdQIgB+cetBdV9EeD+DFrDvrpQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771247598; c=relaxed/simple;
	bh=aZkJ2LC+4l1Mgl8JJsgnBU2eDftSKQyjyB4W5fPxgj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeKCNtx0vabji9n/F7huLDEfEnlgZZVBnReMvAuIJMCeqUuiDS8DwgQqqRLnzbuAFdw6GaXrLYI2thURHXsfQcE9xNNEq/hWHSW4Gfw5bjRPQ8HVN2LxlBmeoH0t/zlbktkfJ1j/lLTkDu3+i0fJ/HBxsaGGY3j+S+iWy15mjT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S721I7Z9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BWf8iQ0A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771247596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eLHZr6BMZ2SnRfi1VuJNibTfFH2915IfXyQtxJbNFRI=;
	b=S721I7Z95QJkm5ZoSN11pfxB986ErA7RJkR3gVGgDKKwmZ4I3DbLJshEJ8N5u2lv9DsnEK
	1uNZw5ODDMySJgDUCDicjm14cXJdetQtq0sjFDGnW2vBzCIxMKVp9dQQt3qS/c4GFEZRx2
	l8NEvTrpX5I2Gkv/+fB2YOfS9iIKLok=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-Lzxvl_k6PO6znfTjns5HZw-1; Mon, 16 Feb 2026 08:13:15 -0500
X-MC-Unique: Lzxvl_k6PO6znfTjns5HZw-1
X-Mimecast-MFC-AGG-ID: Lzxvl_k6PO6znfTjns5HZw_1771247594
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35845fcf0f5so2219545a91.0
        for <linux-ext4@vger.kernel.org>; Mon, 16 Feb 2026 05:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771247593; x=1771852393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eLHZr6BMZ2SnRfi1VuJNibTfFH2915IfXyQtxJbNFRI=;
        b=BWf8iQ0AUM/hISVUYYhq5MRqvtxkrijT9r9y8YrO9YzKrUatKNZZpYOeDi/h4lyXW4
         zzdUCt3zBkk+dhMvlhZmgEhRPZoiztNAgYKEBB93e4csNgVtgJbA2I93Q23OfvLUwdh1
         fImttlJTVJw9nhOrutMnRTJxdsm64ovuTn6XxWazNAol7JnQZuWC+HwzTiVY8uckPg+O
         AWwlsykSXKpMPtKjCBRWZrexgUk1J7auVe934z3a80AFdf88vTEB3mel/Z+fo57uXsfl
         4U6gaMJRG4AxMVJCwJs7v2qNP5Gbzoc0iKtJFitZE/1IyeFnb90nREEXaOlxrIsODyuz
         NwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771247593; x=1771852393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLHZr6BMZ2SnRfi1VuJNibTfFH2915IfXyQtxJbNFRI=;
        b=CYHZNs150YhH0J408kzVZb92ZOuh4ZbwCGHw2SVlU8aYw7MiwsUseO6+BbbTR2u8W9
         nh65Wo/rcbOw16HjgIg4XYnXjd8ZqiGVf1vtM61sU+lN7Q0YO4o0eR2WEZojoNPKI+qN
         U8ILL+W312Th8jf8x1sR+dNHOLw+fwl2EGH7p+gyUti9wL5UK7wSgmazUvLscrPOC8Br
         tqF5c5MMA2DPaopIPboydLyp16xvo/MHQU/BwroAl2GcKtlq/rcYp6DM8sjVco2RMabQ
         unJO259ARrvaSa79uPJWBHmN1PtfkzmQGivxD0uR+StAkYY2bwQdQXU2VhPutyuCer3R
         UHAA==
X-Forwarded-Encrypted: i=1; AJvYcCVHjQ/kFmZHb3S6tw2JppltzN7sU0vVseCNgb42rGPTaVNB0XZTRDatPz12nyrJNBPYTQiT+fLzuCQ6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1HQgiPaHa/yJoJtAsmKUYDR9qEBcMfrFcLCtYtT6OwL55MWBz
	xUo52HthN6HtlMKCgCY2BvZ8F1dY+rdblCNR77OqMM/O03/foY0Qkj51lIHaUd9Qc1eQSemhY52
	2Iwt+Gw+RmD/8d5O9t5rw8WeckB++bsFVfyoIVJAkOmtFxuTCCN2liMCasm1KjvN3W/ccsa8=
X-Gm-Gg: AZuq6aLhXM4o9XKUzhcMzxTml+M4RwS6w7IsKpypykW8d1+4kwCzC+JhXw58MSLr65v
	3tEd7JGkPca+5SglZW4yCpnngPQKgrj5/OcT7/e2RX2Say35Yd9rciX+cUF6e7H4+QNfqLKpCaD
	pNsq4gEys6fHHANmTFDE+tsw7kwvrWpPJQImLaKUetn8MPg0URknyLd0GPRgQ9WXnC9RavqrP6l
	Cn/CbAHk/azR4ef2KtRqP0dsHo0kOk9u1ih59zNVdJCLttYnqQfAwEjAJK92meARFjPylq6xnMo
	L6XI2ts4FtROCKKOlFgmwfZgSlAlv37hkQsMyt7ZzKRYAqSwI71tXFh10OcmNwlrdu1oOnzZrQz
	MD1SSVBcaRWQO3mel2jdmJdi7fMsY1mCI2LcxuAfygOdNTvNkH/LdabVRDVaXgQ==
X-Received: by 2002:a17:90a:dfc8:b0:352:d0cf:9d18 with SMTP id 98e67ed59e1d1-357b50c0548mr6718922a91.5.1771247593522;
        Mon, 16 Feb 2026 05:13:13 -0800 (PST)
X-Received: by 2002:a17:90a:dfc8:b0:352:d0cf:9d18 with SMTP id 98e67ed59e1d1-357b50c0548mr6718904a91.5.1771247593047;
        Mon, 16 Feb 2026 05:13:13 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3567eba92e2sm16065290a91.12.2026.02.16.05.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 05:13:12 -0800 (PST)
Date: Mon, 16 Feb 2026 21:13:08 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 0/4] Avoid failing shutdown tests without a journal
Message-ID: <20260216131308.atxnkqehyke4conu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20260210111707.17132-1-jack@suse.cz>
 <20260212084050.uim52ck6zhffd5kl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <zh372qbq2tq722476eaqrirmi55hxwzfs6msmzxfj6zv3jws5y@rdip5a6twsf6>
 <20260212164402.tbjcalfmeq6jfwum@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <bgtrbxzrwih2j2bgoanwf5sgl4go5xy6fxnvknkgnugqtkl5pt@iy6bcuqrx5ku>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bgtrbxzrwih2j2bgoanwf5sgl4go5xy6fxnvknkgnugqtkl5pt@iy6bcuqrx5ku>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13702-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zlang@redhat.com,linux-ext4@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dell-per750-06-vm-08.rhts.eng.pek2.redhat.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C8A0143B91
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 09:56:07AM +0100, Jan Kara wrote:
> On Fri 13-02-26 00:44:02, Zorro Lang wrote:
> > On Thu, Feb 12, 2026 at 11:41:59AM +0100, Jan Kara wrote:
> > > > I initially considered calling _require_metadata_journaling directly inside
> > > > _require_scratch_shutdown. However, I decided against it because some cases might
> > > > only need the shutdown ioctl and don't strictly require a journal.
> > > 
> > > Absolutely. I think they should stay separate.
> > > 
> > > So to summarize I think we should still add _require_metadata_journaling to:
> > > 
> > > overlay/087
> > > g/536
> > > g/622
> > > g/722
> > 
> > Agree :)
> 
> Should I send patches or will you do this modification?

As you brought this issue up, so I'd like to leave the finish line to you :)
I saw your 4 patches nearly use same subject and commit log too. If you fix more 4 cases,
we'll have 8 seperated patches :-D So how about squashing all changes into one single
patch? Does that make sense to you?

Thanks,
Zorro

> 
> > > and we might add fsync of parent directory before shutdown to g/737 and
> > > overlay/078. Does this sound good?
> > 
> > I'm concerned that adding broader sync or fsync operations might interfere with the
> > test's original intent. We should probably evaluate the impact further. Alternatively,
> > we could simply use _require_metadata_journaling to ensure we at least keep the
> > coverage for the original bug :)
> 
> I agree with the approach to just leave the test as is for now and invest time
> into deciding what's the proper solution once someone complains :)
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 


