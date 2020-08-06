Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FD623D692
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Aug 2020 07:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgHFFwh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Aug 2020 01:52:37 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49484 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726051AbgHFFwh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Aug 2020 01:52:37 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0765qX2u000522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Aug 2020 01:52:33 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0CDA0420263; Thu,  6 Aug 2020 01:52:33 -0400 (EDT)
Date:   Thu, 6 Aug 2020 01:52:32 -0400
From:   tytso@mit.edu
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: handle option set by mount flags correctly
Message-ID: <20200806055232.GN7657@mit.edu>
References: <20200723150526.19931-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723150526.19931-1-lczerner@redhat.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jul 23, 2020 at 05:05:26PM +0200, Lukas Czerner wrote:
> Currently there is a problem with mount options that can be both set by
> vfs using mount flags or by a string parsing in ext4.
> 
> i_version/iversion options gets lost after remount, for example
> 
> $ mount -o i_version /dev/pmem0 /mnt
> $ grep pmem0 /proc/self/mountinfo | grep i_version
> 310 95 259:0 / /mnt rw,relatime shared:163 - ext4 /dev/pmem0 rw,seclabel,i_version
> $ mount -o remount,ro /mnt
> $ grep pmem0 /proc/self/mountinfo | grep i_version
> 
> nolazytime gets ignored by ext4 on remount, for example
> 
> $ mount -o lazytime /dev/pmem0 /mnt
> $ grep pmem0 /proc/self/mountinfo | grep lazytime
> 310 95 259:0 / /mnt rw,relatime shared:163 - ext4 /dev/pmem0 rw,lazytime,seclabel
> $ mount -o remount,nolazytime /mnt
> $ grep pmem0 /proc/self/mountinfo | grep lazytime
> 310 95 259:0 / /mnt rw,relatime shared:163 - ext4 /dev/pmem0 rw,lazytime,seclabel
> 
> Fix it by applying the SB_LAZYTIME and SB_I_VERSION flags from *flags to
> s_flags before we parse the option and use the resulting state of the
> same flags in *flags at the end of successful remount.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>

Thanks, applied.

						- Ted
