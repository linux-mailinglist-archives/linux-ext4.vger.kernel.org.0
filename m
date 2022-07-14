Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE829575126
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Jul 2022 16:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239050AbiGNOzS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Jul 2022 10:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239376AbiGNOzP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Jul 2022 10:55:15 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5BB52445;
        Thu, 14 Jul 2022 07:55:13 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26EEsLPg008235
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 10:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1657810466; bh=QawvQ560xdvpwEjmvpfYqk0KReolW7mc5YwpiDi8AfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=pu/S7BHY5/kT9cNJvuSsMX2+ODL61NzBt9WeY0kH2iDG1wLIRcJqXa056UAdnT5+R
         AOBqk+iBbUVfpambcQLLwkcwq41iDUgaWVXHm0jCDFkqWSpDaoESYWo2IWefkCcFPR
         dNlco22a1oOA7NYcLgzPxYPBZPms8A98tFYGPOCk3otxcYnaC30u5O484Q6oS806vX
         nqNfS1uK+j9hjifljIYmah6A264d9whosKObzjpZTzUMGjE7Zx/aXeDSM0PApGB+9y
         avfsuVx4y3MSJ8j+JXl3SVk3a5IQDq2BOebsVOHim9lSZk09zLlA2Qei9BCtXZjSZp
         VkEYcHXptjpPA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3753C15C003C; Thu, 14 Jul 2022 10:54:21 -0400 (EDT)
Date:   Thu, 14 Jul 2022 10:54:21 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>, Song Liu <song@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH 8/9] ext4: only initialize mmp_bdevname once
Message-ID: <YtAuHaiK+Me08swz@mit.edu>
References: <20220713055317.1888500-1-hch@lst.de>
 <20220713055317.1888500-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713055317.1888500-9-hch@lst.de>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 13, 2022 at 07:53:16AM +0200, Christoph Hellwig wrote:
> mmp_bdevname is currently both initialized nested inside the kthread_run
> call in ext4_multi_mount_protect and in the kmmpd thread started by it.
> 
> Lift the initiaization out of the kthread_run call in
> ext4_multi_mount_protect, move the BUILD_BUG_ON next to it and remove
> the duplicate assignment inside of kmmpd.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Theodore Ts'o <tytso@mit.edu>
