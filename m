Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CEA6C6AC8
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Mar 2023 15:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjCWOVr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Mar 2023 10:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjCWOVb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Mar 2023 10:21:31 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D855B9D
        for <linux-ext4@vger.kernel.org>; Thu, 23 Mar 2023 07:21:30 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32NELHju003275
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 10:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1679581278; bh=Lie5CtaiQbNIDt1S3TRfnx3qWKLuVWEezgIsumJ4veo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Yu8y5BmEZQ6dKOkADZsggQzwLw+MvxjSIrkTK1GYoyYEvz9dCjZRcJiBA75EDZ9Bl
         vTsOqm36128cMMIgcRal42BcNZ0/SoC/f3GytJ/pox4lATwKRuTJf9CfD/Y5FntqlU
         OFSyteMeXLTef6RWl1LV7l5kMGcBPCgd0p7KT4BEE6X5lQO30f68mqWb3xrSRWHc54
         /+tOuJ46xr5aAbcTFSoCC7oNv7Trnj58ORhGK6wIGRLsKr+f086XlSQ/JQLZP/Bj0N
         P+nE7b0BwVXQbB3F5OEjp/tid8WKQ2KSb8j2ddqFNfFdJbv4NzQ2dbrL7xtr3SbJGI
         SNLF5M9W2nUzw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1689E15C4279; Thu, 23 Mar 2023 10:21:17 -0400 (EDT)
Date:   Thu, 23 Mar 2023 10:21:17 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix warnings when freezing filesystem with
 journaled data
Message-ID: <20230323142117.GB136146@mit.edu>
References: <20230308142528.12384-1-jack@suse.cz>
 <20230319183617.GA896@sol.localdomain>
 <20230321120653.j5fpyqk4iat6wrvu@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321120653.j5fpyqk4iat6wrvu@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Jan, have you had a chance to look into finding a fixup to the problem
that Eric identified?  I'm not sure how I had missed this in my
testing as well.  :-/

If fixing this is going to take a while, I can drop this patch for
now, especially since you've pointed out that the warning is a false
positive.

Thanks,

					- Ted
