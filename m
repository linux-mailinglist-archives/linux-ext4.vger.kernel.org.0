Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4CE6FD34A
	for <lists+linux-ext4@lfdr.de>; Wed, 10 May 2023 02:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjEJAWZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 May 2023 20:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjEJAWY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 May 2023 20:22:24 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00492D4F
        for <linux-ext4@vger.kernel.org>; Tue,  9 May 2023 17:22:21 -0700 (PDT)
Received: from letrec.thunk.org (vancouverconventioncentre.com [72.28.92.216] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34A0MClT017982
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 May 2023 20:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1683678135; bh=+XNNATCTVkyahss1M+8eO8RfK8ISbaRGdPkQr3NJSfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=FbH0bBn6u6ivg77ztxLVzpsbXRsMgMMBOdrDU5wYOx9E6vxOBjOdml+hlYc9Gdzyq
         ONXCeieNfXdrSSZa9pXiTrp+XAyDLmI5O2jb0yJZuO7F41mVFBZVfJA1dSYojIwCh4
         OvBtE2CokJTiHllNL/WrTRHbl0etB2YW5Uc2sVhl6pqDssU4tkWwwCXvDFEC6+VIAe
         6T/Gfzglt3vJ+5KYuMUg1UbC73N0WM0/tyOTLQyljkI+hVxbvqoX+UN2YI8+tnB1OW
         C5TrRjcmBaHtSKBx/mT8FI306lt4/oAFNnOYAaKry66W+BMo065J4oe8EjKfoQdIn/
         aFmKAm4+U7w6w==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 5C0E18C03D6; Tue,  9 May 2023 20:22:11 -0400 (EDT)
Date:   Tue, 9 May 2023 20:22:11 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        syzbot+e2efa3efc15a1c9e95c3@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] ext4: allow ext4_get_group_info() to fail
Message-ID: <ZFrjs2i9xK+ektHd@mit.edu>
References: <20230430154311.579720-1-tytso@mit.edu>
 <20230430154311.579720-2-tytso@mit.edu>
 <20230507181816.tsnqhzgajftcbsz5@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230507181816.tsnqhzgajftcbsz5@quack3>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, May 07, 2023 at 08:18:16PM +0200, Jan Kara wrote:
> The patch looks good except for one small problem already found by Julia:
> 
> > @@ -2578,7 +2595,7 @@ void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
> >  		gdp = ext4_get_group_desc(sb, group, NULL);
> >  		grp = ext4_get_group_info(sb, group);
> >  
> > -		if (EXT4_MB_GRP_NEED_INIT(grp) &&
> > +		if (grp && grp && EXT4_MB_GRP_NEED_INIT(grp) &&
> 		    ^^^ one of these should be gdp.
> 
> With this fixed feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks for the review, fixed in my tree.

       	       	       	     	   - Ted
