Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DE76AFB74
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Mar 2023 01:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjCHAqe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Mar 2023 19:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCHAqe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Mar 2023 19:46:34 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A83A9093
        for <linux-ext4@vger.kernel.org>; Tue,  7 Mar 2023 16:46:19 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3280jgfZ017097
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 19:45:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678236344; bh=ZKmLc4Nwlc/lt6Y5Zz64jqgEPqgCmkt/KL2+cqYMWwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ga9+PNNF3B2/qdJ/GoYNAYOq0hSAaMUFm5VMvGiUlMFigubXyEFf3/rbeU434sZ/D
         QtGUDBl19HPhGy9RjJtvRpppu5broucS0oGOOlBs2ntbRMhmt7iNoqUdQVCsjKWJFn
         8w4ViaSJCp9Ee23bscKqEIledTx8lkpEuSCZr01/fSwDlCbCRFz2EeGjvmdy9qafyS
         BoHphBQporm15skq2LkXwlUJzpkw9IqpaO/lgrQdks8F1IbPMMHsmfjnP4PyNXyTy2
         cn40W1JEUNBwyhI6DGLaAhZCgmwJRu5+kOIE2z4vHXAdi6nvRQi+LbqPsZXvLlo9DX
         m2YQ9TBTtUMgw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3615715C3441; Tue,  7 Mar 2023 19:45:42 -0500 (EST)
Date:   Tue, 7 Mar 2023 19:45:42 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jan Kara <jack@suse.cz>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        ext4 Development <linux-ext4@vger.kernel.org>
Subject: Re: The state of ext4 tree merging (was Re: Linux 6.3-rc1)
Message-ID: <20230308004542.GA1867364@mit.edu>
References: <CAHk-=wgr1D8hb75Z+nn+4LXUnosp0HM+gP+YJEcEav1DgTC=Cw@mail.gmail.com>
 <ZAVbZJSyOdF0BxAJ@debian.me>
 <20230306124134.hmeuvjhihs4ubpmz@quack3>
 <20230307090203.56c41488@oak.ozlabs.ibm.com>
 <20230307162137.GB960946@mit.edu>
 <20230308074431.21c32d58@oak.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308074431.21c32d58@oak.ozlabs.ibm.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 08, 2023 at 07:45:13AM +1100, Stephen Rothwell wrote:
> 
> Did you forget to push the dev branch out?  The version I have (and still see on git.kernel.org) has commit
> 
>   2c2dec1e86cc ("ext4: fix incorrect options show of original mount_opt and extend mount_opt2")
> 
> at its head, but what you sent to Linus has commit
> 
>   e3645d72f886 ("ext4: fix incorrect options show of original mount_opt and extend mount_opt2")
> 
> at its head.

Ah, sorry.   I had pushed the tag, but not the branch.  My bad.  Anyway, fixed.

    	       	   	      	       	   - Ted
