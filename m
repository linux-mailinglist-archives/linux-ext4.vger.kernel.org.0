Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA3F817AF04
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Mar 2020 20:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgCEThX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Mar 2020 14:37:23 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48536 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725938AbgCEThX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Mar 2020 14:37:23 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-105.corp.google.com [104.133.0.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 025JbG05010097
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Mar 2020 14:37:16 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C0D9242045B; Thu,  5 Mar 2020 14:37:12 -0500 (EST)
Date:   Thu, 5 Mar 2020 14:37:12 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: Inode ENOSPC due to recently_deleted()
Message-ID: <20200305193712.GD4747@mit.edu>
References: <20200305171431.GM21048@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305171431.GM21048@quack2.suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Mar 05, 2020 at 06:14:31PM +0100, Jan Kara wrote:
> Hello!
> 
> Recently, I've got a bug report about ext4 driver regressing compared to
> the old ext2 driver. The problem is that the filesystem is small and they
> fill the fs (use all inodes), then delete some files, and then want to use
> the inodes for other files but recently_deleted() logic makes the freed
> inodes unusable and thus inode allocation fails with ENOSPC.
> 
> AFAIU the logic implemented by recently_deleted() is more of a preference
> than a hard rule and we should rather reuse recently deleted inodes than
> return ENOSPC. Am I right?
> 
> Also I'd note that the detection whether the inode was written out in
> recently_deleted() is very inaccurate - one of the problems is that if
> several inodes in the same inode table block are deleted, then after
> writing out that block we'll be able to reuse only one of these inodes
> because by doing that, we certainly cache and dirty the inode block and
> thus the recently_deleted() logic for other deleted inodes will start to
> apply. But I think we can just live with that if we stop making
> recently_deleted() a hard rule...

Yes, if we can't find any another inodes, rerying with
recently_deleted logic skipped makes sense.

						- Ted
