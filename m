Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 319E4179C57
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Mar 2020 00:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388468AbgCDXX4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Mar 2020 18:23:56 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36848 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388412AbgCDXX4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Mar 2020 18:23:56 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-105.corp.google.com [104.133.0.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 024NNq1n011948
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Mar 2020 18:23:53 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 97AC642045B; Wed,  4 Mar 2020 18:23:52 -0500 (EST)
Date:   Wed, 4 Mar 2020 18:23:52 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@whamcloud.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 8/9] e2fsck: consistently use ext2fs_get_mem()
Message-ID: <20200304232352.GG74069@mit.edu>
References: <1581037786-62789-1-git-send-email-adilger@whamcloud.com>
 <1581037786-62789-8-git-send-email-adilger@whamcloud.com>
 <20200229233602.GH38945@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229233602.GH38945@mit.edu>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Feb 29, 2020 at 06:36:02PM -0500, Theodore Y. Ts'o wrote:
> On Thu, Feb 06, 2020 at 06:09:45PM -0700, Andreas Dilger wrote:
> > Consistently use ext2fs_get_mem() and ext2fs_free_mem() instead of
> > calling malloc() and free() directly in e2fsck.  In several places
> > it is possible to use ext2fs_get_memzero() instead of explicitly
> > calling memset() on the memory afterward.
> > 
> > This is just a code cleanup, and does not fix any specific bugs.
> > 
> > Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
> > Lustre-bug-id: https://jira.whamcloud.com/browse/LU-13197
> 
> Applied, thanks.

I had to fix up this Makefile so that "make check" would properly link
tst_region.

						- Ted
