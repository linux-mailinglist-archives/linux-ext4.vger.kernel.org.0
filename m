Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FBC647D52
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Dec 2022 06:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiLIFgA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Dec 2022 00:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLIFf7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Dec 2022 00:35:59 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29862613B
        for <linux-ext4@vger.kernel.org>; Thu,  8 Dec 2022 21:35:57 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2B95ZPuE021945
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Dec 2022 00:35:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1670564128; bh=igVYNk9fltUzsRoiHK8ckHLy/kWhm5sy4aTQx/TrRIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ZROy0XJ+s5F+j3Ct3NHhGqf343nXklhpk9E5bGSJhqVIgcHaNsIx8L279tHWoq1aE
         zhGEb7GCVt7H2tElU69BmkRUSlZK8T119OBqNEamlLGKIXxtVnTMMRxpQ7HMSTbI2A
         A7kKHPIbrOcbfOORyhBQZgFAW+nD0nY2PFYRgXgdJ4XYC99WUy/rqcpTHfVkwIppHD
         fuebiZWEvJO0CjDHr/s3rZbmf1AcZ1MAYenpetjXA92ihzHLZGuJOaa4Spq3Sz7gyF
         8kveBfCW7/suV+xzyb7g0hGHwJz5/AYMCvsyeWYkRUxzNQIHzStujNQgtJCUNucM5I
         cUP3XH2W2D0LQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id DE3BA15C3AE9; Fri,  9 Dec 2022 00:35:24 -0500 (EST)
Date:   Fri, 9 Dec 2022 00:35:24 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>,
        syzbot+4d99a966fd74bdeeec36@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 1/4] ext4: fix WARNING in ext4_expand_extra_isize_ea
Message-ID: <Y5LJHI1cHDK0Stjq@mit.edu>
References: <20221208023233.1231330-1-yebin@huaweicloud.com>
 <20221208023233.1231330-2-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208023233.1231330-2-yebin@huaweicloud.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In general, please don't use commit summaries like:

	ext4: fix WARNING in ext4_expand_extra_isize_ea
	
The commit summary should be a summary of what the change *does*.  A
description of *why* the change is needed is properly placed in the
body of the description.  So something like "ext4: clamp
EXT4_XATTR_SIZE_MAX to XATTR_SIZE_MAX" would be a better one-line
commit summary.

That being said, I've decided to not apply this patch.  A 16 MB
extended attribute size is not _that_ insane, although admittedly it's
quite bit larger than any other file system or OS supports (unless you
include Solaris and NTFS's alternate data forks as "extended
attributes").

I personally don't think the mm/page_alloc warning is that big of a
deal (even if it does cause a Syzbot report), and if you really do
care about suppressing the warning, using the kvmalloc() instead of
kmalloc() will do that --- and it does make ext4 friendly in the case
of where we are storing, say, a 30KB Windows ACL as an extended
attribute, since it avoided needing to make a order 3 page allocation.
(Which again, as far as I'm concerned, is more important than the
suppressing the page_alloc warning.)

We may ultimately decide to clamp EXT4_XATTR_SIZE_MAX to
XATTR_SIZE_MAX, but one could imagine some system attribute that in
the future might want to be larger than 32k, that wouldn't be accessed
via the standard xattr API.  That seems unlikely, but I want to keep
our options open.

Cheers,

					- Ted
