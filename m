Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC9C52FCA9
	for <lists+linux-ext4@lfdr.de>; Thu, 30 May 2019 15:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfE3Nwt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 May 2019 09:52:49 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47744 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725870AbfE3Nws (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 May 2019 09:52:48 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4UDptHw021454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 May 2019 09:51:56 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5B089420481; Thu, 30 May 2019 09:51:55 -0400 (EDT)
Date:   Thu, 30 May 2019 09:51:55 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Lukas Czerner <lczerner@redhat.com>, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.com>
Subject: Re: How to package e2scrub
Message-ID: <20190530135155.GD2751@mit.edu>
References: <20190529120603.xuet53xgs6ahfvpl@work>
 <20190529235948.GB3671@mit.edu>
 <20190530095907.GA29237@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530095907.GA29237@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, May 30, 2019 at 11:59:07AM +0200, Jan Kara wrote:
> Yeah, my plan is to just not package cron bits at all since openSUSE / SLES
> support only systemd init anyway these days (and in fact our distro people
> want to deprecate cron in favor of systemd). I guess I'll split off the
> scrub bits into a separate sub-package (likely e2fsprogs will suggest
> installation of this sub-package) and the service will be disabled by
> default.

I'm not super-fond of extra sub-packages for their own sake, and the
extra e2scrub bits are small enough (about 32k?) that I don't believe
it justifies an extra sub-package; but that's a distribution-level
packaging decision, so it's certainly fine if we're not completely aligned.

My plan is to change the Debian package to turn off the timer unit
file by default, probably with a NEWS.Debian file[1] which tells users
how to enable it if they want at package installation time --- but to
keep the e2scrub bits in the base e2fsprogs package.

[1] https://www.debian.org/doc/manuals/developers-reference/ch06.en.html#bpp-news-debian

Out of curiosity, were any of the complaints that you've heard gone
beyond people who ran into the various e2scrub/e2scrub_all bugs?  I'm
curious what their concerns were.

						- Ted
