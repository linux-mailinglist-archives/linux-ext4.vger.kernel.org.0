Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D207BB053
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Oct 2023 04:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjJFCd5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Oct 2023 22:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjJFCdz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Oct 2023 22:33:55 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC88E4
        for <linux-ext4@vger.kernel.org>; Thu,  5 Oct 2023 19:33:53 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-143.bstnma.fios.verizon.net [173.48.111.143])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3962XHSE030957
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Oct 2023 22:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1696559600; bh=iRGmGbDJY30iIloA9rzpgpKjF/B1qICiSCNOtjmmFIw=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=cQH2j1qEYxfHJGty9SixEEFqo6jvZ5ettsbRlleGVhAFa7s7cbN3T9C/RbCvU3TBH
         6bATcUy+3Dcli+VMq4jNP9TK01Qknuj9eGWQFj9bGDeNdNXyF3GhKfMwscRDYV2QQZ
         AY3Li1lUiCCybBbIY8cKszWZLMj1QZ2MwNCUtDkRwqRFyLA93Jw9xs7u4Q9IJUSOy7
         e603AE+7Q34s5EYn1uW9nHaZIjwpnlxJbCS2fDBQBC7AVR0XszGgwtBwcfwK44Lcz9
         X2om4+Ka5JShVT5YiRR61AIRqRs9SGgyTRoTGR8GyOu6sWYQgSxml63iNGkSj73Dm0
         AN5Ctm8E5HZQw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3112E15C0250; Thu,  5 Oct 2023 22:33:17 -0400 (EDT)
Date:   Thu, 5 Oct 2023 22:33:17 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [RFC PATCH 01/16] ext4: correct the start block of counting
 reserved clusters
Message-ID: <20231006023317.GA24026@mit.edu>
References: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
 <20230824092619.1327976-2-yi.zhang@huaweicloud.com>
 <20230830131031.j7r266e77i5k6z2p@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830131031.j7r266e77i5k6z2p@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 30, 2023 at 03:10:31PM +0200, Jan Kara wrote:
> On Thu 24-08-23 17:26:04, Zhang Yi wrote:
> > From: Zhang Yi <yi.zhang@huawei.com>
> > 
> > When big allocate feature is enabled, we need to count and update
> > reserved clusters before removing a delayed only extent_status entry.
> > {init|count|get}_rsvd() have already done this, but the start block
> > number of this counting isn's correct in the following case.
> > 
> >   lblk            end
> >    |               |
> >    v               v
> >           -------------------------
> >           |                       | orig_es
> >           -------------------------
> >                    ^              ^
> >       len1 is 0    |     len2     |
> > 
> > If the start block of the orig_es entry founded is bigger than lblk, we
> > passed lblk as start block to count_rsvd(), but the length is correct,
> > finally, the range to be counted is offset. This patch fix this by
> > passing the start blocks to 'orig_es->lblk + len1'.
> > 
> > Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Looks good. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks, I've applied the first two patches in this series, since these
are bug fixes.  The rest of the patch series requires more analysis
and review.

						- Ted
