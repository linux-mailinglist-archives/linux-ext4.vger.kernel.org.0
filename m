Return-Path: <linux-ext4+bounces-11526-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5632C3A30C
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 11:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9C711A459A6
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 10:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF02230F533;
	Thu,  6 Nov 2025 10:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EWJw7Utr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1CD221FA4
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 10:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423477; cv=none; b=CRTeXbYX+pWeP+K2CHguObq8TOILXB9Bu8nHNndbAzCsyKZeweBwBDgEQFsP+FPg349m79x4q+s3UZq8aHJml+92ydrHsVHS/44hkOp+051kljAJ8EuWveeZaRnpZjH+XlWxLOeF6pFj1HaIcKxDA+Uj5Ik1prsFeQ0brql4WZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423477; c=relaxed/simple;
	bh=vT6p2Ft83AUVQpnKCW7qD9vJskfIVgaA8WibD4YKicI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1SFsLxb9c5DqqGYx4ROZUTdOlj/vTB103nFMqAaLWuCPTKBTt9DoZM7cYkuhs215Kppp07Nf3CALvxvhs5Q0scmEXXwrm/AfYaX3fcaiSoPxZX3ORNN7voaunHMSfVHBcLwUIJFfGL8J+bovfshmSW5TdV0rL4+ZWEjOHqVxjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EWJw7Utr; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-421851bcb25so397069f8f.2
        for <linux-ext4@vger.kernel.org>; Thu, 06 Nov 2025 02:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762423474; x=1763028274; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9pzqQqc6IcRolbDep+B7yNbdFvNbgM81NTbfjuCoPvY=;
        b=EWJw7Utr7kFd1f8ZUvIiWqRkqtKpp52g+YmchQCC4S05k6Cd7cFYbI+ad6Z/wgp0vc
         l3t3z4j+yGbb0fk4sgWWdegtBJxI7obj6qrPaE6kNk8wzESqc6MD/iCcSb/mmGOXArGL
         mhkhgr1QN2TVly2laj9kolEjdnI0pFcssp/wBrHarXmhYgzioJfGI39iU6o3sTh0K5Ca
         qLC4ZWZb4HKr+Vjy5a+nNMWqiCWm9OZxnLVoca1XNJZBF02yK7jlDllo8dxNSvUoOVbQ
         rwmSQewTkbu/RagiSfsR/QUNYV97HrT5pqew0iD3rNbxZ+rLSmGbbTzi/FimbAeDctQw
         y8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762423474; x=1763028274;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9pzqQqc6IcRolbDep+B7yNbdFvNbgM81NTbfjuCoPvY=;
        b=oDfKDCoQ4DzHZOAzByFsm8r213aEerc/LOSKqBsWdt9uDmIJDDs+8J9W5f5m311zkn
         f8EEPtiuPnzv2rG1EnbdPHW/TPqBWqXOetvp6c6vOts5ybT5EvB12AFZd/oPFe3Gn8+j
         Ipi2spUvH8J8cZkU3vQ5MOffiVK+pOp0dU9pgMshWrcgho7dPXZeoW2pRwW1RV5UCGXL
         Lgpc4jMLjnjF36ZOpzYqIgDqOcXfaUYYVmzILqie6l2kRNY9Pxq6xYtA50/BUujrn1JJ
         KNfeqAlZ1MthY8Fe6Ybgj8mxQTAS1K0dH4dNhFqC+eIwfJtBzq5nCCpt6uMer7lkuHhp
         MjSA==
X-Forwarded-Encrypted: i=1; AJvYcCV+hYK9uawszdLSHnxJoKpPDgEl+fXgJuDCHdBI8HqYmvbpVmI2v/JqFz7uiWVMFH21C2UdMBJl47fM@vger.kernel.org
X-Gm-Message-State: AOJu0YysO3s5fbZJk5J1c+0pSq3Do/o2pm1oageGAq29zJCSl9PBdlnW
	uqA4zH0jEjx8qzKKZHeFBG9LHHhZowrqWEhaWojo9WL66MDpxXUhV/tzdfFsf1lJNkM5SdiqXTn
	0A+RHbTq2L8+d+Ifp0o0OitiEk00sagRBAmif17UhqA==
X-Gm-Gg: ASbGncvLVXeWUp76bcgvdSyhpoucpo38oIN6ZrpfJuAKrax9/IdfP9uR3vzd7eH+Xg+
	+MQJ/8P422N84GZ7TpuPb/qGMyQLgOsy/pGD9l9Zwe/yf6H28lQKkkydvszaa0UOkgVPEZXaEuV
	gTrONFnV48oX+R9H4SpO6pFKhG9eonvjwSOsEBb0ktvFqkkl0AEiswrCyKT5Au7f/TJM790KHpz
	pPJ3pQv357ENCqoQmY9WTY5pr3768ahiDPC3DGZysxy9EFPdJxk+kkX2ATXv5p1D57pf+tpQRGO
	65prY/py1LgTTJzwwh2Er0fOCtTrC6QlP5k50PiLMCPVlG2sF4xWvd0VdA==
X-Google-Smtp-Source: AGHT+IF9F1VA3FkhFo+HExPWDHAEgrgxeGGJA7rdOjuOxk6TFCz8t+ouX+7Zbvmcn9f9578SldeY9TT64Kn6ISeqc/8=
X-Received: by 2002:a05:6000:2386:b0:429:d3a7:18bd with SMTP id
 ffacd0b85a97d-429e334019cmr5012608f8f.59.1762423473555; Thu, 06 Nov 2025
 02:04:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
 <20251104-work-guards-v1-5-5108ac78a171@kernel.org> <CAPjX3FeEZd7gX1OeCxRXrdBMafHOONB2WQO_JOZuxKoVEygzuQ@mail.gmail.com>
 <5puaizn2a4dpoinvkct2nz5zdvvv5vdrlrmwcz7j6vl7qrxicb@b4qi4yfk4a5u>
In-Reply-To: <5puaizn2a4dpoinvkct2nz5zdvvv5vdrlrmwcz7j6vl7qrxicb@b4qi4yfk4a5u>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 6 Nov 2025 11:04:22 +0100
X-Gm-Features: AWmQ_bl_uakVnhsIAEGayoqj-TUUrVul9249azhsCYCCICpGbdkLg5N_W05IYjE
Message-ID: <CAPjX3FdKdV5ouW3Vjx1jMO8Ye_21x5CDtpOn+BBD_tou1gPkSg@mail.gmail.com>
Subject: Re: [PATCH RFC 5/8] ext4: use super write guard in write_mmp_block()
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Nov 2025 at 10:24, Jan Kara <jack@suse.cz> wrote:
>
> On Wed 05-11-25 19:33:35, Daniel Vacek wrote:
> > On Tue, 4 Nov 2025 at 13:16, Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > ---
> > >  fs/ext4/mmp.c | 8 ++------
> > >  1 file changed, 2 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
> > > index ab1ff51302fb..6f57c181ff77 100644
> > > --- a/fs/ext4/mmp.c
> > > +++ b/fs/ext4/mmp.c
> > > @@ -57,16 +57,12 @@ static int write_mmp_block_thawed(struct super_block *sb,
> > >
> > >  static int write_mmp_block(struct super_block *sb, struct buffer_head *bh)
> > >  {
> > > -       int err;
> > > -
> > >         /*
> > >          * We protect against freezing so that we don't create dirty buffers
> > >          * on frozen filesystem.
> > >          */
> > > -       sb_start_write(sb);
> > > -       err = write_mmp_block_thawed(sb, bh);
> > > -       sb_end_write(sb);
> > > -       return err;
> > > +       scoped_guard(super_write, sb)
> > > +               return write_mmp_block_thawed(sb, bh);
> >
> > Why the scoped_guard here? Should the simple guard(super_write)(sb) be
> > just as fine here?
>
> Not sure about Ted but I prefer scoped_guard() to plain guard() because the
> scoping makes it more visually obvious where the unlocking happens. Of
> course there has to be a balance as the indentation level can go through
> the roof but that's not the case here...

In a general case I completely agree. Though here you can see the end
of the block right on the next line so it looks quite obvious to me
how far the guarded region spans.

But the question is whether to use the guards at all. To me it's a
huge change in reading and understanding the code as more things are
implied and not explicit. Such implied things result in additional
cognitive load. I guess we can handle it eventually. Yet we can fail
from time to time and it is likely we will, at least in the beginning.

Well, my point is this is a new style we're not used to, yet. It just
takes time to adapt. (And usually a few failures to do so.)

--nX

>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

