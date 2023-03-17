Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354FD6BECD1
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Mar 2023 16:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCQP0N (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Mar 2023 11:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjCQP0J (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Mar 2023 11:26:09 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AF91C7FF
        for <linux-ext4@vger.kernel.org>; Fri, 17 Mar 2023 08:26:05 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32HFPLH0000748
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 11:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1679066724; bh=xeH+3p0rI2I0R5xWgIjV4GmlF5PUsheWzCK9zeEgr34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=IHwsCeMrBR+r04+OmXrWYrZFc+cprczfvk0guXkuq3MYfAWXCbDUX9nikeDBI8sFL
         OsYKd5NzBKLkjxCy2f0LWnPoPdBr8geWt6R8fg84WOv561GX2yC++iUFIXL2wkny2Y
         nVZ9J+JSbhZ61OfKgXIyopXXY7BH+/LPtmlQ/thlRxnpkoYb6VXuKjMeKrUGtUugja
         3kiOukccXmBkTZ2FkiL3A5VGZY2bvOIqPfgpvOn+zezB+gmSU0CEhk8qpfhagZDsPR
         7qRX7kkYvA3Jffkqxk1aRH9Y7RW4b5Mu0GISR44RjdfoMakgpZIkPG3N/J6NyA9psD
         FyFiPlH/SDIgQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8A9D615C33A7; Fri, 17 Mar 2023 11:25:21 -0400 (EDT)
Date:   Fri, 17 Mar 2023 11:25:21 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "wangjianjian (C)" <wangjianjian3@huawei.com>
Cc:     Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH v4 1/2] jbd2: continue to record log between each mount
Message-ID: <20230317152521.GA3270589@mit.edu>
References: <20230317090926.4149399-1-yi.zhang@huaweicloud.com>
 <20230317090926.4149399-2-yi.zhang@huaweicloud.com>
 <021bd760-a3f5-14fa-ca64-27882803abab@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <021bd760-a3f5-14fa-ca64-27882803abab@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Mar 17, 2023 at 06:33:50PM +0800, wangjianjian (C) wrote:
> Do we need update document/filesystems/ext4/journal.rst ?
> 
> On 2023/3/17 17:09, Zhang Yi wrote:
> > -	__u32	s_padding[41];
> > +	__be32	s_head;			/* blocknr of head of log, only uptodate
> > +					 * while the filesystem is clean */
> > +/* 0x005C */
> > +	__u32	s_padding[40];
> >   	__be32	s_checksum;		/* crc32c(superblock) */

Yes, please update journal.rst in the patch.

						- Ted

