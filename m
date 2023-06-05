Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A044A722D1E
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Jun 2023 18:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjFEQ5y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Jun 2023 12:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjFEQ5x (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Jun 2023 12:57:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA259C;
        Mon,  5 Jun 2023 09:57:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6271862068;
        Mon,  5 Jun 2023 16:57:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEB0C433EF;
        Mon,  5 Jun 2023 16:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685984271;
        bh=re8vMj+8xGpFUnAC2qBW/q3FgGQY32jtNqeKye4SRao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IXhUxdRNyC6UMJxCVft4NRBnEOZTHK2wAfxyoF+tdC1yQRSLpgmvWTfuNx0aYWQG5
         Q5hDsG3KmllDXQJC5WpbRH5mwWhOWRWGqE/mDs4RtGDEQcG0H6mOtaaT+jfQ8ti+oo
         NXJ/IOtHaNLvzx/xQf7+U5Hc6dLAQUW81sZoSjLE=
Date:   Mon, 5 Jun 2023 18:57:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kees Cook <kees@kernel.org>, Kees Cook <keescook@chromium.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 0/3] lib/string_helpers et al.: Change return value of
 strreplace()
Message-ID: <2023060537-espionage-comfort-3e56@gregkh>
References: <20230323123704.37983-1-andriy.shevchenko@linux.intel.com>
 <ZC1454AwRUNFTbIW@smile.fi.intel.com>
 <2023040523-unworthy-uncured-1eab@gregkh>
 <ZC2H8ODMwoO5hzZG@smile.fi.intel.com>
 <47D8878A-1108-4AC3-BF7F-507F90F6970A@kernel.org>
 <ZH3rezDApUro84HB@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH3rezDApUro84HB@smile.fi.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 05, 2023 at 05:04:43PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 05, 2023 at 07:58:40PM -0700, Kees Cook wrote:
> > On April 5, 2023 7:38:40 AM PDT, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > >On Wed, Apr 05, 2023 at 04:24:42PM +0200, Greg Kroah-Hartman wrote:
> > >> On Wed, Apr 05, 2023 at 04:34:31PM +0300, Andy Shevchenko wrote:
> > >> > On Thu, Mar 23, 2023 at 02:37:01PM +0200, Andy Shevchenko wrote:
> > >> > > It's more convenient to have strreplace() to return the pointer to
> > >> > >  the string itself. This will help users to make their code better.
> > >> > > 
> > >> > > The patch 1 kills the only user of the returned value of strreplace(),
> > >> > > Patch 2 converts the return value of strreplace(). And patch 3 shows
> > >> > > how it may be useful. That said, the series can be routed via fs tree,
> > >> > > with or without the last patch.
> > >> > 
> > >> > Since there are no comments, who can apply this (patches 1 and 2)?
> > >> > Greg, are you fine with the kobject change?
> > >> 
> > >> Sure, want me to take them all through my driver-core tree?
> > >
> > >Fine by me! Dunno about others. Kees?
> > 
> > Yeah, that's cool by me. :)
> 
> Greg, does this slip through the cracks?

It did.  Can someone resend this?

thanks,

greg k-h
