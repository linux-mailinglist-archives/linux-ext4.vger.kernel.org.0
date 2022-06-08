Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1201054362E
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jun 2022 17:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242230AbiFHPLF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Jun 2022 11:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243265AbiFHPKr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Jun 2022 11:10:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC8948E55D
        for <linux-ext4@vger.kernel.org>; Wed,  8 Jun 2022 08:02:25 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 59EBA1F915;
        Wed,  8 Jun 2022 15:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654700544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vZw2vcn0vJw8g7bjT9eagIVv0xnfGM2x1rhYxp19zxY=;
        b=pBk5iqbwz/WAO/y9hf5SNZXTu5Qdp2MZV9OCfch+xGLy7DJ+SAyYTAWchmAWFMoKrDmiOc
        QyjVXdRPrn1iyiXftGSKYJeErHoBInzmX2zbaYbaPvBj1jgXfiFV0T0ZFNfnISp3ksgXsx
        Rr7kToD+BEzOHAzqheX4uKc9hKQ6Lg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654700544;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vZw2vcn0vJw8g7bjT9eagIVv0xnfGM2x1rhYxp19zxY=;
        b=auX5T0UvD5fGIu7XtqxXMn8Er/a1g4+NtBalHgXY5sf7u+rJ0xnFfj++OLMCUs732Vbo0z
        wqOYs5uOv10PlADw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4AA852C141;
        Wed,  8 Jun 2022 15:02:24 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EB05EA06E2; Wed,  8 Jun 2022 17:02:23 +0200 (CEST)
Date:   Wed, 8 Jun 2022 17:02:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/2] ext4: Fix possible fs corruption due to xattr races
Message-ID: <20220608150223.7mp6v3pinxgoyzv5@quack3.lan>
References: <20220606142215.17962-1-jack@suse.cz>
 <20220608045100.uacl5c6usi7kl7gw@riteshh-domain>
 <20220608095425.nptskml5splta2qd@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608095425.nptskml5splta2qd@quack3.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 08-06-22 11:54:25, Jan Kara wrote:
> On Wed 08-06-22 10:21:00, Ritesh Harjani wrote:
> > On 22/06/06 04:28PM, Jan Kara wrote:
> > > Hello,
> > >
> > > I've tracked down the culprit of the jbd2 assertion Ritesh reported to me. In
> > 
> > Hello Jan,
> > 
> > Thanks for working on the problem and identifying the race.
> > 
> > > the end it does not have much to do with jbd2 but rather points to a subtle
> > > race in xattr code between xattr block reuse and xattr block freeing that can
> > > result in fs corruption during journal replay. See patch 2/2 for more details.
> > > These patches fix the problem. I have to say I'm not too happy with the special
> > 
> > So while I was still reviewing this patch-set, I thought of giving a try with some
> > stress test for xattrs (given that this is some sort of race which is not always
> > easy to track down).
> > 
> > So it seems it is easy to recreate the crash with stress-ng xattr test (even
> > with your patches included).
> > 	stress-ng --xattr 16 --timeout=10000s
> > 
> > Hope this might help further narrow down the problem.
> 
> Drat. I was actually running "stress-ng --xattr
> <some-number-I-dont-remember>" to test my patches and it
> didn't reproduce the crash for me within 5 minutes or so. Let me try harder
> and thanks for the testing!

Indeed, I forgot to enable JBD2_DEBUG in my kernel config and so the
assertion was not triggering for me. Now I can reproduce the issue even
with my patches (although it takes longer to reproduce) so I'm digging more
into it.

							Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
