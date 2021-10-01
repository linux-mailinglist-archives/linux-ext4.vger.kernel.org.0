Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F6C41F240
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Oct 2021 18:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354635AbhJAQl5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 1 Oct 2021 12:41:57 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42743 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232133AbhJAQl5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 1 Oct 2021 12:41:57 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 191Ge5bq022341
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Oct 2021 12:40:06 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9BD4515C34A8; Fri,  1 Oct 2021 12:40:05 -0400 (EDT)
Date:   Fri, 1 Oct 2021 12:40:05 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Alok Jain <jain.alok103@gmail.com>, linux-ext4@vger.kernel.org
Subject: Re: Issue with extension of ext4 filesystem on Rhel7
Message-ID: <YVc55cplzHvPwL00@mit.edu>
References: <CAG-6nk9DKKw2RHiXx_kWN1B5xcTrctTCypUPaicaaW1Ag0jDzw@mail.gmail.com>
 <81899623-90FE-4AFA-AAB6-5ABB21903CBB@dilger.ca>
 <YVcOqNktN4GgFFab@mit.edu>
 <20211001144239.fgizeucgzhingeio@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001144239.fgizeucgzhingeio@work>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 01, 2021 at 04:42:39PM +0200, Lukas Czerner wrote:
> 
> as others have already mentioned, unfortunatelly your file system does
> not have 64-bit feature enabled and so you won't be able to simply
> resize past 16TB. This feature was made default after RHEL7 GA, but sadly
> it was likely too late for you, sorry about that.
> 
> You can try the advice given here, or you can contact RH support as they
> might have some solution for you. However I am affraid it will always
> involve backup for the reasons already mentioned.

It should also be noted that if you are using an enterprise linux
distro, something like a "Linux 3.10" or an "e2fsprogs 1.42.9" from an
enterprise linux has so many backports that it's going to be quite
different from an upstream version.  As a result, you're probably
going to be better off seeking help from the enterprise linux's
support desk, since they will be set up to help you much better than
usptream developers.

Also, there is a big difference between what an enterprise linux might
support and a community distro.  For example, even though Fedora has
defaulted to btrfs, Red Hat Enterprise Linux has not decided to
support btrfs.  It was a techniolgy preview in RHEL 6 and 7, but it
was fully removed in RHEL 8.

So again, if you are using an Enterprise Linux distribution, you
should really ask their support folks so you can get their advice, and
find out what they will actually support.

Cheers,

					- Ted
