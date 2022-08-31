Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA3F5A88CD
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Sep 2022 00:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiHaWJN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 Aug 2022 18:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiHaWJM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 Aug 2022 18:09:12 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9038582D11;
        Wed, 31 Aug 2022 15:09:11 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5062C5C01A1;
        Wed, 31 Aug 2022 18:09:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 31 Aug 2022 18:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1661983748; x=
        1662070148; bh=WIYFoaMKZoiJHnHUDZlxG0jiUy1Dk24eCrFgiVdOiyk=; b=c
        qKWiLl2QVz/BiKw4yh4hFF813J5C30ZKIixDq59fAstDAsNhcFCsk41vOQoBIuPF
        GteoF56ydpmBeeiK3SFVRQS2JRVDdXO2HiyNykd15cW3Ys7NmapdqLpOotT/464l
        ouYoIxA8ZsQMxjotbLvI8NqcvgC/rGvhQ57Hoqqb6TkLQkvQz1es7nD33Mtkirwm
        jrDuPcMNuD3tE3TkXhN9RimS23tzytC6GYezS7H6kuCnCJpT0CgBgf65p8H+D5ix
        0/MwWdbw9dE+KK1CFwqRgZ3CroFgxIFtpDWb/AaIQ59XMtcWpkOJvcfnSt3Oai8y
        Zkp9nozZIIgKaCI5S1voA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1661983748; x=1662070148; bh=WIYFoaMKZoiJHnHUDZlxG0jiUy1D
        k24eCrFgiVdOiyk=; b=O9gAW2mGnwtDMRwMaRX020Zt1+P3WrBjl5ydDY5ynikl
        hTeO2bqgxXXZkdFEeb70fvwza2Fob8yxFDn4lv5qrzGevrHSb+osjR13HmUrhQJR
        6cat51cxS8iw1QNGueMuS3fDPMNQaTbctFgYxIEY8fjJRuW7bCsNJ9hiwed7HUj/
        2OOCPDDG3mciV1b7WXTvvjjUoYmuruIk0ZNvqbn2MCQgEpnGehvbe5t7JSxv1UAO
        tp7Vh/vYoKfF0jgRnDw4rbtYcZhjhoiDxRWG5UXE7ahpmyhlEk2Fv3FY+5Ywg/d6
        7xYy3fG+VoUSv2wz/6cxiZpVeLW4xxIWJC9nFXpl1g==
X-ME-Sender: <xms:A9wPY0VtuUqZ09U4ehnp19qRU6uqVcJF2X0hj5fPiZtnBJGsWvluNQ>
    <xme:A9wPY4mgsUKYlF0vm_oVH074JQ0PkWwyQyyoah-PzmZP-daQvs__0zoDlweWS8m9Q
    28G4Dv8_pIpWhssVGk>
X-ME-Received: <xmr:A9wPY4bIiL-kCzqXYwlb-D-7Z5D7twkLPDM-skaybNpmr8aasx85SjyEs633xpnB7CTcravK927TCwANV26xu1tw494qq0q64Y6K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekjedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheplfhoshhh
    ucfvrhhiphhlvghtthcuoehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeduieegheeijeeuvdetudefvedtjeefgeeufefghfekgfelfeet
    teelvddtffetgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhg
X-ME-Proxy: <xmx:BNwPYzUx0cUvls28QLdYRc5wwsZ8Q3wyY1nekKKU95rF2lzPESDlig>
    <xmx:BNwPY-lVZ7umfkuAyGiGh0l3CX8P-3-Pt2BZyNzToA0vOzMBKQdXxA>
    <xmx:BNwPY4eG4WNWd4deOsha2lEN9r_FSti06YT7NO4Gt1Ptj3G56cLdBA>
    <xmx:BNwPYwiWyyLTAt8Sz0_CYLyGlEPB0UX1NGQALcFtDvYPRT3beIWdHA>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Aug 2022 18:09:06 -0400 (EDT)
Date:   Thu, 1 Sep 2022 00:09:04 +0200
From:   Josh Triplett <josh@joshtriplett.org>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Don't run ext4lazyinit for read-only filesystems
Message-ID: <Yw/cANWSlKYqiT9L@localhost>
References: <48b41da1498fcac3287e2e06b660680646c1c050.1659323972.git.josh@joshtriplett.org>
 <20220803070001.iygdreewgveotfwx@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803070001.iygdreewgveotfwx@fedora>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 03, 2022 at 09:00:01AM +0200, Lukas Czerner wrote:
> On Sun, Jul 31, 2022 at 08:24:53PM -0700, Josh Triplett wrote:
> > On a read-only filesystem, we won't invoke the block allocator, so we
> > don't need to prefetch the block bitmaps.
> > 
> > This avoids starting and running the ext4lazyinit thread at all on a
> > system with no read-write ext4 filesystems (for instance, a container VM
> > with read-only filesystems underneath an overlayfs).
> > 
> > Fixes: 21175ca434c5 ("ext4: make prefetch_block_bitmaps default")
> > Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> > ---
> 
> Looks good to me.
> 
> Reviewed-by: Lukas Czerner <lczerner@redhat.com>
> 
> > Tested in a VM, with a read-only ext4 root filesystem. Confirmed that
> > ext4lazyinit starts without this patch, and does not start with this
> > patch.
> > 
> > (For a future merge window, not the current one. Please let me know if I
> > need to re-send this at a later, more convenient time.)

Now that the merge window has been closed for a while, I wanted to
follow up on this to see if it could get into next.

> >  fs/ext4/super.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 845f2f8aee5f..20437acc8865 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -3973,9 +3973,9 @@ int ext4_register_li_request(struct super_block *sb,
> >  		goto out;
> >  	}
> >  
> > -	if (test_opt(sb, NO_PREFETCH_BLOCK_BITMAPS) &&
> > -	    (first_not_zeroed == ngroups || sb_rdonly(sb) ||
> > -	     !test_opt(sb, INIT_INODE_TABLE)))
> > +	if (sb_rdonly(sb) ||
> > +	    (test_opt(sb, NO_PREFETCH_BLOCK_BITMAPS) &&
> > +	     (first_not_zeroed == ngroups || !test_opt(sb, INIT_INODE_TABLE))))
> >  		goto out;
> >  
> >  	elr = ext4_li_request_new(sb, first_not_zeroed);
> > -- 
> > 2.36.1
> > 
> 
