Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B124F6BFB80
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Mar 2023 17:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjCRQZD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 18 Mar 2023 12:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjCRQZC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 18 Mar 2023 12:25:02 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FB9A279
        for <linux-ext4@vger.kernel.org>; Sat, 18 Mar 2023 09:25:00 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32IGOLW6029079
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Mar 2023 12:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1679156664; bh=iFJTV3zLc+HU0zupBWR2EPsvquVbWbUBSVjFDpNSCvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=mADHBQ491AmRkhTjp2SLi+ghC1Jj1xlMR+llW5EvDesxfAO1DItPSJE9c8X8T8pgt
         73RJCwwUMxwIVnERPM+GVhGJuazSeodgzFZJM0Acwa/WBhIdkgKCmrT+jLxiYKSExr
         jM83DChcp3nCGmFjGtvk0QcmXIJQuQw17HgOrBbLGt5hs5pzQuwJv/8edspzswP/OL
         lJPmAzNn3it6T7wfQ82hafKPU5wntMsUpmJhDGOf1fweqpfTjvdf2oOVzwP1dxmIgX
         Hzg89szhmokbYJeCAJV16bfV9HW/s4OAwd+QPraFNepMGp1uqj9WabHGO54sQoscwG
         6/SFxlc/GFMHw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2A05F15C3AC6; Sat, 18 Mar 2023 12:24:21 -0400 (EDT)
Date:   Sat, 18 Mar 2023 12:24:21 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        adilger@whamcloud.com, Jan Kara <jack@suse.cz>,
        linfeilong <linfeilong@huawei.com>,
        wuguanghao <wuguanghao3@huawei.com>,
        zhanchengbin <zhanchengbin1@huawei.com>, libaokun1@huawei.com
Subject: Re: [PATCH] tune2fs: check whether dev is mounted or in use before
 setting
Message-ID: <20230318162421.GB11916@mit.edu>
References: <8babc8eb-1713-91c9-1efa-496909340a6f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8babc8eb-1713-91c9-1efa-496909340a6f@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Mar 18, 2023 at 11:36:03AM +0800, Zhiqiang Liu wrote:
> From: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> 
> tune2fs is used to adjust various tunable filesystem pars, which
> may conflict with kernel operations. So we should check whether
> device is mounted or in use at the begin similar to e2fsck and mke2fs.
> 
> Of course, we can ignore this check if -f is set.

Tune2fs is designed to work on mounted file systems.  There are
individual checks for those changes which can not be safely done on
mounted file systems, but most changes are safe to do on mounted file
systems.

Cheers,

					- Ted
