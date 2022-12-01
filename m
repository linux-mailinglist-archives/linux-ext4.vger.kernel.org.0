Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1177663F7AF
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Dec 2022 19:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiLASn4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Dec 2022 13:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiLASn4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Dec 2022 13:43:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038F797923;
        Thu,  1 Dec 2022 10:43:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A599FB81FB7;
        Thu,  1 Dec 2022 18:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32874C433D6;
        Thu,  1 Dec 2022 18:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669920230;
        bh=b9MKAOU9mBwWc1Xtj0CoQZLAapZGZR8Q9GkPkmawkKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VQIIwB5sTwPSd9QjcvyUADPXRLM4n5J/PEpx/DBC1by7q6tyvcT1DFmYFHsXfFfhT
         M4/w5vuijB2arX/On2nsU4eNTlHBRK9KmH0rqR9IK7Mh65kcg74ngg7rMGDF2msNod
         03a7I9XByIZnUoixyEuxN+pHg1wV44Sz+0yhBqVGWmGF7G2Lr9djKu7WVWfr9Gd8Rw
         ylwaFwP+WObh+eH/0t3YC25i4FNIpI3SAGAOztichWZpTB891bK64tvK1KUT7w7ubX
         qTdmgIixwW8mJnmQpOzzFCqg6H9Zozl2ERoRmU0qAINfTqIk2JZ9pUFGL3Qa0jiIg5
         s0buzKT0jeFHw==
Date:   Thu, 1 Dec 2022 10:43:47 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     "yebin (H)" <yebin10@huawei.com>, Ye Bin <yebin@huaweicloud.com>,
        tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+4d99a966fd74bdeeec36@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: fix WARNING in ext4_expand_extra_isize_ea
Message-ID: <Y4j142NC7u0O8VHt@sol.localdomain>
References: <20221201084844.2855621-1-yebin@huaweicloud.com>
 <20221201121928.xk5tte4dj3vmxivs@quack3>
 <6388AB33.6050302@huawei.com>
 <20221201142143.yuxnld55qot4jv7b@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201142143.yuxnld55qot4jv7b@quack3>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 01, 2022 at 03:21:43PM +0100, Jan Kara wrote:
> You're right that VFS actually limits xattr size to 64k. So the chances
> that someone actually has filesystem with larger xattrs are slim. But I
> know that Lustre guys run with their modified kernels and they were the
> ones implementing ea_inode feature so maybe they'd bumped the VFS limit as
> well in their kernels.

Upstream has 64K, so that's all that matters in the context of upstream.  If
someone changed it downstream, that's their problem.

- Eric
