Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11BB79DB9F
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2019 04:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbfH0C2F (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Aug 2019 22:28:05 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55330 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727227AbfH0C2F (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Aug 2019 22:28:05 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7R2Rv9I010408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Aug 2019 22:27:58 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1850A42049E; Mon, 26 Aug 2019 22:27:57 -0400 (EDT)
Date:   Mon, 26 Aug 2019 22:27:57 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: attempt to shrink directory on dentry removal
Message-ID: <20190827022756.GG28066@mit.edu>
References: <20190821182740.97127-1-harshadshirwadkar@gmail.com>
 <7303B125-6C0E-41C2-A71E-4AF8C9776468@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7303B125-6C0E-41C2-A71E-4AF8C9776468@dilger.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Aug 25, 2019 at 11:07:46PM -0600, Andreas Dilger wrote:
> This may not always detect empty directory blocks properly, because
> ext4_generic_delete_entry() will only merge deleted entries with the
> previous entry.  It at least appears possible that if entries are not
> deleted in the proper order (e.g. in reverse of the order they are
> listed in the directory) there may be multiple empty entries in a block,
> and the above check will fail.

I don't think that's a problem.  We always merge with the previous
entry, whether it's an empty/deleted entry or an in-use entry.  So
long as all implementations do this, it works just fine.  If there is
an ext2/3/4 implementation which deletes the entry by simply clearing
the inode number *without* merging with the previous one, it's
possible that we might get confused.

But that's easily fixed, too.  In ext4_generic_delete_entry(), we just
need to add a check so that we check to see if the subsequent entry
(if it exists) has a zero de->inode value.  If so, then we absorb the
current directory entry to include the deleted subsequent entry and
repeat the check.

						- Ted
