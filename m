Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CBE62E0C5
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Nov 2022 17:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbiKQQDJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Nov 2022 11:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239451AbiKQQDH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Nov 2022 11:03:07 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D482AE01
        for <linux-ext4@vger.kernel.org>; Thu, 17 Nov 2022 08:03:06 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2AHG2veG010725
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 11:02:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1668700979; bh=pW75se3HOqG74k+J4Ml4ZBrR92ul9Dg9Q3A08IDxifE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=dnvgRMIXr1GY7alwLGY5V2+aMo48uD46QFVJlbNo2wWSaMh+kGot0NsTKdci/6eqy
         PrKkxoXkZ9bkbk9C9EgpPvE+ocMUZUyUHyByj3RFuXindFv4iE9SSF7lOv1h0UCVsS
         2aQatPVzNnnr9YbwwBpYZi+3XPVeo25WcHYD3HSnRKt2GLxqyu31Aj9bPwIyCR+B7X
         rlnHxvJWspVscSLZyWkOc1E2IS/8f4HFVxot9si+QWiBeOzEdy55qotgCcas46P3o5
         aZyq5G88f9p9MY1K2ivqWW0QL9IrboGz1vM1H9iBIPEg8jPfLhS0fRI7M/5ffJk4j7
         rU7SKeO5OEO4A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 81A5315C34C3; Thu, 17 Nov 2022 11:02:57 -0500 (EST)
Date:   Thu, 17 Nov 2022 11:02:57 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, Li Xi <lixi@ddn.com>
Subject: Re: [RFCv1 01/72] e2fsck: Fix unbalanced mutex unlock for BOUNCE_MTX
Message-ID: <Y3ZbMdL/wbeYNRgH@mit.edu>
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

This has been fixed in upstream (for a while, actually); what commit
is your patches based upon?

						- Ted
