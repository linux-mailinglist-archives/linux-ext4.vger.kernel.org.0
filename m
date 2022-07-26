Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09FD5811BE
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Jul 2022 13:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238811AbiGZLPm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Jul 2022 07:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbiGZLPh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 26 Jul 2022 07:15:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7739A959C
        for <linux-ext4@vger.kernel.org>; Tue, 26 Jul 2022 04:15:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 131FE612B9
        for <linux-ext4@vger.kernel.org>; Tue, 26 Jul 2022 11:15:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD226C341C0;
        Tue, 26 Jul 2022 11:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658834134;
        bh=KhXWbKLsIy6Jg1PSa14rbyRXbMp+QWTFRcAxTSDOA14=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Etg5szNm6u9sFSz5wLJdq3ynNqCahxhM5Cxs5V80Ke+3hFAS7lv/ztP5RD5bJlGmy
         mmB+GrTxwIwgz3pHJP9qohrXhK6EcBh7D2tS3ph0QMlt7+6eZfNnWx5Uk77vC9GiSS
         53XSlBsQhECq7Y0IaczkUE4ne06sRRcZ4SLbyXU9S/cyz8R8F5CeMX7Uk7XXw0UMug
         xMcSgf3+w6ZCLZcVn8jyAzLfq9juzSr2c1ObuHmCop0zfQfK42lsIf0d4ArS0WCj74
         a/O/npWjuMep1OhMC7wytv3ollbfri4/XkEV2vHDDR0S1ay2xptEsmjF1vtljcpeZD
         p3m8xX9laHUaA==
Message-ID: <08e2ca4c8f6344bdcd76d75b821116c6147fd57a.camel@kernel.org>
Subject: Re: [PATCH] ext4: unconditionally enable the i_version counter
From:   Jeff Layton <jlayton@kernel.org>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Christoph Hellwig <hch@infradead.org>, kzak@redhat.com
Date:   Tue, 26 Jul 2022 07:15:32 -0400
In-Reply-To: <20220726071001.j3ox56jjuzltrsrg@fedora>
References: <20220725192946.330619-1-jlayton@kernel.org>
         <20220726071001.j3ox56jjuzltrsrg@fedora>
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

On Tue, 2022-07-26 at 09:10 +0200, Lukas Czerner wrote:
> On Mon, Jul 25, 2022 at 03:29:46PM -0400, Jeff Layton wrote:
> > The original i_version implementation was pretty expensive, requiring a
> > log flush on every change. Because of this, it was gated behind a mount
> > option (implemented via the MS_I_VERSION mountoption flag).
> >=20
> > Commit ae5e165d855d (fs: new API for handling inode->i_version) made th=
e
> > i_version flag much less expensive, so there is no longer a performance
> > penalty from enabling it.
> >=20
> > Have ext4 ignore the SB_I_VERSION flag, and just enable it
> > unconditionally.
>=20
> Hi Jeff,
>=20
> the ext4 specific i_version option is deprecated and it's perfect time
> to remove it as well.
>=20
> As for enabling iversion by default, as I said before I am fine with
> that. With this patch we're left with no means of disabling it, which
> might be ok, I don't have a strong opinion.
>=20
> However I don't like the fact that the noiversion mount option is going
> to be just silently ignored and only on some file systems. The
> inconsistency bugs me and will create confusion when things go wrong.
>=20
> Shouldn't we introduce something like SB_NOIVERSION to give fs a clean
> way to inform user we're ignoring it, or even change the default? Or
> perhaps 'noinversion' should be removed?
>=20

Ordinarily, I'd agree here. I like leaving some mechanism to revert an
unconditional change like this.

Unfortunately, the problem here is that the original mount option was
implemented via a mountflag and was parsed by the userland helper.
Trying to rework how "-o {no}iversion" options work is going to be
messy. We can't rely on /bin/mount and the kernel being in sync.

If we did want to add something like this, then we might need to add a
new mount option that doesn't match the old one (e.g. -o no_i_version).
Alternately, could that be made settable via mkfs/tune2fs?

>=20
> >=20
> > Cc: Dave Chinner <david@fromorbit.com>
> > Cc: Lukas Czerner <lczerner@redhat.com>
> > Cc: Benjamin Coddington <bcodding@redhat.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/ext4/inode.c | 5 ++---
> >  fs/ext4/super.c | 8 ++++----
> >  2 files changed, 6 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 84c0eb55071d..c785c0b72116 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -5411,7 +5411,7 @@ int ext4_setattr(struct user_namespace *mnt_usern=
s, struct dentry *dentry,
> >  			return -EINVAL;
> >  		}
> > =20
> > -		if (IS_I_VERSION(inode) && attr->ia_size !=3D inode->i_size)
> > +		if (attr->ia_size !=3D inode->i_size)
> >  			inode_inc_iversion(inode);
> > =20
> >  		if (shrink) {
> > @@ -5717,8 +5717,7 @@ int ext4_mark_iloc_dirty(handle_t *handle,
> >  	}
> >  	ext4_fc_track_inode(handle, inode);
> > =20
> > -	if (IS_I_VERSION(inode))
> > -		inode_inc_iversion(inode);
> > +	inode_inc_iversion(inode);
> > =20
> >  	/* the do_update_inode consumes one bh->b_count */
> >  	get_bh(iloc->bh);
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 845f2f8aee5f..30645d4343b6 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -2142,8 +2142,7 @@ static int ext4_parse_param(struct fs_context *fc=
, struct fs_parameter *param)
> >  		return 0;
> >  	case Opt_i_version:
> >  		ext4_msg(NULL, KERN_WARNING, deprecated_msg, param->key, "5.20");
> > -		ext4_msg(NULL, KERN_WARNING, "Use iversion instead\n");
> > -		ctx_set_flags(ctx, SB_I_VERSION);
> > +		ext4_msg(NULL, KERN_WARNING, "i_version counter is always enabled.\n=
");
> >  		return 0;
> >  	case Opt_inlinecrypt:
> >  #ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
> > @@ -2970,8 +2969,6 @@ static int _ext4_show_options(struct seq_file *se=
q, struct super_block *sb,
> >  		SEQ_OPTS_PRINT("min_batch_time=3D%u", sbi->s_min_batch_time);
> >  	if (nodefs || sbi->s_max_batch_time !=3D EXT4_DEF_MAX_BATCH_TIME)
> >  		SEQ_OPTS_PRINT("max_batch_time=3D%u", sbi->s_max_batch_time);
> > -	if (sb->s_flags & SB_I_VERSION)
> > -		SEQ_OPTS_PUTS("i_version");
> >  	if (nodefs || sbi->s_stripe)
> >  		SEQ_OPTS_PRINT("stripe=3D%lu", sbi->s_stripe);
> >  	if (nodefs || EXT4_MOUNT_DATA_FLAGS &
> > @@ -4630,6 +4627,9 @@ static int __ext4_fill_super(struct fs_context *f=
c, struct super_block *sb)
> >  	sb->s_flags =3D (sb->s_flags & ~SB_POSIXACL) |
> >  		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
> > =20
> > +	/* i_version is always enabled now */
> > +	sb->s_flags |=3D SB_I_VERSION;
> > +
> >  	if (le32_to_cpu(es->s_rev_level) =3D=3D EXT4_GOOD_OLD_REV &&
> >  	    (ext4_has_compat_features(sb) ||
> >  	     ext4_has_ro_compat_features(sb) ||
> > --=20
> > 2.37.1
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
