Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FBD6D7F4D
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Apr 2023 16:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237646AbjDEOY7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Apr 2023 10:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238474AbjDEOYw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Apr 2023 10:24:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270ED26B2;
        Wed,  5 Apr 2023 07:24:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A40E1625AC;
        Wed,  5 Apr 2023 14:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B622FC433EF;
        Wed,  5 Apr 2023 14:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680704685;
        bh=eiBbg0MwdqCSRyYPdbIMvUwBVY7mO5kW4nAZe/cwBpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2SIuXsCF84/UtNsZZtbFPgdUTP6vHW1ckAOTWhfLN5V+9+ZijnMbtMH0OgHvVetSI
         k6UFaZTF/3U9n90SV6VKhx3RZc1YLh7O9xEO53hn4u6iCxmbPpuvJgP0LjhHBVQ0qx
         1fAlF6DWaSE7F9xCuiaGIkZnBvQJRjw8DdvnAT7k=
Date:   Wed, 5 Apr 2023 16:24:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 0/3] lib/string_helpers et al.: Change return value of
 strreplace()
Message-ID: <2023040523-unworthy-uncured-1eab@gregkh>
References: <20230323123704.37983-1-andriy.shevchenko@linux.intel.com>
 <ZC1454AwRUNFTbIW@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC1454AwRUNFTbIW@smile.fi.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 05, 2023 at 04:34:31PM +0300, Andy Shevchenko wrote:
> On Thu, Mar 23, 2023 at 02:37:01PM +0200, Andy Shevchenko wrote:
> > It's more convenient to have strreplace() to return the pointer to
> >  the string itself. This will help users to make their code better.
> > 
> > The patch 1 kills the only user of the returned value of strreplace(),
> > Patch 2 converts the return value of strreplace(). And patch 3 shows
> > how it may be useful. That said, the series can be routed via fs tree,
> > with or without the last patch.
> 
> Since there are no comments, who can apply this (patches 1 and 2)?
> Greg, are you fine with the kobject change?

Sure, want me to take them all through my driver-core tree?

thanks,

greg k-h
