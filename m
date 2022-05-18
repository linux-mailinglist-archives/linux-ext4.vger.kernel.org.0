Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5360B52AF13
	for <lists+linux-ext4@lfdr.de>; Wed, 18 May 2022 02:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbiERAPz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 May 2022 20:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbiERAPx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 May 2022 20:15:53 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D81A1DA77
        for <linux-ext4@vger.kernel.org>; Tue, 17 May 2022 17:15:51 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24I0FXpI008562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 20:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652832935; bh=nLsux+bfQ0hRDpmEXS+VWMhm89TTeh444O+sN/+s48Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=KDgpYTicDX1UqyJA1019FH5KvR050Y4UMYITmPAt7aAmloOpjj1E1FJhMm/FQV0SY
         ge+GzB4KI1dUSJ2txAHPFrqOY/m+avFf4C1hbUCLxnthdpAdWhkBNJWUiaEAstu+9K
         vxxB25NifWUElpWe1l92wRrxYqhFAvpjLgBlvhgayP1ZrNS9Nemb+hhYuSGePYq8Uw
         DAcpQolW+O99Sk4azk8hAEV731c2lQHfLGly2WAL+6D8L3HTC+PkDltJYbUyyStLXa
         9ouXYUxerIs3eMx5K0bK32hqaacZc6M2HBIIExcdz6W/NhHzmLiFuSxfKFQL9EFGxQ
         pssISW+/DRbjg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id F331C15C3EC0; Tue, 17 May 2022 20:15:32 -0400 (EDT)
Date:   Tue, 17 May 2022 20:15:32 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        ebiggers@kernel.org, kernel@collabora.com
Subject: Re: [PATCH v4 00/10] Clean up the case-insensitive lookup path
Message-ID: <YoQ6pPw/ITJtc310@mit.edu>
References: <20220511193146.27526-1-krisman@collabora.com>
 <YoP5jH5axe9ltX2Y@mit.edu>
 <87y1z0vsoe.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1z0vsoe.fsf@collabora.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 17, 2022 at 03:57:05PM -0400, Gabriel Krisman Bertazi wrote:
> 
> I'll be reworking the series to apply Eric's comments and I might render
> patch 1 unnecessary.  I'd be happy to send a v5 for the whole thing
> instead of applying the first two now.

OK, great, I'll wait for the v5 patch series.

Thanks,

						- Ted
