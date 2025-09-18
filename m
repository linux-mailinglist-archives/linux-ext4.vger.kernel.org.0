Return-Path: <linux-ext4+bounces-10240-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62A8B8621C
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Sep 2025 18:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152363B23B1
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Sep 2025 16:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82459254AE7;
	Thu, 18 Sep 2025 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdWOxbk/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1254625393E;
	Thu, 18 Sep 2025 16:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758214534; cv=none; b=fFmRbkr4EH+ZfAHAnWQiSnWOTFgtC4+SUEh9YbPtREdykQaUZNPeHg48zW8PTdcY0fK9rgW96Kcx0DoweRSvqVLqMD/h6qmFhuxi4+CKCI/VY4i/cv7mZjxtDWjS5/Hy8ZpXovwXUyOhr55k2qUI1mIpLd0oCBj/KehujdDEovg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758214534; c=relaxed/simple;
	bh=Kqk5ednRgzGPi+bgJWvscXP/ogWlX/IzlFxebU6bR/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlwfY40NEICn9a4azy4/G9CHCq9P7STypYe8SxeSCY9lmne2ZZfD33htuSEfOdOLfPn7n5EZUE9m8ojboakxPexLhGPY9pN2ZzH0JJagY6Ym6b3H2Q8T1vOG9h8WXbZuZu8nrK5bCXWJSpmvm7P4qbFcndwmivzDbdF6gepI5nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdWOxbk/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A97FC4CEE7;
	Thu, 18 Sep 2025 16:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758214533;
	bh=Kqk5ednRgzGPi+bgJWvscXP/ogWlX/IzlFxebU6bR/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UdWOxbk/g0caqNNOaItptsAiQC152ymoz6X9w1lll1IhaSPr9jPYGMTx9BE6b6mZM
	 XS4ZIMSgDZbU0L6WhvDm49eASwpaTuI16sdFiU5IQEJro5/Igq+AvNFifKq9P4MYla
	 7rQShCUlBuuXIFCKRQ1NIBhH4CmQ6BIGzGzeI1lppdPV9tKVw0ek/YI3WKCasoTKRI
	 YSb+DpFFO+s3s6W8SBwcdpWmNtb5TUBSluALwjkBog/GC5oCtRp5Yy1ReFVeas3bCa
	 Kv9jIjyVQ1UVGKUvvJN7HhJc0dLCxyArDB4ZUSbg3LOuBtyoifULYUr+B/ckHj8e4C
	 rjOcyaB3xcKjA==
Date: Thu, 18 Sep 2025 09:55:33 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: tytso@mit.edu, linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ext4: avoid potential buffer over-read in
 parse_apply_sb_mount_options()
Message-ID: <20250918165533.GF8084@frogsfrogsfrogs>
References: <20250916-tune2fs-v2-0-d594dc7486f0@mit.edu>
 <20250916-tune2fs-v2-1-d594dc7486f0@mit.edu>
 <ik565ztp7s7zyhiog6n52zxylybtkkael6opfrmtvtf6su34iw@zho5dlhfvibq>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ik565ztp7s7zyhiog6n52zxylybtkkael6opfrmtvtf6su34iw@zho5dlhfvibq>

On Wed, Sep 17, 2025 at 06:05:06PM +0200, Jan Kara wrote:
> On Tue 16-09-25 23:22:47, Theodore Ts'o via B4 Relay wrote:
> > From: Theodore Ts'o <tytso@mit.edu>
> > 
> > Unlike other strings in the ext4 superblock, we rely on tune2fs to
> > make sure s_mount_opts is NUL terminated.  Harden
> > parse_apply_sb_mount_options() by treating s_mount_opts as a potential
> > __nonstring.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 8b67f04ab9de ("ext4: Add mount options in superblock")
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> 
> Looks good. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Looks fine to me too,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> 
> 								Honza
> 
> > ---
> >  fs/ext4/super.c | 17 +++++------------
> >  1 file changed, 5 insertions(+), 12 deletions(-)
> > 
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 699c15db28a82f26809bf68533454a242596f0fd..94c98446c84f9a4614971d246ca7f001de610a8a 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -2460,7 +2460,7 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
> >  					struct ext4_fs_context *m_ctx)
> >  {
> >  	struct ext4_sb_info *sbi = EXT4_SB(sb);
> > -	char *s_mount_opts = NULL;
> > +	char s_mount_opts[65];
> >  	struct ext4_fs_context *s_ctx = NULL;
> >  	struct fs_context *fc = NULL;
> >  	int ret = -ENOMEM;
> > @@ -2468,15 +2468,11 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
> >  	if (!sbi->s_es->s_mount_opts[0])
> >  		return 0;
> >  
> > -	s_mount_opts = kstrndup(sbi->s_es->s_mount_opts,
> > -				sizeof(sbi->s_es->s_mount_opts),
> > -				GFP_KERNEL);
> > -	if (!s_mount_opts)
> > -		return ret;
> > +	strscpy_pad(s_mount_opts, sbi->s_es->s_mount_opts);
> >  
> >  	fc = kzalloc(sizeof(struct fs_context), GFP_KERNEL);
> >  	if (!fc)
> > -		goto out_free;
> > +		return -ENOMEM;
> >  
> >  	s_ctx = kzalloc(sizeof(struct ext4_fs_context), GFP_KERNEL);
> >  	if (!s_ctx)
> > @@ -2508,11 +2504,8 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
> >  	ret = 0;
> >  
> >  out_free:
> > -	if (fc) {
> > -		ext4_fc_free(fc);
> > -		kfree(fc);
> > -	}
> > -	kfree(s_mount_opts);
> > +	ext4_fc_free(fc);
> > +	kfree(fc);
> >  	return ret;
> >  }
> >  
> > 
> > -- 
> > 2.51.0
> > 
> > 
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

