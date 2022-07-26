Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E065811A1
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Jul 2022 13:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbiGZLJb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Jul 2022 07:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbiGZLJa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 26 Jul 2022 07:09:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F33B30F57
        for <linux-ext4@vger.kernel.org>; Tue, 26 Jul 2022 04:09:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3648FB8154D
        for <linux-ext4@vger.kernel.org>; Tue, 26 Jul 2022 11:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416ACC341C0;
        Tue, 26 Jul 2022 11:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658833767;
        bh=MZYLlW7NhkEXvfC/RBqMJ2WBA/a9ttyUbHn1UKJOZJA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ITYpsgmJuhSwNPOzXKbXJtm/qkzLiZwcVvJVdnqK4NuXxzIOj7CKi5SmMX707LkvK
         6oDZQ3sVNgbVwE7tRp9tvFZBPFLCv0axN0AKw5BSF8MCXsL2TnbZOMNGzs9y7R5/WA
         HuCQSHSWaZAHJERwjVuhe5BWAav0xCkVPaSLtr1zRDBazvlD47A8zTyHxn4jtsw64F
         v/0I5+WdTpbmCtlNwHct8ulQsVU5mWNiXg0oPp9ROGtNLixKvlIQmBU4CJ4JaPVGoT
         8XpZHjW9KcXOwzgDHE2sfg/hRGFQI126KUY/Hr/chyj0OPfhpHHPAf8i+a5ZaH9GUp
         N781jpLYuGIRg==
Message-ID: <0ac7580af2fc8dd65976939b05bd52ca12cd9dc4.camel@kernel.org>
Subject: Re: [PATCH] ext4: unconditionally enable the i_version counter
From:   Jeff Layton <jlayton@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Date:   Tue, 26 Jul 2022 07:09:24 -0400
In-Reply-To: <Yt8P1HmV//iX9XWC@magnolia>
References: <20220725192946.330619-1-jlayton@kernel.org>
         <Yt8P1HmV//iX9XWC@magnolia>
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

On Mon, 2022-07-25 at 14:49 -0700, Darrick J. Wong wrote:
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
>=20
> Perhaps it's time to kill off Opt_i_version, since we're now at 5.20?
>=20

Ok. I'll plan to remove that instead of altering it like this.

> (For that matter, noacl/nouser_xattr were supposed to be gone by 3.5 and
> they're clearly still there, so either they ought to go as well?)
>=20

I'll leave that for a separate patch.

> --D
>=20
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

--=20
Jeff Layton <jlayton@kernel.org>
