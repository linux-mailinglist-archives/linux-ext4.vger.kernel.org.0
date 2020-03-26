Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29F83194220
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Mar 2020 15:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgCZOzh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Mar 2020 10:55:37 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59660 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726267AbgCZOzh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Mar 2020 10:55:37 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02QEtWsU001774
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Mar 2020 10:55:33 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4F1D5420EBA; Thu, 26 Mar 2020 10:55:32 -0400 (EDT)
Date:   Thu, 26 Mar 2020 10:55:32 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: avoid ENOSPC when avoiding to reuse recently
 deleted inodes
Message-ID: <20200326145532.GA296708@mit.edu>
References: <20200318121317.31941-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318121317.31941-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 18, 2020 at 01:13:17PM +0100, Jan Kara wrote:
> When ext4 is running on a filesystem without a journal, it tries not to
> reuse recently deleted inodes to provide better chances for filesystem
> recovery in case of crash. However this logic forbids reuse of freed
> inodes for up to 5 minutes and especially for filesystems with smaller
> number of inodes can lead to ENOSPC errors returned when allocating new
> inodes.
> 
> Fix the problem by allowing to reuse recently deleted inode if there's
> no other inode free in the scanned range.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Thanks, applied with a minor whitespace fixup.

		       	     		- Ted
