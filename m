Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAB4679EF8
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Jan 2023 17:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbjAXQlA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Jan 2023 11:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjAXQk7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Jan 2023 11:40:59 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD8147EFA
        for <linux-ext4@vger.kernel.org>; Tue, 24 Jan 2023 08:40:36 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 30OGeRAi003336
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 11:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1674578429; bh=C465wp9QRWgcxjXPY1i0s8rlaf67HYP0YRnRYycqN3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=oZ3SAr8r3ALl54Pf+jYACoHNp+QbqibKlyh5MK7qiZ8cB3FXZh7IJ12AQoHHpqg9w
         iYpB+xTiWbItGOIzfz3uZtP1ufJV+1i/rIvCk28vQRudK7M7whtKIe22X+kErXrr5q
         glrZbngElFszEkDKKnka6zuF5aqy8F/g601hG55hUi4v4NHO4rtp/iBFnlhJA2xclD
         njyl2vZMS4KLAKvKzx85Ns6SyMeBAy9/WTPXhkPFYzEs/GPpEMHcS0te3pi/vNEPwJ
         uIdDtPIu5PN9hJdhTpI1/ZL+YwyL+q/XQ1o3pBtwlVyPlvWm95RUuRdUuFpg+V36Mx
         2z4plOuA0WdZQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8EBB015C469B; Tue, 24 Jan 2023 11:40:27 -0500 (EST)
Date:   Tue, 24 Jan 2023 11:40:27 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, Li Xi <lixi@ddn.com>
Subject: Re: [RFCv1 01/72] e2fsck: Fix unbalanced mutex unlock for BOUNCE_MTX
Message-ID: <Y9AJ+4Pj69pq2fYj@mit.edu>
References: <cover.1667822611.git.ritesh.list@gmail.com>
 <febbbd17b3cf4201aaae24e4adb61e4f8a80e9c9.1667822611.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <febbbd17b3cf4201aaae24e4adb61e4f8a80e9c9.1667822611.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 07, 2022 at 05:50:49PM +0530, Ritesh Harjani (IBM) wrote:
> f_crashdisk test failed with UNIX_IO_FORCE_BOUNCE=yes due to unbalanced
> mutex unlock in below path.
> 
> This patch fixes it.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Applied, thanks.

						- Ted
