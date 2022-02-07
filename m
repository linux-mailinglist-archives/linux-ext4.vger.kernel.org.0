Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7488C4ACAC5
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Feb 2022 21:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiBGUxQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Feb 2022 15:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiBGUxP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Feb 2022 15:53:15 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FC3C06173B;
        Mon,  7 Feb 2022 12:53:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1F6D11F380;
        Mon,  7 Feb 2022 20:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644267192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LKv3EweMD03rUYun/L5aHTmWoM0dcEXr0nhc6lTkmFE=;
        b=gNgwVXkjoebU3goU0BxG421Itbvx1KH8zO+NvewX40vrvjeb9JdAPIisGVeLymndxdykw4
        wdchpQ/FYPApj3Eix5rcYkBOVrW64/elRH7GXCoWMaGAw4i6O2VbQ2UBTIHV1c0vVj2o2S
        zEOaG3VfvFVWJOI7lD7zigabDHBJEBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644267192;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LKv3EweMD03rUYun/L5aHTmWoM0dcEXr0nhc6lTkmFE=;
        b=xZy4q7+xKyTGorvlcoIz9qHMKtKKaRLNEiB3DH+5Ea26b0Y2jBLtBialYuZFa60Kx9hXIN
        Iz0SUdav+1Vf3hAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7426113C72;
        Mon,  7 Feb 2022 20:53:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id StSIC7CGAWJOaQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 07 Feb 2022 20:53:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jan Kara" <jack@suse.cz>
Cc:     "Colin Ian King" <colin.i.king@gmail.com>,
        "Jan Kara" <jack@suse.com>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ext2: remove unused pointer bdi
In-reply-to: <20220207144612.zdczs7wxzbuk3ydr@quack3.lan>
References: <20220207134039.337197-1-colin.i.king@gmail.com>,
 <20220207144612.zdczs7wxzbuk3ydr@quack3.lan>
Date:   Tue, 08 Feb 2022 07:52:58 +1100
Message-id: <164426717877.27779.5211639626156510807@noble.neil.brown.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 08 Feb 2022, Jan Kara wrote:
> On Mon 07-02-22 13:40:39, Colin Ian King wrote:
> > The call to bdi_congested has been removed and so the bdi pointer
> > is no longer required. Remove it.
> >=20
> > Fixes: 9bbab3a63d49 ("mm/fs: remove bdi_congested() and wb_congested() an=
d related functions")
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>=20
> I guess this change is in mm tree? So probably it is best if Andrew picks
> it up.

I have to refresh the whole series - hopefully later this week.  I'll
make sure to fix this bit.

Thanks,
NeilBrown


>=20
> 								Honza
>=20
> > ---
> >  fs/ext2/ialloc.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >=20
> > diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
> > index d632764da240..998dd2ac8008 100644
> > --- a/fs/ext2/ialloc.c
> > +++ b/fs/ext2/ialloc.c
> > @@ -170,9 +170,6 @@ static void ext2_preread_inode(struct inode *inode)
> >  	unsigned long offset;
> >  	unsigned long block;
> >  	struct ext2_group_desc * gdp;
> > -	struct backing_dev_info *bdi;
> > -
> > -	bdi =3D inode_to_bdi(inode);
> > =20
> >  	block_group =3D (inode->i_ino - 1) / EXT2_INODES_PER_GROUP(inode->i_sb);
> >  	gdp =3D ext2_get_group_desc(inode->i_sb, block_group, NULL);
> > --=20
> > 2.34.1
> >=20
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
>=20
>=20
