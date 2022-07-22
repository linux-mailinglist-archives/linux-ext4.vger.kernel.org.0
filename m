Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798AB57E2A3
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jul 2022 15:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiGVNzm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jul 2022 09:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGVNzl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jul 2022 09:55:41 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE32C87236;
        Fri, 22 Jul 2022 06:55:40 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26MDtOIe015224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 09:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658498126; bh=adOGrR/XnBYwUl94/YNKQYYFOIUm0MU+TJwn8QCkDdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Twa2n8cElnWOk9wJtu82xIorja+zyCG7F2qFd+ahBHkdpkAlWnWHYbalimcPshvjj
         bNGxOOUrt1CURbl1bT4nYMDifH4FnH4AZI6TxoTDKtJ3rtjm+/4h8TK2131sdwnPU6
         ITka+XOOPFiiVCybAWt14rsesERsvN2Cv4WkxJWyngW+35dyT0Z/ac/njfbQvBC9UI
         Rjr0lMA+dHjiigIKCDnGa9gks7ldszw2NNitYEpEiSzLGCxNQ9HpZ1V2QDs7XBFJ7f
         /tHbNMd7bR1k2N/JETZDwOyv5nEF150LkxqGqaJ/wxsqDb0FiDi8asnBWlDn/hH+wT
         LswBwNKYejIoQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 99ACB15C3EF7; Fri, 22 Jul 2022 09:55:24 -0400 (EDT)
Date:   Fri, 22 Jul 2022 09:55:24 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Jeremy Bongio <bongiojp@gmail.com>, linux-ext4@vger.kernel.org,
        linux-man@vger.kernel.org
Subject: Re: [PATCH v2] Add manpage for get/set fsuuid ioctl for ext4
 filesystem.
Message-ID: <YtqsTM2qXyR+dlz6@mit.edu>
References: <20220720234512.354076-1-bongiojp@gmail.com>
 <YtiZ+gOmOFTpiAjW@magnolia>
 <e503645b-e665-50c4-37a9-cdc8637ba1d8@gmail.com>
 <YtmXAyoF2PXstnLY@magnolia>
 <e1573002-7ea3-2636-b2d2-331767a5622f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1573002-7ea3-2636-b2d2-331767a5622f@gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jul 22, 2022 at 12:03:23PM +0200, Alejandro Colomar (man-pages) wrote:
> > SEE ALSO
> > 	ioctl(2)
> > 
> > at the end of an ioctl_XXX manpage like this one.
> > 
> 
> Okay.  Then may I ask for an EXAMPLES section with a program that
> unequivocally shows users how to use it?

I'll note that existing ioctl man pages don't have an explicit
statement that a libc is required --- nor do we do this for open(2),
stat(2), etc.   (And that's especially necessary for stat(2), BTW!)

Many of the ioctl man pages (or other system call man pages, for that
matter) also don't have an EXAMPLES section, either.

Perhaps it would be useful to have a discussion over what the
standards are for man pages in section 2, and when we need to state
things that seem to be rather obvious (like "you must have a C
library") and when there should be things like an EXAMPLES section?

Some the suggestions you are making don't seem to be adhered to by
the existing man pages, and more text is not always better.

https://www.npr.org/sections/13.7/2014/02/03/270680304/this-could-have-been-shorter

      	     	       	       		- Ted
