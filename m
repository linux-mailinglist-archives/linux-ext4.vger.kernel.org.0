Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D589413B441
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Jan 2020 22:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgANVZ5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Jan 2020 16:25:57 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48254 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727102AbgANVZ4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Jan 2020 16:25:56 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-108.corp.google.com [104.133.0.108] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00ELPpBN020765
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jan 2020 16:25:53 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2FB824207DF; Tue, 14 Jan 2020 16:25:51 -0500 (EST)
Date:   Tue, 14 Jan 2020 16:25:51 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     James Courtier-Dutton <james.dutton@gmail.com>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: ext4 recovery
Message-ID: <20200114212551.GE140865@mit.edu>
References: <CAAMvbhFjLCLiLKhu5s7QtLdUY29h8eZ2pHd120o94gDduo+BLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAMvbhFjLCLiLKhu5s7QtLdUY29h8eZ2pHd120o94gDduo+BLw@mail.gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jan 14, 2020 at 04:03:53PM +0000, James Courtier-Dutton wrote:
> 
> Say I started with 1 disk using LVM with an ext4 partition.
> I then added another disk. Added it to the LVM group, expanded the
> ext4 partition to then fill 2 disks.
> I then added another disk. Added it to the LVM group, expanded the
> ext4 partition to then fill 3 disks.

Where you using RAID 0, or some more advanced RAID level?

> One of the disk has now failed.

How has it failed?  It is dead dead dead?  Or are there a large number
of sector errors?

> Are there any tools available for ext4 that could help recover this?
> Note, I am a single user, not a company, so there is no money to give
> to a data recovery company, so I wish to try myself.

How valuable is your data?  The first thing I would recommend, if your
data is worth it (and only you can make that decision) is to create a
new RAID set (using larger disks if that helps reduce the price) so
you can make an block-level image backup using the dd_rescue program.

If you can, then run e2fsck on the backup copy, and then see what you
can recover from that image set.  This will save time (how much is
your time worth?) and perhaps increase the amount of data you can
recover (how much is your data worth?).

					- Ted
