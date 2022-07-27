Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BE5582A16
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Jul 2022 17:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbiG0P62 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Jul 2022 11:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbiG0P62 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Jul 2022 11:58:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB6D4A812
        for <linux-ext4@vger.kernel.org>; Wed, 27 Jul 2022 08:58:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3A34B8219D
        for <linux-ext4@vger.kernel.org>; Wed, 27 Jul 2022 15:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E63CC433D6;
        Wed, 27 Jul 2022 15:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658937504;
        bh=TGMXihPYIlsoB5rB+YsL3zh8S0h2ZaLigKNAgTeO0PQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mpp/gvvP7Y7Ln8+m1fz7/LBWYoHHqI1O0zJJwX+w7ZzT+fvI7hHH3twWsuRrrPO7a
         1VduGwpSVD10xeZGRSkX2JLsDBPwlS2A0x1L7ec7qOjctaHuTFcdoXVduN0gmCnTmJ
         TX6UNUcbcxGr/LLt4S7ADdhWj188pb/6HkyMwZbcWjfTXdurIRSiDTwCjPNYEd0Vre
         LsIa2n83EzZqbzMUk6z4v7wWDckDeYFVs+9EJk4cqwBNDaMpIwFRIQzMrLqP2Tmmd9
         z3nY2dJc0hK7GBHTRbISud5DIMYoB/SXIq6EQB7wkMcjFbtdFvveNXWJdtADRfUJuV
         JiT9xN/RBIMKw==
Message-ID: <262e94a64185df7cf9eb1d5c537095242a33b746.camel@kernel.org>
Subject: Re: [PATCH v2] ext4: unconditionally enable the i_version counter
From:   Jeff Layton <jlayton@kernel.org>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Date:   Wed, 27 Jul 2022 11:58:22 -0400
In-Reply-To: <ED900EEF-31D1-4A14-A97C-02D3120ABC2A@redhat.com>
References: <20220727143734.71612-1-jlayton@kernel.org>
         <ED900EEF-31D1-4A14-A97C-02D3120ABC2A@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 2022-07-27 at 11:48 -0400, Benjamin Coddington wrote:
> On 27 Jul 2022, at 10:37, Jeff Layton wrote:
>=20
> > The original i_version implementation was pretty expensive, requiring=
=20
> > a
> > log flush on every change. Because of this, it was gated behind a=20
> > mount
> > option (implemented via the MS_I_VERSION mountoption flag).
> >=20
> > Commit ae5e165d855d (fs: new API for handling inode->i_version) made=
=20
> > the
> > i_version flag much less expensive, so there is no longer a=20
> > performance
> > penalty from enabling it. xfs and btrfs already enable it
> > unconditionally when the on-disk format can support it.
> >=20
> > Have ext4 ignore the SB_I_VERSION flag, and just enable it
> > unconditionally. While we're in here, remove the handling of
> > Opt_i_version as well, since we're almost to 5.20 anyway.
> >=20
> > Ideally, we'd couple this change with a way to disable the i_version
> > counter (just in case), but the way the iversion mount option was
> > implemented makes that difficult to do. We'd need to add a new mount
> > option altogether or do something with tune2fs. That's probably best
> > left to later patches if it turns out to be needed.
> >=20
> > Cc: Dave Chinner <david@fromorbit.com>
> > Cc: Lukas Czerner <lczerner@redhat.com>
> > Cc: Benjamin Coddington <bcodding@redhat.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Darrick J. Wong <djwong@kernel.org>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/ext4/inode.c |  5 ++---
> >  fs/ext4/super.c | 13 ++++---------
> >  2 files changed, 6 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 84c0eb55071d..c785c0b72116 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -5411,7 +5411,7 @@ int ext4_setattr(struct user_namespace=20
> > *mnt_userns, struct dentry *dentry,
> >  			return -EINVAL;
> >  		}
> >=20
> > -		if (IS_I_VERSION(inode) && attr->ia_size !=3D inode->i_size)
> > +		if (attr->ia_size !=3D inode->i_size)
> >  			inode_inc_iversion(inode);
> >=20
> >  		if (shrink) {
> > @@ -5717,8 +5717,7 @@ int ext4_mark_iloc_dirty(handle_t *handle,
> >  	}
> >  	ext4_fc_track_inode(handle, inode);
> >=20
> > -	if (IS_I_VERSION(inode))
> > -		inode_inc_iversion(inode);
> > +	inode_inc_iversion(inode);
> >=20
> >  	/* the do_update_inode consumes one bh->b_count */
> >  	get_bh(iloc->bh);
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 845f2f8aee5f..4b06f394d7d1 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -1585,7 +1585,7 @@ enum {
> >  	Opt_inlinecrypt,
> >  	Opt_usrjquota, Opt_grpjquota, Opt_quota,
> >  	Opt_noquota, Opt_barrier, Opt_nobarrier, Opt_err,
> > -	Opt_usrquota, Opt_grpquota, Opt_prjquota, Opt_i_version,
> > +	Opt_usrquota, Opt_grpquota, Opt_prjquota,
> >  	Opt_dax, Opt_dax_always, Opt_dax_inode, Opt_dax_never,
> >  	Opt_stripe, Opt_delalloc, Opt_nodelalloc, Opt_warn_on_error,
> >  	Opt_nowarn_on_error, Opt_mblk_io_submit, Opt_debug_want_extra_isize,
> > @@ -1694,7 +1694,6 @@ static const struct fs_parameter_spec=20
> > ext4_param_specs[] =3D {
> >  	fsparam_flag	("barrier",		Opt_barrier),
> >  	fsparam_u32	("barrier",		Opt_barrier),
> >  	fsparam_flag	("nobarrier",		Opt_nobarrier),
> > -	fsparam_flag	("i_version",		Opt_i_version),
>=20
> We've got to keep the parameter, I think, else we'll break existing=20
> setups
> with the i_version mount option.
>=20

It had already been announced that the above mount option would be
removed by v5.20 (which Darrick pointed out). We might as well drop it
here since this likely wouldn't be merged before then anyway.

The "iversion" mount option is parsed in the userland mount program, and
gets turned into MS_I_VERSION flag for the mount syscall. That will
still be done, though with this change, the kernel should now just
ignore it.
--=20
Jeff Layton <jlayton@kernel.org>
