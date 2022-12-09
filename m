Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1D9647D7B
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Dec 2022 06:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiLIFu5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Dec 2022 00:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLIFu4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Dec 2022 00:50:56 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B472023BDB
        for <linux-ext4@vger.kernel.org>; Thu,  8 Dec 2022 21:50:55 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2B95oQAI027782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Dec 2022 00:50:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1670565028; bh=X/Jfm8BjijlVhp4B8G5dDE3zKMIe+O9aB6X+MtpdH0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=YFVA6aSWsAzu+3P2mUAGqBdbnIAdxsF6g0HNnYQRnbLAMG/ORQrhoHMoyWPWo+SQb
         e/KN/vbcYWspyz28/fq3ZJy0gL7IoKBaKJAz59HXqdcKPuCaPzdA67UURTnDzBgw/j
         AE69jibCdB1+ulzsUyXfuR0wuqWsLFCrGXzSA+mpr1jxSA2obsjhrL9T8oHPvqka6I
         yU9qybkBd10NrBJzA+XjAKQT2RvbDzQ1MjzpIvAfGFaJaipeQls0ReaLwhdAnmjDr8
         7ooBGr7ksYjY6EdkZpcTH0TjtB8sjnecC4WexR6f/G1V8zvGqBSUQHB2cDl10yHuZq
         VynB2fB/IbYPg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 28E2315C3AE9; Fri,  9 Dec 2022 00:50:26 -0500 (EST)
Date:   Fri, 9 Dec 2022 00:50:26 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>, Eric Whitney <enwlinux@gmail.com>
Subject: Re: [PATCH v4 2/3] ext4: record error when detect abnormal
 'i_reserved_data_blocks'
Message-ID: <Y5LMosWupn5a1orF@mit.edu>
References: <20221208033426.1832460-1-yebin@huaweicloud.com>
 <20221208033426.1832460-3-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208033426.1832460-3-yebin@huaweicloud.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 08, 2022 at 11:34:25AM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> If 'i_reserved_data_blocks' is not cleared which mean something wrong with
> code, free space accounting is likely wrong, according to Jan Kara's advice
> use ext4_error() to record this abnormal let fsck to repair and also we can
> capture this issue.

If i_reserved_data_block, it means that there is something wrong with
our delayed allocation accounting.  However, this accounting is
usually only an in-memory error.  The one exception is if quota is
enabled, in which case the space is decremented from the
user/group/project quota.

However, if quota is not in use, which is the overwhelmingly common
case, there will be nothing for fsck to repair.  (It does mean that df
will show a slightly smaller free space value due to the messed up
delayed allocation accounting, but that disappears after a reboot.)

Marking the file system as in need of repair when nothing is actually
wrong with the on-disk file system can backfire, in that it confuses
users when they see the ext4 error but then when they run fsck, fsck
reports nothing wrong --- at which point they file a bug.

We could use ext4_error if quotas are enabled, and ext4_msg if not,
but it might not worth the extra complexity.

Cheers,

					- Ted
