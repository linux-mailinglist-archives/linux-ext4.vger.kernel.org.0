Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A161D0179
	for <lists+linux-ext4@lfdr.de>; Wed, 13 May 2020 00:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731476AbgELWB1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 May 2020 18:01:27 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34593 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728313AbgELWB0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 May 2020 18:01:26 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 04CM1CO6015667
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 May 2020 18:01:12 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 10F464202E4; Tue, 12 May 2020 18:01:12 -0400 (EDT)
Date:   Tue, 12 May 2020 18:01:11 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     julio.lajara@alum.rpi.edu
Cc:     linux-ext4@vger.kernel.org
Subject: Re: Reducing ext4 fs issues resulting from frequent hard poweroffs
Message-ID: <20200512220111.GD1596452@mit.edu>
References: <CAPA0+rx8eLJU6j1uus2bBY63SrY_WC4TU_WTy0MoXk031wNjJw@mail.gmail.com>
 <CAPA0+ryNcZM7ch_beUHkj=s1_FOo7myV=OiY=4qNwoYeAg6FDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPA0+ryNcZM7ch_beUHkj=s1_FOo7myV=OiY=4qNwoYeAg6FDg@mail.gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 12, 2020 at 05:08:51PM -0400, Julio Lajara wrote:
> Hi all, I currently manage an IOT fleet based on Intel NUCs running
> Ubuntu 18.04 Server on SSDs with etx4, no swap. The device usage is
> more CPU bound than I/O bound and we are having some issues keeping a
> subset of devices running due to them being hard powered off in the
> field in some regions (sometimes as frequently as every 12hrs). Due to
> current difficulties in getting devices back from the field I'm
> looking into tweaking them as best as possible to survive these hard
> power off barring any physical SSD issues.

Hi Julio,

If the hardware devices are behaving appropriately --- that is, after
receiving a CACHE FLUSH command the storage device persists all blocks
written up to the CACHE FLUSH command, such that when the OS receives
the command completion notification of the CACHE FLUSH, everything is
persisted even after a hard power off --- no special configuration
should be necessary.

We have regression tests which simulate this and ext4 regularly passes
them.

If you need to tweak settings, that's an indication that your hardware
is buggy.  And unfortunately ,there's not much we can do to prevent
failures.  A lot is going to depend on *how* crappy the SSD's happen
to be.

Your best bet might be to find a way to make your root filesystem
read-only, so it's not being modified at all, and then set up a
scratch partition with state which can be reformatted at any time if
it gets corrupted --- and then try to get all of your date pushed out
to your remote servers / cloud as often as possible.  And next time,
qualify the SSD's ahead of time to make sure they aren't overly "cost
optimized" (read: crap) before you buy your fleet of devices.  :-(

	   	  	       	       - Ted
