Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632406473AA
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Dec 2022 16:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiLHP5o (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Dec 2022 10:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLHP5n (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Dec 2022 10:57:43 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E099183AE
        for <linux-ext4@vger.kernel.org>; Thu,  8 Dec 2022 07:57:42 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2B8FvRvt014504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Dec 2022 10:57:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1670515049; bh=mo+3tEL//8O8xJwCIAwVGyxwU65qTyrtoenyeZpigo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=gFo4JwlaopPJ2vMlZqgKxbV4wgbDodSr/tWXsk8ncahV24M+kTVpvYZfUDXUfP2iF
         I26TqijKFoZgstUgDrV0zN6uht+Fr58lgnwug/p5E3fP825/hjeYLUxuvTOML6+YGk
         DXQmx2yBXtH6q0JtwB24B+WYB212HVt0o9Zps5qxCWZG1TDPKUnQOU5Aa5ju54gJhP
         nBljxcbPahVnFiJEmqdz1r57s1QydD3WecCuDllMf09GkA/eAHTyzJ4xuyXBuse6rE
         xB+QabbRaEU3f0BDDJJ9rO4Ru/wxnaMm+J9sv9cv9nhFQgK5upz7ROfwaMZqnYv5uG
         8NILAlCKPLYOQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8212615C39E4; Thu,  8 Dec 2022 10:57:27 -0500 (EST)
Date:   Thu, 8 Dec 2022 10:57:27 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 13/13] ext4: Remove ordered data support from
 ext4_writepage()
Message-ID: <Y5IJZ6gJt0pbJF6Z@mit.edu>
References: <20221207112259.8143-1-jack@suse.cz>
 <20221207112722.22220-13-jack@suse.cz>
 <Y5HzfGolIoH5PTXn@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5HzfGolIoH5PTXn@mit.edu>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 08, 2022 at 09:23:56AM -0500, Theodore Ts'o wrote:
> Since this is the last patch in the series, and we've already dropped
> the writepage hook (which is one of the things Christoph was going
> for), so one approach might be drop this patch from the series at
> least for this upcoming merge window.

And I've confirmed that dropping thie last patch resolves all of the
test regressions in the ext4/data_journal config.  So that's going to
my plan of record for the ext4 dev branch, unless I hear
differently from Jan.

							- Ted
