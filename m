Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59BEF169150
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Feb 2020 19:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgBVStV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 22 Feb 2020 13:49:21 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56765 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726550AbgBVStV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 22 Feb 2020 13:49:21 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-109.corp.google.com [104.133.8.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01MInCDs021638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Feb 2020 13:49:15 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 53C8B4211EF; Sat, 22 Feb 2020 13:49:12 -0500 (EST)
Date:   Sat, 22 Feb 2020 13:49:12 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Bo Branten <bosse@acc.umu.se>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: A question on directory checksums
Message-ID: <20200222184912.GD873427@mit.edu>
References: <alpine.DEB.2.21.2002221122100.23269@stalin.acc.umu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2002221122100.23269@stalin.acc.umu.se>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Feb 22, 2020 at 11:36:43AM +0100, Bo Branten wrote:
> 
> Hello,
> 
> I am implementing support for metadata checksums on an ext4 driver for
> another os and test this by writing something and then run e2fsck from Linux
> to see what it says. When I create a new empty directory that only contains
> . and .. I got this error message from e2fsck that I want to ask you to
> clearify:
> 
> bo@bo-desktop:~$ sudo e2fsck -pvf /dev/sdb2
> /dev/sdb2: Directory inode 64, block #0, offset 0: directory has no checksum.
> FIXED.
> 
> Am I right that it is not the checksum on the inode that represents the
> directory but the checksum in the directory entry tail in the first and only
> block?

Yes.  It means the dirent tail is missing.

> Also do "no checksum" means something different than wrong checksum, like I
> have not initialized it correctly? (if I dont call initialize_dirent_tail I
> will get another error message from e2fsck that speficially says there is no
> room for the checksum so it can not be that)

I'm not sure what you message you are referring to in your
parenthetical comment.

I'm guessing you don't want to look at the e2fsck source code?  What
about using debugfs so you can see what the directory looks like
before and after running e2fsck.

						- Ted
