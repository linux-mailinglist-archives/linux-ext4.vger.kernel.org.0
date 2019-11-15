Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43EEEFD1F3
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Nov 2019 01:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfKOA1U (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Nov 2019 19:27:20 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55252 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726852AbfKOA1U (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Nov 2019 19:27:20 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xAF0RADX023679
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Nov 2019 19:27:11 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id DE1A24202FD; Thu, 14 Nov 2019 19:27:09 -0500 (EST)
Date:   Thu, 14 Nov 2019 19:27:09 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        Eric Whitney <enwlinux@gmail.com>
Subject: Re: [PATCH] ext4: deaccount delayed allocations at freeing inode in
 ext4_evict_inode()
Message-ID: <20191115002709.GA9640@mit.edu>
References: <157233344808.4027.17162642259754563372.stgit@buzz>
 <20191108020827.15D1EAE056@d06av26.portsmouth.uk.ibm.com>
 <d00c572b-66ae-42dc-746a-e2c365c9895a@yandex-team.ru>
 <20191108115420.GI20863@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108115420.GI20863@quack2.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


> From ee27836b579d3bf750d45cd7081d3433ea6fedd5 Mon Sep 17 00:00:00 2001
> From: Jan Kara <jack@suse.cz>
> Date: Fri, 8 Nov 2019 12:45:11 +0100
> Subject: [PATCH] ext4: Fix leak of quota reservations
> 
> Commit 8fcc3a580651 ("ext4: rework reserved cluster accounting when
> invalidating pages") moved freeing of delayed allocation reservations
> from dirty page invalidation time to time when we evict corresponding
> status extent from extent status tree. For inodes which don't have any
> blocks allocated this may actually happen only in ext4_clear_blocks()
> which is after we've dropped references to quota structures from the
> inode. Thus reservation of quota leaked. Fix the problem by clearing
> quota information from the inode only after evicting extent status tree
> in ext4_clear_inode().
> 
> Reported-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Fixes: 8fcc3a580651 ("ext4: rework reserved cluster accounting when invalidating pages")
> Signed-off-by: Jan Kara <jack@suse.cz>

OK, I've applied this patch.

    	     				- Ted
