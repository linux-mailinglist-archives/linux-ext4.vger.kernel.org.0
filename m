Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A975A46F8
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Aug 2022 12:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiH2KRN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Aug 2022 06:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiH2KQ7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 29 Aug 2022 06:16:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB6D19C27;
        Mon, 29 Aug 2022 03:16:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 783406112A;
        Mon, 29 Aug 2022 10:16:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0832C433C1;
        Mon, 29 Aug 2022 10:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661768204;
        bh=r7bALMY0//epGIR0RkuG3C7W5DcHDyqYRWik9DZ+1BY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YP/+dhl4n623ad/RBYgb7dx/hiQemJCyQ7BStCJfMKShWkyqKZlXo6ottHifSqLN8
         jnrWSNx795T3nPhtVCGZIMYMEOlOEN67VugB9PJPfFsx4e9bksIyhwplVkCCNAO+DU
         5c6AyyIBn8ftJpgyacXOY8mLtSlm6PZTJXFc4yQ9g7pTUO1hfFpCzGJq58wU4F+kC4
         KW21lCn3CQwPaH/9B8q1THnLqv2Txd4i3g2W9qjDlSduonqUgS1kYVPpcDt5Fhz9D4
         Z5abN+JZN6Lfb34jm5dOJ5ZCoMWDbHZpbOEGDQtqWG7aBUcqLN82NevWGg5tfFeJtN
         ny9ketF2G8pOA==
Message-ID: <597d4aba5fff540c55b67bbbcf619a795773292b.camel@kernel.org>
Subject: Re: [PATCH v4 3/3] ext4: unconditionally enable the i_version
 counter
From:   Jeff Layton <jlayton@kernel.org>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, ebiggers@kernel.org,
        david@fromorbit.com, Benjamin Coddington <bcodding@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Christian Brauner <brauner@kernel.org>
Date:   Mon, 29 Aug 2022 06:16:42 -0400
In-Reply-To: <20220829081743.2w4qi3j5o5m4qygi@fedora>
References: <20220824160349.39664-1-lczerner@redhat.com>
         <20220824160349.39664-3-lczerner@redhat.com>
         <e6c92d29cb399ba8cf3cf8b9a3cb532b1287a649.camel@kernel.org>
         <20220829081743.2w4qi3j5o5m4qygi@fedora>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 2022-08-29 at 10:17 +0200, Lukas Czerner wrote:
> On Fri, Aug 26, 2022 at 12:11:23PM -0400, Jeff Layton wrote:
> > On Wed, 2022-08-24 at 18:03 +0200, Lukas Czerner wrote:
> > > From: Jeff Layton <jlayton@kernel.org>
> > >=20
> > > The original i_version implementation was pretty expensive, requiring=
 a
> > > log flush on every change. Because of this, it was gated behind a mou=
nt
> > > option (implemented via the MS_I_VERSION mountoption flag).
> > >=20
> > > Commit ae5e165d855d (fs: new API for handling inode->i_version) made =
the
> > > i_version flag much less expensive, so there is no longer a performan=
ce
> > > penalty from enabling it. xfs and btrfs already enable it
> > > unconditionally when the on-disk format can support it.
> > >=20
> > > Have ext4 ignore the SB_I_VERSION flag, and just enable it
> > > unconditionally. While we're in here, remove the handling of
> > > Opt_i_version as well, since we're almost to 5.20 anyway.
> > >=20
> > > Ideally, we'd couple this change with a way to disable the i_version
> > > counter (just in case), but the way the iversion mount option was
> > > implemented makes that difficult to do. We'd need to add a new mount
> > > option altogether or do something with tune2fs. That's probably best
> > > left to later patches if it turns out to be needed.
> > >=20
> > > [ Removed leftover bits of i_version from ext4_apply_options() since =
it
> > > now can't ever be set in ctx->mask_s_flags -- lczerner ]
> > >=20
> > > Cc: Dave Chinner <david@fromorbit.com>
> > > Cc: Benjamin Coddington <bcodding@redhat.com>
> > > Cc: Christoph Hellwig <hch@infradead.org>
> > > Cc: Darrick J. Wong <djwong@kernel.org>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> > > Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > > Reviewed-by: Jan Kara <jack@suse.cz>
> > > ---
> > > v3: Removed leftover bits of i_version from ext4_apply_options
> > > v4: no change
> > >=20
> > >  fs/ext4/inode.c |  5 ++---
> > >  fs/ext4/super.c | 21 ++++-----------------
> > >  2 files changed, 6 insertions(+), 20 deletions(-)
> > >=20
> > > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > > index 2a220be34caa..c77d40f05763 100644
> > > --- a/fs/ext4/inode.c
> > > +++ b/fs/ext4/inode.c
> > > @@ -5425,7 +5425,7 @@ int ext4_setattr(struct user_namespace *mnt_use=
rns, struct dentry *dentry,
> > >  			return -EINVAL;
> > >  		}
> > > =20
> > > -		if (IS_I_VERSION(inode) && attr->ia_size !=3D inode->i_size)
> > > +		if (attr->ia_size !=3D inode->i_size)
> > >  			inode_inc_iversion(inode);
> > > =20
> > >  		if (shrink) {
> > > @@ -5735,8 +5735,7 @@ int ext4_mark_iloc_dirty(handle_t *handle,
> > >  	 * ea_inodes are using i_version for storing reference count, don't
> > >  	 * mess with it
> > >  	 */
> > > -	if (IS_I_VERSION(inode) &&
> > > -	    !(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
> > > +	if (!(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
> > >  		inode_inc_iversion(inode);
> > > =20
> > >  	/* the do_update_inode consumes one bh->b_count */
> > > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > > index 9a66abcca1a8..1c953f6d400e 100644
> > > --- a/fs/ext4/super.c
> > > +++ b/fs/ext4/super.c
> > > @@ -1585,7 +1585,7 @@ enum {
> > >  	Opt_inlinecrypt,
> > >  	Opt_usrjquota, Opt_grpjquota, Opt_quota,
> > >  	Opt_noquota, Opt_barrier, Opt_nobarrier, Opt_err,
> > > -	Opt_usrquota, Opt_grpquota, Opt_prjquota, Opt_i_version,
> > > +	Opt_usrquota, Opt_grpquota, Opt_prjquota,
> > >  	Opt_dax, Opt_dax_always, Opt_dax_inode, Opt_dax_never,
> > >  	Opt_stripe, Opt_delalloc, Opt_nodelalloc, Opt_warn_on_error,
> > >  	Opt_nowarn_on_error, Opt_mblk_io_submit, Opt_debug_want_extra_isize=
,
> > > @@ -1694,7 +1694,6 @@ static const struct fs_parameter_spec ext4_para=
m_specs[] =3D {
> > >  	fsparam_flag	("barrier",		Opt_barrier),
> > >  	fsparam_u32	("barrier",		Opt_barrier),
> > >  	fsparam_flag	("nobarrier",		Opt_nobarrier),
> > > -	fsparam_flag	("i_version",		Opt_i_version),
> > >  	fsparam_flag	("dax",			Opt_dax),
> > >  	fsparam_enum	("dax",			Opt_dax_type, ext4_param_dax),
> > >  	fsparam_u32	("stripe",		Opt_stripe),
> > > @@ -2140,11 +2139,6 @@ static int ext4_parse_param(struct fs_context =
*fc, struct fs_parameter *param)
> > >  	case Opt_abort:
> > >  		ctx_set_mount_flag(ctx, EXT4_MF_FS_ABORTED);
> > >  		return 0;
> > > -	case Opt_i_version:
> > > -		ext4_msg(NULL, KERN_WARNING, deprecated_msg, param->key, "5.20");
> > > -		ext4_msg(NULL, KERN_WARNING, "Use iversion instead\n");
> > > -		ctx_set_flags(ctx, SB_I_VERSION);
> > > -		return 0;
> > >  	case Opt_inlinecrypt:
> > >  #ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
> > >  		ctx_set_flags(ctx, SB_INLINECRYPT);
> > > @@ -2814,14 +2808,6 @@ static void ext4_apply_options(struct fs_conte=
xt *fc, struct super_block *sb)
> > >  	sb->s_flags &=3D ~ctx->mask_s_flags;
> > >  	sb->s_flags |=3D ctx->vals_s_flags;
> > > =20
> > > -	/*
> > > -	 * i_version differs from common mount option iversion so we have
> > > -	 * to let vfs know that it was set, otherwise it would get cleared
> > > -	 * on remount
> > > -	 */
> > > -	if (ctx->mask_s_flags & SB_I_VERSION)
> > > -		fc->sb_flags |=3D SB_I_VERSION;
> > > -
> > >  #define APPLY(X) ({ if (ctx->spec & EXT4_SPEC_##X) sbi->X =3D ctx->X=
; })
> > >  	APPLY(s_commit_interval);
> > >  	APPLY(s_stripe);
> > > @@ -2970,8 +2956,6 @@ static int _ext4_show_options(struct seq_file *=
seq, struct super_block *sb,
> > >  		SEQ_OPTS_PRINT("min_batch_time=3D%u", sbi->s_min_batch_time);
> > >  	if (nodefs || sbi->s_max_batch_time !=3D EXT4_DEF_MAX_BATCH_TIME)
> > >  		SEQ_OPTS_PRINT("max_batch_time=3D%u", sbi->s_max_batch_time);
> > > -	if (sb->s_flags & SB_I_VERSION)
> > > -		SEQ_OPTS_PUTS("i_version");
> > >  	if (nodefs || sbi->s_stripe)
> > >  		SEQ_OPTS_PRINT("stripe=3D%lu", sbi->s_stripe);
> > >  	if (nodefs || EXT4_MOUNT_DATA_FLAGS &
> > > @@ -4640,6 +4624,9 @@ static int __ext4_fill_super(struct fs_context =
*fc, struct super_block *sb)
> > >  	sb->s_flags =3D (sb->s_flags & ~SB_POSIXACL) |
> > >  		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
> > > =20
> > > +	/* i_version is always enabled now */
> > > +	sb->s_flags |=3D SB_I_VERSION;
> > > +
> > >  	if (le32_to_cpu(es->s_rev_level) =3D=3D EXT4_GOOD_OLD_REV &&
> > >  	    (ext4_has_compat_features(sb) ||
> > >  	     ext4_has_ro_compat_features(sb) ||
> >=20
> > Hi Lukas,
> >=20
> > I know I had originally asked you to shepherd this patch into mainline,
> > but I think it may be better to wait on it for now. Since I asked that,
> > we've since found out that ext4 is bumping the i_version counter on
> > atime updates. It'd be best to get that fixed before we turn this on
> > unconditionally, since it could cause a performance regression in some
> > cases. I'll plan to pick this back up for my latest i_version series if
> > that sounds ok to you.
> >=20
> > Sorry for the back and forth, and thanks again!
>=20
> Hi Jeff,
>=20
> sure, no problem. I can drop the patch. The rest of the series is still
> valid though.
>=20
> Thanks!
> -Lukas
>=20
>=20

Yes, the rest is fine (AFAICT)

Thanks!
--=20
Jeff Layton <jlayton@kernel.org>
