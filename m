Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3317063F4AF
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Dec 2022 17:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiLAQBm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Dec 2022 11:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiLAQBl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Dec 2022 11:01:41 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFE9B275D;
        Thu,  1 Dec 2022 08:01:40 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2B1G0wPn029259
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Dec 2022 11:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1669910461; bh=saT2dZml2UgO+SyDIZo0C0RLdh6FTTZ9Dk8A3buiwyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=WaGH67J//chGIV//JDerMs66PGulta2qIBrnT+0rJKXkns9BVksB0nm/jwQf1b9WN
         VAJ9nAvfRSVWn3fEzKGd7Q5RyQXzO/CrzihZPSMgSXlmGVuBYHFLfEUsIKIBISgMVD
         mWR5Kv9VP45HM0hszpAvKl+WmLnuU4jwdS3H1VnZ4pm+3sV9RaPmuXVEgGpEWnw+gJ
         94YzBZd+ie1jcwaC6zxDit7fV+Zywud4DnZwUrr8C3qy4HiYuo712LkQXA9Oqqc+Yp
         cLFlumyyPukXK6oQY7GpMjhPubSLtV0JUkq5VC3zjIACHQJCUtd2M9PDkBd63N7ITi
         GQstNeu6c73zQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B0E1315C46FB; Thu,  1 Dec 2022 11:00:58 -0500 (EST)
Date:   Thu, 1 Dec 2022 11:00:58 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>,
        syzbot+4d99a966fd74bdeeec36@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] ext4: fix WARNING in ext4_expand_extra_isize_ea
Message-ID: <Y4jPuoJsW5+t9UUn@mit.edu>
References: <20221201145923.73028-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201145923.73028-1-yebin@huaweicloud.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 01, 2022 at 10:59:23PM +0800, Ye Bin wrote:
> 
> Reason is allocate 16M memory by kmalloc, but MAX_ORDER is 11, kmalloc
> can allocate maxium size memory is 4M.
> XATTR_SIZE_MAX is currently 64k, but EXT4_XATTR_SIZE_MAX is '(1 << 24)',
> so 'ext4_xattr_check_entries()' regards this length as legal. Then trigger
> warning in 'ext4_xattr_move_to_block()'.
> To solve above issue, according to Jan Kara's suggestion use kvmalloc()
> to allocate memory in ext4_xattr_move_to_block().

See my comment to the v1 version of the patch.  I suspect the real
problem is that the e_value_size is completely bogus, and we should
have checked it much earlier in the stack call trace, via a call to
xattr_check_inode().

Cheers,

					- Ted
